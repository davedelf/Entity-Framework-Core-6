﻿// <auto-generated />
using System;
using EFCorePeliculas;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using NetTopologySuite.Geometries;

#nullable disable

namespace EFCorePeliculas.Migrations
{
    [DbContext(typeof(ApplicationDbContext))]
    [Migration("20231017235509_EjemploPersona")]
    partial class EjemploPersona
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "6.0.0")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder, 1L, 1);

            modelBuilder.Entity("EFCorePeliculas.Entidades.Actor", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("Biografia")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime?>("FechaNacimiento")
                        .HasColumnType("date");

                    b.Property<string>("FotoURL")
                        .HasMaxLength(500)
                        .IsUnicode(false)
                        .HasColumnType("varchar(500)");

                    b.Property<string>("Nombre")
                        .IsRequired()
                        .HasMaxLength(150)
                        .HasColumnType("nvarchar(150)");

                    b.HasKey("Id");

                    b.ToTable("Actores");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.Cine", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("Nombre")
                        .IsRequired()
                        .HasMaxLength(150)
                        .HasColumnType("nvarchar(150)");

                    b.Property<Point>("Ubicacion")
                        .HasColumnType("geography");

                    b.HasKey("Id");

                    b.ToTable("Cines");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.CineOferta", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<int?>("CineId")
                        .HasColumnType("int");

                    b.Property<DateTime>("FechaFin")
                        .HasColumnType("date");

                    b.Property<DateTime>("FechaInicio")
                        .HasColumnType("date");

                    b.Property<decimal>("PorcentajeDescuento")
                        .HasPrecision(5, 2)
                        .HasColumnType("decimal(5,2)");

                    b.HasKey("Id");

                    b.HasIndex("CineId")
                        .IsUnique()
                        .HasFilter("[CineId] IS NOT NULL");

                    b.ToTable("CinesOfertas");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.Genero", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<bool>("EstaBorrado")
                        .HasColumnType("bit");

                    b.Property<DateTime>("FechaCreacion")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("datetime2")
                        .HasDefaultValueSql("GetDate()");

                    b.Property<string>("Nombre")
                        .IsRequired()
                        .HasMaxLength(150)
                        .HasColumnType("nvarchar(150)")
                        .HasColumnName("NombreGenero");

                    b.HasKey("Id");

                    b.HasIndex("Nombre")
                        .IsUnique()
                        .HasFilter("EstaBorrado = 'false'");

                    b.ToTable("Generos");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.Log", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Mensaje")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Logs");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.Mensaje", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("Contenido")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("EmisorId")
                        .HasColumnType("int");

                    b.Property<int>("ReceptorId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("EmisorId");

                    b.HasIndex("ReceptorId");

                    b.ToTable("Mensajes");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Contenido = "Hola, Claudia!",
                            EmisorId = 1,
                            ReceptorId = 2
                        },
                        new
                        {
                            Id = 2,
                            Contenido = "Hola, Felipe, ¿Cómo te va?",
                            EmisorId = 2,
                            ReceptorId = 1
                        },
                        new
                        {
                            Id = 3,
                            Contenido = "Todo bien, ¿Y tú?",
                            EmisorId = 1,
                            ReceptorId = 2
                        },
                        new
                        {
                            Id = 4,
                            Contenido = "Muy bien, gracias",
                            EmisorId = 2,
                            ReceptorId = 1
                        });
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.Pelicula", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<bool>("EnCartelera")
                        .HasColumnType("bit");

                    b.Property<DateTime>("FechaEstreno")
                        .HasColumnType("date");

                    b.Property<string>("PosterURL")
                        .HasMaxLength(500)
                        .IsUnicode(false)
                        .HasColumnType("varchar(500)");

                    b.Property<string>("Titulo")
                        .IsRequired()
                        .HasMaxLength(250)
                        .HasColumnType("nvarchar(250)");

                    b.HasKey("Id");

                    b.ToTable("Peliculas");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.PeliculaActor", b =>
                {
                    b.Property<int>("PeliculaId")
                        .HasColumnType("int");

                    b.Property<int>("ActorId")
                        .HasColumnType("int");

                    b.Property<int>("Orden")
                        .HasColumnType("int");

                    b.Property<string>("Personaje")
                        .HasMaxLength(150)
                        .HasColumnType("nvarchar(150)");

                    b.HasKey("PeliculaId", "ActorId");

                    b.HasIndex("ActorId");

                    b.ToTable("PeliculasActores");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.Persona", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("Nombre")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Personas");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Nombre = "Felipe"
                        },
                        new
                        {
                            Id = 2,
                            Nombre = "Claudia"
                        });
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.SalaDeCine", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<int>("CineId")
                        .HasColumnType("int");

                    b.Property<string>("Moneda")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<decimal>("Precio")
                        .HasPrecision(9, 2)
                        .HasColumnType("decimal(9,2)");

                    b.Property<string>("TipoSalaDeCine")
                        .IsRequired()
                        .ValueGeneratedOnAdd()
                        .HasColumnType("nvarchar(max)")
                        .HasDefaultValue("DosDimensiones");

                    b.HasKey("Id");

                    b.HasIndex("CineId");

                    b.ToTable("SalasDeCine");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.SinLlaves.CineSinUbicacion", b =>
                {
                    b.Property<int>("Id")
                        .HasColumnType("int");

                    b.Property<string>("Nombre")
                        .HasColumnType("nvarchar(max)");

                    b.ToView(null);

                    b.ToSqlQuery("Select Id, Nombre FROM Cines");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.SinLlaves.PeliculaConConteos", b =>
                {
                    b.Property<int>("CantidadActores")
                        .HasColumnType("int");

                    b.Property<int>("CantidadCines")
                        .HasColumnType("int");

                    b.Property<int>("CantidadGeneros")
                        .HasColumnType("int");

                    b.Property<int>("Id")
                        .HasColumnType("int");

                    b.Property<string>("Titulo")
                        .HasColumnType("nvarchar(max)");

                    b.ToView("PeliculasConConteos");
                });

            modelBuilder.Entity("GeneroPelicula", b =>
                {
                    b.Property<int>("GenerosId")
                        .HasColumnType("int");

                    b.Property<int>("PeliculasId")
                        .HasColumnType("int");

                    b.HasKey("GenerosId", "PeliculasId");

                    b.HasIndex("PeliculasId");

                    b.ToTable("GeneroPelicula");
                });

            modelBuilder.Entity("PeliculaSalaDeCine", b =>
                {
                    b.Property<int>("PeliculasId")
                        .HasColumnType("int");

                    b.Property<int>("SalasDeCineId")
                        .HasColumnType("int");

                    b.HasKey("PeliculasId", "SalasDeCineId");

                    b.HasIndex("SalasDeCineId");

                    b.ToTable("PeliculaSalaDeCine");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.CineOferta", b =>
                {
                    b.HasOne("EFCorePeliculas.Entidades.Cine", null)
                        .WithOne("CineOferta")
                        .HasForeignKey("EFCorePeliculas.Entidades.CineOferta", "CineId");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.Mensaje", b =>
                {
                    b.HasOne("EFCorePeliculas.Entidades.Persona", "Emisor")
                        .WithMany("MensajesEnviados")
                        .HasForeignKey("EmisorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("EFCorePeliculas.Entidades.Persona", "Receptor")
                        .WithMany("MensajesRecibidos")
                        .HasForeignKey("ReceptorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Emisor");

                    b.Navigation("Receptor");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.PeliculaActor", b =>
                {
                    b.HasOne("EFCorePeliculas.Entidades.Actor", "Actor")
                        .WithMany("PeliculasActores")
                        .HasForeignKey("ActorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("EFCorePeliculas.Entidades.Pelicula", "Pelicula")
                        .WithMany("PeliculasActores")
                        .HasForeignKey("PeliculaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Actor");

                    b.Navigation("Pelicula");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.SalaDeCine", b =>
                {
                    b.HasOne("EFCorePeliculas.Entidades.Cine", "Cine")
                        .WithMany("SalasDeCine")
                        .HasForeignKey("CineId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Cine");
                });

            modelBuilder.Entity("GeneroPelicula", b =>
                {
                    b.HasOne("EFCorePeliculas.Entidades.Genero", null)
                        .WithMany()
                        .HasForeignKey("GenerosId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("EFCorePeliculas.Entidades.Pelicula", null)
                        .WithMany()
                        .HasForeignKey("PeliculasId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("PeliculaSalaDeCine", b =>
                {
                    b.HasOne("EFCorePeliculas.Entidades.Pelicula", null)
                        .WithMany()
                        .HasForeignKey("PeliculasId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("EFCorePeliculas.Entidades.SalaDeCine", null)
                        .WithMany()
                        .HasForeignKey("SalasDeCineId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.Actor", b =>
                {
                    b.Navigation("PeliculasActores");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.Cine", b =>
                {
                    b.Navigation("CineOferta");

                    b.Navigation("SalasDeCine");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.Pelicula", b =>
                {
                    b.Navigation("PeliculasActores");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.Persona", b =>
                {
                    b.Navigation("MensajesEnviados");

                    b.Navigation("MensajesRecibidos");
                });
#pragma warning restore 612, 618
        }
    }
}
