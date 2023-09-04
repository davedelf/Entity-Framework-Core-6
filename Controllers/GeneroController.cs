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

        /*First y FirstOrDefault*/

        /*First trae el primer registro que cumpla con la condición, pero si no encuentra nada entonces arroja Error 500
         FirstOrDefault trae el primer registro que cumpla con la condición y si no encuentra nada entonces trae null*/

        [HttpGet("primer")]
        public async Task<ActionResult<Genero>> Primer()
        {
            var genero = await _context.Generos.FirstOrDefaultAsync(g => g.Nombre.StartsWith("C"));

            if(genero == null)
            {
                return NotFound();
            }
            else
            {
                return genero;
            }


        }

        [HttpGet("{id:int}")]
        public async Task<ActionResult<Genero>> Get(int id)
        {
            var genero=await _context.Generos.FirstOrDefaultAsync(g=>g.Id==id);

            if(genero == null)
            {
                return NotFound();

            }
            else
            {
                return genero;
            }
        }

    }
}
