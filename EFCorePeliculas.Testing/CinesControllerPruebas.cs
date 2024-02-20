//using EFCorePeliculas.Controllers;
//using Microsoft.AspNetCore.Mvc;
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using System.Threading.Tasks;

//namespace EFCorePeliculas.Testing
//{
//    [TestClass]
//    public class CinesControllerPruebas:BasePruebas
//    {
//        [TestMethod]
//        public async Task Get_MandoLatitudYLongitudDeSD_Obtengo2CinesCercanos()
//        {
//            var latitud = 18.481139;
//            var longitud = -69.938950;

//            using (var context = LocalDbInicializador.GetDbContextLocalDb())
//            {
//                var mapper = ConfigurarAutoMapper();
//                var controller = new CinesController(context, mapper,
//                        actualizadorObservableCollection: null);
//                var respuesta = await controller.Get(latitud, longitud);
//                var objectResult = respuesta as ObjectResult;
//                var cines = (IEnumerable<object>)objectResult.Value;
//                Assert.AreEqual(8, cines.Count());
//            }
//        }
//    }
//}
