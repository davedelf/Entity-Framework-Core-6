using System;
using System.Collections.Generic;

namespace EFCorePeliculasDbFirstScaffolding.Entidades
{
    public partial class SalasDeCine
    {
        public SalasDeCine()
        {
            Peliculas = new HashSet<Pelicula>();
        }

        public int Id { get; set; }
        public decimal Precio { get; set; }
        public int CineId { get; set; }
        public string TipoSalaDeCine { get; set; } = null!;
        public string Moneda { get; set; } = null!;

        public virtual Cine Cine { get; set; } = null!;

        public virtual ICollection<Pelicula> Peliculas { get; set; }
    }
}
