﻿using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System.Reflection.Emit;

namespace EFCorePeliculas.Entidades.Configuraciones
{
    public class ActorConfig : IEntityTypeConfiguration<Actor>
    {
        public void Configure(EntityTypeBuilder<Actor> builder)
        {
            builder.Property(prop => prop.Nombre)
                .HasMaxLength(150)
                .IsRequired();
            /*MAPEAR DATETIME A DATE*/
            //modelBuilder.Entity<Actor>().Property(prop => prop.FechaNacimiento).HasColumnType("date");


            /*Acá indicamos que la propiedad Nombre tiene el Campo _nombre*/
            builder.Property(x => x.Nombre).HasField("_nombre");


            builder.Ignore(a => a.Edad);

            builder.Ignore(a => a.Direccion);
        }
    }
}
