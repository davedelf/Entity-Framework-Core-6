using System.Reflection;

namespace EFCorePeliculas.Entidades
{
    //Para que esta clase represente una tabla en la base de datos debemos colocarla como propiedad DBSet en el DBContext
    public class Genero
    {
        public int Id { get; set; }
        public string Nombre { get; set; }

        /*RELACIÓN N:N*/

        /*Podemos hacerlo de dos formas: Manual y Automática. En forma Automática lo hace EF, pero la desventaja es que no tenemos control
         sobre ello. Suele utilizarse cuando simplemente necesitamos relacionar las entidades y ya. En el caso de que querramos agregar más
        datos o personalizarlo debemos hacerlo de forma Manual. Para hacerlo de forma Automática colocamos HashSet en ambas entidades.*/

        /*Forma Automática:*/
        public virtual HashSet<Pelicula> Peliculas { get; set; }

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
    }
}
