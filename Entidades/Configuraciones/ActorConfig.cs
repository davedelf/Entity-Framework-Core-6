using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System.Reflection.Emit;

namespace EFCorePeliculas.Entidades.Configuraciones
{
    public class ActorConfig : IEntityTypeConfiguration<Actor>
    {
        public void Configure(EntityTypeBuilder<Actor> builder)
        {
            builder.Property(prop => prop.Nombre)
                .HasMaxLength(150)
                .IsRequired();
            /*MAPEAR DATETIME A DATE*/
            //modelBuilder.Entity<Actor>().Property(prop => prop.FechaNacimiento).HasColumnType("date");


            /*Acá indicamos que la propiedad Nombre tiene el Campo _nombre*/
            builder.Property(x => x.Nombre).HasField("_nombre");


            builder.Ignore(a => a.Edad);

            builder.Ignore(a => a.Direccion);

            builder.OwnsOne(a => a.DireccionHogar, dir =>
            {
                dir.Property(d => d.Calle).HasColumnName("Calle");
                dir.Property(d => d.Provincia).HasColumnName("Provincia");
                dir.Property(d => d.Pais).HasColumnName("Pais");
            });

            // Dejamos por defecto el BillingAdress para que siga la nomenclatura convencional y veremos que a la hora de realizar
            // la migración, DirecciónHogar tendrá los nombres de columnas que especificamos y BillingAdress no. Lo mismo
            // sucede con Dirección de Cine.
        }
    }
}
