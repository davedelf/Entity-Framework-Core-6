using Microsoft.EntityFrameworkCore;

namespace EFCorePeliculas.Entidades
{
    public class DetalleFactura
    {
        public int Id { get; set; }
        public string Producto { get; set; }
        public int FacturaId { get; set; }
        [Precision(18, 2)]
        public double Precio { get; set; }
    }
}
