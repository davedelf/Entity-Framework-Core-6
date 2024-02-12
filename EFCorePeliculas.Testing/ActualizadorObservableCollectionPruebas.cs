using EFCorePeliculas.Servicios;
using EFCorePeliculas.Testing.Mocks;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EFCorePeliculas.Testing
{
    [TestClass]
    public class ActualizadorObservableCollectionPruebas
    {
        [TestMethod]
        public void Actualizar_SiEntidadesEsVacio_Entonces_TodosLosDTOSPasanAFormarParteDeEntidades()
        {
            //Preparación
            var mapeador = new Mapeador();
            var actualizadorObservableCollection = new ActualizadorObservableCollection(mapeador);
            var entidades = new ObservableCollection<ConId>();
            var dtos = new List<ConId>()
            {
                new ConId
                {
                    Id=1
                },
                new ConId
                {
                    Id=2
                }
            };

            //Prueba
            actualizadorObservableCollection.Actualizar(entidades, dtos);

            //Vertificación
            Assert.AreEqual(2, entidades.Count);
            Assert.AreEqual(1, entidades[0].Id);
            Assert.AreEqual(2, entidades[1].Id);

        }

        [TestMethod]
        public void Actualizar_SiDTOsEsVacio_EntoncesTodasLasEntidadesSonRemovidas()
        {
            //Preparación
            var mapeador=new Mapeador();
            var actualizadorObservableCollection=new ActualizadorObservableCollection(mapeador);
            var entidades = new ObservableCollection<ConId>()
            {
                new ConId { Id=1 },
                new ConId { Id=2 }
            };
            var dtos = new List<ConId>();

            //Prueba
            actualizadorObservableCollection.Actualizar(entidades, dtos);

            //Verificación
            Assert.AreEqual(0, dtos.Count);
        }

        [TestMethod]
        public void Actualizazr_SiDTOyEntidadesTienenLosMismosObjetos_EntoncesLasCantidadesDeLasColeccionesNoSeAlteran()
        {
            //Preparación
            var mapeador = new Mapeador();
            var actualizadorObservableCollection = new ActualizadorObservableCollection(mapeador);
            var entidades = new ObservableCollection<ConId>()
            {
                new ConId{ Id=1},
                new ConId{ Id=2}
            };
            var dtos = new List<ConId>()
            {
                new ConId{ Id=1},
                new ConId{ Id=2}
            };

            //Prueba
            actualizadorObservableCollection.Actualizar(entidades, dtos);

            //Verificar
            Assert.AreEqual(2, entidades.Count);
            Assert.AreEqual(2,dtos.Count);
        }
    }

    /*Así que en esta prueba vimos que utilizando Mock podemos suplantar el funcionamiento de la dependencia de 
     nuestra clase ObservableCollection*/
}
