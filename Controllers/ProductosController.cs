using AutoMapper;
using EFCorePeliculas.Entidades;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EFCorePeliculas.Controllers
{
    [ApiController]
    [Route("api/productos")]
    public class ProductosController:ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IMapper _mapper;

        public ProductosController(ApplicationDbContext context, IMapper mapper)
        {
            _context=context;
            _mapper=mapper;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Producto>>> Get()
        {
            return await _context.Productos.ToListAsync();
        }

        [HttpGet("Merchs")]
        public async Task<ActionResult<IEnumerable<Merchandising>>> GetMerchs()
        {
            /*En lugar de usar OfType usamos Set ya que en el caso de query por tipo
             produce un query más eficiente*/
            return await _context.Set<Merchandising>().ToListAsync();
        }

        [HttpGet("Alquileres")]
        public async Task<ActionResult<IEnumerable<PeliculaAlquilable>>> GetAlquileres()
        {
            /*En lugar de usar OfType usamos Set ya que en el caso de query por tipo
             produce un query más eficiente*/
            return await _context.Set<PeliculaAlquilable>().ToListAsync();
        }
    }
}
