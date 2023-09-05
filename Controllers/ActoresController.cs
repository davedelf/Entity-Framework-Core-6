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

        public ActoresController(ApplicationDbContext context)
        {
             _context = context;
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

        [HttpGet]
        public async Task<IEnumerable<ActorDTO>> Get()
        {
            return await _context.Actores.Select(a=>new ActorDTO { Id = a.Id,Nombre = a.Nombre }).ToListAsync();

        }

    }
}
