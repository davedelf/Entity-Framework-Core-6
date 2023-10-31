using System.ComponentModel.DataAnnotations.Schema;

namespace EFCorePeliculas.Entidades
{
    public class PeliculaAlquilable:Producto
    {
        public Pelicula Pelicula { get; set; }
        public int PeliculaId { get; set; }

    }
}
