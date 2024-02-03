using Microsoft.EntityFrameworkCore;

//Segunda forma de invocar funciones definidas por el usuario
namespace EFCorePeliculas.Entidades.Funciones
{
    public static class Escalares
    {
        public static void RegistrarFunciones(ModelBuilder modelbuilder)
        {
            modelbuilder.HasDbFunction(() => DetalleFacturaPromedio(0));
        }

        public static decimal DetalleFacturaPromedio(int facturaId)
        {
            return 0;
        }
    }
}
