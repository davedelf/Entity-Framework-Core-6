using AutoMapper;
using EFCorePeliculas.DTOs;
using EFCorePeliculas.Entidades;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace EFCorePeliculas.Controllers
{
    [ApiController]
    [Route("api/peliculas")]
    public class PeliculasController:ControllerBase
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
                .Include(p => p.Generos)
                .Include (p=>p.SalasDeCine)
                /*Acá nos tira error 500 al serializar el point del Cine, entonces lo que podemos hacer es realizar una proyección
                 para así evitar estar intentanto serializar el tipo de dato point.*/
                    .ThenInclude(s=>s.Cine)
                .Include(p=>p.PeliculasActores)
                    .ThenInclude(pa=>pa.Actor)
                .FirstOrDefaultAsync(p=>p.Id==id);

            if (pelicula == null)
            {
                return NotFound(id);
            }

            /*Esta es una forma de realizar un mapeo sin utilizar la propiedad .ProjectTo*/
            var peliculaDTO=_mapper.Map<PeliculaDTO>(pelicula);
            
            peliculaDTO.Cines=peliculaDTO.Cines.DistinctBy(x=>x.Id).ToList();
            return peliculaDTO;

            /*ACLARACIONES: Si vemos que en la peticion nos arroja Id 0 entonces posiblemente se deba a que los campos de DTO no tienen el mismo
             nombre o no coinciden con los de su respectiva entidad. Tener en claro es; el nombre de campo debe ser el mismo tanto en la entidad 
             como en su respectivo DTO.*/
           
        }
    }
}
