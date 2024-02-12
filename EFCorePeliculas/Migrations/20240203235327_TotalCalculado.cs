using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EFCorePeliculas.Migrations
{
    public partial class TotalCalculado : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<decimal>(
                name: "Precio",
                table: "DetallesFacturas",
                type: "decimal(18,2)",
                precision: 18,
                scale: 2,
                nullable: false,
                oldClrType: typeof(double),
                oldType: "float(18)",
                oldPrecision: 18,
                oldScale: 2);

            migrationBuilder.AddColumn<int>(
                name: "Cantidad",
                table: "DetallesFacturas",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<decimal>(
                name: "Total",
                table: "DetallesFacturas",
                type: "decimal(18,2)",
                precision: 18,
                scale: 2,
                nullable: false,
                computedColumnSql: "Precio * Cantidad");

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 1,
                column: "Precio",
                value: 350.99m);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 2,
                column: "Precio",
                value: 10m);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 3,
                column: "Precio",
                value: 45.50m);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 4,
                column: "Precio",
                value: 17.99m);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 5,
                column: "Precio",
                value: 14m);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 6,
                column: "Precio",
                value: 45m);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 7,
                column: "Precio",
                value: 100m);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 8,
                column: "Precio",
                value: 371m);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 9,
                column: "Precio",
                value: 114.99m);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 10,
                column: "Precio",
                value: 425m);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 11,
                column: "Precio",
                value: 1000m);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 12,
                column: "Precio",
                value: 5m);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 13,
                column: "Precio",
                value: 2.99m);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 14,
                column: "Precio",
                value: 50m);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Total",
                table: "DetallesFacturas");

            migrationBuilder.DropColumn(
                name: "Cantidad",
                table: "DetallesFacturas");

            migrationBuilder.AlterColumn<double>(
                name: "Precio",
                table: "DetallesFacturas",
                type: "float(18)",
                precision: 18,
                scale: 2,
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,2)",
                oldPrecision: 18,
                oldScale: 2);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 1,
                column: "Precio",
                value: 350.99000000000001);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 2,
                column: "Precio",
                value: 10.0);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 3,
                column: "Precio",
                value: 45.5);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 4,
                column: "Precio",
                value: 17.989999999999998);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 5,
                column: "Precio",
                value: 14.0);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 6,
                column: "Precio",
                value: 45.0);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 7,
                column: "Precio",
                value: 100.0);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 8,
                column: "Precio",
                value: 371.0);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 9,
                column: "Precio",
                value: 114.98999999999999);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 10,
                column: "Precio",
                value: 425.0);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 11,
                column: "Precio",
                value: 1000.0);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 12,
                column: "Precio",
                value: 5.0);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 13,
                column: "Precio",
                value: 2.9900000000000002);

            migrationBuilder.UpdateData(
                table: "DetallesFacturas",
                keyColumn: "Id",
                keyValue: 14,
                column: "Precio",
                value: 50.0);
        }
    }
}
