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
            //Preparaci�n
            var servicioUsuario = new ServicioUsuario();

            //Prueba
            var resultado = servicioUsuario.ObtenerUsuarioId();

            //Verificaci�n
            Assert.AreNotEqual("", resultado);
            Assert.IsNotNull(resultado);

            /*Podemos agregar la cantidad de asserts que consideremos necesarios*/
        }
    }
}