using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System.Reflection.Emit;

namespace EFCorePeliculas.Entidades.Configuraciones
{
    public class PeliculaActorConfig : IEntityTypeConfiguration<PeliculaActor>
    {
        public void Configure(EntityTypeBuilder<PeliculaActor> builder)
        {
            builder.HasKey(prop => new { prop.PeliculaId, prop.ActorId }); //Con esto indicamos la clave compuesta de la tabla intermedia.
            builder.Property(prop => prop.Personaje).HasMaxLength(150);

            
            //Relación 1:N entre Actor y PeliculasActores y 1:N entre Pelicula y PeliculasActores

            // que en conjunto conforman la relación N:N. Esto lo podemos hacer mediante una entidad intermedia (PeliculaActor)
            // o con el API Fluente como el siguiente ejemplo:
            builder.HasOne(p => p.Actor)
                .WithMany(a => a.PeliculasActores)
                .HasForeignKey(pa => pa.ActorId);

            builder.HasOne(pa => pa.Pelicula)
                .WithMany(p => p.PeliculasActores)
                .HasForeignKey(pa => pa.PeliculaId);

            /*Recordamos que tenemos dos formas de trabajar la relación N:N
             - Con una entidad intermedia definida por nosotros, como la relación Películas - Actores = PeliculaActore
             - Sin la entidad intermedia, como hicimos con Películas - Géneros

            Recordamos que no podemos configurar una pk compuesta ni por convenciones ni por anotaciones de datos, para ello
            hacemos uso del API Fluente. En las líneas de arriba estamos configurando la pk compuesta con el API Fluente.
             */
            

        }
    }
}
