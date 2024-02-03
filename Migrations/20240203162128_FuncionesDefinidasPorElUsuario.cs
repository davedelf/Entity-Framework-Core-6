using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EFCorePeliculas.Migrations
{
    public partial class FuncionesDefinidasPorElUsuario : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql(@"
                CREATE FUNCTION DetalleFacturaSuma
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
                ");

            migrationBuilder.Sql(@"
                CREATE FUNCTION DetalleFacturaPromedio
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
                ");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql("DROP FUNCTION [dbo].[DetalleFacturaSuma]");
            migrationBuilder.Sql("DROP FUNCTION [dbo].[DetalleFacturaPromedio]");
        }
    }
}
