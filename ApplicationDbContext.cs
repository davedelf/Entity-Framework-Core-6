using EFCorePeliculas.Entidades;
using Microsoft.EntityFrameworkCore;

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
            /*CLAVE PRIMARIA*/
            /*Ejemplo 2: Declarar campo clave primaria con API Fluente*/

            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Genero>().HasKey(prop => prop.Id);
            /*LONGITUD MÁXIMA DE UN CAMPO DE TEXTO*/
            /*Ejemplo 2: Longitud máxima con API FLuente*/
            modelBuilder.Entity<Genero>().Property(prop => prop.Nombre).HasMaxLength(150).IsRequired().HasColumnName("NombreGenero");
            /*(puedo alterar el nombre de las propiedades, no afecta a su funcionamiento)*/
            /*CAMBIANDO NOMBRES Y ESQUEMA*/
            modelBuilder.Entity<Genero>().ToTable(name: "TablaGeneros", schema: "peliculas");
            /*Por lo general estas propiedades .ToTable() y .HasColumnName() no se suelen utilizar, pero en ciertas ocasiones pueden 
             resultar útiles, sobre todo cuando queremos hardcodear*/

            modelBuilder.Entity<Actor>().Property(prop => prop.Nombre).HasMaxLength(150).IsRequired();
            /*MAPEAR DATETIME A DATE*/
            //modelBuilder.Entity<Actor>().Property(prop => prop.FechaNacimiento).HasColumnType("date");

            modelBuilder.Entity<Cine>().Property(prop => prop.Nombre).HasMaxLength(150).IsRequired();
            modelBuilder.Entity<SalaDeCine>().Property(prop => prop.Precio).HasPrecision(precision: 9, scale: 2);
            /*A la hora de realizar la migración, el valor por defecto que se agrega a TipoSalaDeCine es 0. Podemos cambiar dicho valor
             directamente especificando el valor que se agregará. En este caso todas las salas de cine se crearan por defecto con el valor
            asociado a DosDimensiones, que es 1. Ahora vemos que en la migración el defaultValue es 1*/
            modelBuilder.Entity<SalaDeCine>().Property(prop => prop.TipoSalaDeCine).HasDefaultValue(TipoSalaDeCine.DosDimensiones);

            modelBuilder.Entity<Pelicula>().Property(prop => prop.Titulo).HasMaxLength(250).IsRequired();
            //modelBuilder.Entity<Pelicula>().Property(prop => prop.FechaEstreno).HasColumnType("date");
            modelBuilder.Entity<Pelicula>().Property(prop => prop.PosterURL).HasMaxLength(500).IsUnicode(false);
            /*Unicode se recomienda cuando necesitamos guardar informacion ingresada por el usuario donde contenga caracteres especiales,
             emojis, entre otros, como ser comentarios. En el caso de las URL no utilizamos todos los caracteres especiales, por ello 
             lo colocamos en false. Siempre tener en cuenta esta característica a la hora de configurar los campos.*/
            modelBuilder.Entity<CineOferta>().Property(prop => prop.PorcentajeDescuento).HasPrecision(precision: 5, scale: 2);
            //modelBuilder.Entity<CineOferta>().Property(prop=>prop.FechaInicio).HasColumnType("date");
            //modelBuilder.Entity<CineOferta>().Property(prop=>prop.FechaFin).HasColumnType("date");

            modelBuilder.Entity<PeliculaActor>().HasKey(prop => new { prop.PeliculaId, prop.ActorId }); //Con esto indicamos la clave compuesta de la tabla intermedia.
            modelBuilder.Entity<PeliculaActor>().Property(prop => prop.Personaje).HasMaxLength(150);
            
            
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
