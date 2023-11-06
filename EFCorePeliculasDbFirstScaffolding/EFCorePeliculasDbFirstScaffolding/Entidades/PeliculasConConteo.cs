using System;
using System.Collections.Generic;

namespace EFCorePeliculasDbFirstScaffolding.Entidades
{
    public partial class PeliculasConConteo
    {
        public int Id { get; set; }
        public string Titulo { get; set; } = null!;
        public int? CantidadGeneros { get; set; }
        public int? CantidadCines { get; set; }
        public int? CantidadActores { get; set; }
    }
}
