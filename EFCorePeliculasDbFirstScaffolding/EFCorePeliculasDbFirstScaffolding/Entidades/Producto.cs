using System;
using System.Collections.Generic;

namespace EFCorePeliculasDbFirstScaffolding.Entidades
{
    public partial class Producto
    {
        public int Id { get; set; }
        public string? Nombre { get; set; }
        public decimal Precio { get; set; }

        public virtual Merchandising Merchandising { get; set; } = null!;
        public virtual PeliculasAlquilable PeliculasAlquilable { get; set; } = null!;
    }
}
