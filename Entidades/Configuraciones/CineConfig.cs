using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System.Reflection.Emit;

namespace EFCorePeliculas.Entidades.Configuraciones
{
    public class CineConfig : IEntityTypeConfiguration<Cine>
    {
        public void Configure(EntityTypeBuilder<Cine> builder)
        {
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
                .OnDelete(DeleteBehavior.Restrict);


            //Un Cine tiene varias SalasDeCine mientras que una SalaDeCine tiene solo un Cine
        }
    }
}
