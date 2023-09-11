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

        /*Insertando registro con data relacionada*/

        [HttpPost]
        public async Task<ActionResult> Post()
        {
            var geometryFactory= NtsGeometryServices.Instance.CreateGeometryFactory(srid:4326);
            var ubicacionCine = geometryFactory.CreatePoint(new Coordinate(-31.4198807, -64.2062673));

            /*Creamos el cine que es la entidad principal y las secundarias o entidades relacionadas*/

            var cine = new Cine()
            {
                Nombre = "Mi Cine",
                Ubicacion = ubicacionCine,
                CineOferta = new CineOferta()
                {
                    PorcentajeDescuento = 5,
                    FechaInicio = DateTime.Today,
                    FechaFin = DateTime.Today.AddDays(7)
                },
                SalasDeCine = new HashSet<SalaDeCine>()
                {
                    new SalaDeCine()
                    {
                        Precio=200,
                        TipoSalaDeCine=TipoSalaDeCine.DosDimensiones,

                    },
                    new SalaDeCine()
                    {
                        Precio=350,
                        TipoSalaDeCine=TipoSalaDeCine.TresDimensiones,

                    }
                }
            };

            _context.Add(cine);
            await _context.SaveChangesAsync();

            return Ok();
        }

        /*Como vemos es muy simple agregar un registro con data relacioanda simplemente agregando las propiedades
         de navegación correspondientes. Sin embargo conviene utilizar un DTO*/
        

    }
}
