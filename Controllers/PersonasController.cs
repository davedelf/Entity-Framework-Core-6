using AutoMapper;
using EFCorePeliculas.Entidades;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EFCorePeliculas.Controllers
{
    [ApiController]
    [Route("api/personas")]
    public class PersonasController:ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IMapper _mapper;

        public PersonasController(ApplicationDbContext context, IMapper mapper)
        {
            this ._context = context;
            this._mapper = mapper;
        }

        //En este endpoint utilizamos la técnica de eaggerloading al hacer uso de .Include
        [HttpGet("id:int")]
        public async Task<ActionResult<Persona>> Get(int id)
        {
            return await _context.Personas
                .Include(p=>p.MensajesEnviados)
                .Include(p=>p.MensajesRecibidos)
                .FirstOrDefaultAsync(p=>p.Id==id);
        }
    }
}
