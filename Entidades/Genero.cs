using Microsoft.EntityFrameworkCore;
using System.Reflection;

namespace EFCorePeliculas.Entidades
{
        /*Supongamos que queremos colocar un índice único para la columna Nombre de la tabla Géneros.Notas que debemos colocar
         la configuración a nivel namespace y no dentro de la clase*/
     //[Index(nameof(Nombre), IsUnique = true)]
     /*Esto me garantiza de que no va a haber dos géneros con el mismo nombre. Podemos hacer esta misma configuración en el 
      API Fluente en el archivo GeneroConfig*/
    public class Genero
    {
        //Para que esta clase represente una tabla en la base de datos debemos colocarla como propiedad DBSet en el DBContext
        public int Id { get; set; }
        public string Nombre { get; set; }
        public bool EstaBorrado { get; set; }


        /*RELACIÓN N:N*/

        /*Podemos hacerlo de dos formas: Manual y Automática. En forma Automática lo hace EF, pero la desventaja es que no tenemos control
         sobre ello. Suele utilizarse cuando simplemente necesitamos relacionar las entidades y ya. En el caso de que querramos agregar más
        datos o personalizarlo debemos hacerlo de forma Manual. Para hacerlo de forma Automática colocamos HashSet en ambas entidades.*/

        /*Forma Automática:*/
        public  HashSet<Pelicula> Peliculas { get; set; }

        /*CLAVE PRIMARIA*/

        /*Por convencion todos los atributos o campos que contengan la palabra Id van a ser autocreados como clave primaria, pero podríamos tener un campo con nombre
         diferente al que querramos usar como clave primaria. Tenemos dos formas: 
           1- Usar [Key]
           2- En el DbContext usar el API Fluente (No confundir con el NuGet FluentValidation)
        
           Ejemplo: Si queremos declarar un campo como clave primaria que contenga un nombre personalizado
            
            [Key]
            public int Identificador {get; set; }

         Cabe destacar que si no tenemos declarado un campo clave primaria, a la hora de realizar una migración no dará error ya que es necesario especificar dicho campo.
         Si no tenemos campo pk, no podemos realizar la migración.
        
         */


        /*LONGITUD MÁXIMA DE UN CAMPO DE TEXTO*/

        /*Podemos especificar la logitud de un campo (en este ejemplo Nombre) de dos formas: con Atributos y con API FLuente
         
           Ejemplo con atributos:

            [StringLength(150)]
            public string Nombre {Get; set; }
        
            o
            
            [MaxLength(150)]
            public string Nombre {get; set; }
         
         */


        /*CAMPOS NO NULOS*/

        /*Podemos hacerlo de dos formas: API Fluente y Atributos
         Atributos: [Required]
         API Fluente: .IsRequired(); */


        /*CAMBIANDO NOMBRES Y ESQUEMA*/

        /*Podemos cambiar el nombre de las columnas y/o tablas, así como el nombre del esquema. Por ejemplo, en vez de que el nombre de la columna se asocie
         directamente al nombre de la propiedad del objeto, podemos definirlo manualmente. 
        Ejemplo:

        [Table("TablaGeneros"),Schema="peliculas"]
        public class Genero
        {
            [Key]
            public int Identificador {get; set;}
            
            [MaxLength (150)]
            [Column("NombreGenero")]
            public string Genero {get; set;}
        }

        Entonces de este modo, la tabla se llamará TablaGeneros en lugar de Genero (el nombre de la clase) y 
        la columna NombreGenero hará referencia al atributo o propertie Genero en lugar de llamarse como el mismo.
        A su vez, el esquema en lugar de llamarse dbo. se llamará peliculas.
        */

        /*ÍNDICES CON FILTROS*/

        /*Supongamos el siguiente escenario: Previamente colocamos en géneros el índice sobre el campo Nobre por lo que no pueden existir dos géneros con el mismo nombre
         ya que éste funciona como identificador. Si recordamos utilizamos la técnica del borrado lógico (soft delete) y no el borrado permanente (hard deletete) ya que podríamos 
        necesitar realizar un historial para luego acceder a la data. Ahora bien, tneiendo en cuenta este escenario podríamos dar de baja un género y después querer agregar otro con el 
        mismo nombre pero nos arrojaría error ya que se duplicaría (estamos aplicando borrado lógico, por lo que en realidad no se está borrando el registro). Para evitar
        esto aplciamos la técnica de Índices Con Filtros. Vamos al API Fluente y colocamos .HasFilter()*/
    }
}
