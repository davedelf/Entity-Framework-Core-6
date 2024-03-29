USE [master]
GO
/****** Object:  Database [EFCorePeliculasDB]    Script Date: 26/2/2024 23:05:54 ******/
CREATE DATABASE [EFCorePeliculasDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EFCorePeliculasDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\EFCorePeliculasDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EFCorePeliculasDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\EFCorePeliculasDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [EFCorePeliculasDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EFCorePeliculasDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EFCorePeliculasDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EFCorePeliculasDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EFCorePeliculasDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EFCorePeliculasDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EFCorePeliculasDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [EFCorePeliculasDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [EFCorePeliculasDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EFCorePeliculasDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EFCorePeliculasDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EFCorePeliculasDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EFCorePeliculasDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EFCorePeliculasDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EFCorePeliculasDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EFCorePeliculasDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EFCorePeliculasDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [EFCorePeliculasDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EFCorePeliculasDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EFCorePeliculasDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EFCorePeliculasDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EFCorePeliculasDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EFCorePeliculasDB] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [EFCorePeliculasDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EFCorePeliculasDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EFCorePeliculasDB] SET  MULTI_USER 
GO
ALTER DATABASE [EFCorePeliculasDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EFCorePeliculasDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EFCorePeliculasDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EFCorePeliculasDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EFCorePeliculasDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EFCorePeliculasDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [EFCorePeliculasDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [EFCorePeliculasDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [EFCorePeliculasDB]
GO
/****** Object:  Schema [factura]    Script Date: 26/2/2024 23:05:54 ******/
CREATE SCHEMA [factura]
GO
USE [EFCorePeliculasDB]
GO
/****** Object:  Sequence [factura].[NumeroFactura]    Script Date: 26/2/2024 23:05:55 ******/
CREATE SEQUENCE [factura].[NumeroFactura] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
/****** Object:  UserDefinedFunction [dbo].[DetalleFacturaPromedio]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

                CREATE FUNCTION [dbo].[DetalleFacturaPromedio]
                (
                @FacturaId int
                )
                RETURNS decimal(18,2)
                AS
                BEGIN
                DECLARE @promedio decimal(18,2);
                SELECT @promedio=AVG(Precio)
                FROM DetallesFacturas
                WHERE FacturaId=FacturaId
                RETURN @promedio
                END
                
GO
/****** Object:  UserDefinedFunction [dbo].[DetalleFacturaSuma]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

                CREATE FUNCTION [dbo].[DetalleFacturaSuma]
                (
                @FacturaId int
                )
                RETURNS int 
                AS
                BEGIN
                DECLARE @suma int;
                SELECT @suma=SUM(Precio)
                FROM DetallesFacturas
                WHERE FacturaId=@FacturaId
                RETURN @suma
                END
                
GO
/****** Object:  Table [dbo].[GenerosHistory]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenerosHistory](
	[Id] [int] NOT NULL,
	[NombreGenero] [nvarchar](150) NOT NULL,
	[EstaBorrado] [bit] NOT NULL,
	[FechaCreacion] [datetime2](7) NOT NULL,
	[UsuarioCrecion] [nvarchar](150) NULL,
	[UsuarioModificacion] [nvarchar](150) NULL,
	[PeriodEnd] [datetime2](7) NOT NULL,
	[PeriodStart] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [ix_GenerosHistory]    Script Date: 26/2/2024 23:05:55 ******/
CREATE CLUSTERED INDEX [ix_GenerosHistory] ON [dbo].[GenerosHistory]
(
	[PeriodEnd] ASC,
	[PeriodStart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Generos]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Generos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NombreGenero] [nvarchar](150) NOT NULL,
	[EstaBorrado] [bit] NOT NULL,
	[FechaCreacion] [datetime2](7) NOT NULL,
	[UsuarioCrecion] [nvarchar](150) NULL,
	[UsuarioModificacion] [nvarchar](150) NULL,
	[PeriodEnd] [datetime2](7) GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
	[PeriodStart] [datetime2](7) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
 CONSTRAINT [PK_Generos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([PeriodStart], [PeriodEnd])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[GenerosHistory])
)
GO
/****** Object:  Table [dbo].[FacturasHistorico]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacturasHistorico](
	[Id] [int] NOT NULL,
	[FechaCreacion] [date] NOT NULL,
	[NumeroFactura] [int] NOT NULL,
	[Version] [timestamp] NULL,
	[Desde] [datetime2](7) NOT NULL,
	[Hasta] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [ix_FacturasHistorico]    Script Date: 26/2/2024 23:05:55 ******/
CREATE CLUSTERED INDEX [ix_FacturasHistorico] ON [dbo].[FacturasHistorico]
(
	[Hasta] ASC,
	[Desde] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facturas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FechaCreacion] [date] NOT NULL,
	[NumeroFactura] [int] NOT NULL,
	[Version] [timestamp] NULL,
	[Desde] [datetime2](7) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	[Hasta] [datetime2](7) GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
 CONSTRAINT [PK_Facturas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([Desde], [Hasta])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[FacturasHistorico])
)
GO
/****** Object:  Table [dbo].[Peliculas]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Peliculas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [nvarchar](250) NOT NULL,
	[EnCartelera] [bit] NOT NULL,
	[FechaEstreno] [date] NOT NULL,
	[PosterURL] [varchar](500) NULL,
 CONSTRAINT [PK_Peliculas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalasDeCine]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalasDeCine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Precio] [decimal](9, 2) NOT NULL,
	[CineId] [int] NOT NULL,
	[TipoSalaDeCine] [nvarchar](max) NOT NULL,
	[Moneda] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_SalasDeCine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PeliculasActores]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PeliculasActores](
	[PeliculaId] [int] NOT NULL,
	[ActorId] [int] NOT NULL,
	[Personaje] [nvarchar](150) NULL,
	[Orden] [int] NOT NULL,
 CONSTRAINT [PK_PeliculasActores] PRIMARY KEY CLUSTERED 
(
	[PeliculaId] ASC,
	[ActorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PeliculaSalaDeCine]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PeliculaSalaDeCine](
	[PeliculasId] [int] NOT NULL,
	[SalasDeCineId] [int] NOT NULL,
 CONSTRAINT [PK_PeliculaSalaDeCine] PRIMARY KEY CLUSTERED 
(
	[PeliculasId] ASC,
	[SalasDeCineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PeliculasConConteos]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

            create view [dbo].[PeliculasConConteos]
            as
            select Id, Titulo, 
            (select count(*)
            from GeneroPelicula
            where PeliculasId=Peliculas.Id) as CantidadGeneros,
            (select count(distinct CineId)
            from PeliculaSalaDeCine
            INNER JOIN SalasDeCine
            ON SalasDeCIne.Id=PeliculaSalaDeCine.SalasDeCineId
            where PeliculasId=Peliculas.Id) as CantidadCines,
            (
            select count(*)
            from PeliculasActores where PeliculaId=Peliculas.Id) as CantidadActores
            from Peliculas
GO
/****** Object:  Table [dbo].[GenerosPeliculas]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenerosPeliculas](
	[GenerosId] [int] NOT NULL,
	[PeliculasId] [int] NOT NULL,
 CONSTRAINT [PK_GenerosPeliculas] PRIMARY KEY CLUSTERED 
(
	[GenerosId] ASC,
	[PeliculasId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[PeliculaConConteos]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[PeliculaConConteos]
            (
            @peliculaId int
            )
            returns table
            as
            return
            (
            select Id, Titulo, 
            (select count(*)
            from GenerosPeliculas
            where PeliculasId=Peliculas.Id) as CantidadGeneros,
            (select count(distinct CineId)
            from PeliculaSalaDeCine
            INNER JOIN SalasDeCine
            ON SalasDeCIne.Id=PeliculaSalaDeCine.SalasDeCineId
            where PeliculasId=Peliculas.Id) as CantidadCines,
            (
            select count(*)
            from PeliculasActores where PeliculaId=Peliculas.Id) as CantidadActores
            from Peliculas
            where Id=@peliculaId
            )
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Actores]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](150) NOT NULL,
	[Biografia] [nvarchar](max) NULL,
	[FechaNacimiento] [date] NULL,
	[FotoURL] [varchar](500) NULL,
	[BillingAdress_Calle] [nvarchar](max) NULL,
	[BillingAdress_Pais] [nvarchar](max) NULL,
	[BillingAdress_Provincia] [nvarchar](max) NULL,
	[Calle] [nvarchar](max) NULL,
	[Pais] [nvarchar](max) NULL,
	[Provincia] [nvarchar](max) NULL,
 CONSTRAINT [PK_Actores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cines]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cines](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](150) NOT NULL,
	[Ubicacion] [geography] NULL,
	[CodigoDeEtica] [nvarchar](max) NULL,
	[Historia] [nvarchar](max) NULL,
	[Misiones] [nvarchar](max) NULL,
	[Valores] [nvarchar](max) NULL,
	[Calle] [nvarchar](max) NULL,
	[Pais] [nvarchar](max) NULL,
	[Provincia] [nvarchar](max) NULL,
 CONSTRAINT [PK_Cines] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CinesOfertas]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CinesOfertas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFin] [date] NOT NULL,
	[PorcentajeDescuento] [decimal](5, 2) NOT NULL,
	[CineId] [int] NULL,
 CONSTRAINT [PK_CinesOfertas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetallesFacturas]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetallesFacturas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Producto] [nvarchar](max) NULL,
	[FacturaId] [int] NOT NULL,
	[Precio] [decimal](18, 2) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Total]  AS ([Precio]*[Cantidad]),
 CONSTRAINT [PK_DetallesFacturas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Logs]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logs](
	[Id] [uniqueidentifier] NOT NULL,
	[Mensaje] [nvarchar](max) NULL,
	[Ejemplo] [nvarchar](max) NULL,
 CONSTRAINT [PK_Logs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mensajes]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mensajes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Contenido] [nvarchar](max) NULL,
	[EmisorId] [int] NOT NULL,
	[ReceptorId] [int] NOT NULL,
 CONSTRAINT [PK_Mensajes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Merchandising]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Merchandising](
	[Id] [int] NOT NULL,
	[DisponibleEnInventario] [bit] NOT NULL,
	[Peso] [float] NOT NULL,
	[Volumen] [float] NOT NULL,
	[EsRopa] [bit] NOT NULL,
	[EsColeccionable] [bit] NOT NULL,
 CONSTRAINT [PK_Merchandising] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pagos]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pagos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Monto] [decimal](18, 2) NOT NULL,
	[FechaTransaccion] [date] NOT NULL,
	[TipoPago] [int] NOT NULL,
	[CorreoElectronico] [nvarchar](150) NULL,
	[UltimosCuatroDigitos] [char](4) NULL,
 CONSTRAINT [PK_Pagos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PeliculasAlquilables]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PeliculasAlquilables](
	[Id] [int] NOT NULL,
	[PeliculaId] [int] NOT NULL,
 CONSTRAINT [PK_PeliculasAlquilables] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personas]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](max) NULL,
 CONSTRAINT [PK_Personas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](max) NULL,
	[Precio] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230904232409_Db', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230905235458_agregadoGeneros', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230913224855_borradoLogicoGeneros', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230914210453_Logs', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230915000454_GeneroIndice', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230924195036_inicial', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230925011658_EjemploConversion', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230929190719_CampoMoneda', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231001005017_VistaConteoPeliculas', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231001005712_VistaConteoPeliculas', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231002173130_PropiedadSombraFechaCreacionGenero', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231002194148_FotoActor', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231011185836_CineIdNullable', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231011194021_CampoElCine', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231017235509_EjemploPersona', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231028013402_NoPodemosBorrarCineConSalasDeCine', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231028031558_CineDetalleTableSplitting', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231030175325_EjemploOwned', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231030191707_TablaPorJerarquia', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231031111635_EjemploTablaPorTipo', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231031113103_EjemploTablaPorTipo', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231031113743_TablaPorTipo', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231103124304_LogEjemplo', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240130193206_GeneroAuditable', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240202221109_ProcedimientosAlmacenados', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240203014449_MaestroDetalle_FacturasDetalles', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240203162050_DatosFacturaEjemplo', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240203162128_FuncionesDefinidasPorElUsuario', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240203213706_FuncionesConValoresDeTabla', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240203235327_TotalCalculado', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240204220720_Secuencias', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240205121909_ConcurrenciaPorFila', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240205163751_TablasTemporales', N'6.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240206194443_FacturasHistorico', N'6.0.0')
GO
SET IDENTITY_INSERT [dbo].[Actores] ON 

INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (1, N'Ana López', N'Actriz de renombre en la industria cinematográfica.', CAST(N'2000-01-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (2, N'Prueba De Actor Modelo Conectado A Desconectado', N'modeloDesconectado', CAST(N'2023-09-13' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (3, N'Isa', N'Conocida por sus papeles en películas de drama.', CAST(N'2002-05-20' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (4, N'Carlos Martínez', N'Actor de comedia con un gran sentido del humor.', CAST(N'2003-07-10' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (5, N'Elena Sánchez', N'Actriz talentosa que ha trabajado en producciones internacionales.', CAST(N'2004-09-05' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (6, N'Miguel Fernández', N'Actor comprometido con roles sociales y políticos.', CAST(N'2005-11-02' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (7, N'Carmen García', N'Reconocida por su interpretación en películas de época.', CAST(N'2006-12-08' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (8, N'Luis Morales', N'Actor joven con un prometedor futuro en la industria.', CAST(N'2007-02-14' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (9, N'María Torres', N'Actriz destacada en películas de acción y aventura.', CAST(N'2008-04-23' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (10, N'José González', N'Intérprete carismático con una gran base de fanáticos.', CAST(N'2009-06-30' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (11, N'Laura Pérez', N'Actriz con una voz increíble que también canta en musicales.', CAST(N'2010-08-17' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (12, N'Antonio Ruiz', N'Actor de carácter que ha interpretado una amplia gama de roles.', CAST(N'2011-10-25' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (13, N'Paula Fernández', N'Ganadora de varios premios por sus actuaciones en el cine.', CAST(N'2012-12-19' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (14, N'Daniel Martín', N'Actor que ha trabajado en películas de ciencia ficción.', CAST(N'2013-01-03' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (15, N'Sofía López', N'Actriz joven que ha ganado popularidad en películas para adolescentes.', CAST(N'2014-03-12' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (16, N'Pablo García', N'Intérprete apasionado por el teatro clásico.', CAST(N'2015-05-27' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (17, N'Lucía Rodríguez', N'Actriz que ha participado en películas de misterio y suspense.', CAST(N'2016-07-06' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (18, N'Adrián Sánchez', N'Actor que ha trabajado en películas de terror.', CAST(N'2017-09-11' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (19, N'Eva Pérez', N'Actriz versátil que ha trabajado en comedia y drama.', CAST(N'2018-11-28' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (20, N'Mario Torres', N'Ganador de un premio Oscar por su actuación en una película biográfica.', CAST(N'2019-01-09' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (21, N'Sara Martínez', N'Actriz de teatro que también ha incursionado en el cine.', CAST(N'2020-03-18' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (22, N'Fernando González', N'Actor con una amplia experiencia en televisión.', CAST(N'2021-05-24' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (23, N'Lara Ruiz', N'Estrella en ascenso en el mundo del cine independiente.', CAST(N'2022-07-04' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (24, N'Raúl Morales', N'Actor carismático que ha trabajado en películas de comedia romántica.', CAST(N'2023-09-15' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (25, N'Luisa García', N'Actriz de renombre en el teatro y el cine.', CAST(N'2000-11-22' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (26, N'Andrés Pérez', N'Actor conocido por su versatilidad en diferentes géneros.', CAST(N'2001-03-14' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (27, N'Marina Rodríguez', N'Actriz apasionada por los personajes dramáticos.', CAST(N'2002-05-07' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (28, N'Roberto Martínez', N'Actor destacado en comedias de situación.', CAST(N'2003-07-18' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (29, N'Julia Sánchez', N'Actriz versátil que ha trabajado en cine y televisión.', CAST(N'2004-09-30' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (30, N'Diego Fernández', N'Actor comprometido con causas sociales.', CAST(N'2005-12-12' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (31, N'Sofía López', N'Reconocida por su actuación en películas de época.', CAST(N'2007-02-25' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (32, N'Gonzalo Morales', N'Actor joven con gran potencial en la industria.', CAST(N'2008-04-08' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (33, N'Valentina Torres', N'Actriz versátil que ha interpretado roles de acción.', CAST(N'2009-06-21' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (34, N'Martín González', N'Actor carismático que ha ganado seguidores leales.', CAST(N'2010-08-03' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (35, N'Cecilia Ruiz', N'Actriz con una voz impresionante en musicales.', CAST(N'2011-10-15' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (36, N'Felipe Sánchez', N'Actor conocido por su versatilidad en la actuación.', CAST(N'2012-12-27' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (37, N'Laura Pérez', N'Ganadora de premios por sus destacadas actuaciones.', CAST(N'2014-02-09' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (38, N'Javier Martín', N'Actor que ha trabajado en películas de ciencia ficción.', CAST(N'2015-04-23' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (39, N'Camila López', N'Actriz que se ha destacado en películas para adolescentes.', CAST(N'2016-06-06' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (40, N'Lucas Fernández', N'Intérprete apasionado por el teatro clásico.', CAST(N'2017-08-19' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (41, N'Isabella Rodríguez', N'Actriz que brilla en películas de misterio y suspense.', CAST(N'2018-10-02' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (42, N'Alexandra Pérez', N'Actriz que ha dejado huella en películas de terror.', CAST(N'2019-12-14' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (43, N'Mateo Torres', N'Actor versátil que se desenvuelve en comedia y drama.', CAST(N'2021-02-26' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (44, N'Paulina García', N'Ganadora de un premio Oscar por una película biográfica.', CAST(N'2022-04-10' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (45, N'Joaquín Morales', N'Actor apasionado por el teatro y el cine independiente.', CAST(N'2023-06-22' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (46, N'Alicia Sánchez', N'Estrella en ascenso en el mundo de la televisión.', CAST(N'2000-08-04' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (47, N'Hugo Martínez', N'Actor talentoso en papeles dramáticos.', CAST(N'2001-10-17' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (48, N'Valeria Fernández', N'Actriz que se destaca en películas de aventuras.', CAST(N'2002-12-29' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (49, N'Gabriel Pérez', N'Actor cómico con una gran habilidad para la improvisación.', CAST(N'2004-02-11' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (50, N'Carolina González', N'Actriz que ha trabajado en producciones internacionales.', CAST(N'2005-04-24' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (51, N'Joaquín Rodríguez', N'Actor comprometido con causas sociales.', CAST(N'2006-06-07' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (52, N'Isabel López', N'Actriz versátil con una amplia gama de roles.', CAST(N'2007-08-20' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (53, N'Matías Torres', N'Actor joven que ha ganado popularidad en comedias románticas.', CAST(N'2008-10-02' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (54, N'Sara Martínez', N'Actriz carismática con un toque de comedia.', CAST(N'2009-12-15' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (55, N'Lucas Sánchez', N'Actor apasionado por el teatro clásico.', CAST(N'2011-02-28' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (56, N'Valentina García', N'Actriz conocida por sus papeles en películas de acción.', CAST(N'2012-04-12' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (57, N'Maximiliano Pérez', N'Actor versátil que se ha destacado en el cine de autor.', CAST(N'2013-06-25' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (58, N'María Rodríguez', N'Actriz que ha trabajado en películas de suspenso.', CAST(N'2014-08-07' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (59, N'Diego Martínez', N'Ganador de premios por sus actuaciones en el cine independiente.', CAST(N'2015-10-20' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (60, N'Lorena Sánchez', N'Actriz que brilla en el cine de terror.', CAST(N'2016-12-02' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (61, N'Carlos López', N'Actor carismático que ha ganado popularidad en comedia.', CAST(N'2018-02-14' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (62, N'Catalina Torres', N'Actriz apasionada por el cine de ciencia ficción.', CAST(N'2019-04-28' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (63, N'Juan García', N'Actor que ha interpretado a superhéroes en películas.', CAST(N'2020-06-10' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (64, N'Mariana Pérez', N'Actriz talentosa en papeles dramáticos.', CAST(N'2021-08-22' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (65, N'Eduardo Rodríguez', N'Actor que ha trabajado en películas biográficas.', CAST(N'2022-10-04' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (66, N'String', N'string', CAST(N'2023-09-13' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (67, N'Mapeo Flexible - Prueba', N'sdfsd', CAST(N'2023-09-13' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Actores] ([Id], [Nombre], [Biografia], [FechaNacimiento], [FotoURL], [BillingAdress_Calle], [BillingAdress_Pais], [BillingAdress_Provincia], [Calle], [Pais], [Provincia]) VALUES (68, N'Mapeo Flexible - Prueba', N'sdfsd', CAST(N'2023-09-13' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Actores] OFF
GO
SET IDENTITY_INSERT [dbo].[Cines] ON 

INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (1, N'Hoyts Abasto Modificado Con Detección ded Cambios Personalizada', 0xE6100000010CA77A8DB85B5F4EC025E99AC9379F3FC0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (2, N'Cinemark Avellaneda', 0xE6100000010C81994A9A9A314DC06232B0E99C5441C0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (4, N'Hoyts DOT', 0xE6100000010C9259BDC3ED3E4DC01AE65F26E54541C0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (5, N'Cinemark Malvinas Argentinas', 0xE6100000010CF14927124C5A4DC08FC29A6FE94341C0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (6, N'Cinemark Mendoza', 0xE6100000010C665C829D2C3751C031DF0BDD367A40C0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (7, N'Hoyts Moreno', 0xE6100000010C2205AADAC9654DC0D809D407375141C0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (8, N'Hoyts Moron', 0xE6100000010CDD9CA5BFF2504DC0C2C2499A3F5141C0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (9, N'Cinemark Neuquen', 0xE6100000010CE768FA91470451C0BD40A43A787843C0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (10, N'Hoyts Nuevocentro', 0xE6100000010C2BC995D54F0D50C0F744323F92693FC0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (11, N'Cinemark Palermo', 0xE6100000010C2D8892DAD5344DC06787AEFA124B41C0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (12, N'Hoyts Patio Olmos', 0xE6100000010C4B2D4ABF330C50C0FBBB2D477E6B3FC0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (13, N'Cinemark Puerto Madero', 0xE6100000010C628F3F074C2F4DC00031AE5D7F4F41C0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (14, N'Hoyts Quilmes', 0xE6100000010C30A990E167234DC0ABE408BE0E6141C0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (15, N'Hoyts Rosario', 0xE6100000010CC2C82654CB574EC058422DBC817440C0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (16, N'Hoyts Salta', 0xE6100000010C29852F02195A50C059C40B7D0BC838C0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (17, N'Cinemark Salta', 0xE6100000010C872469ED6C5B50C02AD31EE516D538C0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (18, N'Cinemark San Justo', 0xE6100000010CCF30B5A50E474DC0820EA958EB5741C0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (19, N'Cinemark Santa Fe', 0xE6100000010CC9D00C3DBD594EC0E000E951A7A63FC0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (20, N'Cinemark Soleil', 0xE6100000010CBAF605F4C24B4DC0868E1D54E23E41C0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (21, N'Hoyts Temperley', 0xE6100000010C42C7B370FE334DC031C225112B6441C0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (22, N'Cinemark Tortugas', 0xE6100000010C770A5E995C5D4DC058C27F5FC83941C0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (23, N'Hoyts Unicenter', 0xE6100000010CA4A42CE862434DC022DFA5D4254141C0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (24, N'Mi Cine', 0xE6100000010CFDEEC27B330D50C0BAB8324D7D6B3FC0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (25, N'Mi Cine DTO - Gran Rex', 0xE6100000010C407969D40D0D50C098C28366D7693FC0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (26, N'CineActualizado', 0xE6100000010C881634886A0C50C01036864A6D673FC0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (27, N'test', 0xE6100000010C00000000000000000000000000000000, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (30, N'Mi Cine con Relación Opcional', 0xE6100000010CFDEEC27B330D50C0BAB8324D7D6B3FC0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (32, N'Mi Cine sin datalle', 0xE6100000010CFDEEC27B330D50C0BAB8324D7D6B3FC0, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cines] ([Id], [Nombre], [Ubicacion], [CodigoDeEtica], [Historia], [Misiones], [Valores], [Calle], [Pais], [Provincia]) VALUES (33, N'Mi Cine con detalle', 0xE6100000010CFDEEC27B330D50C0BAB8324D7D6B3FC0, N'Código de ética...', N'Historia del cine...', N'Misiones...', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Cines] OFF
GO
SET IDENTITY_INSERT [dbo].[CinesOfertas] ON 

INSERT [dbo].[CinesOfertas] ([Id], [FechaInicio], [FechaFin], [PorcentajeDescuento], [CineId]) VALUES (1, CAST(N'2023-09-11' AS Date), CAST(N'2023-09-18' AS Date), CAST(5.00 AS Decimal(5, 2)), 24)
INSERT [dbo].[CinesOfertas] ([Id], [FechaInicio], [FechaFin], [PorcentajeDescuento], [CineId]) VALUES (2, CAST(N'2023-09-11' AS Date), CAST(N'2023-12-04' AS Date), CAST(7.00 AS Decimal(5, 2)), 25)
INSERT [dbo].[CinesOfertas] ([Id], [FechaInicio], [FechaFin], [PorcentajeDescuento], [CineId]) VALUES (3, CAST(N'2023-07-08' AS Date), CAST(N'2023-09-13' AS Date), CAST(9.00 AS Decimal(5, 2)), 26)
INSERT [dbo].[CinesOfertas] ([Id], [FechaInicio], [FechaFin], [PorcentajeDescuento], [CineId]) VALUES (4, CAST(N'2023-09-13' AS Date), CAST(N'2023-09-13' AS Date), CAST(100.00 AS Decimal(5, 2)), 27)
INSERT [dbo].[CinesOfertas] ([Id], [FechaInicio], [FechaFin], [PorcentajeDescuento], [CineId]) VALUES (6, CAST(N'2023-10-11' AS Date), CAST(N'2023-10-18' AS Date), CAST(5.00 AS Decimal(5, 2)), NULL)
INSERT [dbo].[CinesOfertas] ([Id], [FechaInicio], [FechaFin], [PorcentajeDescuento], [CineId]) VALUES (7, CAST(N'2023-10-27' AS Date), CAST(N'2023-11-03' AS Date), CAST(5.00 AS Decimal(5, 2)), 30)
INSERT [dbo].[CinesOfertas] ([Id], [FechaInicio], [FechaFin], [PorcentajeDescuento], [CineId]) VALUES (8, CAST(N'2023-10-27' AS Date), CAST(N'2023-11-03' AS Date), CAST(5.00 AS Decimal(5, 2)), NULL)
INSERT [dbo].[CinesOfertas] ([Id], [FechaInicio], [FechaFin], [PorcentajeDescuento], [CineId]) VALUES (9, CAST(N'2023-10-28' AS Date), CAST(N'2023-11-04' AS Date), CAST(5.00 AS Decimal(5, 2)), 32)
INSERT [dbo].[CinesOfertas] ([Id], [FechaInicio], [FechaFin], [PorcentajeDescuento], [CineId]) VALUES (10, CAST(N'2023-10-28' AS Date), CAST(N'2023-11-04' AS Date), CAST(5.00 AS Decimal(5, 2)), 33)
INSERT [dbo].[CinesOfertas] ([Id], [FechaInicio], [FechaFin], [PorcentajeDescuento], [CineId]) VALUES (11, CAST(N'2024-02-03' AS Date), CAST(N'2024-02-03' AS Date), CAST(70.00 AS Decimal(5, 2)), 1)
SET IDENTITY_INSERT [dbo].[CinesOfertas] OFF
GO
SET IDENTITY_INSERT [dbo].[DetallesFacturas] ON 

INSERT [dbo].[DetallesFacturas] ([Id], [Producto], [FacturaId], [Precio], [Cantidad]) VALUES (1, N'Papa', 1, CAST(350.99 AS Decimal(18, 2)), 1)
INSERT [dbo].[DetallesFacturas] ([Id], [Producto], [FacturaId], [Precio], [Cantidad]) VALUES (2, N'Acelga', 1, CAST(10.00 AS Decimal(18, 2)), 3)
INSERT [dbo].[DetallesFacturas] ([Id], [Producto], [FacturaId], [Precio], [Cantidad]) VALUES (3, N'Zanahoria', 1, CAST(45.50 AS Decimal(18, 2)), 7)
INSERT [dbo].[DetallesFacturas] ([Id], [Producto], [FacturaId], [Precio], [Cantidad]) VALUES (4, N'Tornillo', 2, CAST(17.99 AS Decimal(18, 2)), 12)
INSERT [dbo].[DetallesFacturas] ([Id], [Producto], [FacturaId], [Precio], [Cantidad]) VALUES (5, N'Arandela', 2, CAST(14.00 AS Decimal(18, 2)), 3)
INSERT [dbo].[DetallesFacturas] ([Id], [Producto], [FacturaId], [Precio], [Cantidad]) VALUES (6, N'Clavo', 2, CAST(45.00 AS Decimal(18, 2)), 4)
INSERT [dbo].[DetallesFacturas] ([Id], [Producto], [FacturaId], [Precio], [Cantidad]) VALUES (7, N'Carne', 2, CAST(100.00 AS Decimal(18, 2)), 6)
INSERT [dbo].[DetallesFacturas] ([Id], [Producto], [FacturaId], [Precio], [Cantidad]) VALUES (8, N'Huevo', 3, CAST(371.00 AS Decimal(18, 2)), 8)
INSERT [dbo].[DetallesFacturas] ([Id], [Producto], [FacturaId], [Precio], [Cantidad]) VALUES (9, N'Aceituna', 3, CAST(114.99 AS Decimal(18, 2)), 2)
INSERT [dbo].[DetallesFacturas] ([Id], [Producto], [FacturaId], [Precio], [Cantidad]) VALUES (10, N'Cloro', 3, CAST(425.00 AS Decimal(18, 2)), 7)
INSERT [dbo].[DetallesFacturas] ([Id], [Producto], [FacturaId], [Precio], [Cantidad]) VALUES (11, N'Banana', 3, CAST(1000.00 AS Decimal(18, 2)), 4)
INSERT [dbo].[DetallesFacturas] ([Id], [Producto], [FacturaId], [Precio], [Cantidad]) VALUES (12, N'Pescado', 3, CAST(5.00 AS Decimal(18, 2)), 10)
INSERT [dbo].[DetallesFacturas] ([Id], [Producto], [FacturaId], [Precio], [Cantidad]) VALUES (13, N'Franela', 3, CAST(2.99 AS Decimal(18, 2)), 9)
INSERT [dbo].[DetallesFacturas] ([Id], [Producto], [FacturaId], [Precio], [Cantidad]) VALUES (14, N'Golosina', 4, CAST(50.00 AS Decimal(18, 2)), 5)
INSERT [dbo].[DetallesFacturas] ([Id], [Producto], [FacturaId], [Precio], [Cantidad]) VALUES (18, N'Crema', 4, CAST(89.00 AS Decimal(18, 2)), 6)
INSERT [dbo].[DetallesFacturas] ([Id], [Producto], [FacturaId], [Precio], [Cantidad]) VALUES (20, N'Nutella', 4, CAST(670.00 AS Decimal(18, 2)), 3)
SET IDENTITY_INSERT [dbo].[DetallesFacturas] OFF
GO
SET IDENTITY_INSERT [dbo].[Facturas] ON 

INSERT [dbo].[Facturas] ([Id], [FechaCreacion], [NumeroFactura], [Desde], [Hasta]) VALUES (1, CAST(N'2024-02-05' AS Date), 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2))
INSERT [dbo].[Facturas] ([Id], [FechaCreacion], [NumeroFactura], [Desde], [Hasta]) VALUES (2, CAST(N'2024-02-17' AS Date), 2, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2))
INSERT [dbo].[Facturas] ([Id], [FechaCreacion], [NumeroFactura], [Desde], [Hasta]) VALUES (3, CAST(N'2002-01-24' AS Date), 3, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2))
INSERT [dbo].[Facturas] ([Id], [FechaCreacion], [NumeroFactura], [Desde], [Hasta]) VALUES (4, CAST(N'2002-01-24' AS Date), 4, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Facturas] OFF
GO
SET IDENTITY_INSERT [dbo].[Generos] ON 

INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (1, N'Nombre cambiado por primera persona', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (2, N'Aventura', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, N'Felipe', CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (3, N'C. Ficción', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, N'Felipe', CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (4, N'Fantasía', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (5, N'Comedia', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (6, N'Drama', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (7, N'Romance', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (8, N'Terror', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (9, N'Suspenso', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (10, N'Misterio', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (11, N'Crimen', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (12, N'Western', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (13, N'Animación', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (14, N'Musical', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (15, N'Documental', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (17, N'Fantasía científica', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (18, N'Superhéroes', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (19, N'Guerra', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (20, N'Romántica', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (21, N'Biografía', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (22, N'postMultiple1', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (23, N'postMultiple2', 0, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (25, N'Animé', 1, CAST(N'2023-10-02T14:31:50.1200000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (26, N'Prueba Entry', 0, CAST(N'2023-11-06T18:07:01.1000000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (28, N'Generos Ej SaveChanges Modificado', 0, CAST(N'2024-01-30T16:56:17.0733333' AS DateTime2), N'Felipe', N'Felipe2', CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (29, N'Género Inyección de Dependencias', 0, CAST(N'2024-01-30T22:14:57.3733333' AS DateTime2), N'Felipe', N'Felipe', CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (30, N'Genero Eventos Tracked', 0, CAST(N'2024-01-30T23:44:56.7300000' AS DateTime2), N'Felipe', N'Felipe', CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (31, N'Genero Primero Eventos de Savechanges', 0, CAST(N'2024-02-01T03:05:33.0766667' AS DateTime2), N'Felipe', N'Felipe', CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (32, N'Genero Segundo Eventos de Savechanges', 0, CAST(N'2024-02-01T03:05:33.0766667' AS DateTime2), N'Felipe', N'Felipe', CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (33, N'Genero Tercero Eventos de Savechanges', 0, CAST(N'2024-02-01T03:05:33.0766667' AS DateTime2), N'Felipe', N'Felipe', CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (34, N'Genero Cuarto Eventos de Savechanges', 0, CAST(N'2024-02-01T03:05:33.0766667' AS DateTime2), N'Felipe', N'Felipe', CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (35, N'Genero Quinto Eventos de Savechanges', 0, CAST(N'2024-02-01T03:05:33.0766667' AS DateTime2), N'Felipe', N'Felipe', CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (36, N'Genero Sexto Eventos de Savechanges', 0, CAST(N'2024-02-01T03:05:33.0766667' AS DateTime2), N'Felipe', N'Felipe', CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (37, N'Genero Septimo Eventos de Savechanges', 0, CAST(N'2024-02-01T03:05:33.0766667' AS DateTime2), N'Felipe', N'Felipe', CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (40, N'postArbitrario', 0, CAST(N'2024-02-02T14:34:23.8833333' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (43, N'Post SP', 0, CAST(N'2024-02-02T19:21:24.8000000' AS DateTime2), NULL, NULL, CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (44, N'ComediaActualizado', 0, CAST(N'2024-02-05T11:34:37.2366667' AS DateTime2), N'Felipe', N'Felipe', CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (47, N'ModificacionActual', 0, CAST(N'2024-02-05T16:22:05.8000000' AS DateTime2), N'Felipe', N'Felipe', CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'2024-02-05T21:05:53.9138419' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (48, N'Prueba de inserción de género', 0, CAST(N'2024-02-22T11:06:17.8633333' AS DateTime2), N'Felipe', N'Felipe', CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'2024-02-22T14:06:17.8562104' AS DateTime2))
INSERT [dbo].[Generos] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (49, N'Prueba de inserción de género 2', 1, CAST(N'2024-02-22T11:06:29.1000000' AS DateTime2), N'Felipe', N'Felipe', CAST(N'9999-12-31T23:59:59.9999999' AS DateTime2), CAST(N'2024-02-22T14:08:46.5413839' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Generos] OFF
GO
INSERT [dbo].[GenerosHistory] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (47, N'Genero Temporal', 0, CAST(N'2024-02-05T16:22:05.8000000' AS DateTime2), N'Felipe', N'Felipe', CAST(N'2024-02-05T19:23:50.4614397' AS DateTime2), CAST(N'2024-02-05T19:22:05.7437935' AS DateTime2))
INSERT [dbo].[GenerosHistory] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (47, N'Genero Temporal_Modificado', 0, CAST(N'2024-02-05T16:22:05.8000000' AS DateTime2), N'Felipe', N'Felipe', CAST(N'2024-02-05T19:25:13.2483341' AS DateTime2), CAST(N'2024-02-05T19:23:50.4614397' AS DateTime2))
INSERT [dbo].[GenerosHistory] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (47, N'Genero Temporal_Modificado_2', 0, CAST(N'2024-02-05T16:22:05.8000000' AS DateTime2), N'Felipe', N'Felipe', CAST(N'2024-02-05T19:25:47.3678217' AS DateTime2), CAST(N'2024-02-05T19:25:13.2483341' AS DateTime2))
INSERT [dbo].[GenerosHistory] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (47, N'Genero Temporal_Modificado_2', 1, CAST(N'2024-02-05T16:22:05.8000000' AS DateTime2), N'Felipe', N'Felipe', CAST(N'2024-02-05T21:04:56.9475071' AS DateTime2), CAST(N'2024-02-05T19:25:47.3678217' AS DateTime2))
INSERT [dbo].[GenerosHistory] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (47, N'Genero Temporal_Modificado_2', 0, CAST(N'2024-02-05T16:22:05.8000000' AS DateTime2), N'Felipe', N'Felipe', CAST(N'2024-02-05T21:05:41.7060134' AS DateTime2), CAST(N'2024-02-05T21:04:56.9475071' AS DateTime2))
INSERT [dbo].[GenerosHistory] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (47, N'Modificacion1', 0, CAST(N'2024-02-05T16:22:05.8000000' AS DateTime2), N'Felipe', N'Felipe', CAST(N'2024-02-05T21:05:43.8277564' AS DateTime2), CAST(N'2024-02-05T21:05:41.7060134' AS DateTime2))
INSERT [dbo].[GenerosHistory] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (47, N'Modificacion2', 0, CAST(N'2024-02-05T16:22:05.8000000' AS DateTime2), N'Felipe', N'Felipe', CAST(N'2024-02-05T21:05:45.8459613' AS DateTime2), CAST(N'2024-02-05T21:05:43.8277564' AS DateTime2))
INSERT [dbo].[GenerosHistory] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (47, N'Modificacion3', 0, CAST(N'2024-02-05T16:22:05.8000000' AS DateTime2), N'Felipe', N'Felipe', CAST(N'2024-02-05T21:05:47.8596155' AS DateTime2), CAST(N'2024-02-05T21:05:45.8459613' AS DateTime2))
INSERT [dbo].[GenerosHistory] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (47, N'Modificacion4', 0, CAST(N'2024-02-05T16:22:05.8000000' AS DateTime2), N'Felipe', N'Felipe', CAST(N'2024-02-05T21:05:49.8816842' AS DateTime2), CAST(N'2024-02-05T21:05:47.8596155' AS DateTime2))
INSERT [dbo].[GenerosHistory] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (47, N'Modificacion5', 0, CAST(N'2024-02-05T16:22:05.8000000' AS DateTime2), N'Felipe', N'Felipe', CAST(N'2024-02-05T21:05:51.8917334' AS DateTime2), CAST(N'2024-02-05T21:05:49.8816842' AS DateTime2))
INSERT [dbo].[GenerosHistory] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (47, N'Modificacion6', 0, CAST(N'2024-02-05T16:22:05.8000000' AS DateTime2), N'Felipe', N'Felipe', CAST(N'2024-02-05T21:05:53.9138419' AS DateTime2), CAST(N'2024-02-05T21:05:51.8917334' AS DateTime2))
INSERT [dbo].[GenerosHistory] ([Id], [NombreGenero], [EstaBorrado], [FechaCreacion], [UsuarioCrecion], [UsuarioModificacion], [PeriodEnd], [PeriodStart]) VALUES (49, N'Prueba de inserción de género 2', 0, CAST(N'2024-02-22T11:06:29.1000000' AS DateTime2), N'Felipe', N'Felipe', CAST(N'2024-02-22T14:08:46.5413839' AS DateTime2), CAST(N'2024-02-22T14:06:29.1022444' AS DateTime2))
GO
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (4, 1)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (7, 1)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (12, 1)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (5, 2)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (8, 2)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (11, 2)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (20, 2)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (7, 3)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (10, 4)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (1, 5)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (8, 5)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (18, 5)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (4, 6)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (19, 6)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (17, 7)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (4, 8)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (9, 8)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (13, 8)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (2, 9)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (17, 9)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (18, 9)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (8, 10)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (10, 10)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (12, 10)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (14, 10)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (5, 11)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (19, 11)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (9, 12)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (18, 12)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (19, 12)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (5, 13)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (10, 13)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (12, 13)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (14, 13)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (9, 14)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (18, 14)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (20, 14)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (9, 15)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (19, 15)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (4, 16)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (8, 16)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (17, 16)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (2, 17)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (3, 17)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (7, 17)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (5, 18)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (17, 18)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (2, 19)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (17, 19)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (18, 19)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (19, 19)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (5, 20)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (9, 20)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (11, 20)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (14, 20)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (2, 21)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (4, 21)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (5, 22)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (4, 23)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (6, 23)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (11, 23)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (10, 24)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (14, 24)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (15, 24)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (17, 24)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (8, 25)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (17, 25)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (18, 25)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (4, 26)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (7, 26)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (2, 27)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (19, 27)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (6, 28)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (14, 28)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (5, 29)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (17, 29)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (19, 29)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (13, 30)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (7, 31)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (8, 31)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (5, 32)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (13, 33)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (14, 33)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (17, 33)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (6, 34)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (17, 34)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (17, 35)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (4, 36)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (13, 36)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (17, 36)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (19, 36)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (8, 37)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (12, 37)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (5, 38)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (12, 38)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (15, 38)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (3, 39)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (9, 39)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (11, 39)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (20, 39)
GO
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (9, 41)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (13, 41)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (17, 41)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (11, 42)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (2, 43)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (11, 43)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (12, 43)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (2, 44)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (3, 44)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (5, 44)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (8, 44)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (5, 45)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (7, 45)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (2, 46)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (3, 46)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (12, 46)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (17, 46)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (20, 46)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (15, 47)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (6, 48)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (8, 48)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (5, 49)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (6, 49)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (10, 49)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (3, 50)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (4, 50)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (6, 50)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (7, 50)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (14, 50)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (2, 51)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (6, 51)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (10, 51)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (18, 51)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (5, 52)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (6, 52)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (9, 52)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (14, 53)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (11, 54)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (15, 54)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (18, 54)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (6, 55)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (4, 56)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (8, 56)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (12, 56)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (8, 57)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (17, 57)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (19, 57)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (12, 58)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (2, 59)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (17, 61)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (10, 62)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (13, 63)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (7, 64)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (14, 64)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (19, 64)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (11, 65)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (10, 66)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (7, 68)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (5, 69)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (9, 69)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (14, 69)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (12, 71)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (6, 72)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (7, 72)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (14, 74)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (18, 75)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (19, 76)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (5, 77)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (12, 78)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (15, 78)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (14, 79)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (20, 80)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (1, 81)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (1, 82)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (2, 82)
INSERT [dbo].[GenerosPeliculas] ([GenerosId], [PeliculasId]) VALUES (4, 82)
GO
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'00000000-0000-0000-0000-000000000000', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'c1d6f0d5-ffe8-42be-bb93-08dbb5669bd0', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'7ad4460d-62bc-4074-870e-08dbb568ee4f', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'2a70107c-c0db-4279-870f-08dbb568ee4f', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'e386dd92-28d1-4060-5db9-08dbb6432a3c', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'd9de0947-76e3-4f03-5dba-08dbb6432a3c', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'd98ef289-324e-4892-3a64-08dbbaa3974c', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'39cc8579-de8b-45ff-e314-08dbbaa62f2a', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'c6dd2dcd-1ed6-4ec4-f723-08dc27539b81', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'b80fd358-df8e-4dbc-6357-08dc296eada7', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'af7ab3b8-eda8-47c3-2b2e-08dc29727953', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'8ffc4ee1-d2e0-4f21-9e09-08dc297662c3', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'a8474d83-97ce-45c6-81ad-08dc2b276259', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'd5b1b984-4753-4667-653d-08dc2c161a3b', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'084258bb-5c94-44fe-9637-08dc3252f892', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'c103b15b-5edb-498f-7d47-08dc325b2b53', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'b2113d38-1820-4e8e-709b-08dc325b846e', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'1a8f29af-dcb8-4960-709c-08dc325b846e', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'b48c8e04-b254-4f00-959b-08dc325c831c', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'9b99fdf5-e41d-455f-4b9e-08dc325f699c', N'Ejecutando el método GenerosController.Get', NULL)
INSERT [dbo].[Logs] ([Id], [Mensaje], [Ejemplo]) VALUES (N'b145492b-c631-4422-0173-08dc33af432c', N'Ejecutando el método GenerosController.Get', NULL)
GO
SET IDENTITY_INSERT [dbo].[Mensajes] ON 

INSERT [dbo].[Mensajes] ([Id], [Contenido], [EmisorId], [ReceptorId]) VALUES (1, N'Hola, Claudia!', 1, 2)
INSERT [dbo].[Mensajes] ([Id], [Contenido], [EmisorId], [ReceptorId]) VALUES (2, N'Hola, Felipe, ¿Cómo te va?', 2, 1)
INSERT [dbo].[Mensajes] ([Id], [Contenido], [EmisorId], [ReceptorId]) VALUES (3, N'Todo bien, ¿Y tú?', 1, 2)
INSERT [dbo].[Mensajes] ([Id], [Contenido], [EmisorId], [ReceptorId]) VALUES (4, N'Muy bien, gracias', 2, 1)
SET IDENTITY_INSERT [dbo].[Mensajes] OFF
GO
INSERT [dbo].[Merchandising] ([Id], [DisponibleEnInventario], [Peso], [Volumen], [EsRopa], [EsColeccionable]) VALUES (2, 1, 1, 1, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[Pagos] ON 

INSERT [dbo].[Pagos] ([Id], [Monto], [FechaTransaccion], [TipoPago], [CorreoElectronico], [UltimosCuatroDigitos]) VALUES (1, CAST(500.00 AS Decimal(18, 2)), CAST(N'2022-01-06' AS Date), 2, NULL, N'0123')
INSERT [dbo].[Pagos] ([Id], [Monto], [FechaTransaccion], [TipoPago], [CorreoElectronico], [UltimosCuatroDigitos]) VALUES (2, CAST(120.00 AS Decimal(18, 2)), CAST(N'2022-01-06' AS Date), 2, NULL, N'1234')
INSERT [dbo].[Pagos] ([Id], [Monto], [FechaTransaccion], [TipoPago], [CorreoElectronico], [UltimosCuatroDigitos]) VALUES (3, CAST(157.00 AS Decimal(18, 2)), CAST(N'2022-01-07' AS Date), 1, N'david@hotmail.com', NULL)
INSERT [dbo].[Pagos] ([Id], [Monto], [FechaTransaccion], [TipoPago], [CorreoElectronico], [UltimosCuatroDigitos]) VALUES (4, CAST(9.99 AS Decimal(18, 2)), CAST(N'2022-01-07' AS Date), 1, N'claudia@hotmail.com', NULL)
SET IDENTITY_INSERT [dbo].[Pagos] OFF
GO
SET IDENTITY_INSERT [dbo].[Peliculas] ON 

INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (1, N'Amanecer en el Bosque', 1, CAST(N'2000-01-01' AS Date), N'http://www.ejemplo.com/poster1')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (2, N'Bajo el Cielo Estrellado', 0, CAST(N'2001-02-02' AS Date), N'http://www.ejemplo.com/poster2')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (3, N'Cazadores del Tesoro', 1, CAST(N'2002-03-03' AS Date), N'http://www.ejemplo.com/poster3')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (4, N'Días de Aventuras', 0, CAST(N'2003-04-04' AS Date), N'http://www.ejemplo.com/poster4')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (5, N'Expedición a lo Desconocido', 1, CAST(N'2004-05-05' AS Date), N'http://www.ejemplo.com/poster5')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (6, N'Fuego en la Noche', 0, CAST(N'2005-06-06' AS Date), N'http://www.ejemplo.com/poster6')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (7, N'Guardianes del Abismo', 1, CAST(N'2006-07-07' AS Date), N'http://www.ejemplo.com/poster7')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (8, N'Héroes Submarinos', 0, CAST(N'2007-08-08' AS Date), N'http://www.ejemplo.com/poster8')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (9, N'Intriga en el Desierto', 1, CAST(N'2008-09-09' AS Date), N'http://www.ejemplo.com/poster9')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (10, N'Jungla Misteriosa', 0, CAST(N'2009-10-10' AS Date), N'http://www.ejemplo.com/poster10')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (11, N'Kárate en el Pirata Dorado', 1, CAST(N'2010-11-11' AS Date), N'http://www.ejemplo.com/poster11')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (12, N'Luna sobre la Ciudad Antigua', 0, CAST(N'2011-12-12' AS Date), N'http://www.ejemplo.com/poster12')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (13, N'Misterio en el Castillo Olvidado', 1, CAST(N'2013-01-13' AS Date), N'http://www.ejemplo.com/poster13')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (14, N'Noche en la Isla Desierta', 0, CAST(N'2014-02-14' AS Date), N'http://www.ejemplo.com/poster14')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (15, N'Oculto en el Espacio Profundo', 1, CAST(N'2015-03-15' AS Date), N'http://www.ejemplo.com/poster15')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (16, N'Perdidos en el Explorador', 0, CAST(N'2016-04-16' AS Date), N'http://www.ejemplo.com/poster16')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (17, N'Querido Tesoro Lejano', 1, CAST(N'2017-05-17' AS Date), N'http://www.ejemplo.com/poster17')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (18, N'Rastro en la Montaña Nevada', 0, CAST(N'2018-06-18' AS Date), N'http://www.ejemplo.com/poster18')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (19, N'Secretos en la Jungla Mística', 1, CAST(N'2019-07-19' AS Date), N'http://www.ejemplo.com/poster19')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (20, N'Travesía en el Océano Profundo', 0, CAST(N'2020-08-20' AS Date), N'http://www.ejemplo.com/poster20')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (21, N'Aventuras en el Desierto Antiguo', 1, CAST(N'2021-09-21' AS Date), N'http://www.ejemplo.com/poster21')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (22, N'Búsqueda en la Ciudad Perdida', 0, CAST(N'2022-10-22' AS Date), N'http://www.ejemplo.com/poster22')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (23, N'Caza del Mar Profundo', 1, CAST(N'2023-11-23' AS Date), N'http://www.ejemplo.com/poster23')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (24, N'Días de Espacio Lejano', 0, CAST(N'2024-12-24' AS Date), N'http://www.ejemplo.com/poster24')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (25, N'Explorando el Bosque Encantado', 1, CAST(N'2026-01-25' AS Date), N'http://www.ejemplo.com/poster25')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (26, N'Fuga en la Isla Desierta', 0, CAST(N'2027-02-26' AS Date), N'http://www.ejemplo.com/poster26')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (27, N'Guardianes del Cielo Azul', 1, CAST(N'2028-03-27' AS Date), N'http://www.ejemplo.com/poster27')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (28, N'Historias en el Castillo Antiguo', 0, CAST(N'2029-04-28' AS Date), N'http://www.ejemplo.com/poster28')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (29, N'Intriga en el Desierto Profundo', 1, CAST(N'2030-05-29' AS Date), N'http://www.ejemplo.com/poster29')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (30, N'Jungla de Tesoros', 0, CAST(N'2031-06-30' AS Date), N'http://www.ejemplo.com/poster30')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (31, N'Kárate en el Mar Profundo', 1, CAST(N'2032-07-31' AS Date), N'http://www.ejemplo.com/poster31')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (32, N'Luna sobre el Bosque Olvidado', 0, CAST(N'2033-08-01' AS Date), N'http://www.ejemplo.com/poster32')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (33, N'Misterio en el Castillo Lejano', 1, CAST(N'2034-09-02' AS Date), N'http://www.ejemplo.com/poster33')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (34, N'Noche en la Isla Misteriosa', 0, CAST(N'2035-10-03' AS Date), N'http://www.ejemplo.com/poster34')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (35, N'Oculto en el Espacio Desconocido', 1, CAST(N'2036-11-04' AS Date), N'http://www.ejemplo.com/poster35')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (36, N'Perdidos en el Explorador Profundo', 0, CAST(N'2037-12-05' AS Date), N'http://www.ejemplo.com/poster36')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (37, N'Querido Tesoro Desconocido', 1, CAST(N'2039-01-06' AS Date), N'http://www.ejemplo.com/poster37')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (38, N'Rastro en la Montaña Profunda', 0, CAST(N'2040-02-07' AS Date), N'http://www.ejemplo.com/poster38')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (39, N'Secretos en la Jungla Lejana', 1, CAST(N'2041-03-08' AS Date), N'http://www.ejemplo.com/poster39')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (40, N'Travesía en el Océano Desconocido', 0, CAST(N'2042-04-09' AS Date), N'http://www.ejemplo.com/poster40')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (41, N'Forrest Gump', 1, CAST(N'2000-05-15' AS Date), N'http://www.ejemplo.com/poster46')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (42, N'La Lista de Schindler', 0, CAST(N'1999-09-08' AS Date), N'http://www.ejemplo.com/poster47')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (43, N'Pulp Fiction', 1, CAST(N'2002-03-23' AS Date), N'http://www.ejemplo.com/poster48')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (44, N'El Señor de los Anillos: El Retorno del Rey', 0, CAST(N'2003-11-11' AS Date), N'http://www.ejemplo.com/poster49')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (45, N'Tiempos Violentos', 1, CAST(N'2004-07-05' AS Date), N'http://www.ejemplo.com/poster50')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (46, N'Salvar al Soldado Ryan', 0, CAST(N'2005-02-19' AS Date), N'http://www.ejemplo.com/poster51')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (47, N'Gladiador', 1, CAST(N'2006-11-30' AS Date), N'http://www.ejemplo.com/poster52')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (48, N'Matrix', 0, CAST(N'2007-08-17' AS Date), N'http://www.ejemplo.com/poster53')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (49, N'Naufrago', 1, CAST(N'2008-06-22' AS Date), N'http://www.ejemplo.com/poster54')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (50, N'El Club de la Lucha', 0, CAST(N'2009-04-14' AS Date), N'http://www.ejemplo.com/poster55')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (51, N'El Silencio de los Corderos', 1, CAST(N'2010-01-07' AS Date), N'http://www.ejemplo.com/poster56')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (52, N'El Rey León', 0, CAST(N'2011-10-25' AS Date), N'http://www.ejemplo.com/poster57')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (53, N'Titanic', 1, CAST(N'2012-12-01' AS Date), N'http://www.ejemplo.com/poster58')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (54, N'La Vida es Bella', 0, CAST(N'2013-06-14' AS Date), N'http://www.ejemplo.com/poster59')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (55, N'Mente Indomable', 1, CAST(N'2014-04-10' AS Date), N'http://www.ejemplo.com/poster60')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (56, N'El Gran Lebowski', 0, CAST(N'2015-03-05' AS Date), N'http://www.ejemplo.com/poster61')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (57, N'Interestelar', 1, CAST(N'2016-01-19' AS Date), N'http://www.ejemplo.com/poster62')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (58, N'El Caballero de la Noche', 0, CAST(N'2017-10-29' AS Date), N'http://www.ejemplo.com/poster63')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (59, N'La Red Social', 1, CAST(N'2018-03-01' AS Date), N'http://www.ejemplo.com/poster64')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (60, N'El Resplandor', 0, CAST(N'2019-09-09' AS Date), N'http://www.ejemplo.com/poster65')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (61, N'Paseo de la Fama', 1, CAST(N'2020-07-12' AS Date), N'http://www.ejemplo.com/poster66')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (62, N'12 Monos', 0, CAST(N'2021-05-18' AS Date), N'http://www.ejemplo.com/poster67')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (63, N'Blade Runner', 1, CAST(N'2022-03-20' AS Date), N'http://www.ejemplo.com/poster68')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (64, N'Jurassic Park', 0, CAST(N'2022-12-04' AS Date), N'http://www.ejemplo.com/poster69')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (65, N'Eterno Resplandor de una Mente sin Recuerdos', 1, CAST(N'2023-08-19' AS Date), N'http://www.ejemplo.com/poster70')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (66, N'Matrix', 0, CAST(N'2021-07-25' AS Date), N'http://www.ejemplo.com/poster71')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (67, N'Donnie Darko', 1, CAST(N'2022-04-13' AS Date), N'http://www.ejemplo.com/poster72')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (68, N'Los Infiltrados', 0, CAST(N'2023-01-05' AS Date), N'http://www.ejemplo.com/poster73')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (69, N'El Gran Hotel Budapest', 1, CAST(N'2020-12-14' AS Date), N'http://www.ejemplo.com/poster74')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (70, N'El Renacido', 0, CAST(N'2021-09-07' AS Date), N'http://www.ejemplo.com/poster75')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (71, N'Birdman', 1, CAST(N'2022-06-16' AS Date), N'http://www.ejemplo.com/poster76')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (72, N'Parásitos', 0, CAST(N'2023-03-19' AS Date), N'http://www.ejemplo.com/poster77')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (73, N'Una Mente Brillante', 1, CAST(N'2021-02-25' AS Date), N'http://www.ejemplo.com/poster78')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (74, N'El Club de los Cinco', 0, CAST(N'2020-12-12' AS Date), N'http://www.ejemplo.com/poster79')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (75, N'El Padrino', 1, CAST(N'2022-11-14' AS Date), N'http://www.ejemplo.com/poster80')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (76, N'Parque Jurásico', 1, CAST(N'2021-08-15' AS Date), N'http://www.ejemplo.com/poster81')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (77, N'Matrix Reloaded', 0, CAST(N'2022-06-21' AS Date), N'http://www.ejemplo.com/poster82')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (78, N'El Padrino: Parte II', 1, CAST(N'2023-04-08' AS Date), N'http://www.ejemplo.com/poster83')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (79, N'Los Vengadores', 0, CAST(N'2021-11-30' AS Date), N'http://www.ejemplo.com/poster84')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (80, N'La Sirenita', 1, CAST(N'2022-09-12' AS Date), N'http://www.ejemplo.com/poster85')
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (81, N'fgh', 1, CAST(N'2023-09-13' AS Date), NULL)
INSERT [dbo].[Peliculas] ([Id], [Titulo], [EnCartelera], [FechaEstreno], [PosterURL]) VALUES (82, N'TestPeliculaConDataExistente', 1, CAST(N'2023-09-13' AS Date), NULL)
SET IDENTITY_INSERT [dbo].[Peliculas] OFF
GO
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (1, 1, N'Natalie', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (1, 13, N'Astra', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (1, 25, N'Garrison', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (2, 24, N'Aquila', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (2, 25, N'Sage', 10)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (2, 41, N'Kristen', 10)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (2, 48, N'Blaze', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (3, 4, N'Mira', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (3, 42, N'Daphne', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (3, 51, N'Beverly', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (3, 55, N'Cheryl', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (3, 62, N'Samantha', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (4, 4, N'Jolie', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (4, 9, N'Henry', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (4, 10, N'Elmo', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (4, 17, N'Carter', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (4, 45, N'Kylie', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (5, 5, N'Caldwell', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (5, 25, N'Harding', 10)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (5, 35, N'Sacha', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (5, 43, N'Gillian', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (5, 44, N'Gil', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (5, 61, N'Clarke', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (6, 6, N'Quamar', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (6, 18, N'Constance', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (6, 20, N'Amanda', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (7, 6, N'Damian', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (7, 8, N'Drew', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (7, 41, N'Cody', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (7, 56, N'Shelley', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (8, 11, N'Henry', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (8, 17, N'Chantale', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (8, 19, N'Beau', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (8, 33, N'Cade', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (8, 44, N'Jaime', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (8, 59, N'Uriel', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (8, 60, N'Carter', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (9, 4, N'Baxter', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (9, 9, N'Shaine', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (9, 36, N'Jaden', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (9, 51, N'Talon', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (10, 18, N'Melanie', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (10, 32, N'Cairo', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (10, 34, N'Veronica', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (11, 15, N'Carolyn', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (11, 31, N'Vanna', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (11, 33, N'Jayme', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (11, 36, N'Nichole', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (11, 53, N'Dylan', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (12, 3, N'Quemby', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (12, 12, N'Maxwell', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (12, 45, N'Deirdre', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (13, 4, N'Sybill', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (13, 20, N'Eric', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (13, 37, N'Scarlet', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (13, 53, N'Kellie', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (13, 54, N'Britanni', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (14, 1, N'Dolan', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (14, 13, N'Shad', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (14, 57, N'Veda', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (14, 58, N'Kane', 10)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (15, 34, N'Jason', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (15, 41, N'Cooper', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (15, 54, N'Amery', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (15, 57, N'Ulric', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (16, 8, N'Arthur', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (16, 22, N'Nelle', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (16, 53, N'Fiona', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (17, 20, N'Gareth', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (17, 21, N'Eric', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (17, 26, N'Kibo', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (17, 35, N'Jada', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (17, 52, N'Erich', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (17, 59, N'Steel', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (18, 18, N'Lila', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (18, 28, N'Simone', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (18, 31, N'Caryn', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (18, 65, N'Kasper', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (19, 15, N'Chantale', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (19, 30, N'Melinda', 10)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (19, 34, N'Brendan', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (19, 54, N'Madaline', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (20, 3, N'Cora', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (20, 13, N'Aristotle', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (20, 22, N'Vivien', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (20, 58, N'Allen', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (21, 11, N'Melissa', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (21, 29, N'Kim', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (21, 35, N'Hyatt', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (21, 36, N'Sigourney', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (21, 48, N'Carol', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (22, 7, N'Idona', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (22, 29, N'Ali', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (22, 37, N'Sandra', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (22, 43, N'Amena', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (23, 3, N'Naomi', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (23, 34, N'Tamara', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (23, 39, N'Brynne', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (24, 26, N'Vaughan', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (24, 31, N'Isaiah', 9)
GO
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (24, 36, N'Vanna', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (25, 12, N'Kato', 10)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (25, 19, N'Leroy', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (25, 36, N'Zia', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (25, 52, N'Beverly', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (26, 9, N'Brynne', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (26, 16, N'Amela', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (26, 21, N'Autumn', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (27, 2, N'Basil', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (27, 3, N'Lamar', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (27, 20, N'Devin', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (27, 22, N'Orli', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (27, 34, N'Rowan', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (27, 35, N'Reagan', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (27, 40, N'Abel', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (27, 59, N'Callum', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (28, 4, N'Kirk', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (28, 9, N'Ivory', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (28, 19, N'Jerry', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (28, 20, N'Aaron', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (28, 56, N'Nathaniel', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (29, 5, N'Brennan', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (29, 31, N'Judah', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (30, 4, N'Tanek', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (30, 6, N'Curran', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (30, 31, N'Jayme', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (30, 49, N'Quail', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (30, 60, N'Christen', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (31, 29, N'Iona', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (32, 9, N'Abra', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (32, 20, N'Erin', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (32, 24, N'Eaton', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (32, 45, N'Francis', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (33, 5, N'Declan', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (33, 37, N'Ivor', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (33, 50, N'Kelsie', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (34, 5, N'Zia', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (34, 6, N'Amethyst', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (34, 17, N'Edward', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (34, 21, N'Stone', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (34, 22, N'Paki', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (34, 40, N'Vivian', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (35, 16, N'Berk', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (35, 34, N'Wylie', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (36, 14, N'Hedwig', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (36, 25, N'Peter', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (36, 32, N'Wynne', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (36, 48, N'Ashely', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (36, 56, N'Lacy', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (37, 8, N'Charissa', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (37, 30, N'Ralph', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (37, 36, N'Connor', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (37, 40, N'Ashton', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (38, 16, N'Wilma', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (38, 26, N'Walker', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (38, 56, N'Christine', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (39, 5, N'Shelby', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (39, 25, N'Serina', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (39, 58, N'Maxwell', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (40, 42, N'Mara', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (40, 62, N'Amal', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (41, 2, N'Germane', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (41, 43, N'Mannix', 10)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (41, 51, N'Quentin', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (42, 24, N'Victoria', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (42, 36, N'Raven', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (42, 51, N'Jayme', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (42, 58, N'Alexander', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (43, 3, N'Sharon', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (43, 7, N'Gary', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (43, 14, N'Andrew', 10)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (43, 33, N'Vera', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (43, 49, N'Talon', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (43, 55, N'Plato', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (43, 60, N'Lynn', 10)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (44, 22, N'Aiko', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (44, 27, N'Cheyenne', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (45, 14, N'Kessie', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (45, 34, N'Melissa', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (45, 56, N'Fuller', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (47, 10, N'Stephanie', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (47, 14, N'Andrew', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (48, 3, N'Alexandra', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (48, 5, N'Victoria', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (48, 39, N'Irene', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (48, 47, N'Nissim', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (48, 60, N'Nigel', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (48, 61, N'Thor', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (48, 65, N'Marsden', 10)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (49, 1, N'Fleur', 10)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (49, 4, N'Vernon', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (49, 17, N'Ariel', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (49, 30, N'Guy', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (50, 7, N'Harriet', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (50, 14, N'Walker', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (50, 19, N'Chloe', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (50, 46, N'Giacomo', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (50, 47, N'Isaac', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (51, 9, N'Kane', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (51, 20, N'Quinlan', 5)
GO
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (51, 22, N'Charles', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (51, 63, N'Alika', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (52, 3, N'Rina', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (52, 10, N'Bryar', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (52, 31, N'Garth', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (52, 56, N'Arden', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (53, 34, N'Ulric', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (54, 32, N'Kirk', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (54, 33, N'Sacha', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (55, 17, N'Jemima', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (55, 36, N'William', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (55, 52, N'Cyrus', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (55, 56, N'Zelda', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (55, 62, N'Colin', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (56, 10, N'Louis', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (56, 16, N'Abdul', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (56, 19, N'Judah', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (56, 57, N'Sheila', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (56, 62, N'Maxwell', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (57, 28, N'Dorothy', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (57, 41, N'Oliver', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (57, 54, N'Simon', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (58, 6, N'Hillary', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (58, 18, N'Laurel', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (58, 41, N'Azalia', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (58, 45, N'Elmo', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (58, 55, N'Randall', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (58, 58, N'Warren', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (59, 24, N'Elton', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (59, 57, N'Lesley', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (59, 61, N'Cecilia', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (59, 64, N'Cynthia', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (60, 12, N'Seth', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (60, 16, N'Garrison', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (60, 19, N'Linus', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (60, 20, N'Graham', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (60, 50, N'Judith', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (60, 53, N'Erica', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (60, 54, N'Kirby', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (60, 62, N'Troy', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (60, 64, N'Meredith', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (61, 35, N'Lacy', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (61, 48, N'Hedwig', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (61, 63, N'Rinah', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (62, 18, N'Rina', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (62, 21, N'Ahmed', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (62, 60, N'Kylynn', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (63, 32, N'Kristen', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (63, 51, N'Jaden', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (64, 9, N'Dalton', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (64, 44, N'Barclay', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (64, 58, N'Orlando', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (65, 19, N'Hiram', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (65, 28, N'Shelly', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (65, 42, N'Clayton', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (65, 58, N'Leah', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (66, 4, N'Hamish', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (66, 23, N'Henry', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (66, 28, N'Chanda', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (66, 49, N'Ramona', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (66, 52, N'Felix', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (67, 6, N'Jordan', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (67, 15, N'Alika', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (67, 16, N'Logan', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (68, 11, N'Judah', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (68, 19, N'Minerva', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (68, 20, N'Cathleen', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (68, 23, N'Aline', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (68, 27, N'Erasmus', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (68, 29, N'Cody', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (68, 60, N'Shaeleigh', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (68, 63, N'Keiko', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (68, 65, N'Diana', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (69, 4, N'Echo', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (69, 7, N'Moses', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (69, 29, N'Jason', 10)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (69, 49, N'Whitney', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (70, 1, N'Lysandra', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (70, 4, N'Lilah', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (70, 7, N'Alvin', 10)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (70, 13, N'Quinn', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (70, 30, N'Jermaine', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (70, 50, N'Reece', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (71, 1, N'Baxter', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (71, 8, N'Eve', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (71, 11, N'Georgia', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (72, 18, N'Aurelia', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (72, 41, N'Beau', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (72, 46, N'Brett', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (72, 53, N'Ezekiel', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (72, 62, N'Emerson', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (73, 8, N'Kuame', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (73, 44, N'MacKensie', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (74, 3, N'Joshua', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (74, 9, N'Brady', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (74, 24, N'Ulric', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (74, 33, N'Deacon', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (74, 48, N'Jaquelyn', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (74, 62, N'Knox', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (75, 27, N'Noble', 8)
GO
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (76, 7, N'Lionel', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (76, 14, N'Flynn', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (76, 15, N'Ezekiel', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (76, 41, N'Carter', 5)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (76, 49, N'Kasper', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (77, 17, N'Inez', 3)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (77, 19, N'Sydnee', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (77, 42, N'Isadora', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (77, 46, N'Hiram', 7)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (77, 57, N'Ferris', 10)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (77, 58, N'Kuame', 9)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (78, 2, N'Ignacia', 8)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (78, 6, N'Jacob', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (78, 7, N'Baxter', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (78, 17, N'Emily', 2)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (78, 54, N'Tate', 4)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (78, 56, N'Unity', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (79, 16, N'Roth', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (79, 34, N'Tatyana', 6)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (79, 40, N'Moses', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (81, 1, N'ghf', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (82, 1, N'Pelotudo', 1)
INSERT [dbo].[PeliculasActores] ([PeliculaId], [ActorId], [Personaje], [Orden]) VALUES (82, 4, N'Viejo Petero', 2)
GO
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (3, 1)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (78, 1)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (81, 1)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (11, 2)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (16, 2)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (71, 2)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (78, 2)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (82, 2)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (35, 3)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (41, 3)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (82, 3)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (10, 4)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (20, 4)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (24, 4)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (35, 4)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (57, 4)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (82, 4)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (24, 5)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (56, 6)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (64, 6)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (65, 6)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (3, 8)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (10, 8)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (18, 9)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (36, 9)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (73, 9)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (31, 10)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (20, 11)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (65, 12)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (69, 12)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (5, 13)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (7, 13)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (10, 13)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (14, 13)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (15, 14)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (42, 14)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (74, 14)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (17, 16)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (65, 16)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (69, 16)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (74, 17)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (78, 17)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (5, 20)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (28, 20)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (5, 21)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (23, 21)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (31, 21)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (37, 21)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (61, 21)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (50, 22)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (75, 22)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (44, 23)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (4, 24)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (6, 24)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (27, 24)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (7, 25)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (45, 25)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (37, 28)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (5, 29)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (29, 30)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (34, 30)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (62, 30)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (79, 30)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (51, 31)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (55, 31)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (73, 31)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (8, 32)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (45, 32)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (47, 34)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (67, 34)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (72, 35)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (3, 36)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (54, 36)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (15, 37)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (37, 37)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (48, 37)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (27, 38)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (33, 39)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (19, 40)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (39, 40)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (44, 40)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (70, 40)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (74, 40)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (2, 41)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (10, 41)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (70, 41)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (73, 41)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (78, 41)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (42, 42)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (44, 42)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (76, 42)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (78, 42)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (42, 43)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (43, 44)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (69, 44)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (49, 45)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (54, 46)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (34, 47)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (38, 47)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (54, 47)
GO
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (18, 48)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (35, 50)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (42, 51)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (67, 51)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (3, 52)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (18, 52)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (52, 52)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (44, 53)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (46, 53)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (14, 54)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (18, 54)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (72, 54)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (79, 54)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (5, 56)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (10, 56)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (62, 56)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (28, 57)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (48, 57)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (80, 57)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (23, 58)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (44, 58)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (54, 58)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (24, 59)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (50, 59)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (61, 59)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (66, 59)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (69, 59)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (3, 60)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (71, 60)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (78, 60)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (72, 61)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (23, 62)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (40, 62)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (45, 62)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (53, 63)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (54, 63)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (57, 63)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (73, 64)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (15, 65)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (27, 65)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (7, 67)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (16, 67)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (24, 67)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (54, 67)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (62, 67)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (26, 68)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (27, 68)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (46, 68)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (14, 69)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (52, 69)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (61, 69)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (64, 69)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (62, 70)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (8, 71)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (31, 71)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (22, 72)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (26, 72)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (36, 72)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (2, 73)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (20, 73)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (73, 73)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (55, 74)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (64, 74)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (26, 75)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (32, 76)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (50, 78)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (52, 78)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (66, 78)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (69, 78)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (42, 81)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (64, 82)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (70, 83)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (75, 83)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (17, 84)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (50, 84)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (65, 85)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (56, 86)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (9, 87)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (51, 87)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (53, 87)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (74, 87)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (57, 89)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (13, 91)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (25, 91)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (70, 91)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (10, 92)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (34, 92)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (30, 93)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (14, 94)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (69, 94)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (23, 97)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (49, 97)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (50, 97)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (51, 98)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (16, 99)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (66, 99)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (15, 100)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (34, 100)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (36, 100)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (54, 100)
GO
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (75, 100)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (48, 102)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (6, 104)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (24, 104)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (51, 104)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (11, 105)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (14, 105)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (79, 105)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (10, 106)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (20, 107)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (32, 107)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (66, 107)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (21, 108)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (24, 108)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (26, 109)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (30, 109)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (78, 109)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (32, 110)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (71, 110)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (72, 110)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (8, 111)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (29, 111)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (10, 112)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (13, 112)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (13, 113)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (34, 113)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (65, 113)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (41, 114)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (47, 114)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (13, 115)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (15, 115)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (37, 115)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (47, 116)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (58, 116)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (21, 117)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (59, 117)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (52, 118)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (64, 118)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (62, 119)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (3, 120)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (61, 120)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (68, 120)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (47, 122)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (55, 122)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (56, 122)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (76, 122)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (50, 123)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (70, 124)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (78, 124)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (15, 125)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (21, 125)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (53, 125)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (20, 127)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (63, 127)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (40, 128)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (41, 128)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (58, 128)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (74, 128)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (78, 128)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (3, 129)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (15, 129)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (32, 129)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (43, 130)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (46, 130)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (68, 130)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (19, 131)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (57, 131)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (68, 131)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (3, 132)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (76, 132)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (68, 134)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (24, 135)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (39, 135)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (45, 135)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (52, 135)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (57, 135)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (66, 135)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (67, 135)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (57, 137)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (59, 137)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (63, 137)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (79, 137)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (24, 139)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (70, 140)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (32, 141)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (75, 141)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (62, 142)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (10, 143)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (39, 143)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (53, 143)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (77, 143)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (27, 145)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (34, 146)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (20, 147)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (24, 147)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (28, 147)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (33, 148)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (23, 150)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (35, 150)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (52, 150)
GO
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (69, 150)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (27, 151)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (38, 151)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (75, 151)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (76, 151)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (24, 152)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (37, 152)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (43, 152)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (31, 154)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (17, 155)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (23, 155)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (40, 155)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (67, 155)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (78, 155)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (60, 156)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (55, 157)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (3, 158)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (8, 158)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (17, 158)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (53, 158)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (58, 158)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (5, 159)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (61, 159)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (31, 160)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (44, 160)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (67, 160)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (14, 162)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (15, 162)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (51, 162)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (73, 162)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (65, 163)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (52, 164)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (59, 164)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (16, 166)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (40, 166)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (20, 167)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (3, 168)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (39, 168)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (45, 168)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (21, 169)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (11, 171)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (20, 171)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (58, 171)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (38, 172)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (61, 173)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (66, 173)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (35, 174)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (48, 174)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (57, 174)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (67, 174)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (68, 174)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (77, 174)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (21, 175)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (57, 177)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (62, 177)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (14, 178)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (23, 178)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (49, 178)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (3, 179)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (22, 179)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (71, 179)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (38, 180)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (58, 180)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (3, 182)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (10, 182)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (32, 182)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (38, 182)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (79, 183)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (26, 184)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (6, 185)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (63, 185)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (72, 186)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (18, 188)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (75, 188)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (18, 189)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (69, 189)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (6, 190)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (9, 190)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (49, 190)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (11, 191)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (32, 194)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (69, 194)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (67, 195)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (78, 195)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (9, 198)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (23, 198)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (67, 198)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (9, 201)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (76, 205)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (36, 206)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (66, 208)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (24, 209)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (63, 209)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (58, 210)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (34, 212)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (36, 212)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (2, 213)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (24, 213)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (25, 213)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (27, 213)
GO
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (72, 213)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (17, 214)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (43, 214)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (36, 215)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (11, 216)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (17, 216)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (8, 218)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (29, 218)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (35, 220)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (58, 220)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (73, 220)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (7, 221)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (31, 221)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (41, 221)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (55, 222)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (15, 223)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (28, 223)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (61, 223)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (1, 224)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (4, 224)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (20, 224)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (23, 224)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (61, 224)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (69, 224)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (45, 225)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (16, 226)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (19, 226)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (24, 227)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (76, 227)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (71, 228)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (80, 228)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (10, 229)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (79, 229)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (55, 230)
INSERT [dbo].[PeliculaSalaDeCine] ([PeliculasId], [SalasDeCineId]) VALUES (65, 230)
GO
INSERT [dbo].[PeliculasAlquilables] ([Id], [PeliculaId]) VALUES (1, 10)
GO
SET IDENTITY_INSERT [dbo].[Personas] ON 

INSERT [dbo].[Personas] ([Id], [Nombre]) VALUES (1, N'Felipe')
INSERT [dbo].[Personas] ([Id], [Nombre]) VALUES (2, N'Claudia')
SET IDENTITY_INSERT [dbo].[Personas] OFF
GO
SET IDENTITY_INSERT [dbo].[Productos] ON 

INSERT [dbo].[Productos] ([Id], [Nombre], [Precio]) VALUES (1, N'Spider-Man', CAST(5.99 AS Decimal(18, 2)))
INSERT [dbo].[Productos] ([Id], [Nombre], [Precio]) VALUES (2, N'Remera', CAST(0.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Productos] OFF
GO
SET IDENTITY_INSERT [dbo].[SalasDeCine] ON 

INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (1, CAST(221.00 AS Decimal(9, 2)), 1, N'DosDimensiones', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (2, CAST(2.00 AS Decimal(9, 2)), 18, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (3, CAST(1776.00 AS Decimal(9, 2)), 6, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (4, CAST(2205.00 AS Decimal(9, 2)), 19, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (5, CAST(870.00 AS Decimal(9, 2)), 13, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (6, CAST(173.00 AS Decimal(9, 2)), 5, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (8, CAST(90000.00 AS Decimal(9, 2)), 26, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (9, CAST(577.00 AS Decimal(9, 2)), 2, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (10, CAST(1926.00 AS Decimal(9, 2)), 12, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (11, CAST(2156.00 AS Decimal(9, 2)), 2, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (12, CAST(103.00 AS Decimal(9, 2)), 11, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (13, CAST(2226.00 AS Decimal(9, 2)), 7, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (14, CAST(1360.00 AS Decimal(9, 2)), 6, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (15, CAST(2037.00 AS Decimal(9, 2)), 15, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (16, CAST(2342.00 AS Decimal(9, 2)), 16, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (17, CAST(2481.00 AS Decimal(9, 2)), 9, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (18, CAST(132.00 AS Decimal(9, 2)), 4, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (20, CAST(1353.00 AS Decimal(9, 2)), 18, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (21, CAST(1850.00 AS Decimal(9, 2)), 19, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (22, CAST(1942.00 AS Decimal(9, 2)), 5, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (23, CAST(1544.00 AS Decimal(9, 2)), 23, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (24, CAST(761.00 AS Decimal(9, 2)), 21, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (25, CAST(302.00 AS Decimal(9, 2)), 23, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (28, CAST(2210.00 AS Decimal(9, 2)), 10, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (29, CAST(83.00 AS Decimal(9, 2)), 23, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (30, CAST(1338.00 AS Decimal(9, 2)), 7, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (31, CAST(1698.00 AS Decimal(9, 2)), 6, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (32, CAST(1324.00 AS Decimal(9, 2)), 20, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (34, CAST(2419.00 AS Decimal(9, 2)), 14, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (35, CAST(2059.00 AS Decimal(9, 2)), 19, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (36, CAST(1291.00 AS Decimal(9, 2)), 10, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (37, CAST(1253.00 AS Decimal(9, 2)), 8, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (38, CAST(825.00 AS Decimal(9, 2)), 11, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (39, CAST(828.00 AS Decimal(9, 2)), 22, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (40, CAST(824.00 AS Decimal(9, 2)), 7, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (41, CAST(1749.00 AS Decimal(9, 2)), 8, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (42, CAST(709.00 AS Decimal(9, 2)), 9, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (43, CAST(49.00 AS Decimal(9, 2)), 23, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (44, CAST(1015.00 AS Decimal(9, 2)), 15, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (45, CAST(2050.00 AS Decimal(9, 2)), 15, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (46, CAST(204.00 AS Decimal(9, 2)), 21, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (47, CAST(2120.00 AS Decimal(9, 2)), 19, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (48, CAST(1507.00 AS Decimal(9, 2)), 18, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (49, CAST(2085.00 AS Decimal(9, 2)), 12, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (50, CAST(415.00 AS Decimal(9, 2)), 10, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (51, CAST(1756.00 AS Decimal(9, 2)), 8, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (52, CAST(2271.00 AS Decimal(9, 2)), 11, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (53, CAST(591.00 AS Decimal(9, 2)), 19, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (54, CAST(1923.00 AS Decimal(9, 2)), 14, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (56, CAST(915.00 AS Decimal(9, 2)), 7, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (57, CAST(2490.00 AS Decimal(9, 2)), 19, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (58, CAST(1980.00 AS Decimal(9, 2)), 23, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (59, CAST(650.00 AS Decimal(9, 2)), 13, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (60, CAST(1739.00 AS Decimal(9, 2)), 16, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (61, CAST(1594.00 AS Decimal(9, 2)), 14, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (62, CAST(71.00 AS Decimal(9, 2)), 6, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (63, CAST(1590.00 AS Decimal(9, 2)), 16, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (64, CAST(202.00 AS Decimal(9, 2)), 14, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (65, CAST(2063.00 AS Decimal(9, 2)), 11, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (66, CAST(1174.00 AS Decimal(9, 2)), 16, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (67, CAST(1911.00 AS Decimal(9, 2)), 7, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (68, CAST(1858.00 AS Decimal(9, 2)), 10, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (69, CAST(1791.00 AS Decimal(9, 2)), 5, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (70, CAST(2205.00 AS Decimal(9, 2)), 10, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (71, CAST(2279.00 AS Decimal(9, 2)), 21, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (72, CAST(161.00 AS Decimal(9, 2)), 11, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (73, CAST(1701.00 AS Decimal(9, 2)), 4, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (74, CAST(1758.00 AS Decimal(9, 2)), 7, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (75, CAST(23.00 AS Decimal(9, 2)), 9, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (76, CAST(1724.00 AS Decimal(9, 2)), 21, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (77, CAST(420.00 AS Decimal(9, 2)), 12, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (78, CAST(1472.00 AS Decimal(9, 2)), 19, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (79, CAST(1686.00 AS Decimal(9, 2)), 7, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (80, CAST(851.00 AS Decimal(9, 2)), 17, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (81, CAST(430.00 AS Decimal(9, 2)), 22, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (82, CAST(1749.00 AS Decimal(9, 2)), 22, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (83, CAST(1824.00 AS Decimal(9, 2)), 18, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (84, CAST(1526.00 AS Decimal(9, 2)), 18, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (85, CAST(2375.00 AS Decimal(9, 2)), 17, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (86, CAST(1060.00 AS Decimal(9, 2)), 8, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (87, CAST(1680.00 AS Decimal(9, 2)), 12, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (89, CAST(251.00 AS Decimal(9, 2)), 17, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (91, CAST(842.00 AS Decimal(9, 2)), 13, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (92, CAST(70.00 AS Decimal(9, 2)), 16, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (93, CAST(2005.00 AS Decimal(9, 2)), 23, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (94, CAST(666.00 AS Decimal(9, 2)), 5, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (95, CAST(2448.00 AS Decimal(9, 2)), 2, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (97, CAST(473.00 AS Decimal(9, 2)), 17, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (98, CAST(528.00 AS Decimal(9, 2)), 6, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (99, CAST(1860.00 AS Decimal(9, 2)), 9, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (100, CAST(2368.00 AS Decimal(9, 2)), 20, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (101, CAST(1043.00 AS Decimal(9, 2)), 18, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (102, CAST(2383.00 AS Decimal(9, 2)), 4, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (104, CAST(933.00 AS Decimal(9, 2)), 19, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (105, CAST(2398.00 AS Decimal(9, 2)), 20, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (106, CAST(1893.00 AS Decimal(9, 2)), 16, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (107, CAST(1982.00 AS Decimal(9, 2)), 8, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (108, CAST(319.00 AS Decimal(9, 2)), 22, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (109, CAST(831.00 AS Decimal(9, 2)), 19, N'3', N'')
GO
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (110, CAST(1567.00 AS Decimal(9, 2)), 8, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (111, CAST(938.00 AS Decimal(9, 2)), 17, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (112, CAST(1483.00 AS Decimal(9, 2)), 20, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (113, CAST(2125.00 AS Decimal(9, 2)), 19, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (114, CAST(2281.00 AS Decimal(9, 2)), 18, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (115, CAST(787.00 AS Decimal(9, 2)), 18, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (116, CAST(137.00 AS Decimal(9, 2)), 8, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (117, CAST(1748.00 AS Decimal(9, 2)), 5, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (118, CAST(405.00 AS Decimal(9, 2)), 10, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (119, CAST(1954.00 AS Decimal(9, 2)), 4, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (120, CAST(2269.00 AS Decimal(9, 2)), 22, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (121, CAST(2397.00 AS Decimal(9, 2)), 9, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (122, CAST(506.00 AS Decimal(9, 2)), 17, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (123, CAST(201.00 AS Decimal(9, 2)), 5, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (124, CAST(2413.00 AS Decimal(9, 2)), 9, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (125, CAST(2445.00 AS Decimal(9, 2)), 12, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (126, CAST(1877.00 AS Decimal(9, 2)), 16, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (127, CAST(1003.00 AS Decimal(9, 2)), 19, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (128, CAST(568.00 AS Decimal(9, 2)), 22, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (129, CAST(1136.00 AS Decimal(9, 2)), 15, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (130, CAST(403.00 AS Decimal(9, 2)), 6, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (131, CAST(996.00 AS Decimal(9, 2)), 15, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (132, CAST(1560.00 AS Decimal(9, 2)), 7, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (133, CAST(585.00 AS Decimal(9, 2)), 16, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (134, CAST(1116.00 AS Decimal(9, 2)), 15, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (135, CAST(493.00 AS Decimal(9, 2)), 18, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (136, CAST(852.00 AS Decimal(9, 2)), 10, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (137, CAST(2230.00 AS Decimal(9, 2)), 19, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (138, CAST(2166.00 AS Decimal(9, 2)), 2, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (139, CAST(949.00 AS Decimal(9, 2)), 7, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (140, CAST(1823.00 AS Decimal(9, 2)), 11, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (141, CAST(445.00 AS Decimal(9, 2)), 16, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (142, CAST(1369.00 AS Decimal(9, 2)), 15, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (143, CAST(175.00 AS Decimal(9, 2)), 7, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (144, CAST(878.00 AS Decimal(9, 2)), 20, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (145, CAST(958.00 AS Decimal(9, 2)), 20, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (146, CAST(1186.00 AS Decimal(9, 2)), 15, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (147, CAST(2399.00 AS Decimal(9, 2)), 11, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (148, CAST(11.00 AS Decimal(9, 2)), 15, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (149, CAST(361.00 AS Decimal(9, 2)), 1, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (150, CAST(749.00 AS Decimal(9, 2)), 18, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (151, CAST(1686.00 AS Decimal(9, 2)), 8, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (152, CAST(1108.00 AS Decimal(9, 2)), 13, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (153, CAST(1244.00 AS Decimal(9, 2)), 22, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (154, CAST(739.00 AS Decimal(9, 2)), 16, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (155, CAST(1288.00 AS Decimal(9, 2)), 20, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (156, CAST(1766.00 AS Decimal(9, 2)), 16, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (157, CAST(1405.00 AS Decimal(9, 2)), 15, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (158, CAST(1693.00 AS Decimal(9, 2)), 18, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (159, CAST(437.00 AS Decimal(9, 2)), 5, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (160, CAST(328.00 AS Decimal(9, 2)), 8, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (162, CAST(11.00 AS Decimal(9, 2)), 20, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (163, CAST(312.00 AS Decimal(9, 2)), 5, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (164, CAST(1609.00 AS Decimal(9, 2)), 23, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (166, CAST(1635.00 AS Decimal(9, 2)), 19, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (167, CAST(2193.00 AS Decimal(9, 2)), 13, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (168, CAST(1521.00 AS Decimal(9, 2)), 5, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (169, CAST(1628.00 AS Decimal(9, 2)), 17, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (170, CAST(1936.00 AS Decimal(9, 2)), 2, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (171, CAST(1759.00 AS Decimal(9, 2)), 17, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (172, CAST(1170.00 AS Decimal(9, 2)), 17, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (173, CAST(1974.00 AS Decimal(9, 2)), 16, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (174, CAST(1809.00 AS Decimal(9, 2)), 21, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (175, CAST(340.00 AS Decimal(9, 2)), 12, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (176, CAST(1090.00 AS Decimal(9, 2)), 13, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (177, CAST(1173.00 AS Decimal(9, 2)), 17, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (178, CAST(112.00 AS Decimal(9, 2)), 15, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (179, CAST(1190.00 AS Decimal(9, 2)), 13, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (180, CAST(325.00 AS Decimal(9, 2)), 8, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (181, CAST(1811.00 AS Decimal(9, 2)), 13, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (182, CAST(2085.00 AS Decimal(9, 2)), 6, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (183, CAST(147.00 AS Decimal(9, 2)), 16, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (184, CAST(2189.00 AS Decimal(9, 2)), 16, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (185, CAST(2220.00 AS Decimal(9, 2)), 4, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (186, CAST(1548.00 AS Decimal(9, 2)), 9, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (187, CAST(225.00 AS Decimal(9, 2)), 9, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (188, CAST(1738.00 AS Decimal(9, 2)), 12, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (189, CAST(1859.00 AS Decimal(9, 2)), 13, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (190, CAST(1046.00 AS Decimal(9, 2)), 23, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (191, CAST(1013.00 AS Decimal(9, 2)), 13, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (192, CAST(630.00 AS Decimal(9, 2)), 17, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (193, CAST(1786.00 AS Decimal(9, 2)), 13, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (194, CAST(2337.00 AS Decimal(9, 2)), 19, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (195, CAST(1242.00 AS Decimal(9, 2)), 8, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (196, CAST(618.00 AS Decimal(9, 2)), 4, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (197, CAST(1097.00 AS Decimal(9, 2)), 21, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (198, CAST(559.00 AS Decimal(9, 2)), 21, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (199, CAST(1591.00 AS Decimal(9, 2)), 8, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (200, CAST(1788.00 AS Decimal(9, 2)), 12, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (201, CAST(467.00 AS Decimal(9, 2)), 21, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (202, CAST(1411.00 AS Decimal(9, 2)), 20, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (203, CAST(1669.00 AS Decimal(9, 2)), 1, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (204, CAST(291.00 AS Decimal(9, 2)), 7, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (205, CAST(92.00 AS Decimal(9, 2)), 4, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (206, CAST(1024.00 AS Decimal(9, 2)), 19, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (207, CAST(2051.00 AS Decimal(9, 2)), 9, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (208, CAST(2309.00 AS Decimal(9, 2)), 2, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (209, CAST(2446.00 AS Decimal(9, 2)), 6, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (210, CAST(1129.00 AS Decimal(9, 2)), 20, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (211, CAST(879.00 AS Decimal(9, 2)), 9, N'1', N'')
GO
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (212, CAST(568.00 AS Decimal(9, 2)), 9, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (213, CAST(2386.00 AS Decimal(9, 2)), 11, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (214, CAST(1131.00 AS Decimal(9, 2)), 12, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (215, CAST(2075.00 AS Decimal(9, 2)), 20, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (216, CAST(1878.00 AS Decimal(9, 2)), 19, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (217, CAST(1915.00 AS Decimal(9, 2)), 18, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (218, CAST(1650.00 AS Decimal(9, 2)), 22, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (219, CAST(1709.00 AS Decimal(9, 2)), 7, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (220, CAST(1302.00 AS Decimal(9, 2)), 16, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (221, CAST(528.00 AS Decimal(9, 2)), 18, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (222, CAST(241.00 AS Decimal(9, 2)), 11, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (223, CAST(130.00 AS Decimal(9, 2)), 22, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (224, CAST(2491.00 AS Decimal(9, 2)), 5, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (225, CAST(494.00 AS Decimal(9, 2)), 20, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (226, CAST(475.00 AS Decimal(9, 2)), 7, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (227, CAST(435.00 AS Decimal(9, 2)), 17, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (228, CAST(591.00 AS Decimal(9, 2)), 2, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (229, CAST(151.00 AS Decimal(9, 2)), 7, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (230, CAST(1119.00 AS Decimal(9, 2)), 20, N'3', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (231, CAST(200.00 AS Decimal(9, 2)), 24, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (232, CAST(350.00 AS Decimal(9, 2)), 24, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (233, CAST(480.00 AS Decimal(9, 2)), 25, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (234, CAST(670.00 AS Decimal(9, 2)), 25, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (236, CAST(0.00 AS Decimal(9, 2)), 27, N'1', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (237, CAST(256.00 AS Decimal(9, 2)), 26, N'2', N'')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (242, CAST(200.00 AS Decimal(9, 2)), 30, N'DosDimensiones', N'ARS')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (243, CAST(350.00 AS Decimal(9, 2)), 30, N'TresDimensiones', N'$')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (246, CAST(200.00 AS Decimal(9, 2)), 32, N'DosDimensiones', N'ARS')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (247, CAST(350.00 AS Decimal(9, 2)), 32, N'TresDimensiones', N'$')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (248, CAST(200.00 AS Decimal(9, 2)), 33, N'DosDimensiones', N'ARS')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (249, CAST(350.00 AS Decimal(9, 2)), 33, N'TresDimensiones', N'$')
INSERT [dbo].[SalasDeCine] ([Id], [Precio], [CineId], [TipoSalaDeCine], [Moneda]) VALUES (250, CAST(400.00 AS Decimal(9, 2)), 1, N'CXC', N'')
SET IDENTITY_INSERT [dbo].[SalasDeCine] OFF
GO
/****** Object:  Index [IX_CinesOfertas_CineId]    Script Date: 26/2/2024 23:05:55 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_CinesOfertas_CineId] ON [dbo].[CinesOfertas]
(
	[CineId] ASC
)
WHERE ([CineId] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DetallesFacturas_FacturaId]    Script Date: 26/2/2024 23:05:55 ******/
CREATE NONCLUSTERED INDEX [IX_DetallesFacturas_FacturaId] ON [dbo].[DetallesFacturas]
(
	[FacturaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Generos_NombreGenero]    Script Date: 26/2/2024 23:05:55 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Generos_NombreGenero] ON [dbo].[Generos]
(
	[NombreGenero] ASC
)
WHERE ([EstaBorrado]='false')
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_GenerosPeliculas_PeliculasId]    Script Date: 26/2/2024 23:05:55 ******/
CREATE NONCLUSTERED INDEX [IX_GenerosPeliculas_PeliculasId] ON [dbo].[GenerosPeliculas]
(
	[PeliculasId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Mensajes_EmisorId]    Script Date: 26/2/2024 23:05:55 ******/
CREATE NONCLUSTERED INDEX [IX_Mensajes_EmisorId] ON [dbo].[Mensajes]
(
	[EmisorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Mensajes_ReceptorId]    Script Date: 26/2/2024 23:05:55 ******/
CREATE NONCLUSTERED INDEX [IX_Mensajes_ReceptorId] ON [dbo].[Mensajes]
(
	[ReceptorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PeliculasActores_ActorId]    Script Date: 26/2/2024 23:05:55 ******/
CREATE NONCLUSTERED INDEX [IX_PeliculasActores_ActorId] ON [dbo].[PeliculasActores]
(
	[ActorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PeliculaSalaDeCine_SalasDeCineId]    Script Date: 26/2/2024 23:05:55 ******/
CREATE NONCLUSTERED INDEX [IX_PeliculaSalaDeCine_SalasDeCineId] ON [dbo].[PeliculaSalaDeCine]
(
	[SalasDeCineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PeliculasAlquilables_PeliculaId]    Script Date: 26/2/2024 23:05:55 ******/
CREATE NONCLUSTERED INDEX [IX_PeliculasAlquilables_PeliculaId] ON [dbo].[PeliculasAlquilables]
(
	[PeliculaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_SalasDeCine_CineId]    Script Date: 26/2/2024 23:05:55 ******/
CREATE NONCLUSTERED INDEX [IX_SalasDeCine_CineId] ON [dbo].[SalasDeCine]
(
	[CineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DetallesFacturas] ADD  DEFAULT ((0)) FOR [Cantidad]
GO
ALTER TABLE [dbo].[Facturas] ADD  DEFAULT (NEXT VALUE FOR [Factura].[NumeroFactura]) FOR [NumeroFactura]
GO
ALTER TABLE [dbo].[Facturas] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [Desde]
GO
ALTER TABLE [dbo].[Facturas] ADD  DEFAULT ('9999-12-31T23:59:59.9999999') FOR [Hasta]
GO
ALTER TABLE [dbo].[Generos] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Generos] ADD  DEFAULT ('9999-12-31T23:59:59.9999999') FOR [PeriodEnd]
GO
ALTER TABLE [dbo].[Generos] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [PeriodStart]
GO
ALTER TABLE [dbo].[SalasDeCine] ADD  DEFAULT (N'DosDimensiones') FOR [TipoSalaDeCine]
GO
ALTER TABLE [dbo].[SalasDeCine] ADD  DEFAULT (N'') FOR [Moneda]
GO
ALTER TABLE [dbo].[CinesOfertas]  WITH CHECK ADD  CONSTRAINT [FK_CinesOfertas_Cines_CineId] FOREIGN KEY([CineId])
REFERENCES [dbo].[Cines] ([Id])
GO
ALTER TABLE [dbo].[CinesOfertas] CHECK CONSTRAINT [FK_CinesOfertas_Cines_CineId]
GO
ALTER TABLE [dbo].[DetallesFacturas]  WITH CHECK ADD  CONSTRAINT [FK_DetallesFacturas_Facturas_FacturaId] FOREIGN KEY([FacturaId])
REFERENCES [dbo].[Facturas] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DetallesFacturas] CHECK CONSTRAINT [FK_DetallesFacturas_Facturas_FacturaId]
GO
ALTER TABLE [dbo].[GenerosPeliculas]  WITH CHECK ADD  CONSTRAINT [FK_GenerosPeliculas_Generos_GenerosId] FOREIGN KEY([GenerosId])
REFERENCES [dbo].[Generos] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GenerosPeliculas] CHECK CONSTRAINT [FK_GenerosPeliculas_Generos_GenerosId]
GO
ALTER TABLE [dbo].[GenerosPeliculas]  WITH CHECK ADD  CONSTRAINT [FK_GenerosPeliculas_Peliculas_PeliculasId] FOREIGN KEY([PeliculasId])
REFERENCES [dbo].[Peliculas] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GenerosPeliculas] CHECK CONSTRAINT [FK_GenerosPeliculas_Peliculas_PeliculasId]
GO
ALTER TABLE [dbo].[Mensajes]  WITH CHECK ADD  CONSTRAINT [FK_Mensajes_Personas_EmisorId] FOREIGN KEY([EmisorId])
REFERENCES [dbo].[Personas] ([Id])
GO
ALTER TABLE [dbo].[Mensajes] CHECK CONSTRAINT [FK_Mensajes_Personas_EmisorId]
GO
ALTER TABLE [dbo].[Mensajes]  WITH CHECK ADD  CONSTRAINT [FK_Mensajes_Personas_ReceptorId] FOREIGN KEY([ReceptorId])
REFERENCES [dbo].[Personas] ([Id])
GO
ALTER TABLE [dbo].[Mensajes] CHECK CONSTRAINT [FK_Mensajes_Personas_ReceptorId]
GO
ALTER TABLE [dbo].[Merchandising]  WITH CHECK ADD  CONSTRAINT [FK_Merchandising_Productos_Id] FOREIGN KEY([Id])
REFERENCES [dbo].[Productos] ([Id])
GO
ALTER TABLE [dbo].[Merchandising] CHECK CONSTRAINT [FK_Merchandising_Productos_Id]
GO
ALTER TABLE [dbo].[PeliculasActores]  WITH CHECK ADD  CONSTRAINT [FK_PeliculasActores_Actores_ActorId] FOREIGN KEY([ActorId])
REFERENCES [dbo].[Actores] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PeliculasActores] CHECK CONSTRAINT [FK_PeliculasActores_Actores_ActorId]
GO
ALTER TABLE [dbo].[PeliculasActores]  WITH CHECK ADD  CONSTRAINT [FK_PeliculasActores_Peliculas_PeliculaId] FOREIGN KEY([PeliculaId])
REFERENCES [dbo].[Peliculas] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PeliculasActores] CHECK CONSTRAINT [FK_PeliculasActores_Peliculas_PeliculaId]
GO
ALTER TABLE [dbo].[PeliculaSalaDeCine]  WITH CHECK ADD  CONSTRAINT [FK_PeliculaSalaDeCine_Peliculas_PeliculasId] FOREIGN KEY([PeliculasId])
REFERENCES [dbo].[Peliculas] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PeliculaSalaDeCine] CHECK CONSTRAINT [FK_PeliculaSalaDeCine_Peliculas_PeliculasId]
GO
ALTER TABLE [dbo].[PeliculaSalaDeCine]  WITH CHECK ADD  CONSTRAINT [FK_PeliculaSalaDeCine_SalasDeCine_SalasDeCineId] FOREIGN KEY([SalasDeCineId])
REFERENCES [dbo].[SalasDeCine] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PeliculaSalaDeCine] CHECK CONSTRAINT [FK_PeliculaSalaDeCine_SalasDeCine_SalasDeCineId]
GO
ALTER TABLE [dbo].[PeliculasAlquilables]  WITH CHECK ADD  CONSTRAINT [FK_PeliculasAlquilables_Peliculas_PeliculaId] FOREIGN KEY([PeliculaId])
REFERENCES [dbo].[Peliculas] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PeliculasAlquilables] CHECK CONSTRAINT [FK_PeliculasAlquilables_Peliculas_PeliculaId]
GO
ALTER TABLE [dbo].[PeliculasAlquilables]  WITH CHECK ADD  CONSTRAINT [FK_PeliculasAlquilables_Productos_Id] FOREIGN KEY([Id])
REFERENCES [dbo].[Productos] ([Id])
GO
ALTER TABLE [dbo].[PeliculasAlquilables] CHECK CONSTRAINT [FK_PeliculasAlquilables_Productos_Id]
GO
ALTER TABLE [dbo].[SalasDeCine]  WITH CHECK ADD  CONSTRAINT [FK_SalasDeCine_Cines_CineId] FOREIGN KEY([CineId])
REFERENCES [dbo].[Cines] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SalasDeCine] CHECK CONSTRAINT [FK_SalasDeCine_Cines_CineId]
GO
/****** Object:  StoredProcedure [dbo].[Generos_Insertar]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Generos_Insertar]
                @nombre nvarchar(150),
                @id int output
                AS
                BEGIN
                INSERT INTO Generos(NombreGenero,EstaBorrado) VALUES (@nombre,0);

                SELECT @id = SCOPE_IDENTITY();
                END 
                
GO
/****** Object:  StoredProcedure [dbo].[Generos_ObtenerPorId]    Script Date: 26/2/2024 23:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Generos_ObtenerPorId]
                @id int 
                AS
                BEGIN
                SET NOCOUNT ON;
                SELECT * FROM Generos 
                WHERE id=@id
                END
                
GO
USE [master]
GO
ALTER DATABASE [EFCorePeliculasDB] SET  READ_WRITE 
GO
