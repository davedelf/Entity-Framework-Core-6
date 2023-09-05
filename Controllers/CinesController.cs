using AutoMapper;
using AutoMapper.QueryableExtensions;
using EFCorePeliculas.DTOs;
using EFCorePeliculas.Entidades;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EFCorePeliculas.Controllers
{
    [ApiController]
    [Route("api/cines")]
    public class CinesController:ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IMapper _mapper;
        public CinesController(ApplicationDbContext context,IMapper mapper)
        { 
            _context= context;
            _mapper= mapper;
        }

        /*CONSULTANDO DATOS ESPACIALES*/

        /*Si intentamos ejecutar el endpoint de esta forma nos dara un error 500 el cual especifica que no se puede serializar las coordenadas
         o el tipo de dato Point de Ubicación. La solución es mapear*/
        [HttpGet]
        public async Task<IEnumerable<CineDTO>> Get()
        {
            return await _context.Cines.ProjectTo<CineDTO>(_mapper.ConfigurationProvider).ToListAsync();
        }

        
    }
}
