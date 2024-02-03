using Microsoft.EntityFrameworkCore;
using NetTopologySuite.Geometries;
using System.Collections.ObjectModel;

namespace EFCorePeliculas.Entidades
{
    public class Cine:Notificacion
    {
        /* Notificación Personalizada: Tengo que modificar todos las propiedades y colocarles un campo de manera explícita
         Puede ser un poco tedioso-engorroso realizarlo, pero lo bueno de esta técnica es que solo lo aplicamos a las entidades
        que querramos y no a todas*/
        public int Id { get; set; }
        private string _nombre;
        public string Nombre { get => _nombre; set=>Set(value, ref _nombre); }

        //[Precision(precision:9, scale: 2)]

        /*Otro campo de interes puede ser la ubicación geográfica del cine.En SQL Server tenemos el tipo de dato "geography" para almacenar
         ubicaciones. Lo bueno de utilizar este tipo de dato es que podemos operar sobre el, por ejemplo, si queremos indicarle al usuario
         qué cine se encuentra más cerca de su ubicación actual o de su domicilio o inclusive ordenar los cines de acuerdo a la ubicacion 
         del usuario, es decir, de los más cercanos a los más lejanos - Interesante - */
        /*Sin embargo en C# no tenemos el tipo dedato geography, para ello debemos ahcer uso de una librería para que luego podamos almacenarlo
         en SQL Server. La librería que nos puede ayudar es Microsoft.EntityFrameworkCore.SqlServer.NetTopologySuite
         Luego de instalado el NuGet debemos inyectarlo en el Program.cs para que EntityFramework pueda utilizarlo*/

        private Point _ubicacion;
        public Point Ubicacion { get=>_ubicacion; set=>Set(value, ref _ubicacion);}

        private CineOferta _cineOferta;
        public  CineOferta CineOferta { get=>_cineOferta; set=>Set(value, ref _cineOferta); }
        /*HashSet lo usamos para colecciones; en este caso estamos indicando que el Cine tiene una coleccion de salas o varias salas.
         La desventaja de HashSet es que no es una lista ordenada, es decir, no ordena. Para tener una coleccion ordenada
        debemos usar ICollection o también List*/

        //Notif. Personalizada: En el caso de los HashSet no necesitamos usar el campo explícito; cambiamos HashSet por ObservableCollection
        public  ObservableCollection<SalaDeCine> SalasDeCine { get; set; }

        private CineDetalle _cineDetalle;
        public CineDetalle CineDetalle { get => _cineDetalle; set => Set(value,ref _cineDetalle); }

        private Direccion _direccion;
        public Direccion Direccion { get=>_direccion; set=>Set(value, ref _direccion); }

    }
}
