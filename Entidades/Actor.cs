using System.ComponentModel.DataAnnotations.Schema;

namespace EFCorePeliculas.Entidades
{
    public class Actor
    {
        public int Id { get; set; }
        /*MAPEO FLEXIBLE*/

        /*Cuando creamos un modelo, en ocasiones nos limitamos a utilizar propiedades que vendrían a representar columnas de una tabla en SQL Server o 
         cualquier otro motor de base de datos. Para la mayoría de las ocasiones sea suficiente, pero habrá otras ocasiones en las que vamos a querer utilizar
        una combinación de propeidad y campo. La idea entonces es que podremos utilizar un campo para representar una columna e una tabla de SQL Server y
        utilizaremos la propiedad para realizar una transformación sobre la data que vamos a insertar. A esto le llamamos Mapeo Flexible.
        La idea del mapeo flexible es poder mapear no solamente propiedades con colmnas sino campo con columnas. Una ventaja de hacer esto es que entonces podemos
        agregar una transformación de datos a la hora de insertar los registros en la base de datos. Asi, si queremos siempre aplicar una transformación de datos a una
        información que insertemos en una tabla, la podemos hacer a nivel del modelo. De esta manera no importa desde donde utilices EF Core para realizar la inserción
        de la data, esta transformación va a ser siempre aplicada.*/

        /*Ejemplo: Quiero que al crear un Actor el nombre se inserte de la siguiente forma: Que su primera letra de nombre y apellido estén en mayúscula
         */

        private string _nombre;

        public string Nombre
        {
            get
            {
                return _nombre;
            }
            set
            {
                /*El Join lo que va a hacer es unir cada una de las palabras que componen el nombre de la persona*/
                _nombre = string.Join(' ',
                    value.Split(' ')
                    .Select(x => x[0].ToString().ToUpper() + x.Substring(1).ToLower()).ToArray());

                /*Ahora vamos a ir al API Fluente para configurar/indicar que la propiedad Nombre utiliza el campo _nombre. Recordemos que para configurar el
                 API Fluente hacemos uso de Configuraciones (Configs). Entonces nos dirigimos a Configuraciones > ActorConfig */
            }
        }
        public string Biografia { get; set; }
        public DateTime? FechaNacimiento { get; set; }
        public  List<PeliculaActor> PeliculasActores { get; set; }



        /*MAPEAR DATETIME A DATE*/

        /*En este escenario nos interesa solamente la fecha, no la hora. Para ello podemos mapear Datetime a Date sobre el atributo o en el
         API Fluent.
         En el atributo: [Column(TypeName="Date")]   

         Ya que en C# Datetime es un tipo de valor, este no puede aceptar valores nulos por defecto. Para que lo acepte basta con agregar
         ? al lado del tipo de dato. Entonces quedaría Datetime?
         */


        /*Siempre que agreguemos una propiedad a una entidad ésta se mapea a alguna columna en la tabla correspondiente, sin embargo
         podría haber ocasiones en la que no querramos esto. Quizas tengamos propieades de utilidad que devuelven data que no queremos en la base de datos
        por ejemplo, digamos que queremos un campo Edad en nuestra entidad Actor, sin embargo, dicho campo se va a calcular en base a la propiedad fecha de nacimiento
        (recordemos que en la base de datos NO SE ALMACENAN DATOS CALCULABLES, por lo tanto no tiene sentido guardarlo en la tabla, ya que es un dato que puede obtenerse
        a partir de otro que ya existe. Para ello usamos un atributo llamado [NotMapped])*/

        [NotMapped]
        public int? Edad
        {
            get
            {
               if(!FechaNacimiento.HasValue)
               {
                    return null;
               }

                var fechaNacimiento = FechaNacimiento.Value;
                var edad = DateTime.Today.Year - fechaNacimiento.Year;

                //Si estamos antes del día de su cumpleaños entonces le restamos 1 al año
               if(new DateTime(DateTime.Today.Year, fechaNacimiento.Month, fechaNacimiento.Day) > DateTime.Today)
               {
                    edad--;
               }
                return edad;
            }
        }

        /*Entonces con ese [NotMapped] el campo edad no se va a agregar en la tabla correspondiente. Inclusive si creamos una migración
         y luego aplicamos update veremos que no se agrega el campo a la base de datos.*/

        /*Recordemos que por normalizacón de base de datos no se almacenan datos calculables.*/

        /*Otra forma de ignorar esta propiedad es utilizando el API Fluente. Para ello configuramos en ActorConfig
         builder.Ignore(a => a.Edad); */

        /*Además de ignorar propiedades también podemos ignorar Clases. Vamos a crear a modo de ejemplo la clase Direccion (ojo,
         en este caso a modo de ejemplo la clase Direccion no es una entidad ya que no corresponde a ninguna tabla de la base de datos.)*/

        public Direccion Direccion { get; set; }

        /*Hacemos lo mismo en ActorConfig para ignorar dicha propiedad/clase*/

        public string FotoURL { get; set; }
    }
}
