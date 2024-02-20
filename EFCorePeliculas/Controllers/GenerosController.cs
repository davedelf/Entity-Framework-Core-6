using AutoMapper;
using EFCorePeliculas.DTOs;
using EFCorePeliculas.Entidades;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace EFCorePeliculas.Controllers
{
    [ApiController]
    [Route("api/generos")]
    public class GenerosController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IMapper _mapper;

        public GenerosController(ApplicationDbContext context, IMapper mapper)
        {
            this._context = context;
            this._mapper = mapper;

        }

        [HttpGet]
        public async Task<IEnumerable<Genero>> Get()
        {
            //Esto (a modo de ejemplo) lo que hace es crear un registro log al ejecutar el endpoint Get. Si consultamos la tabla
            // Logs en Management Studio veremos que el registro log se crea cada vez que ejecutamos el endpoint y su id se compone de
            // una cadena de caracteres o string irrepetible.

            _context.Logs.Add(new Log()
            {
                //Id=new Guid(),
                Mensaje = "Ejecutando el método GenerosController.Get"
            });

            /*Sin embargo no es conveniente configurar manualmente la instancia de GUID ya que puede entrar en conflicto a la hora de almacenarse,
             ya que la misma base de datos lo genera de manera secuencial bajo un determinado patrón de su motor. Conclusión: con configurarlo manualmente
            y dejar que la base de datos lo genere ella misma. Por lo tanto, conviene revertir los cambios y solamente asignar el tipo de dato Guid a la propiedad
            en la entidad.
            Si ejecutamos el endpoint con las configuraciones de crear manualmente el Guid veremos que en la bd se genera el id 
            00000000-0000-0000-0000-000000000000, pero si volvemos a ejecutar el endpoint nos dará Error 500 especificando que el id está duplicado
            o ya ha sido creado. Es por ello que conviene dejar que la bd lo genere solo.*/
            await _context.SaveChangesAsync();
            //Usamos la propiedad sombra para ordernar los resultados por fecha de creación.
            return await _context.Generos.OrderByDescending(g => EF.Property<DateTime>(g, "FechaCreacion")).ToListAsync();

            /*Optimización de Queries*/

            /*Podemos optimizar los Queries de lectura - GET - con .AsNoTracking. Podemos colocarlo como propiedad o como comportamiento global
             en la clase program.
            
             Como propiedad: return await _context.Generos.AsNoTracking.ToListAsync();

             En la clase program dentro de la inyección de dependencias: 
                opciones.UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking);
            
             */

        }

        /*First y FirstOrDefault*/

        /*First trae el primer registro que cumpla con la condición, pero si no encuentra nada entonces arroja Error 500
         FirstOrDefault trae el primer registro que cumpla con la condición y si no encuentra nada entonces trae null*/

        [HttpGet("primer")]
        public async Task<ActionResult<Genero>> Primer()
        {
            var genero = await _context.Generos.FirstOrDefaultAsync(g => g.Nombre.StartsWith("C"));

            if (genero == null)
            {
                return NotFound();
            }
            else
            {
                return genero;
            }


        }

        [HttpGet("{id:int}")]
        public async Task<ActionResult<Genero>> Get(int id)
        {
            //QUERIES ARBITRARIOS

            //Utilizando técnica placeholder


            //var genero = await _context.Generos.FromSqlRaw("select * from Generos where id={0}", id)
            //    .IgnoreQueryFilters()
            //    .FirstOrDefaultAsync();

            /*IMPORTANTE: utilizar sintaxis {0}", id para evitar ataque Sql Inyection*/



            //Utilizando String Interpolation

            var genero = await _context.Generos.FromSqlInterpolated($"Select * From Generos where id={id}")
                .IgnoreQueryFilters()
                .FirstOrDefaultAsync();

            //var genero = await _context.Generos.AsTracking().FirstOrDefaultAsync(g => g.Id == id);

            if (genero == null)
            {
                return NotFound();

            }
            return Ok(genero);

            //var fechaCreacion = _context.Entry(genero).Property<DateTime>("FechaCreacion").CurrentValue;
            //return Ok(new
            //{
            //    Id = genero.Id,
            //    Nombre = genero.Nombre,
            //    fechaCreacion
            //});

        }

        [HttpGet]
        [Route("api/filtrar")]
        public async Task<IEnumerable<Genero>> Filtrar()
        {
            var genero = await _context.Generos.Where(
                g => g.Nombre.StartsWith("C") || g.Nombre.StartsWith("A")).ToListAsync();

            return genero;
        }

        [HttpGet("string:nombre")]
        public async Task<IEnumerable<Genero>> Filtrar(string nombre)
        {
            var genero = await _context.Generos
                .Where(g => g.Nombre.Contains(nombre))
                //.OrderBy(g=>g.Nombre)
                //.OrderyByDescending(g=>g.Nombre)
                .ToListAsync();

            return genero;
        }

        [HttpGet("paginacion")]
        public async Task<ActionResult<IEnumerable<Genero>>> GetPaginacion(int pagina = 1)
        {
            //Lo que hace es saltear (skip) el primer registro y traer (take) los dos siguientes.

            //var generos = await _context.Generos.Skip(1).Take(2).ToListAsync();
            //return generos;

            var cantidadRegistrosPorPagina = 2;
            var generos = await _context.Generos
                .Skip((pagina - 1) * cantidadRegistrosPorPagina)
                .Take(cantidadRegistrosPorPagina)
                .ToListAsync();
            return generos;

            /*Con este método obtengo la paginación. Muestro dos registros por cada página en orden consecutivo, es decir, en la página 1

              muestro los registros 1 y 2, pág.2 registros 3 y 4, y así sucesivamente.*/
        }


        /*  EF Core nos la pone facil para trabajar con la modificacion de datos. Si hacemos una consulta y no usamos AsNoTracking, entonces las instancias de las entidades que tenemos estan recibiendo seguimiento de EF Core. Esto quiere decir que si modificamos una propiedad del objeto y utilizamos la función SaveChanges() entonces los cambios se almacenarán en la base de datos. A este modelo de trabajo lo llamamos Modelo Conectado. La idea de este modelo es que utilizamos la misma instancia del DbContext tanto para consultar la data como para editarla. Esta es la forma más simple de trabajar, sin embargo no siempre vamos a recibir la instancia de la entidad desde el cliente. Esto se da bastante en escenarios web en donde el cliente va a tener un formulario, lo va a llenar y nos va a enviar la data del formulario a traves de una petición HTTP, lo que quiere decir que es ainstancia de la entidad no fue creada por el mismo DbContext con el cual va a ser procesada. A esto le llamamos Modelo Desconectado. Por ejemplo, si trabajamos con un cliente o una aplicación de React, nos podría enviar un actor para que editemos una de sus propiedades. Los cambios realizados en la entidad actor van a ser actualizados en la base de datos a través de un DbContext distinto al que cargó dicha entidad. ¿Y cómo podemos hacer para que EF Core tome una simple instancia de una clase y modifique registros de una base de datos con ella? Pues esto se trabaja con el Status de la Entidad. 
            Como mencionabamos anteriormente, EF Core le da seguimiento a nuestras instancias de entidades, este seguimiento se realiza a traves del status registrado de cada instancia. Los siguientes son los status que maneja EF Core:
            - Agregado/Added: Una entidad tiene que ser creada en la bd.
            - Modificado/Modified: La entidad representa un registro de la bd y dicha entidad tiene cambios pendientes ded replicar en el registro correspondiente.
            - Sin Modificar/Unchanged: La entidad representa un registro de la bd pero no hay cambios pendientes para guardar.
            - Borrado/Deleted: Una entidad representa un registro de la bd y dicho registro debe ser eliminado.
            - Sin seguimiento/Detached: Es cuando una entidad no está recibiendo ningún seguimiento por EF Core.*/


        [HttpPost("postSimple")]
        public async Task<ActionResult> Post(Genero genero)
        {
            /*En la siguiente linea lo que estamos haciendo es cambiar el status de la entidad género. No es que ya s eva a agregar
             a la bd sino que está marcando ese objeto como próximo a agregar para cuando ejecutemos la función SaveChanges se agregue a la bd.*/

            /*Con el Savechanges EF Core va a chequear todos los objetos con seguimiento, va a verificar su status y con dicho status
             va a realizar algo. En la linea anterior el objeto genero está marcado como agregado, entonces SaveChanges lo va a agregar a la bd.*/

            /*SI queremos evitar el código 500 al agregar un registro duplicado (el caso del campo Nombre que funciona como índice) podemos agregar la siguiente validación:*/

            var existeGeneroConNombre = await _context.Generos.AnyAsync(g => g.Nombre == genero.Nombre);

            if (existeGeneroConNombre)
            {
                return BadRequest("Ya existe un género con ese nombre: " + genero.Nombre);
            }
            /*Ya hemos visto que podemos usar métodos como Add, Update y Remove para cambiar el status de una entidad. Sin embargo, también 
             * podemos usar Entry para cambiar el status directamente de una entidad.*/

            /*El Add lo que hace sencillamente es cambiar el status de la entidad en memoria.*/
            _context.Add(genero);

            /*En lugar de hacerlo con Add lo vamos a hacer directamente. Entonces con esto estanos diciendo que el status de éste genero
             va a ser agregado y por lo tanto cuando se ejecute el SaveChanges veremos que se agrega el género en la base de datos.*/

            _context.Entry(genero).State = EntityState.Added;
            await _context.SaveChangesAsync();
            return Ok();

            /*Y si intentamos agregar nuevamente un genero con el mismo nombre ahora recibimos un Error 400*/
        }

        [HttpPost("postMultiple")]
        public async Task<ActionResult> Post(Genero[] generos)
        {
            _context.AddRange(generos);
            await _context.SaveChangesAsync();
            return Ok();
        }

        /*Vamos a ver como actualizar registros con el modelo conectado. Recordamos que cuando hablamos de modelo conectado
        estamos diciendo que la entidad a actualizar va a ser cargada por el mismo DbContext, es decir, ambas operaciones
        seran realizadas por la misma instancia de DbContext*/
        /*El primer ejemplo simple consiste en agregar un número 2 al final del género*/

        [HttpPost("agregar2")]
        public async Task<ActionResult> Agregar2(int id)
        {
            /*Colocamos AsTracking ya que por defecto tenemos configurado AsNoTracking a nivel global por defecto*/
            var genero = await _context.Generos.AsTracking().FirstOrDefaultAsync(g => g.Id == id);

            if (genero == null)
            {
                return NotFound();
            }
            else
            {
                genero.Nombre += "2";
            }

            await _context.SaveChangesAsync();
            return Ok();

            /*Es conectado porque estoy usando el mismo DbContext tanto para cargar el género como para actualizarlo-grabarlo*/


        }

        /*BORRADO NORMAL - EJEMPLO*/
        [HttpDelete("{id:int}")]
        public async Task<ActionResult> Delete(int id)
        {
            var genero = await _context.Generos.FirstOrDefaultAsync(g => g.Id == id);
            if (genero is null)
            {
                return NotFound();
            }
            _context.Remove(genero); //Remove es el cambia el status del género a borrado
            await _context.SaveChangesAsync();
            return Ok();
        }

        /*BORRADO LÓGICO - EJEMPLO*/
        [HttpDelete("BorradoLogico/{id:int}")]
        public async Task<ActionResult> DeleteLogico(int id)
        {
            /*Colocamos AsTracking xq vamos a hacer una actualización, es decir,cambiar el valor del campo booleano*/
            var genero = await _context.Generos.AsTracking().FirstOrDefaultAsync(g => g.Id == id);
            if (genero is null)
            {
                return NotFound();
            }
            genero.EstaBorrado = true;
            await _context.SaveChangesAsync();
            return Ok();
        }

        /*Endpoint Get para traer aquellos géneros que no han sido borrados de manera lógica/no han sido dados de baja*/
        [HttpGet("NoBorradosLogico")]
        public async Task<IEnumerable<Genero>> GetNoBorradosLogico()
        {
            var genero = await _context.Generos
                .Where(g => g.EstaBorrado == false)
                .ToListAsync();

            return genero;
        }
        /*O en lugar de crear un nuevo endpoint podemos refactorizar alguno de los ya creados previamente*/

        /*Pero entonces en cada verbo Get o cada acción que requiera géneros vamos a tener que refactorizar cada enpoint para indicar
         que solo nos traiga los activos (no borrados) y puede que se nos escape en algun momento. Para simplificar todo esto podemos aplicar
         Filtros por Defecto al Nivel del Modelo*/

        /*Aquellos filtros a nivel de modelo que configuremos siempre se van a aplicar en nuestra entidad. Veamos un ejemplo en
         GeneroConfig*/

        /*Y de esta forma ya no necesitaremos refactorizar cada endpoint agregando cláusula Where, condición o filtro.
         Trabajar sobre el API Fluente mediante los Config puede resultar más comodo y organizado*/

        /*Ahora vamos a ver cómo podemos saltarnos este filtro. Un caso puede ser cuando necesito restaurar un género borrado
         o cuando quiero mostrarle a un administrador todos los géneros incluidos los borrados. Para ello hacemos uso de una función
        llamada IgnoreQueryFilters. Lo vemos a continuación con un Post para restaurar géneros:*/

        [HttpPost("Restaurar/{id:int}")]
        public async Task<ActionResult> Restaurar(int id)
        {
            var genero = await _context.Generos.AsTracking()
                .IgnoreQueryFilters()
                .FirstOrDefaultAsync(g => g.Id == id);
            if (genero is null)
            {
                return NotFound();
            }
            genero.EstaBorrado = false;
            await _context.SaveChangesAsync();
            return Ok();
        }
        /*Ejecutamos el endpoint y podemos observar cómo el registro cambia su estado lógico, por lo cual vuelve a 
         aparecer cuando realizamos la petición Get mediante su id o consultamos todos los géneros. Cuando estaba dado de baja
         e intentabamos traerlo por su id nos arrojaba Error 404 pero al restaurarlo mediante el Post volvemos a intentar traerlo
         y ahora nos lo devuelve con su respectivo Código 200-*/




        /*RESUMEN DE SECCIÓN 4: CRUD*/

        /*Modelo Conectado: Es cuando el DbContext que carga una entidad es el mismo que usamos para editarla.

          Modelo Desconectado: Es cuando intentamos editar una entidad utilizando un DbContext distinto al que la ha cargado.

          Add: Usamos ese método para cambiar el status de la entidad en memoria, para que cuando utilicemos Savechanges la entidad sea insertada
          en la base de datos.

          Mapeo Flexible: Nos sirve para poder mapear un campo a una columna, en vez de una propiedad a una columna. Esto nos da la flexibilidad de poder
          realizar transformaciones a la data antes de insertarla en la bd.

          Update: Podemos marcar un registro como modificado, lo que significa que cuando ejecutemos SaveChanges EF Core se va a encargar de actualizar el registro
          correspondiente en la bd. Esta es la forma en la cual actualizamos un registro utilizando Modelo Desconectado. En el caso de Modelo Conectado no es necesario
          utilizar la función update, sino que podemos actualizar las propiedades de la entidad y al utilizar SaveChanges los campos modificados serán persistidos en la bd.

          Remove: Podemos actualizar el status de una entidad a borrada, para que cuando ejecutemos SaveChanges el registro en la bd sea eliminado. 

          Borrado Lógico o Suave: Nos permite marcar un registro como borrado pero sin realmente removerlo de la tabla. Esto es útil cuando queremos permitir
          una funcionalidad de borrado pero cuando necesitamos conservar la data para uso futuro (ej.: historial).

          Filtros a Nivel del Modelo: Lo utilizamos para configurar filtros por defecto en nuestras entidades. Podemos saltarnos dichos filtros en los queries querramos.
        */

        [HttpPut]
        public async Task<ActionResult> Put(Genero genero)
        {
            _context.Update(genero);
            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpPut("ActualizacionDTO")]
        public async Task<ActionResult> Put(GeneroActualizacionDTO generoActualizacionDTO)
        {
            var genero = _mapper.Map<Genero>(generoActualizacionDTO);
            _context.Update(genero);
            _context.Entry(genero).Property(g => g.Nombre).OriginalValue = generoActualizacionDTO.Nombre_Original;

            await _context.SaveChangesAsync();
            return Ok();
        }

        //Sentencia Arbitraria 

        [HttpPost("PostArbitrario")]
        public async Task<ActionResult> PostArbitrario(Genero genero)
        {
            var existe = await _context.Generos.AnyAsync(g => g.Nombre == genero.Nombre);

            if (existe)
            {
                return BadRequest("Género ya existe");
            }


            await _context.Database.ExecuteSqlInterpolatedAsync($@"INSERT INTO GENEROS (NombreGenero, EstaBorrado) VALUES ({genero.Nombre},{0})");
            await _context.SaveChangesAsync();

            return Ok();

            //Funciona, pero ver xq no agrega automáticamente el campo EstaBorrado=false.
            //Por un lado supongo que se debe a que estamos realizando un post arbitrario
            //y no utilizando linq o el criterio estandarizado por defecto (GeneroConfig)
        }

        [HttpGet("procedimientoAlmacenado/{id:int}")]
        public async Task<ActionResult<Genero>> GetSP(int id)
        {
            var generos = _context.Generos.FromSqlInterpolated($"EXEC Generos_ObtenerPorId {id}")
                .IgnoreQueryFilters()
                .AsAsyncEnumerable();

            //Aunque sea un único resultado debemos utilizar AsAsyncEnumerable() ya que de lo contrario
            // no funcionará. Esto se debe a que este query arbitrario no puede ser modificado libremente
            // por EF Core o no sigue las reglas estandarizadas por el framework.

            await foreach ( var genero in generos )
            {
                return genero;
            }
            return NotFound();

        }

        [HttpPost("procedimientoAlmacenado")]
        public async Task<ActionResult> PostSP(Genero genero)
        {
            var existeGenero = await _context.Generos.AnyAsync(g => g.Nombre == genero.Nombre);

            if (existeGenero)
            {
                return BadRequest("Género ya existe");
            }

            //Necesitamos extraer el id del sp, ya que es de tipo output. Para ello creamos un SqlParameter

            var outputId = new SqlParameter();
            outputId.ParameterName = "id";
            outputId.SqlDbType = System.Data.SqlDbType.Int;
            outputId.Direction = System.Data.ParameterDirection.Output;

            await _context.Database.ExecuteSqlRawAsync("EXEC Generos_Insertar @nombre = {0}, @id = {1} OUTPUT ", genero.Nombre, outputId);

            var id=(int)outputId.Value;

            return Ok(id);

            //Al ejecutar el endpoint nos devolverá el id del género recién creado
        }


        //Conflicto de Concurencia por Campo

        //Situación de ejemplo simulada; los cambios que se guardarán son los de primera persona

        [HttpPost("concurrency_token")]
        public async Task<ActionResult> ConcurrencyToken()
        {
            var generoId = 1;

            //Primera persona lee la bd
            
            var genero=await _context.Generos.FirstOrDefaultAsync(g=>g.Id==generoId);

            genero.Nombre = "Nombre cambiado por primera persona";

            //Segunda persona intenta actualizar el registro

            await _context.Database.ExecuteSqlInterpolatedAsync($@"UPDATE Generos SET NombreGenero={genero.Nombre} 
            WHERE id={generoId}");


            //Primera persona intenta actualizar
            await _context.SaveChangesAsync();

            return Ok();

        }

        //Consultando Tabla Temporal y Tabla Histórica

        [HttpPut("modificar_varias_veces")]
        public async Task<ActionResult> ModificarVariasVeces()
        {
            var id = 47;
            var genero=await _context.Generos.AsTracking().FirstOrDefaultAsync(g=>g.Id == id);

            genero.Nombre = "Modificacion1";
            await _context.SaveChangesAsync();
            await Task.Delay(2000);

            genero.Nombre = "Modificacion2";
            await _context.SaveChangesAsync();
            await Task.Delay(2000);

            genero.Nombre = "Modificacion3";
            await _context.SaveChangesAsync();
            await Task.Delay(2000);

            genero.Nombre = "Modificacion4";
            await _context.SaveChangesAsync();
            await Task.Delay(2000);

            genero.Nombre = "Modificacion5";
            await _context.SaveChangesAsync();
            await Task.Delay(2000);

            genero.Nombre = "Modificacion6";
            await _context.SaveChangesAsync();
            await Task.Delay(2000);

            genero.Nombre = "ModificacionActual";
            await _context.SaveChangesAsync();
            await Task.Delay(2000);

            return Ok();
        }

        [HttpGet("getTablaTemporal/{id:int}")]
        public async Task<ActionResult<Genero>> GetTablaHistorica(int id)
        {
            var genero=await _context.Generos.AsTracking().FirstOrDefaultAsync(g=>g.Id == id);
            var periodStart = _context.Entry(genero).Property<DateTime>("PeriodStart").CurrentValue;
            var periodEnd = _context.Entry(genero).Property<DateTime>("PeriodEnd").CurrentValue;

            if(genero is null)
            {
                return NotFound();
            }
            var fechaCreacion = _context.Entry(genero).Property<DateTime>("FechaCreacion").CurrentValue;

            return Ok(new
            {
                Id=genero.Id,
                Nombre=genero.Nombre,
                fechaCreacion,
                periodStart,
                periodEnd
            });
        }

        [HttpGet("TemporalAll/{id:int}")]
        public async Task<ActionResult> GetTemporalAll(int id)
        {
            //Con TemporalAll indico que quiero traer todos los registros tanto de la tabla temporal y de la tabla historica
            var generos=await _context.Generos.TemporalAll().AsTracking()
                .Where(g=>g.Id == id)
                .Select(g => new
                {
                    Id=g.Id,
                    Nombre=g.Nombre,
                    PeriodStart=EF.Property<DateTime>(g,"PeriodStart"),
                    PeriodEnd=EF.Property<DateTime>(g,"PeriodEnd")
                })
                .ToListAsync();
            return Ok(generos);
        }

        //TemporalAsOf - consultar registro temporal en determinado momento o fecha
        [HttpGet("TemporalAsOf/{id:int}")]
        public async Task<ActionResult<Genero>> GetTemporalAsOf(int id, DateTime fecha)
        {
            var genero = await _context.Generos.TemporalAsOf(fecha).AsTracking()
                .Where(g => g.Id == id)
                .Select(g => new
                {
                    Id = g.Id,
                    Nombre = g.Nombre,
                    PeriodStart = EF.Property<DateTime>(g, "PeriodStart"),
                    PeriodEnd = EF.Property<DateTime>(g, "PeriodEnd")
                })
                .FirstOrDefaultAsync();
            return Ok(genero);
        }

        //TemporalFromTo - consultar registros temporales dentro de un rango de fecha
        [HttpGet("TemporalFromTo/{id:int}")]
        public async Task<ActionResult<Genero>> GetTemporalFromTo(int id, DateTime fechaInicio, DateTime fechaFin)
        {
            var generos = await _context.Generos.TemporalFromTo(fechaInicio, fechaFin).AsTracking()
                .Where(g => g.Id == id)
                .Select(g => new
                {
                    Id = g.Id,
                    Nombre = g.Nombre,
                    PeriodStart = EF.Property<DateTime>(g, "PeriodStart"),
                    PeriodEnd = EF.Property<DateTime>(g, "PeriodEnd")
                })
                .ToListAsync();
            return Ok(generos);
        }
        
        //TemporalContained - consultar registros temporales en un rango de fecha
        [HttpGet("TemporalContainedIn/{id:int}")]
        public async Task<ActionResult<Genero>> GetTemporalContainedIn(int id, DateTime fechaInicio, DateTime fechaFin)
        {
            var generos = await _context.Generos.TemporalContainedIn(fechaInicio, fechaFin).AsTracking()
                .Where(g => g.Id == id)
                .Select(g => new
                {
                    Id = g.Id,
                    Nombre = g.Nombre,
                    PeriodStart = EF.Property<DateTime>(g, "PeriodStart"),
                    PeriodEnd = EF.Property<DateTime>(g, "PeriodEnd")
                })
                .ToListAsync();
            return Ok(generos);
        }

        /*TemporalBetween - consultar registros temporales activos dentro de un rango de fecha con la particularidad
         de que si la fechaInicio coincide con fechaFin pues éste es incluido en el resultado*/
        [HttpGet("TemporalBetween/{id:int}")]
        public async Task<ActionResult<Genero>> GetTemporalBetween(int id, DateTime fechaInicio, DateTime fechaFin)
        {
            var generos = await _context.Generos.TemporalBetween(fechaInicio, fechaFin).AsTracking()
               .Where(g => g.Id == id)
               .Select(g => new
               {
                   Id = g.Id,
                   Nombre = g.Nombre,
                   PeriodStart = EF.Property<DateTime>(g, "PeriodStart"),
                   PeriodEnd = EF.Property<DateTime>(g, "PeriodEnd")
               })
               .ToListAsync();
            return Ok(generos);
        }

        //Restaurar registro de la tabla histórica a la temporal

        //ESTE ENDPOINT NO FUNCIONA, ARROJA ERROR DE PK YA EXISTENTE. VER COMO SOLUCIONARLO

        [HttpPost("Restaurar_Borrado/{id:int}")]
        public async Task<ActionResult> RestaurarBorrado(int id, DateTime fecha)
        {
            var genero = await _context.Generos.TemporalAsOf(fecha).AsTracking()
                .IgnoreQueryFilters()
                .FirstOrDefaultAsync(g => g.Id == id);
            if (genero is null)
            {
                return NotFound();
            }

            /*Este bloque try lo colocamos porque de lo contrario al restaurar el nuevo género se crearía con un nuevo
             id y se perderían las relaciones que estaban con ese género, es decir, no coincidiría con el verdadero
            id del registro, además de que es identity*/
            try
            {
                await _context.Database.ExecuteSqlInterpolatedAsync($@"
                    SET IDENTITY_INSERT Generos ON;

                    INSERT INTO Generos (Id, NombreGenero, EstaBorrado)
                    VALUES ({genero.Id},{genero.Nombre}, 0)

                    SET IDENTITY_INSERT Generos OFF;
                    ");
            }
            finally
            {
                //Este bloque lo colocamos por si falla el cierre de IDENTITY_INSERT en el bloque try
                await _context.Database.ExecuteSqlRawAsync("SET IDENTITY_INSERT Generos OFF;");
            }

            return Ok();
        }





    }

}
