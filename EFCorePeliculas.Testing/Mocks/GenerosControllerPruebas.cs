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

        /*Vamos a testear el metodo PUT. Recordemos que estamos trabajando con el tema de concurrency check,
         y para el chequeo de concurrencia necesitamos enviar el Nombre que tenía antes, es decir, debemos enviar
        NombreOriginal y NombreNuevo.
        Primeramente realizamos una Prueba Negativa: Una prueba negativa es aquella que está destinada a arrojar
        algún tipo de error o a mostrar que cuando el sistema no se utiliza de la manera correcta, el sistema responde 
        como se espera. Por ejemplo, en este testmethod vamos a enviar un NombreOriginal incorrecto para comprobar que
        efectivamente se nos va a arrojar la excepción esperada.*/

        [TestMethod]
        public async Task Put_SiEnvioConNombreOriginalIncorrecto_UnaExcepcionEsArrojada()
        {
            //Preparación
            var nombreDB= Guid.NewGuid().ToString();
            var contexto1 = ConstruirContext(nombreDB);
            var mapper = ConfigurarAutoMapper();
            var generoPrueba = new Genero() { Nombre = "Genero 1" };
            contexto1.Add(generoPrueba);
            await contexto1.SaveChangesAsync();

            var contexto2= ConstruirContext(nombreDB);
            var generosController = new GenerosController(contexto2, mapper);

            //Prueba y Verificación

            await Assert.ThrowsExceptionAsync<DbUpdateConcurrencyException>(() => generosController.Put(
                new DTOs.GeneroActualizacionDTO()
                {
                    Id = generoPrueba.Id,
                    Nombre="Genero 2",
                    Nombre_Original="Nombre incorrecto"
                    
                }));


        }

        //Ahora realizamos una prueba positiva

        [TestMethod]
        public async Task Put_SiEnvioConNombreOriginalCorrecto_EntoncesSeActualizaElGenero()
        {
            //Preparación
            var nombreDB = Guid.NewGuid().ToString();
            var contexto1 = ConstruirContext(nombreDB);
            var mapper = ConfigurarAutoMapper();
            var generoPrueba = new Genero() { Nombre = "Genero 1" };
            contexto1.Add(generoPrueba);
            await contexto1.SaveChangesAsync();

            var contexto2 = ConstruirContext(nombreDB);
            var generosController = new GenerosController(contexto2, mapper);

            //Prueba 

            await generosController.Put(
                new DTOs.GeneroActualizacionDTO()
                {
                    Id = generoPrueba.Id,
                    Nombre = "Genero 2",
                    Nombre_Original = "Genero 1"

                });

            //Verificación

            var contexto3=ConstruirContext(nombreDB);
            var generoDB = await contexto3.Generos.SingleAsync();
            Assert.AreEqual(generoPrueba.Id, generoDB.Id);
            Assert.AreEqual("Genero 2", generoDB.Nombre);


        }
    }
}
