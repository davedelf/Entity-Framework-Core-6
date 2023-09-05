using AutoMapper;
using AutoMapper.QueryableExtensions;
using EFCorePeliculas.DTOs;
using EFCorePeliculas.Entidades;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Migrations;
using NetTopologySuite;
using NetTopologySuite.Geometries;

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

        /*CONSULTANDO Y ORDENANDO DATOS ESPACIALES*/

        /*Podemos ordenar los datos espaciales segun nuestras necesidades, por ejemplo, ordenar y mostrar los cines más cercanos a la ubicación del usuario
         El SRID 4326 es uno de los códigos más comunes y se utiliza para representar coordenadas en el sistema de coordenadas geográficas WGS 84,
         que es un sistema de referencia ampliamente utilizado para representar la superficie de la Tierra en grados de latitud y longitud.*/

        [HttpGet("cercanos")]
        public async Task<ActionResult<CineDTO>> Get(double latitud, double longitud)
        {
            var geometryfactory=NtsGeometryServices.Instance.CreateGeometryFactory(srid:4326);
            var miUbicacion = geometryfactory.CreatePoint(new Coordinate(latitud, longitud));
            var distanciaMaximaEnMetros = 2000;

            var cines=await _context.Cines
                .OrderBy(c=>c.Ubicacion.Distance(miUbicacion))
                .Where(c=>c.Ubicacion.IsWithinDistance(miUbicacion,distanciaMaximaEnMetros))
                .Select(c => new
                {
                    Nombre=c.Nombre,
                    Distancia=Math.Round(c.Ubicacion.Distance(miUbicacion))
                })
                .ToListAsync();

            return Ok(cines);
        }

        
    }
}
