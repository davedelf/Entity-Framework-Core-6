using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace EFCorePeliculas.Entidades.Configuraciones
{
    public class FacturaConfig : IEntityTypeConfiguration<Factura>
    {
        public void Configure(EntityTypeBuilder<Factura> builder)
        {
            //Establecemos la relación entre Factura y DetalleFactura (1:N)

            builder.HasMany(typeof(DetalleFactura)).WithOne();

            //Secuencia
            builder.Property(f => f.NumeroFactura).HasDefaultValueSql("NEXT VALUE FOR Factura.NumeroFactura");
        }
    }
}
