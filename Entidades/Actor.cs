namespace EFCorePeliculas.Entidades
{
    public class Actor
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Biografia { get; set; }
        public DateTime? FechaNacimiento { get; set; }
        public virtual HashSet<PeliculaActor> PeliculasActores { get; set; }



        /*MAPEAR DATETIME A DATE*/

        /*En este escenario nos interesa solamente la fecha, no la hora. Para ello podemos mapear Datetime a Date sobre el atributo o en el
         API Fluent.
         En el atributo: [Column(TypeName="Date")]   

         Ya que en C# Datetime es un tipo de valor, este no puede aceptar valores nulos por defecto. Para que lo acepte basta con agregar
         ? al lado del tipo de dato. Entonces quedaría Datetime?
         */
    }
}
