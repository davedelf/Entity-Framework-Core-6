using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System.Reflection.Emit;

namespace EFCorePeliculas.Entidades.Configuraciones
{
    public class CineConfig : IEntityTypeConfiguration<Cine>
    {
        public void Configure(EntityTypeBuilder<Cine> builder)
        {
            //Notif. Personalizada: cambiamos la estrategia de detección de cambios

            builder.HasChangeTrackingStrategy(ChangeTrackingStrategy.ChangedNotifications);

            builder.Property(prop => prop.Nombre).HasMaxLength(150).IsRequired();

            //Configuramos la relación uno a uno con el API Fluente

            builder.HasOne(c => c.CineOferta)
                .WithOne()
                .HasForeignKey<CineOferta>(co => co.CineId);

            //Un Cine tiene un cineOferta - HasOne - y un CineOferta tiene un Cine - WithOne -

            //Configuración 1:N entre Cine y SalasDeCine con API Fluente

            builder.HasMany(c => c.SalasDeCine)
                .WithOne(s => s.Cine)
                .HasForeignKey(s => s.CineId)

                //Con esta opción estamos restringiendo el borrado del cine, es decir, si tiene salas de cine
                //relacionadas no podremos borrarlo. Usar NoAction también es válido/cumple la misma función.

                //.OnDelete(DeleteBehavior.Restrict);

                //Colocamos Cascade para que la notificación personalizada funcione
                .OnDelete(DeleteBehavior.Cascade);

            builder.HasOne(c => c.CineDetalle)
                .WithOne(cd => cd.Cine)
                .HasForeignKey<CineDetalle>(cd => cd.Id);


            //Un Cine tiene varias SalasDeCine mientras que una SalaDeCine tiene solo un Cine

            /*Con esto podemos configurar el nombre de las columnas que se generan al crear la migración. 
             * Si observamos el comportamiento de la misma veremos que todo lo que respecte a la propiedad Dirección
             * se colocará con su prefijo Direccion_/campo/ y lo mismo con BillingAdress_/campo/. Si queremos personalizar
             dicho comportamiento podemos hacerlo con el API Fluente de la siguiente forma:*/
            builder.OwnsOne(c => c.Direccion, dir =>
            {
                dir.Property(d => d.Calle).HasColumnName("Calle");
                dir.Property(d => d.Provincia).HasColumnName("Provincia");
                dir.Property(d => d.Pais).HasColumnName("Pais");
            });
        }
    }
}
