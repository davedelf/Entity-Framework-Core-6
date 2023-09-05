using AutoMapper;
using AutoMapper.QueryableExtensions;
using EFCorePeliculas.DTOs;
using EFCorePeliculas.Entidades;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EFCorePeliculas.Controllers
{
    [ApiController]
    [Route("api/actores")]
    public class ActoresController:ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IMapper _mapper;

        public ActoresController(ApplicationDbContext context, IMapper mapper)
        {
             _context = context;
            _mapper = mapper;
        }

        /*SELECT*/

        /*Podemos mapear a un objeto anónimo o mapear a un objeto específico, como son los DTO (Data-Transfer Object)*/

        /*Mapeando a objeto anónimo*/


        /* [HttpGet]
        public async Task<ActionResult> Get()
        {

           var actores=await _context.Actores.Select(a=>new {a.Id, a.Nombre}).ToListAsync();
            return Ok(actores);
        } */

        /*Mapear a objeto DTO*/

        //[HttpGet]
        //public async Task<IEnumerable<ActorDTO>> Get()
        //{
        //    return await _context.Actores.Select(a=>new ActorDTO { Id = a.Id,Nombre = a.Nombre }).ToListAsync();

        //}


        /*AUTOMAPPER*/

        /*Podemos evitar el uso del Select y tener que setearlo manualmente para campo y entidad que necesitemos y hacerlo de forma automática.
         Para ello hacemos uso de AutoMapper; lo que hace es tomar los campos de una entidad y mapearlos automáticamente a su respectivo DTO.
         Necesitamos instalar el NuGet AutoMapper.Extensions.Microsoft.DependencyInjection y su inyección builder.Services.AddAutoMapper(typeof(Program));
         Para tener el código más organizado crearemos la carpeta Services y dentro colocaremos las coniguraciones correspondientes
         a cada entidad a mapear dentro de una clase llamada AutoMapperProfiles*/

        [HttpGet]
        public async Task<IEnumerable<ActorDTO>> Get()
        {
            /*.ProyectoTo<HaciaDondeQueremosMapear>(mapper.ConfigurationProvider)*/
            return await _context.Actores.ProjectTo<ActorDTO>(_mapper.ConfigurationProvider).ToListAsync();

            /*Y con esto ya no necesitamos el Select. Lo bueno es que si queremos mapear o necesitamos mostrar otro campo
             simplemente debemos modificar el DTO correspondiente sin tener que tocar la entidad base. Ejemplo, si agregamos el campo
             FechaNacimiento en el ActorDTO coincidirá con su entidad Actor, lo mapeará y lo mostrará en la consulta del endpoint*/
        }
    }
}
