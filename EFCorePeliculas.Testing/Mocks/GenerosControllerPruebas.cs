using EFCorePeliculas.Controllers;
using EFCorePeliculas.Entidades;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EFCorePeliculas.Testing.Mocks
{
    [TestClass]
    public class GenerosControllerPruebas:BasePruebas
    {
        //Vamos a probar el método post que intenta agregar varios métodos
        [TestMethod]
        public async Task Post_SiEnvioDosGeneros_AmbosSonInsertados()
        {
            //Preparación
            var nombreDB=Guid.NewGuid().ToString();
            var contexto1 = ConstruirContext(nombreDB);
            var generosController = new GenerosController(contexto1, mapper: null);
            var generos = new Genero[]
            {
                new Genero()
                {
                    Nombre="Genero 1"
                },
                new Genero()
                {
                    Nombre="Genero 2"
                }
            };


            //Prueba
            await generosController.Post(generos);

            //Verificación
            var contexto2=ConstruirContext(nombreDB);
            var generosDB = await contexto2.Generos.ToListAsync();

            Assert.AreEqual(2, generosDB.Count);

            var existeGenero1 = generosDB.Any(g => g.Nombre == "Genero 1");
            Assert.IsTrue(existeGenero1, message: "El Genero 1 no fue encontrado");

            var existeGenero2 = generosDB.Any(g => g.Nombre == "Genero 2");
            Assert.IsTrue(existeGenero2, message: "El Genero 2 no fue encontrado");


        }
    }
}
