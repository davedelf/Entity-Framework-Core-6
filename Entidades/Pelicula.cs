using Microsoft.EntityFrameworkCore;

namespace EFCorePeliculas.Entidades
{
    public class Pelicula
    {
        public int Id { get; set; }
        public string Titulo { get; set; }
        public bool EnCartelera { get; set; }
        public DateTime FechaEstreno { get; set; }

        //[Unicode(false)]
        public string PosterURL { get; set; }

        /*Segun la documentación oficial de Microsoft no se garantiza que siempre estén ordenados los objetos con
         HashSet por lo que resulta conveniente utilizar List. Cabe destacar que esa elección de una u otra
         (HashSet, ICollection o List) dependerá de la situación planteada.*/
        public  List<Genero> Generos { get; set; }
        public  HashSet<SalaDeCine> SalasDeCine { get; set; }
        public  HashSet<PeliculaActor> PeliculasActores { get; set; }
    }
}
