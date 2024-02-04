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
    [Migration("20240203235327_TotalCalculado")]
    partial class TotalCalculado
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

            modelBuilder.Entity("EFCorePeliculas.Entidades.CineDetalle", b =>
                {
                    b.Property<int>("Id")
                        .HasColumnType("int");

                    b.Property<string>("CodigoDeEtica")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Historia")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Misiones")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Valores")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Cines", (string)null);
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

            modelBuilder.Entity("EFCorePeliculas.Entidades.DetalleFactura", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<int>("Cantidad")
                        .HasColumnType("int");

                    b.Property<int>("FacturaId")
                        .HasColumnType("int");

                    b.Property<decimal>("Precio")
                        .HasPrecision(18, 2)
                        .HasColumnType("decimal(18,2)");

                    b.Property<string>("Producto")
                        .HasColumnType("nvarchar(max)");

                    b.Property<decimal>("Total")
                        .ValueGeneratedOnAddOrUpdate()
                        .HasPrecision(18, 2)
                        .HasColumnType("decimal(18,2)")
                        .HasComputedColumnSql("Precio * Cantidad");

                    b.HasKey("Id");

                    b.HasIndex("FacturaId");

                    b.ToTable("DetallesFacturas");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Cantidad = 0,
                            FacturaId = 1,
                            Precio = 350.99m,
                            Total = 0m
                        },
                        new
                        {
                            Id = 2,
                            Cantidad = 0,
                            FacturaId = 1,
                            Precio = 10m,
                            Total = 0m
                        },
                        new
                        {
                            Id = 3,
                            Cantidad = 0,
                            FacturaId = 1,
                            Precio = 45.50m,
                            Total = 0m
                        },
                        new
                        {
                            Id = 4,
                            Cantidad = 0,
                            FacturaId = 2,
                            Precio = 17.99m,
                            Total = 0m
                        },
                        new
                        {
                            Id = 5,
                            Cantidad = 0,
                            FacturaId = 2,
                            Precio = 14m,
                            Total = 0m
                        },
                        new
                        {
                            Id = 6,
                            Cantidad = 0,
                            FacturaId = 2,
                            Precio = 45m,
                            Total = 0m
                        },
                        new
                        {
                            Id = 7,
                            Cantidad = 0,
                            FacturaId = 2,
                            Precio = 100m,
                            Total = 0m
                        },
                        new
                        {
                            Id = 8,
                            Cantidad = 0,
                            FacturaId = 3,
                            Precio = 371m,
                            Total = 0m
                        },
                        new
                        {
                            Id = 9,
                            Cantidad = 0,
                            FacturaId = 3,
                            Precio = 114.99m,
                            Total = 0m
                        },
                        new
                        {
                            Id = 10,
                            Cantidad = 0,
                            FacturaId = 3,
                            Precio = 425m,
                            Total = 0m
                        },
                        new
                        {
                            Id = 11,
                            Cantidad = 0,
                            FacturaId = 3,
                            Precio = 1000m,
                            Total = 0m
                        },
                        new
                        {
                            Id = 12,
                            Cantidad = 0,
                            FacturaId = 3,
                            Precio = 5m,
                            Total = 0m
                        },
                        new
                        {
                            Id = 13,
                            Cantidad = 0,
                            FacturaId = 3,
                            Precio = 2.99m,
                            Total = 0m
                        },
                        new
                        {
                            Id = 14,
                            Cantidad = 0,
                            FacturaId = 4,
                            Precio = 50m,
                            Total = 0m
                        });
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.Factura", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<DateTime>("FechaCreacion")
                        .HasColumnType("date");

                    b.HasKey("Id");

                    b.ToTable("Facturas");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            FechaCreacion = new DateTime(2002, 1, 24, 0, 0, 0, 0, DateTimeKind.Unspecified)
                        },
                        new
                        {
                            Id = 2,
                            FechaCreacion = new DateTime(2002, 1, 24, 0, 0, 0, 0, DateTimeKind.Unspecified)
                        },
                        new
                        {
                            Id = 3,
                            FechaCreacion = new DateTime(2002, 1, 24, 0, 0, 0, 0, DateTimeKind.Unspecified)
                        },
                        new
                        {
                            Id = 4,
                            FechaCreacion = new DateTime(2002, 1, 24, 0, 0, 0, 0, DateTimeKind.Unspecified)
                        });
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

                    b.Property<string>("UsuarioCrecion")
                        .HasMaxLength(150)
                        .HasColumnType("nvarchar(150)");

                    b.Property<string>("UsuarioModificacion")
                        .HasMaxLength(150)
                        .HasColumnType("nvarchar(150)");

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

                    b.Property<string>("Ejemplo")
                        .HasColumnType("nvarchar(max)");

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

            modelBuilder.Entity("EFCorePeliculas.Entidades.Pago", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<DateTime>("FechaTransaccion")
                        .HasColumnType("date");

                    b.Property<decimal>("Monto")
                        .HasPrecision(18, 2)
                        .HasColumnType("decimal(18,2)");

                    b.Property<int>("TipoPago")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.ToTable("Pagos");

                    b.HasDiscriminator<int>("TipoPago");
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

            modelBuilder.Entity("EFCorePeliculas.Entidades.Producto", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("Nombre")
                        .HasColumnType("nvarchar(max)");

                    b.Property<decimal>("Precio")
                        .HasPrecision(18, 2)
                        .HasColumnType("decimal(18,2)");

                    b.HasKey("Id");

                    b.ToTable("Productos");
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

                    b.ToTable((string)null);
                });

            modelBuilder.Entity("GeneroPelicula", b =>
                {
                    b.Property<int>("GenerosId")
                        .HasColumnType("int");

                    b.Property<int>("PeliculasId")
                        .HasColumnType("int");

                    b.HasKey("GenerosId", "PeliculasId");

                    b.HasIndex("PeliculasId");

                    b.ToTable("GenerosPeliculas", (string)null);

                    b.HasData(
                        new
                        {
                            GenerosId = 7,
                            PeliculasId = 1
                        });
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

            modelBuilder.Entity("EFCorePeliculas.Entidades.Merchandising", b =>
                {
                    b.HasBaseType("EFCorePeliculas.Entidades.Producto");

                    b.Property<bool>("DisponibleEnInventario")
                        .HasColumnType("bit");

                    b.Property<bool>("EsColeccionable")
                        .HasColumnType("bit");

                    b.Property<bool>("EsRopa")
                        .HasColumnType("bit");

                    b.Property<double>("Peso")
                        .HasColumnType("float");

                    b.Property<double>("Volumen")
                        .HasColumnType("float");

                    b.ToTable("Merchandising", (string)null);

                    b.HasData(
                        new
                        {
                            Id = 2,
                            Nombre = "Remera",
                            Precio = 0m,
                            DisponibleEnInventario = true,
                            EsColeccionable = false,
                            EsRopa = true,
                            Peso = 1.0,
                            Volumen = 1.0
                        });
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.PagoPaypal", b =>
                {
                    b.HasBaseType("EFCorePeliculas.Entidades.Pago");

                    b.Property<string>("CorreoElectronico")
                        .IsRequired()
                        .HasMaxLength(150)
                        .HasColumnType("nvarchar(150)");

                    b.HasDiscriminator().HasValue(1);

                    b.HasData(
                        new
                        {
                            Id = 3,
                            FechaTransaccion = new DateTime(2022, 1, 7, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Monto = 157m,
                            TipoPago = 1,
                            CorreoElectronico = "david@hotmail.com"
                        },
                        new
                        {
                            Id = 4,
                            FechaTransaccion = new DateTime(2022, 1, 7, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Monto = 9.99m,
                            TipoPago = 1,
                            CorreoElectronico = "claudia@hotmail.com"
                        });
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.PagoTarjeta", b =>
                {
                    b.HasBaseType("EFCorePeliculas.Entidades.Pago");

                    b.Property<string>("UltimosCuatroDigitos")
                        .IsRequired()
                        .HasColumnType("char(4)");

                    b.HasDiscriminator().HasValue(2);

                    b.HasData(
                        new
                        {
                            Id = 1,
                            FechaTransaccion = new DateTime(2022, 1, 6, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Monto = 500m,
                            TipoPago = 2,
                            UltimosCuatroDigitos = "0123"
                        },
                        new
                        {
                            Id = 2,
                            FechaTransaccion = new DateTime(2022, 1, 6, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Monto = 120m,
                            TipoPago = 2,
                            UltimosCuatroDigitos = "1234"
                        });
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.PeliculaAlquilable", b =>
                {
                    b.HasBaseType("EFCorePeliculas.Entidades.Producto");

                    b.Property<int>("PeliculaId")
                        .HasColumnType("int");

                    b.HasIndex("PeliculaId");

                    b.ToTable("PeliculasAlquilables", (string)null);

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Nombre = "Spider-Man",
                            Precio = 5.99m,
                            PeliculaId = 10
                        });
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.Actor", b =>
                {
                    b.OwnsOne("EFCorePeliculas.Entidades.Direccion", "BillingAdress", b1 =>
                        {
                            b1.Property<int>("ActorId")
                                .HasColumnType("int");

                            b1.Property<string>("Calle")
                                .HasColumnType("nvarchar(max)");

                            b1.Property<string>("Pais")
                                .IsRequired()
                                .HasColumnType("nvarchar(max)");

                            b1.Property<string>("Provincia")
                                .HasColumnType("nvarchar(max)");

                            b1.HasKey("ActorId");

                            b1.ToTable("Actores");

                            b1.WithOwner()
                                .HasForeignKey("ActorId");
                        });

                    b.OwnsOne("EFCorePeliculas.Entidades.Direccion", "DireccionHogar", b1 =>
                        {
                            b1.Property<int>("ActorId")
                                .HasColumnType("int");

                            b1.Property<string>("Calle")
                                .HasColumnType("nvarchar(max)")
                                .HasColumnName("Calle");

                            b1.Property<string>("Pais")
                                .IsRequired()
                                .HasColumnType("nvarchar(max)")
                                .HasColumnName("Pais");

                            b1.Property<string>("Provincia")
                                .HasColumnType("nvarchar(max)")
                                .HasColumnName("Provincia");

                            b1.HasKey("ActorId");

                            b1.ToTable("Actores");

                            b1.WithOwner()
                                .HasForeignKey("ActorId");
                        });

                    b.Navigation("BillingAdress");

                    b.Navigation("DireccionHogar");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.Cine", b =>
                {
                    b.OwnsOne("EFCorePeliculas.Entidades.Direccion", "Direccion", b1 =>
                        {
                            b1.Property<int>("CineId")
                                .HasColumnType("int");

                            b1.Property<string>("Calle")
                                .HasColumnType("nvarchar(max)")
                                .HasColumnName("Calle");

                            b1.Property<string>("Pais")
                                .IsRequired()
                                .HasColumnType("nvarchar(max)")
                                .HasColumnName("Pais");

                            b1.Property<string>("Provincia")
                                .HasColumnType("nvarchar(max)")
                                .HasColumnName("Provincia");

                            b1.HasKey("CineId");

                            b1.ToTable("Cines");

                            b1.WithOwner()
                                .HasForeignKey("CineId");
                        });

                    b.Navigation("Direccion");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.CineDetalle", b =>
                {
                    b.HasOne("EFCorePeliculas.Entidades.Cine", "Cine")
                        .WithOne("CineDetalle")
                        .HasForeignKey("EFCorePeliculas.Entidades.CineDetalle", "Id")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Cine");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.CineOferta", b =>
                {
                    b.HasOne("EFCorePeliculas.Entidades.Cine", null)
                        .WithOne("CineOferta")
                        .HasForeignKey("EFCorePeliculas.Entidades.CineOferta", "CineId");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.DetalleFactura", b =>
                {
                    b.HasOne("EFCorePeliculas.Entidades.Factura", null)
                        .WithMany()
                        .HasForeignKey("FacturaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
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

            modelBuilder.Entity("EFCorePeliculas.Entidades.Merchandising", b =>
                {
                    b.HasOne("EFCorePeliculas.Entidades.Producto", null)
                        .WithOne()
                        .HasForeignKey("EFCorePeliculas.Entidades.Merchandising", "Id")
                        .OnDelete(DeleteBehavior.ClientCascade)
                        .IsRequired();
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.PeliculaAlquilable", b =>
                {
                    b.HasOne("EFCorePeliculas.Entidades.Producto", null)
                        .WithOne()
                        .HasForeignKey("EFCorePeliculas.Entidades.PeliculaAlquilable", "Id")
                        .OnDelete(DeleteBehavior.ClientCascade)
                        .IsRequired();

                    b.HasOne("EFCorePeliculas.Entidades.Pelicula", "Pelicula")
                        .WithMany()
                        .HasForeignKey("PeliculaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Pelicula");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.Actor", b =>
                {
                    b.Navigation("PeliculasActores");
                });

            modelBuilder.Entity("EFCorePeliculas.Entidades.Cine", b =>
                {
                    b.Navigation("CineDetalle");

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
