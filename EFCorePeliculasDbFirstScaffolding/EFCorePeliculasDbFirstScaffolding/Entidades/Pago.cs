using System;
using System.Collections.Generic;

namespace EFCorePeliculasDbFirstScaffolding.Entidades
{
    public partial class Pago
    {
        public int Id { get; set; }
        public decimal Monto { get; set; }
        public DateTime FechaTransaccion { get; set; }
        public int TipoPago { get; set; }
        public string? CorreoElectronico { get; set; }
        public string? UltimosCuatroDigitos { get; set; }
    }
}
