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


        /*  EF Core nos la pone facil para trabajar con la modificacion de datos. Si hacemos una consulta y no usamos AsNoTracking, entonces las instancias de las entidades que tenemos estan recibiendo seguimiento de EF Core. Esto quiere decir que si modificamos una propiedad del objeto y utilizamos la función SaveChanges() entonces los cambios se almacenarán en la base de datos. A este modelo de trabajo lo llamamos Modelo Conectado. La idea de este modelo es que utilizamos la misma instancia del DbContext tanto para consultar la data como para editarla. Esta es la forma más simple de trabajar, sin embargo no siempre vamos a recibir la instancia de la entidad desde el cliente. Esto se da bastante en escenarios web en donde el cliente va a tener un formulario, lo va a llenar y nos va a enviar la data del formulario a traves de una petición HTTP, lo que quiere decir que es ainstancia de la entidad no fue creada por el mismo DbContext con el cual va a ser procesada. A esto le llamamos Modelo Desconectado. Por ejemplo, si trabajamos con un cliente o una aplicación de React, nos podría enviar un actor para que editemos una de sus propiedades. Los cambios realizados en la entidad actor van a ser actualizados en la base de datos a través de un DbContext distinto al que cargó dicha entidad. ¿Y cómo podemos hacer para que EF Core tome una simple instancia de una clase y modifique registros de una base de datos con ella? Pues esto se trabaja con el Status de la Entidad. 
            Como mencionabamos anteriormente, EF Core le da seguimiento a nuestras instancias de entidades, este seguimiento se realiza a traves del status registrado de cada instancia. Los siguientes son los status que maneja EF Core:
            - Agregado/Added: Una entidad tiene que ser creada en la bd.
            - Modificado/Modified: La entidad representa un registro de la bd y dicha entidad tiene cambios pendientes ded replicar en el registro correspondiente.
            - Sin Modificar/Unchanged: La entidad representa un registro de la bd pero no hay cambios pendientes para guardar.
            - Borrado/Deleted: Una entidad representa un registro de la bd y dicho registro debe ser eliminado.
            - Sin seguimiento/Detached: Es cuando una entidad no está recibiendo ningún seguimiento por EF Core.*/


        [HttpPost("postSimple")]
        public async Task<ActionResult>Post(Genero genero)
        {
            /*En la siguiente linea lo que estamos haciendo es cambiar el status de la entidad género. No es que ya s eva a agregar
             a la bd sino que está marcando ese objeto como próximo a agregar para cuando ejecutemos la función SaveChanges se agregue a la bd.*/
            _context.Add(genero);

            /*Con el Savechanges EF Core va a chequear todos los objetos con seguimiento, va a verificar su status y con dicho status
             va a realizar algo. En la linea anterior el objeto genero está marcado como agregado, entonces SaveChanges lo va a agregar a la bd.*/
            await _context.SaveChangesAsync();

            return Ok();
        }

        [HttpPost("postMultiple")]
        public async Task<ActionResult> Post(Genero[] generos)
        {
            _context.AddRange(generos);
            await _context.SaveChangesAsync();
            return Ok();
        }
    }
}
