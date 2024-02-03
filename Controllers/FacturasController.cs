using EFCorePeliculas.Entidades;
using Microsoft.AspNetCore.Mvc;

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
    }
}
