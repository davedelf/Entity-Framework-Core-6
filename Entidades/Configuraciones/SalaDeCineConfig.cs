using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System.Reflection.Emit;

namespace EFCorePeliculas.Entidades.Configuraciones
{
    public class SalaDeCineConfig : IEntityTypeConfiguration<SalaDeCine>
    {
        public void Configure(EntityTypeBuilder<SalaDeCine> builder)
        {
            builder.Property(prop => prop.Precio).HasPrecision(precision: 9, scale: 2);
            /*A la hora de realizar la migración, el valor por defecto que se agrega a TipoSalaDeCine es 0. Podemos cambiar dicho valor
             directamente especificando el valor que se agregará. En este caso todas las salas de cine se crearan por defecto con el valor
            asociado a DosDimensiones, que es 1. Ahora vemos que en la migración el defaultValue es 1*/
            builder.Property(prop => prop.TipoSalaDeCine).HasDefaultValue(TipoSalaDeCine.DosDimensiones);
        }
    }
}
