using AutoMapper;
using AutoMapper.QueryableExtensions;
using EFCorePeliculas.DTOs;
using EFCorePeliculas.Entidades;
using EFCorePeliculas.Entidades.SinLlaves;
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

        [HttpGet("SinUbicacion")]
        public async Task<IEnumerable<CineSinUbicacion>> GetCinesSinUbicacion()
        {
            return await _context.Set<CineSinUbicacion>().ToListAsync();
            //Si no queremos utilizar el .Set podemos ir al ApplicationDbContext y crear un DbSet, que en este caso sería
            // public DbSet<CineSinUbicacion> CinesSinUbicacion{get; set;}

            /*Y la línea de arriba la comentamos y queda return await _context.CinesSinUbicacion.ToListAsync()*/
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
                Nombre = "Mi Cine con detalle",
                Ubicacion = ubicacionCine,
                CineOferta = new CineOferta()
                {
                    PorcentajeDescuento = 5,
                    FechaInicio = DateTime.Today,
                    FechaFin = DateTime.Today.AddDays(7)
                },
                CineDetalle=new CineDetalle
                {
                    Historia="Historia del cine...",
                    CodigoDeEtica="Código de ética...",
                    Misiones="Misiones..."

                },
                SalasDeCine = new HashSet<SalaDeCine>()
                {
                    new SalaDeCine()
                    {
                        Precio=200,
                        Moneda=Moneda.PesoArgentino,
                        TipoSalaDeCine=TipoSalaDeCine.DosDimensiones,

                    },
                    new SalaDeCine()
                    {
                        Precio=350,
                        Moneda=Moneda.Dolar,
                        TipoSalaDeCine=TipoSalaDeCine.TresDimensiones,

                    }
                }
            };

            _context.Add(cine);
            await _context.SaveChangesAsync();

            return Ok();
        }



        /*Insertando Cine con Data Relacionada Inexistente*/
        /*Como vemos es muy simple agregar un registro con data relacioanda simplemente agregando las propiedades
         de navegación correspondientes. Sin embargo conviene utilizar un DTO*/

        [HttpPost("conDTO")]
        public async Task<ActionResult> Post(CineCreacionDTO cineCreacionDTO)
        {
            var cine = _mapper.Map<Cine>(cineCreacionDTO);
            _context.Add(cine);
            await _context.SaveChangesAsync();
            return Ok();
        }

        /*Actualizando la entidad principal junto a sus entidades relacionadas.
        Ejemplo: Actualizar un Cine con su CineOferta al mismo tiempo, Cine con sus SalasCine, Pelicula con sus PeliculasActores, etc */

        [HttpPut("{id:int}")]
        public async Task<ActionResult> Put(CineCreacionDTO cineCreacionDTO, int id)
        {
            var cineDB = await _context.Cines.AsTracking()
                /*EL Include es improtante aca porque a traves de él EF Core va a poder decir si necesito crear una nueva sala de cine, actualizar o borrar
                 una ya existente y lo mismo con CineOferta.
                Tenemos que tener algo en cuenta con SalasDeCine: SalasDeCine es un listado List<>, por lo que el Include me va a permitir
                trabajar sobre ese listado*/
                .Include(c => c.SalasDeCine)
                .Include(c => c.CineOferta)
                .FirstOrDefaultAsync(c => c.Id == id);

            if(cineDB is null)
            {
                return NotFound();
            }

            cineDB = _mapper.Map(cineCreacionDTO, cineDB); //Esta simple línea de código ya hace todo: crear, actualizar, modificar y borrar.

            await _context.SaveChangesAsync();

            return Ok();
        }

        /*Creamos un endpoint para ver las actualizaciones/modificaciones que realizamos*/
        [HttpGet("{id:int}")]
        public async Task<ActionResult>Get(int id)
        {
            var cineDB = await _context.Cines.AsTracking()
               .Include(c => c.SalasDeCine)
               .Include(c => c.CineOferta)
                //Ejemplo de implementación de Table Splitting
                .Include(c => c.CineDetalle)
               .FirstOrDefaultAsync(c => c.Id == id);
            if (cineDB is null)
            {
                return NotFound();
            }

            cineDB.Ubicacion = null; //Esto lo colocamos simplemente para no tener problemas con la ubicación
            return Ok(cineDB);
        }

        /*Al ejecutar el endpoint podemos observar lo siguiente: 
         Si insertamos datos de sala de cine pero no insertamos su campo id, EF Core va a interpretar que estamos creando
        una nueva sala de cine por lo que creará una nueva sala de cine. Podemos corroborarlo en Management Studio haciendo un
        count(id) de salas de cine o viendo cual es el último id antes de ejecutar el endpoint. Como vemos, podemos actualizar un cine
        cambiando su nombre, borrar alguna de sus salas, actualizar su oferta e inclusive agregar una sala de cine nueva que no existe
        previamente. Es muy loco*/

        /*Podemos observar que al hacer el truco aprendido hace todo por nosotros de una forma sencilla sin complicarla. Con tan solo
         utilizar los Include y luego el AutoMapper todo se hace se manera resumida, tanto para relaciones 1:1 como 1:N y también
        para N:N en caso de que tengamos una para actualizar.*/


        /*BORRADO DE REGISTROS*/

        /*Vamos a trabajar dos tipos de borrado: Borrado Normal y Borrado Lógico*/

        /*Borrado Normal: Para borrar un registro primero cambiamos su status a borrado yu luego SaveChanges.*/

        /*Borrado Lógico: Consiste en cambiar a true or false - 1 o 0 - el campo de tipo bit/booleano que funciona como "bandera" 
         o "status" del registro sin eliminar el registro de la bd. */


        /*MODOS DE CONFIGURACIÓN*/

        /*Cuando hablamos de configuraciones nos referimos a definir el comportamiento de EF Core ante determinadas situaciones,
         por ejemplo, que si un campo se llama Id entonces será llave primaria o que si un campo es DateTime en C# se mapee a Date 
        de Sql Server. En general tenemos tres formas de hacer configuraciones en EF Core: Por Convención, Por Anotaciones de Datos
        y por el API Fluente.
        
         Convenciones: Funciona en base a los estilos de código que utilicemos en nuestra aplicación. Un ejemplo es el del campo Id.
        si tenemos un campo con ese nombre entonces por defecto será llave primaria. Esto es un ejemplo de conveción ya que con el simple
        hecho del nombre EF Core toma una decisión acerca de sus características. A partir de EF Core 6 podemos configurar nuestras propias
        convenciones con ConfigConventions. Con esta función pudimos indicar que un campo DateTime iba a mapear a un Date en Sql Server .
        
         Anotaciones de Datos: Se refierea los atributos que colocamos encima de entidades y propiedades. Un ejemplo es cuando en la clase Género
        marcamos el campo Id con el atributo [Key].
        
         API Fluente: Se configura en un método llamado OnModelCreating de la clase DbContext. Vimos un ejemplo de esto cuando configuramos
        que el campo nombre de un actor iba a ser requerido y de longitud máxima 150 caracteres. Esta es la forma más poderosa de realizar configuraciones.
        Utilizando el API Fluente tenemos acceso a todas las configuraciones posibles de EF Core mientras que en otras formas de configuracion
        no siempre tenemos todas las opciones de configuración disponibles.
        
        Tip/Nemotécnica: 
        
         Convenciones --> ApplicationDbContext
         Anotaciones de Datos -->  Entidad
         API Fluente -- > EntidadConfig*/


        /*Llaves Primarias*/

        /*Hemos visto que podemos establecer llaves primarias con el tipo de dato int, pero también podemos asignar otro tipo de dato.
         Es asi el caso de GUID (Global Unique Identifier) el cual consiste en un string aleatorio el cual virtualmente es imposible 
        repetir, caso contrario a los int, en el escenario de que trabajemos con diferentes bases de datos los ids serán los mismos por 
        lo que podrían entrar en conflicto. Es por ello que se implementa GUID como pk, ya que el mismo es único tanto en la misma base de datos
        como entre varias.
        Para demostar este ejemplo crearemos la clase Log para almacenar mensajes, sin embargo, estos logs podríamos fusionarlos con otros
        logs que tengamos de otras aplicaciones. Entonces para no tener datos repetidos utilizamos Guid como tipo de dato para la clave primaria.*/

        //Relación Opcional
        [HttpDelete("{id:int}")]
        public async Task<ActionResult> Delete(int id)
        {
            //El Include c=>c.CineOferta lo colocamos porque si intentamos borrar nos da error ya que no estaríamos
            //modificando el nullable de CineOferta..
            //Si consultamos la base de datos luego del borrado del cine veremos que el CineOferta permanece y en su campo
            //CineId figura NULL, ya que el Cine que le correspondía se borró.
            var cine= await _context.Cines
                .Include(c=>c.SalasDeCine)
                .Include(c=>c.CineOferta).FirstOrDefaultAsync(c=> c.Id == id);

            if (cine is null)
            {
                return NotFound();
            }

            //Con esto borro las salas de cine y luego el cine. Para ello utilizo Include y RemoveRange 
            _context.RemoveRange(cine.SalasDeCine);
            await _context.SaveChangesAsync();

            _context.Remove(cine);
            await _context.SaveChangesAsync();
            return Ok();
        }

        //Ejemplo del uso de OnDelete con Restrict


    }
}
