using EFCorePeliculas.Entidades;
using EFCorePeliculas.Entidades.Configuraciones;
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
            
        }


        /*Siempre debemos crear/agregar los DbSet para cada tabla, sino no se crearán en la db*/
        public DbSet<Genero> Generos { get; set; }
        public DbSet<Actor> Actores { get; set; }
        public DbSet<Cine> Cines { get; set; }
        public DbSet<Pelicula> Peliculas { get; set; }
        public DbSet<CineOferta> CinesOfertas { get; set; }
        public DbSet<SalaDeCine> SalasDeCine { get; set; }
        public DbSet<PeliculaActor> PeliculasActores { get; set; }



    }
}
