using System;
using System.Collections.Generic;

namespace EFCorePeliculasDbFirstScaffolding.Entidades
{
    public partial class Mensaje
    {
        public int Id { get; set; }
        public string? Contenido { get; set; }
        public int EmisorId { get; set; }
        public int ReceptorId { get; set; }

        public virtual Persona Emisor { get; set; } = null!;
        public virtual Persona Receptor { get; set; } = null!;
    }
}
