using EFCorePeliculas.Entidades;
using EFCorePeliculas.Entidades.Configuraciones;
using EFCorePeliculas.Entidades.SinLlaves;
using Microsoft.EntityFrameworkCore;
using System.Reflection;

namespace EFCorePeliculas
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions options) : base(options)
        {

        }

        /*CONFIGURACIÓN DE CONVENCIONES*/
        /*Cuando hablamos de convenciones nos referimos a las acciones por defecto de EF, por ejemplo, que los campos string los mapea a 
         nvarcharmax por defecto. Podemos alterar esas convenciones por defecto a convenciones personalizadas (como hicimos con mapear 
         datetime a date). Para ello hacemos uso de ConfigureConventions*/

        protected override void ConfigureConventions(ModelConfigurationBuilder configurationBuilder)
        {
            configurationBuilder.Properties<DateTime>().HaveColumnType("date");
            /*Y con esto es suficiente. Por defecto, cada vez que agreguemos un campo DateTime se va a mapear a Date*/
        }



        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            

            base.OnModelCreating(modelBuilder);

            /*De esta forma aplicamos las configuraciones*/

            // modelBuilder.ApplyConfiguration(new ActorConfig());
            // modelBuilder.ApplyConfiguration(new CineConfig());
            // modelBuilder.ApplyConfiguration(new CineOfertaConfig());
            // modelBuilder.ApplyConfiguration(new GeneroConfig());
            // modelBuilder.ApplyConfiguration(new PeliculaActorConfig());
            // modelBuilder.ApplyConfiguration(new PeliculaConfig());
            // modelBuilder.ApplyConfiguration(new SalaDeCineConfig());


            /*Para evitar tener que agregar una por una, hacemos lo siguiente: */

            modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());

            /*Lo que se refiere a Assembly es "escanea todo este proyecto y toma todas esas clases
             que heredan de IEntityTypeConfiguration y aplícalas en nuestro API Fluente*/

            /*De esta forma nos queda más compacto y más bonito-ordenado*/

            /*Misma configuración que en la entidad (anotación) pero a nivel convención*/
            //modelBuilder.Entity<Log>().Property(l=>l.Id).ValueGeneratedNever();

            /*Para ignorar siempre la clase Direccion*/

            modelBuilder.Ignore<Direccion>();
            //Acá centralizamos el Select en el API Fluente
            //El .ToView(null) es para que no se nos agregue una tabla en bd sin ubicación.
            modelBuilder.Entity<CineSinUbicacion>()
                .HasNoKey()
                .ToSqlQuery("Select Id, Nombre FROM Cines")
                .ToView(null);
            //Si no queremos utilizar la notación [Keyless] en la entidad podemos colocar acá .HasNoKey()
            
        }


        /*Siempre debemos crear/agregar los DbSet para cada tabla, sino no se crearán en la db*/
        public DbSet<Genero> Generos { get; set; }
        public DbSet<Actor> Actores { get; set; }
        public DbSet<Cine> Cines { get; set; }
        public DbSet<Pelicula> Peliculas { get; set; }
        public DbSet<CineOferta> CinesOfertas { get; set; }
        public DbSet<SalaDeCine> SalasDeCine { get; set; }
        public DbSet<PeliculaActor> PeliculasActores { get; set; }
        public DbSet<Log> Logs { get; set; }


        /*ÍNDICES*/

        /*Podemos crear índices en nuestras tablas para aumentar la velocidad de ciertas consultas. Esto es importante cuando tenemos 
         bases de datos masivas las cuales no es viable hacer un fullscan o búsqueda completa cada vez que hagamos un query, es más
        rápido auxiliarse de índices para realizar búsquedas. Además los índices pueden ser configurados como únicos en el sentido de que
        nos garantizan que otra fila no va a tener el mismo valor, por ejemplo, si tenemos un campo Email y queremos que dicho campo no se 
        repita en toda la tabla podemos configurar un índice único para evitar esta repetición y para acelerar la velocidad de las búsquedas 
        por dicho campo de Email.
        En teoría ya hemos utilizado índices, pues las claves primarias son automáticamente configuradas como índices únicos, sin embargo podemos tener
        otros campos, además de la clave primaria, configurados como índices. Vemos un ejemplo en la tabla Géneros*/
        



    }
}
