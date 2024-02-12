using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System.Reflection.Emit;

namespace EFCorePeliculas.Entidades.Configuraciones
{
    public class PeliculaConfig : IEntityTypeConfiguration<Pelicula>
    {
        public void Configure(EntityTypeBuilder<Pelicula> builder)
        {
            builder.Property(prop => prop.Titulo).HasMaxLength(250).IsRequired();
            //modelBuilder.Entity<Pelicula>().Property(prop => prop.FechaEstreno).HasColumnType("date");
            builder.Property(prop => prop.PosterURL).HasMaxLength(500).IsUnicode(false);
            /*Unicode se recomienda cuando necesitamos guardar informacion ingresada por el usuario donde contenga caracteres especiales,
             emojis, entre otros, como ser comentarios. En el caso de las URL no utilizamos todos los caracteres especiales, por ello 
             lo colocamos en false. Siempre tener en cuenta esta característica a la hora de configurar los campos.*/

            //SkipNavigation: Configuración de la relación N:N sin la utilización de Entidad Intermedia
            builder.HasMany(p => p.Generos)
                .WithMany(g => g.Peliculas)
            //Una configuración que podemos hacer es respecto a la Tabla Intermedia (ojo, no la entidad intermedia)
            // que une las dos entidades. También podemos usar Seeding con el HasData, es decir, "sembrar" o colocar valores
            // por defecto.
                .UsingEntity(j => j.ToTable("GenerosPeliculas").HasData(new {PeliculasId=1,GenerosId=7}));
        }
    }
}
