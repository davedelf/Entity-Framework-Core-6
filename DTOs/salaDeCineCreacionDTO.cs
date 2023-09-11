using EFCorePeliculas.Entidades;

namespace EFCorePeliculas.DTOs
{
    public class salaDeCineCreacionDTO
    {
        public decimal Precio { get; set; }
        public TipoSalaDeCine TipoSalaDeCine { get; set; }
    }
}
