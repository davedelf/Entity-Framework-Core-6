using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace EFCorePeliculas.Entidades.Configuraciones
{
    public class CineDetalleConfig : IEntityTypeConfiguration<CineDetalle>
    {
        public void Configure(EntityTypeBuilder<CineDetalle> builder)
        {
            //Estoy diciendo que la tabla CineDetalle va a mapear con la tabla Cines, que es la misma tabla
            // de nuestra entidad Cine
            builder.ToTable("Cines");
        }
    }
}
