using EFCorePeliculas.Entidades;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EFCorePeliculas.Controllers
{
    [ApiController]
    [Route("api/generos")]
    public class GeneroController:ControllerBase    
    {
        private readonly ApplicationDbContext _context;

        public GeneroController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IEnumerable<Genero>> Get()
        {
            return await _context.Generos.ToListAsync();

            /*Optimización de Queries*/

            /*Podemos optimizar los Queries de lectura - GET - con .AsNoTracking. Podemos colocarlo como propiedad o como comportamiento global
             en la clase program.
            
             Como propiedad: return await _context.Generos.AsNoTracking.ToListAsync();

             En la clase program dentro de la inyección de dependencias: 
                opciones.UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking);
            
             */
            
        }

    }
}
