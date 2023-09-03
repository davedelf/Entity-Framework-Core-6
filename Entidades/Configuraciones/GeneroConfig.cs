using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System.Reflection.Emit;

namespace EFCorePeliculas.Entidades.Configuraciones
{
    public class GeneroConfig : IEntityTypeConfiguration<Genero>
    {
        public void Configure(EntityTypeBuilder<Genero> builder)
        {
            builder.HasKey(prop => prop.Id);
            /*LONGITUD MÁXIMA DE UN CAMPO DE TEXTO*/
            /*Ejemplo 2: Longitud máxima con API FLuente*/
            builder.Property(prop => prop.Nombre).HasMaxLength(150).IsRequired().HasColumnName("NombreGenero");
            /*(puedo alterar el nombre de las propiedades, no afecta a su funcionamiento)*/
            /*CAMBIANDO NOMBRES Y ESQUEMA*/
            builder.ToTable(name: "TablaGeneros", schema: "peliculas");
            /*Por lo general estas propiedades .ToTable() y .HasColumnName() no se suelen utilizar, pero en ciertas ocasiones pueden 
             resultar útiles, sobre todo cuando queremos hardcodear*/
        }
    }
}
