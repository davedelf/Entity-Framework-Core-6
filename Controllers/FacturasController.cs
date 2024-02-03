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

        public FacturasController(ApplicationDbContext context)
        {
            this._context = context;
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
    }
}
