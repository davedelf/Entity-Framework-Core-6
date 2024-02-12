using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace EFCorePeliculas.Entidades.Configuraciones
{
    public class DetalleFacturaConfig : IEntityTypeConfiguration<DetalleFactura>
    {
        public void Configure(EntityTypeBuilder<DetalleFactura> builder)
        {
            builder.Property(f => f.Total)
                .HasComputedColumnSql("Precio * Cantidad");
        }

        /*
         Si la operación es muy lenta entonces conviene guardar el resultado - stored:true - pero a costa de 
        consumir más espacio; caso contrario, si la operación es rápida como en este caso, no conviene guardar
        el resultado - stored:false -
         */
    }
}
