using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace EFCorePeliculas.Entidades.Configuraciones
{
    public class PagoConfig : IEntityTypeConfiguration<Pago>
    {
        public void Configure(EntityTypeBuilder<Pago> builder)
        {
            /*Discriminator se refiere a una columna que va a permitir a EF Core determinar si
             un pago va a ser de Paypal o de Tarjeta, es decir, a qué clase derivada le corresponde
             un registro en específico. */
            builder.HasDiscriminator(p => p.TipoPago)
                .HasValue<PagoPaypal>(TipoPago.Paypal)
                .HasValue<PagoTarjeta>(TipoPago.Tarjeta);

            builder.Property(p => p.Monto).HasPrecision(18, 2);
        }
    }
}
