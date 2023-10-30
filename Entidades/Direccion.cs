using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EFCorePeliculas.Entidades
{
    [Owned]
    public class Direccion
    {
        /*También podemos hacer que la clase Direccion siempre se ignore, siempre siempre, no importa donde se coloque o se utilice*/
        /*Si quiero ignorarlo a nivel global, podemos hacer uso del API Fluente colocando dicha propiedad en ApplicationDbContext*/
        //[NotMapped]
        public string Calle { get; set; }
        public string Provincia { get; set; }
        [Required]
        public string Pais { get; set; }
    }
}
