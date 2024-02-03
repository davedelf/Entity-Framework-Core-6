using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EFCorePeliculas.Migrations
{
    public partial class FuncionesConValoresDeTabla : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql(@"CREATE FUNCTION PeliculaConConteos
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
            )");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql("DROP FUNCTION [dbo].[PeliculaConConteos]");
        }
    }
}
