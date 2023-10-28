using Microsoft.EntityFrameworkCore;
using NetTopologySuite.Geometries;

namespace EFCorePeliculas.Entidades
{
    public class Cine
    {
        public int Id { get; set; }
        public string Nombre { get; set; }

        //[Precision(precision:9, scale: 2)]

        /*Otro campo de interes puede ser la ubicación geográfica del cine.En SQL Server tenemos el tipo de dato "geography" para almacenar
         ubicaciones. Lo bueno de utilizar este tipo de dato es que podemos operar sobre el, por ejemplo, si queremos indicarle al usuario
         qué cine se encuentra más cerca de su ubicación actual o de su domicilio o inclusive ordenar los cines de acuerdo a la ubicacion 
         del usuario, es decir, de los más cercanos a los más lejanos - Interesante - */
        /*Sin embargo en C# no tenemos el tipo dedato geography, para ello debemos ahcer uso de una librería para que luego podamos almacenarlo
         en SQL Server. La librería que nos puede ayudar es Microsoft.EntityFrameworkCore.SqlServer.NetTopologySuite
         Luego de instalado el NuGet debemos inyectarlo en el Program.cs para que EntityFramework pueda utilizarlo*/
        public Point Ubicacion { get; set; }
        public  CineOferta CineOferta { get; set; }
        /*HashSet lo usamos para colecciones; en este caso estamos indicando que el Cine tiene una coleccion de salas o varias salas.
         La desventaja de HashSet es que no es una lista ordenada, es decir, no ordena. Para tener una coleccion ordenada
        debemos usar ICollection o también List*/
        public  HashSet<SalaDeCine> SalasDeCine { get; set; }
        public CineDetalle CineDetalle { get; set; }

    }
}
