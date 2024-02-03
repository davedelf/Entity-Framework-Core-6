using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace EFCorePeliculas.Entidades
{
    public class Notificacion : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;

        /*Usamos genéricos ya que no necesitamos saber de antemano a qué entidad se va a aplicar la interfaz, es decir,
         queremos poder utilizar Notificacion en cualquier propiedad de cualquier entidad que querramos (Cine, Actor, Genero, etc).
         Investigar más acerca de los genéricos*/

        /*Parámetros del método: 
          T valor, T ref campo porque le pasamos una refenrencia del campo, pues para poder utilizar esta técnica no vamos
        a utilizar propiedades con el campo implícito sino que usaremos el campo de manera explícita. 
        [CallerMemberName] xq necesito el nombre de la propiedad sobre la cual estamos trabajando
         */
        protected void Set<T>(T valor, ref T campo, [CallerMemberName] string propiedad = "")
        {
            if(!Equals(campo,valor))
            {
                campo= valor;
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propiedad));

                /*Usamos el evento y le pasamos la propiedad, que es la información que necesita EF Core
                 para saber qué va a tener que construir en el query de actualización, que tal o cual propiedad 
                 ha sido actualizada.*/
            }
        }

        /*Para aplicar esta lógica de notificación personalizada debemos modificar la entidad que queremos que la aplique.
         Para ello nos vamos a la entidad en cuestíón (en este ejemplo: Cine) y modificamos.
        
         Suele ser engorroso modificar cada propiedad de la entidad pero lo bueno de esta técnica es que no necesitamos
        aplicarla en todas las entidades, sino sólamente en las que querramos-nos interesen. Además de ello,
        debemos modificar CineConfig para que surta efecto al eliminar en cascada, ya que si se elimina un cine
        se deben eliminar todas sus relaciones o data relacionada de otras entidades o clases (salas, etc)
        
         Como se trata de una clase base, las entidades de interés deben heredarla*/
    }
}
