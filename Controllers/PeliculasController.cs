using AutoMapper;
using EFCorePeliculas.DTOs;
using EFCorePeliculas.Entidades;
using EFCorePeliculas.Entidades.SinLlaves;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace EFCorePeliculas.Controllers
{
    [ApiController]
    [Route("api/peliculas")]
    public class PeliculasController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IMapper _mapper;

        public PeliculasController(ApplicationDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        [HttpGet("{id:int}")]
        public async Task<ActionResult<PeliculaDTO>> Get(int id)
        {
            var pelicula = await _context.Peliculas
                .Include(p => p.Generos.OrderByDescending(g => g.Nombre))
                .Include(p => p.SalasDeCine)
                    /*Acá nos tira error 500 al serializar el point del Cine, entonces lo que podemos hacer es realizar una proyección
                     para así evitar estar intentanto serializar el tipo de dato point.*/
                    .ThenInclude(s => s.Cine)
                /*También podemos filtrar por ejemplo, los actores que nacieron después del año 1980*/
                .Include(p => p.PeliculasActores.Where(pa => pa.Actor.FechaNacimiento.Value.Year >= 1980))
                    .ThenInclude(pa => pa.Actor)
                .FirstOrDefaultAsync(p => p.Id == id);

            if (pelicula == null)
            {
                return NotFound(id);
            }

            /*Esta es una forma de realizar un mapeo sin utilizar la propiedad .ProjectTo*/
            var peliculaDTO = _mapper.Map<PeliculaDTO>(pelicula);

            peliculaDTO.Cines = peliculaDTO.Cines.DistinctBy(x => x.Id).ToList();
            return peliculaDTO;

            /*ACLARACIONES: Si vemos que en la peticion nos arroja Id 0 entonces posiblemente se deba a que los campos de DTO no tienen el mismo
             nombre o no coinciden con los de su respectiva entidad. Tener en claro es; el nombre de campo debe ser el mismo tanto en la entidad 
             como en su respectivo DTO.*/

        }

        [HttpGet("cargadoselectivo/{id:int}")]
        public async Task<ActionResult> GetSelectivo(int id)
        {
            var pelicula = await _context.Peliculas.Select(p =>
            new
            {
                Id = p.Id,
                Titulo = p.Titulo,
                Generos = p.Generos.OrderByDescending(g => g.Nombre).Select(g => g.Nombre).ToList(),
                /*Puedo generar operaciones también. Ej*/
                CantidadActores = p.PeliculasActores.Count(), //Cuantos actores tiene la película
                CantidadCines = p.SalasDeCine.Select(s => s.CineId).Distinct().Count() //En cuantos cines se encuentra la película
            }).FirstOrDefaultAsync(p => p.Id == id);

            if (pelicula == null)
            {
                return NotFound();
            }
            return Ok(pelicula);
        }

        [HttpGet("cargadoExplicito/{id:int}")]
        public async Task<ActionResult<PeliculaDTO>> GetExplicito(int id)
        {
            /*Para hacer el Cargado Explícito necesitamos tener activado el Astracking; por defecto a nivel global
             lo tenemos desactivado (AsNoTracking), entonces vamos a activarlo*/
            var pelicula = await _context.Peliculas.AsTracking().FirstAsync(p => p.Id == id);

            await _context.Entry(pelicula).Collection(p => p.Generos).LoadAsync();

            /*Funciona como si quisieramos cargar la película y luego cargar sus datos relacionados; de esta forma funciona
             el cargado explícito, es decir, explicitamos qué queremos cargar*/

            /*pelicula is null es lo mismo que pelicula==null*/
            /*A nivel consola se realizan dos query diferentes; primero uno para pelicula y luego otro para géneros
             Lo bueno del cargado explícito es que podemos separar la carga de la entidad principal de las entidades secundarias
            o relacionadas. No necesariamente tenemos que cargar toda la data relacionada, hasta podemos realizar querys sobre ello.
            Ej.: Queremos cargar cuantos generos tiene la película (pero no los géneros en si)*/
            var cantidadGeneros = await _context.Entry(pelicula).Collection(p => p.Generos).Query().CountAsync();
            if (pelicula is null)
            {
                return NotFound();
            }

            var peliculaDTO = _mapper.Map<PeliculaDTO>(pelicula);

            return Ok(peliculaDTO);

            /*A veces es más optimo cargar toda la data relacionada en una sola consulta ya sea con un Select o con un Include, pero dependerá
             del caso o la situación que se nos presente y qué requerimos cargar en el momento.
             Se puede hacer de las tres formas, pero tener en cuenta la optimización de la API.*/

            /*Con Lazy Loading lo que hacemos es configurar EF Core para que si al data relacioanda ya ha sido cargada entonces
             se utilice, pero si no se ha cargado entonces que se cargue automáticamente.
             La desventaja de utilziar esta técncia repercute en la optimizacíón de las consultas a la db, por lo que es 
             mejor realizar todos los queries en una misma consulta. Además, nos exponemos al problema de N+1
            
             Para hacer uso de esta técnica debemos descargar el NuGet Microsoft.EntityFrameworkCore.Proxies. Luego debemos marcar
             cada propiedad de navegación de nuestros modelos como virtual y configurar el DbContext*/


        }

        //[HttpGet("lazyloading/{id:int}")]
        //public async Task<ActionResult<List<PeliculaDTO>>> GetLazyLoading(int id)
        //{
        //    /*El problema N+1 se da cuando tenemos un conjunto de entidades relacionadas e intentamos acceder a cada ellas de 
        //     manera individual. Con lazy loading este es un problema sumamente ineficiente, ya que se realiza
        //     un query por cada consulta. Ejemplo:*/
        //    var peliculas = await _context.Peliculas.AsTracking().ToListAsync();
        //    foreach (var pelicula in peliculas)
        //    {
        //        //Cargar los generos de la pelicula
        //        /*Problema N+1
        //         Por cada pelicula que tengamos vamos a cargar sus respectivos géneros.
        //         Si tuvieramos 100 películas entonces necesitaríamos 100 query para cargar cada una 
        //         y a su vez un query para cargar los géneros. Por eso es N+1 (N querys para películas y +1 query para los Géneros./
        //        pelicula.Generos.ToList();
        //    }

        //    /*En este caso la data relacionada se cargará ya que _mapper está llamandola; caso contrario 
        //     no se carga*/


        //    }
        //    var peliculasDTOs = _mapper.Map<List<PeliculaDTO>>(peliculas);
        //    return peliculasDTOs;

        //    /*En resumen: Convenientemente conviene utilizar Eager Loading o Cargado Selectivo y no se 
        //     recomienda el uso de Lazy Loading*/
        //}

        /*Ejemplo de endpoint utilizando group by; en este caso para las películas que se encuentran en cartelera*/

        [HttpGet("agrupadasPorEstreno")]
        public async Task<ActionResult> AgrupadasPorCartelera()
        {
            var peliculasAgrupadas = await _context.Peliculas.GroupBy(p => p.EnCartelera)
                .Select(g => new
                {
                    EnCartelera = g.Key, //key se refiere a p=>p.EnCartelera
                    Conteo = g.Count(),
                    Peliculas = g.ToList()
                }).ToListAsync();
            return Ok(peliculasAgrupadas);
        }

        /*También podemos agrupar por el resultado ded una acción, por ejemplo, por cantidad de géneros*/

        [HttpGet("agrupadasPorGenero")]
        public async Task<ActionResult> AgrupadasPorCantidadGenero()
        {
            var peliculasAgrupadas = await _context.Peliculas.GroupBy(p => p.Generos.Count())
            .Select(g => new
            {
                conteo = g.Key,
                Titulos = g.Select(x => x.Titulo),
                Generos = g.Select(x => x.Generos).SelectMany(gen => gen).Select(gen => gen.Nombre).Distinct()
                //Lo que hace es tomar los géneros de los resultados y 
                //colocarlos en una única colección, es decir, agrupa por géneros sin repetir resultados
            }).ToListAsync();
            return Ok(peliculasAgrupadas);

            /*Entonces nos retorna las colecciones por cantidad de conteo (generos) y sus respectivos géneros*/

            /*Ahora vamos a hacer una función para filtrar películas, ya sea por su género o por si se estrenará en el futuro
             Sin embargo, los filtros serán dinámicos. Se aplicarán segun los valores que le pasemos a la función de filtrado. Ejemplo,
             si le pasamos un título entonces se filtrará por éste. Acquí implementamos el concepto de Ejecución Diferida*/

        }

        [HttpGet("filtrar")]
        public async Task<ActionResult<List<PeliculaDTO>>> Filtrar([FromQuery] PeliculasFiltroDTO peliculasFiltroDTO)
        {
            //El FromQuery me va a permitir recibir el tipo de dato complejo,  en este caso, PeliculaDTO
            //AsQueryable es basicamente el tipo de dato que nos permite ir construyendo nuestros queries 
            var peliculasQueryable = _context.Peliculas.AsQueryable();

            if (!string.IsNullOrEmpty(peliculasFiltroDTO.Titulo))
            {
                peliculasQueryable = peliculasQueryable.Where(p => p.Titulo.Contains(peliculasFiltroDTO.Titulo));
            }
            if (peliculasFiltroDTO.EnCartelera)
            {
                peliculasQueryable = peliculasQueryable.Where(p => p.EnCartelera);
            }
            if (peliculasFiltroDTO.ProximosEstrenos)
            {
                var hoy = DateTime.Today;
                peliculasQueryable.Where(p => p.FechaEstreno > hoy);
            }
            if (peliculasFiltroDTO.GeneroId != 0)
            {
                peliculasQueryable = peliculasQueryable.Where(p => p.Generos.Select(g => g.Id)
                .Contains(peliculasFiltroDTO.GeneroId));
            }


            var peliculas = await peliculasQueryable.Include(p => p.Generos).ToListAsync();


            return _mapper.Map<List<PeliculaDTO>>(peliculas);

        }

        /*RESUMEN*/
        /*EF Core nos ayuda a consultar datos de la db utilizando código LINQ, ya sean filtros, proyecciones, agrupamientos, tomar y saltar elementos
          son algunas de las funciones que podemos hacer utilizando simples líneas de C#.
          
        Eager Loading: Cargmaos la data de nuestras entidades relacionadas desde un principio. Esta técncia es eficiente porque todo lo hacemos pocos queries
        y sin realizar demasiados viajes a la bd.
        
        Select Loading: Tenemos mucha flexibilidad para seleccionar aquellas columnas que querramos, incluso aquellas que sean de datos
        relacionados.

        Explicit Loading: Podemos realizar la carga de la data en un query aparte ejecutando la función Load.

        Lazy Loading: Podemos realizar la carga de la data en un query aparte accediendo a la propiedad de navegación correspondiente.

        (Estas dos últimas formas pueden ser un poco ineficientes por la forma en que operan por lo que deben ser utilizadas con precaución)

        Ejecución Diferida: Nos permite armar nuestro query paso a paso. Esto nos da la oportunidad de realizar queries dinámicamente dependiendo
        de los valores enviados por el usuario.
        */


        /*Insertar Registro Con Data Relacionada Existente*/
        /*Vamos a insertar peliculas con generos y salas de cines ya creados, es decir, data relacionada ya existente.
         Para ello vamos a trabajar con el Status*/

        [HttpPost("conDataExistente")]
        public async Task<ActionResult> Post(PeliculaCreacionDTO peliculaCreacionDTO)
        {
            var pelicula = _mapper.Map<Pelicula>(peliculaCreacionDTO);
            /*Lo que le estoy diciendo con el status unchanged es que quiero agregar los generos ya existentes pero que no quiero
             ni modificarlos ni agregar nuevos, es por ello que es unchanged. Simplemente quiero utilizar los ya existentes.*/
            pelicula.Generos.ForEach(g => _context.Entry(g).State = EntityState.Unchanged);
            pelicula.SalasDeCine.ForEach(s => _context.Entry(s).State = EntityState.Unchanged);
            /*Con PeliculasActores no necesitamos hacer lo mismo porque yo realmente si quiero crear un actor, ya que la relacion
             pelicula-actor es N:N*/
            
            if (pelicula.PeliculasActores is not null)
            {
                for (int i = 0; i < pelicula.PeliculasActores.Count; i++)
                {
                    pelicula.PeliculasActores[i].Orden = i + 1;
                }
            }

            _context.Add(pelicula);
            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpGet("PeliculasConConteos/{id:int}")]
        public async Task<ActionResult<PeliculaConConteos>> GetPeliculasConConteos(int id)
        {
            //Recordemos que el Set es para crear el DbSet, podemos obviar esta línea creando el dbset en el API Fluente
            //return await _context.Set<PeliculaConConteos>().ToListAsync();

            var resultado = await _context.PeliculaConConteos(id).FirstOrDefaultAsync();

            //FirstOrDefaultAsync porque espero un solo resultado; si fueran varios usamos ToList

            if(resultado is null)
            {
                return NotFound();
            }

            return Ok(resultado);
        }

      
    }
}
