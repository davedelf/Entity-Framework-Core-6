using EFCorePeliculas.Entidades;
using EFCorePeliculas.Entidades.Funciones;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EFCorePeliculas.Controllers
{
    [ApiController]
    [Route("api/Facturas")]
    public class FacturasController:ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly ILogger _logger;

        public FacturasController(ApplicationDbContext context, ILogger<FacturasController> logger)
        {
            this._context = context;
            this._logger = logger;
        }

        //Post a modo de ejemplo con data seeding
        [HttpPost]
        public async Task<ActionResult> Post()
        {
            using var transaccion= await _context.Database.BeginTransactionAsync();

            try
            {
                var factura = new Factura()
                {
                    FechaCreacion = DateTime.Now
                };
                _context.Add(factura);
                await _context.SaveChangesAsync();

                var detalleFactura = new List<DetalleFactura>()
                {
                    new DetalleFactura()
                    {
                        Producto="A",
                        Precio=12345,
                        FacturaId=factura.Id
                        
                    },
                    new DetalleFactura()
                    {
                        Producto="B",
                        Precio=6789,
                        FacturaId=factura.Id
                    }
                };
                _context.AddRange(detalleFactura);
                await _context.SaveChangesAsync();
                await transaccion.CommitAsync();
                return Ok("Grabado correctamente");
            }
            catch (Exception ex)
            {
                //Manejo de excepciones...
                return BadRequest("Error al grabar");
            }
        }


        //Hecho por mí - Ver qué se puede pulir o mejorar
        [HttpPost("postConParametros")]
        public async Task<ActionResult> PostP(List<DetalleFactura> detalles)
        {
            using var transaccion=await _context.Database.BeginTransactionAsync();

            //Estas validaciones ¿deberían ir en el bloque catch?
            foreach(var detalle in detalles)
            {
                if(detalle.Producto==null)
                {
                    return BadRequest("Error. Ingrese producto");

                }
                if (detalle.Precio == 0)
                {
                    return BadRequest($"Error. Ingrese precio para {detalle.Producto}");
                }

            }

            try
            {
                var factura = new Factura()
                {
                    FechaCreacion = DateTime.Now
                };
                await _context.AddAsync(factura);
                await _context.SaveChangesAsync();

                foreach (var det in detalles)
                {
                    det.FacturaId = factura.Id;
                    await _context.AddAsync(det);
                    await _context.SaveChangesAsync();
                }
                await _context.SaveChangesAsync();
                await transaccion.CommitAsync();
                return Ok("Grabado correctamente");


            }
            catch (Exception ex)
            {
                return BadRequest("Error al grabar datos");
            }

        }

        [HttpGet("FuncionesEscalares")]
        public async Task<ActionResult> GetFuncionesEscalares()
        {
            var facturas = await _context.Facturas.Select(f => new 
            {
                Id = f.Id,
                Total = _context.DetalleFacturaSuma(f.Id),
                Promedio = Escalares.DetalleFacturaPromedio(f.Id),
            }).OrderByDescending(f => _context.DetalleFacturaSuma(f.Id)).ToListAsync();

            return Ok(facturas);
        }

        //endpoint para columna calculada

        [HttpGet("{id:int}/detalle")]
        public async Task<ActionResult<IEnumerable<DetalleFactura>>> GetDetalle(int id)
        {
            return await _context.DetallesFacturas.Where(f=>f.FacturaId==id)
                .OrderByDescending(f=>f.Total).ToListAsync();
            
        }

        [HttpPost("concurrencia_fila")]
        public async Task<ActionResult> ConcurrenciaFila()
        {
            var facturaId = 2;

            var factura=await _context.Facturas.AsTracking().FirstOrDefaultAsync(f=>f.Id==facturaId);
            factura.FechaCreacion = DateTime.Now;

            await _context.Database.ExecuteSqlInterpolatedAsync(
                @$"UPDATE Facturas SET FechaCreacion=GetDate() WHERE Id={factura.Id}");

            await _context.SaveChangesAsync();

            return Ok();
        }


        //Manejando Conflictos de Concurrencia

        [HttpPost("concurrencia_fila_manejandoError")]
        public async Task<ActionResult> ConcurrenciaFilaManejandoError()
        {
            var facturaId = 1;
            try
            {

                //Persona1
                var factura = await _context.Facturas.AsTracking().FirstOrDefaultAsync(f => f.Id == facturaId);
                factura.FechaCreacion = DateTime.Now.AddDays(-10);

                //Persona2
                await _context.Database.ExecuteSqlInterpolatedAsync(
                    @$"UPDATE Facturas SET FechaCreacion=GetDate() WHERE Id={factura.Id}");

                //Persona1
                await _context.SaveChangesAsync();

                return Ok();
            }
            catch(DbUpdateConcurrencyException ex)
            {
                var entry = ex.Entries.Single();

                var facturaActual = await _context.Facturas.AsNoTracking().FirstOrDefaultAsync(f => f.Id == facturaId);

                foreach(var propiedad in entry.Metadata.GetProperties())
                {
                    var valorIntentado = entry.Property(propiedad.Name).CurrentValue;
                    var valorDBActual=_context.Entry(facturaActual).Property(propiedad.Name).CurrentValue;
                    var valorAnterior=entry.Property(propiedad.Name).OriginalValue;

                    if (valorDBActual.ToString() == valorIntentado.ToString())
                    {
                        //Esta propiedad no fue modificada
                        continue;
                    }

                    _logger.LogInformation($"--- Propiedad {propiedad.Name} ---");
                    _logger.LogInformation($"Valor intentado: {valorIntentado}");
                    _logger.LogInformation($"Valor en la base de datos: {valorDBActual}");
                    _logger.LogInformation($"Valor anterior: {valorAnterior}");

                    //Hacer algo - opcional - 
                }

                return BadRequest("El registro no pudo ser actualizado, pues fué modificado por otra persona");
            }
        }

        //Conflicto de concurrencia con modelo desconectado

        [HttpGet("ObtenerFactura")]
        public async Task<ActionResult<Factura>> ObtenerFactura(int id)
        {
            var factura = await _context.Facturas.FirstOrDefaultAsync(f => f.Id == id);

            if(factura is null)
            {
                return NotFound();
            }
            return factura;
        }

        [HttpPut("ActualizarFactura")]
        public async Task<ActionResult> ActualizarFactura(Factura factura)
        {
            _context.Update(factura);
            await _context.SaveChangesAsync();
            return Ok();
        }
    }
}
