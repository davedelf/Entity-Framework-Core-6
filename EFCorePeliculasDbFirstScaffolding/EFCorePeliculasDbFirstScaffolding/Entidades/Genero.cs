using System;
using System.Collections.Generic;

namespace EFCorePeliculasDbFirstScaffolding.Entidades
{
    public partial class Genero
    {
        public Genero()
        {
            Peliculas = new HashSet<Pelicula>();
        }

        public int Id { get; set; }
        public string NombreGenero { get; set; } = null!;
        public bool EstaBorrado { get; set; }
        public DateTime FechaCreacion { get; set; }

        public virtual ICollection<Pelicula> Peliculas { get; set; }
    }
}
