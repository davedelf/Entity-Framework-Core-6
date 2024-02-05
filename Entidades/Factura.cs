using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace EFCorePeliculas.Entidades
{
    public class Factura
    {
        public int Id { get; set; }
        public DateTime FechaCreacion { get; set; }
        public int NumeroFactura { get; set; }

        //Concurrencia por fila
        [Timestamp]
        public byte[] Version { get; set; }
    }
}
