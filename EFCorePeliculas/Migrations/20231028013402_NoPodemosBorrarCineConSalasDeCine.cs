using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EFCorePeliculas.Migrations
{
    public partial class NoPodemosBorrarCineConSalasDeCine : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_GeneroPelicula_Generos_GenerosId",
                table: "GeneroPelicula");

            migrationBuilder.DropForeignKey(
                name: "FK_GeneroPelicula_Peliculas_PeliculasId",
                table: "GeneroPelicula");

            migrationBuilder.DropForeignKey(
                name: "FK_SalasDeCine_Cines_CineId",
                table: "SalasDeCine");

            migrationBuilder.DropPrimaryKey(
                name: "PK_GeneroPelicula",
                table: "GeneroPelicula");

            migrationBuilder.RenameTable(
                name: "GeneroPelicula",
                newName: "GenerosPeliculas");

            migrationBuilder.RenameIndex(
                name: "IX_GeneroPelicula_PeliculasId",
                table: "GenerosPeliculas",
                newName: "IX_GenerosPeliculas_PeliculasId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_GenerosPeliculas",
                table: "GenerosPeliculas",
                columns: new[] { "GenerosId", "PeliculasId" });

            migrationBuilder.InsertData(
                table: "GenerosPeliculas",
                columns: new[] { "GenerosId", "PeliculasId" },
                values: new object[] { 7, 1 });

            migrationBuilder.AddForeignKey(
                name: "FK_GenerosPeliculas_Generos_GenerosId",
                table: "GenerosPeliculas",
                column: "GenerosId",
                principalTable: "Generos",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_GenerosPeliculas_Peliculas_PeliculasId",
                table: "GenerosPeliculas",
                column: "PeliculasId",
                principalTable: "Peliculas",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_SalasDeCine_Cines_CineId",
                table: "SalasDeCine",
                column: "CineId",
                principalTable: "Cines",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_GenerosPeliculas_Generos_GenerosId",
                table: "GenerosPeliculas");

            migrationBuilder.DropForeignKey(
                name: "FK_GenerosPeliculas_Peliculas_PeliculasId",
                table: "GenerosPeliculas");

            migrationBuilder.DropForeignKey(
                name: "FK_SalasDeCine_Cines_CineId",
                table: "SalasDeCine");

            migrationBuilder.DropPrimaryKey(
                name: "PK_GenerosPeliculas",
                table: "GenerosPeliculas");

            migrationBuilder.DeleteData(
                table: "GenerosPeliculas",
                keyColumns: new[] { "GenerosId", "PeliculasId" },
                keyValues: new object[] { 7, 1 });

            migrationBuilder.RenameTable(
                name: "GenerosPeliculas",
                newName: "GeneroPelicula");

            migrationBuilder.RenameIndex(
                name: "IX_GenerosPeliculas_PeliculasId",
                table: "GeneroPelicula",
                newName: "IX_GeneroPelicula_PeliculasId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_GeneroPelicula",
                table: "GeneroPelicula",
                columns: new[] { "GenerosId", "PeliculasId" });

            migrationBuilder.AddForeignKey(
                name: "FK_GeneroPelicula_Generos_GenerosId",
                table: "GeneroPelicula",
                column: "GenerosId",
                principalTable: "Generos",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_GeneroPelicula_Peliculas_PeliculasId",
                table: "GeneroPelicula",
                column: "PeliculasId",
                principalTable: "Peliculas",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_SalasDeCine_Cines_CineId",
                table: "SalasDeCine",
                column: "CineId",
                principalTable: "Cines",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
