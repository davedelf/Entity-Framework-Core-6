using System;
using System.Collections.Generic;

namespace EFCorePeliculasDbFirstScaffolding.Entidades
{
    public partial class Actore
    {
        public Actore()
        {
            PeliculasActores = new HashSet<PeliculasActore>();
        }

        public int Id { get; set; }
        public string Nombre { get; set; } = null!;
        public string? Biografia { get; set; }
        public DateTime? FechaNacimiento { get; set; }
        public string? FotoUrl { get; set; }
        public string? BillingAdressCalle { get; set; }
        public string? BillingAdressPais { get; set; }
        public string? BillingAdressProvincia { get; set; }
        public string? Calle { get; set; }
        public string? Pais { get; set; }
        public string? Provincia { get; set; }

        public virtual ICollection<PeliculasActore> PeliculasActores { get; set; }
    }
}
