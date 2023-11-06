using System;
using System.Collections.Generic;

namespace EFCorePeliculasDbFirstScaffolding.Entidades
{
    public partial class PeliculasAlquilable
    {
        public int Id { get; set; }
        public int PeliculaId { get; set; }

        public virtual Producto IdNavigation { get; set; } = null!;
        public virtual Pelicula Pelicula { get; set; } = null!;
    }
}
