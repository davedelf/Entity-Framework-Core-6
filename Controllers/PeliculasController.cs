﻿using AutoMapper;
using EFCorePeliculas.DTOs;
using EFCorePeliculas.Entidades;
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
    }
}
