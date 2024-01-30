using EFCorePeliculas.Entidades;
using EFCorePeliculas.Entidades.Configuraciones;
using EFCorePeliculas.Entidades.Seeding;
using EFCorePeliculas.Entidades.SinLlaves;
using Microsoft.EntityFrameworkCore;
using System.Reflection;

namespace EFCorePeliculas
{
    public class ApplicationDbContext : DbContext
    {
        /*Si no queremos entrar en conflicto al utilizar la inyección de dependencias para instanciar el DbContext colocamos un constructor y en la clase Program
         builder.Services.AddDbContext<ApplicationDbContext>();*/
        public ApplicationDbContext()
        {
            
        }
        public ApplicationDbContext(DbContextOptions options) : base(options)
        {

        }
        public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            ProcesarSalvado();
            return base.SaveChangesAsync(cancellationToken);
        }

        private void ProcesarSalvado()
        {
            foreach(var item in ChangeTracker.Entries().Where(e=>e.State== EntityState.Added && e.Entity is EntidadAuditable)) 
            {
                var entidad=item.Entity as EntidadAuditable;
                entidad.UsuarioCrecion = "Felipe";
                entidad.UsuarioModificacion = "Felipe";
            }

            foreach (var item in ChangeTracker.Entries().Where(e => e.State == EntityState.Modified && e.Entity is EntidadAuditable))
            {
                var entidad = item.Entity as EntidadAuditable;
                entidad.UsuarioModificacion = "Felipe2";
                item.Property(nameof(entidad.UsuarioCrecion)).IsModified = false;
            }
        }

        /*Para realiizar la misma configuración de inyección de dependencias pero en el mismo DbContext con el método OnConfiguring. Para no entrar en conflictos de configuración lo colocamos dentro de un condicional*/
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer("name=DefaultConnection", opciones =>
                {
                    opciones.UseNetTopologySuite();
                }).UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking);
            }
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
            //modelBuilder.Ignore<Direccion>();

            modelBuilder.Ignore<Direccion>();
            //Acá centralizamos el Select en el API Fluente
            //El .ToView(null) es para que no se nos agregue una tabla en bd sin ubicación.
            modelBuilder.Entity<CineSinUbicacion>()
                .HasNoKey()
                .ToSqlQuery("Select Id, Nombre FROM Cines")
                .ToView(null);
            //Si no queremos utilizar la notación [Keyless] en la entidad podemos colocar acá .HasNoKey()

            modelBuilder.Entity<PeliculaConConteos>().HasNoKey().ToView("PeliculasConConteos");

            //Automatizando Configuraciones en el API Fluente
            foreach(var tipoEntidad in modelBuilder.Model.GetEntityTypes())
            {
                foreach (var propiedad in tipoEntidad.GetProperties())
                {
                    if(propiedad.ClrType==typeof(string) && propiedad.Name.Contains("URL", StringComparison.CurrentCultureIgnoreCase))
                    {
                        propiedad.SetIsUnicode(false);
                        propiedad.SetMaxLength(500);
                    }
                }
            }
            /*Este tipo de configuracion va a tomar todos los modelos de la app, no importa cual sea. Estos tipos de configuraciones son útiles cuando tenemos
             aplicaciones grandes o muchos modelos. Lo que hestamos haciendo en esta configuración es que lea cada propiedad de cada modelo, se fije si es string y si su nombre
             es o contiene URL. En ese caso, no importa si está en mayúscula o minúscula, no lo convierte a Unicode.*/

            SeedingPersonaMensaje.Seed(modelBuilder);


            modelBuilder.Entity<Merchandising>().ToTable("Merchandising");
            modelBuilder.Entity<PeliculaAlquilable>().ToTable("PeliculasAlquilables");


            var pelicula1 = new PeliculaAlquilable()
            {
                Id = 1,
                Nombre = "Spider-Man",
                PeliculaId = 10,
                Precio = 5.99m
            };
            var merch1 = new Merchandising()
            {
                Id = 2,
                DisponibleEnInventario = true,
                EsRopa = true,
                Nombre = "Remera",
                Peso = 1,
                Volumen = 1,
            };

            modelBuilder.Entity<Merchandising>().HasData(merch1);
            modelBuilder.Entity<PeliculaAlquilable>().HasData(pelicula1);


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
        public DbSet<Persona> Personas { get; set; }
        public DbSet<Mensaje> Mensajes { get; set; }


        /*ÍNDICES*/

        /*Podemos crear índices en nuestras tablas para aumentar la velocidad de ciertas consultas. Esto es importante cuando tenemos 
         bases de datos masivas las cuales no es viable hacer un fullscan o búsqueda completa cada vez que hagamos un query, es más
        rápido auxiliarse de índices para realizar búsquedas. Además los índices pueden ser configurados como únicos en el sentido de que
        nos garantizan que otra fila no va a tener el mismo valor, por ejemplo, si tenemos un campo Email y queremos que dicho campo no se 
        repita en toda la tabla podemos configurar un índice único para evitar esta repetición y para acelerar la velocidad de las búsquedas 
        por dicho campo de Email.
        En teoría ya hemos utilizado índices, pues las claves primarias son automáticamente configuradas como índices únicos, sin embargo podemos tener
        otros campos, además de la clave primaria, configurados como índices. Vemos un ejemplo en la tabla Géneros*/
        public DbSet<CineDetalle>CineDetalles { get; set; }
        public DbSet<Pago> Pagos { get; set; }
        public DbSet<Producto>Productos { get; set; }




    }
}
