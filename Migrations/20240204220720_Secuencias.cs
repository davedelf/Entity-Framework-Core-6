using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EFCorePeliculas.Migrations
{
    public partial class Secuencias : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.EnsureSchema(
                name: "factura");

            migrationBuilder.CreateSequence(
                name: "NumeroFactura",
                schema: "factura");

            migrationBuilder.AddColumn<int>(
                name: "NumeroFactura",
                table: "Facturas",
                type: "int",
                nullable: false,
                defaultValueSql: "NEXT VALUE FOR Factura.NumeroFactura");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropSequence(
                name: "NumeroFactura",
                schema: "factura");

            migrationBuilder.DropColumn(
                name: "NumeroFactura",
                table: "Facturas");
        }
    }
}
