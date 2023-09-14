using System.ComponentModel.DataAnnotations.Schema;

namespace EFCorePeliculas.Entidades
{
    public class Log
    {
        /*Generando la pk utilizando Anotaciones*/
        /*Acá lo que estoy diciendo es que el valor del campo Id no se genere automáticamente*/
        //[DatabaseGenerated(DatabaseGeneratedOption.None)]
        public Guid Id { get; set; }
        public string Mensaje { get; set; }
    }
}
