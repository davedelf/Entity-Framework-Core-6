namespace EFCorePeliculas.Entidades
{
    public class PeliculaActor
    {

        /*La relación Actores y Peliculas es N:N, ya que un actor puede estar en una o varias peliculas y una pelicula puede tener  varios actores.
         En lugar de hacerlo de forma Automatica con HashSet lo haremos de forma Manual, ya que podríamos necesitar agregar más campso o información
        como por ejemplo, nombre del personaje u orden de actores, lo que hará es que se mostrara en orden de relevancia los personajes o actores.
        Para hacerlo de forma Manual creamos la Entidad que representa la TablaIntermedia y agregamos los HashSet en las entidades que se relacionan*/

        public int PeliculaId { get; set; }
        public int ActorId { get; set; }
        public string Personaje { get; set; }
        public int Orden { get; set; }
        public virtual Pelicula Pelicula { get; set; }
        public virtual Actor Actor { get; set; }
    }
}
