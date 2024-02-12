using EFCorePeliculas.Servicios;
using Microsoft.VisualStudio.TestTools.UnitTesting;
namespace EFCorePeliculas.Testing
{
    [TestClass]
    public class ServiciousuarioTest
    {
        //Ejemplo simple de prueba unitaria
        [TestMethod]
        public void ServicioUsuarioIdNoDevuelveValorVacioONulo()
        {
            //Preparación
            var servicioUsuario = new ServicioUsuario();

            //Prueba
            var resultado = servicioUsuario.ObtenerUsuarioId();

            //Verificación
            Assert.AreNotEqual("", resultado);
            Assert.IsNotNull(resultado);

            /*Podemos agregar la cantidad de asserts que consideremos necesarios*/
        }
    }
}