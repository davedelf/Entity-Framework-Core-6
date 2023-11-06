using System;
using System.Collections.Generic;

namespace EFCorePeliculasDbFirstScaffolding.Entidades
{
    public partial class Log
    {
        public Guid Id { get; set; }
        public string? Mensaje { get; set; }
        public string? Ejemplo { get; set; }
    }
}
