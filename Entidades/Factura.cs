using Microsoft.EntityFrameworkCore;

namespace EFCorePeliculas.Entidades
{
    public class Factura
    {
        public int Id { get; set; }
        public DateTime FechaCreacion { get; set; }
        public int NumeroFactura { get; set; }

    }
}
