using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace EFCorePeliculas.Entidades.SinLlaves
{
    //Este atributo indica que la clase es sin pk
   //[Keyless]
    public class CineSinUbicacion
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
    }
}
