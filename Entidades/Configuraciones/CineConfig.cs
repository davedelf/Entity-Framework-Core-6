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
        }
    }
}
