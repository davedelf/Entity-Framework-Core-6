using EFCorePeliculas.Entidades;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EFCorePeliculas.Controllers
{
    [ApiController]
    [Route("api/generos")]
    public class GenerosController:ControllerBase    
    {
        private readonly ApplicationDbContext _context;

        public GenerosController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IEnumerable<Genero>> Get()
        {
            return await _context.Generos.OrderBy(g=>g.Nombre).ToListAsync();

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

        [HttpGet]
        [Route("api/filtrar")]
        public async Task<IEnumerable<Genero>> Filtrar()
        {
            var genero = await _context.Generos.Where(
                g => g.Nombre.StartsWith("C") || g.Nombre.StartsWith("A")).ToListAsync();

            return genero;
        }

        [HttpGet("string:nombre")]
        public async Task<IEnumerable<Genero>> Filtrar(string nombre)
        {
            var genero = await _context.Generos
                .Where(g => g.Nombre.Contains(nombre))
              //.OrderBy(g=>g.Nombre)
              //.OrderyByDescending(g=>g.Nombre)
                .ToListAsync();

            return genero;
        }

        [HttpGet("paginacion")]
        public async Task<ActionResult<IEnumerable<Genero>>> GetPaginacion(int pagina = 1)
        {
            //Lo que hace es saltear (skip) el primer registro y traer (take) los dos siguientes.

            //var generos = await _context.Generos.Skip(1).Take(2).ToListAsync();
            //return generos;

            var cantidadRegistrosPorPagina = 2;
            var generos = await _context.Generos
                .Skip((pagina - 1) * cantidadRegistrosPorPagina)
                .Take(cantidadRegistrosPorPagina)
                .ToListAsync();
            return generos;
            
            /*Con este método obtengo la paginación. Muestro dos registros por cada página en orden consecutivo, es decir, en la página 1

              muestro los registros 1 y 2, pág.2 registros 3 y 4, y así sucesivamente.*/
        }



    }
}
