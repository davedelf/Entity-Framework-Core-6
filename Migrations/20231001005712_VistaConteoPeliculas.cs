using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EFCorePeliculas.Migrations
{
    public partial class VistaConteoPeliculas : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql(@"
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
            from Peliculas");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql("DROP VIEW [dbo].[PeliculasConConteos]");
        }
    }
}
