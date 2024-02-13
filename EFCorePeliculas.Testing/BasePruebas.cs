using EFCorePeliculas.Servicios;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EFCorePeliculas.Testing
{
    internal class BasePruebas
    {
        //Este método me va a permitir crear un dbcontext para pruebas
        protected ApplicationDbContext ConstruirContext(string nombreDB)
        {
            var opciones = new DbContextOptionsBuilder<ApplicationDbContext>()
                .UseInMemoryDatabase(nombreDB).Options;

            //Recordamos que nuestro DbContext tiene una dependencia con ServicioUsuario

            var servicioUsuario = new ServicioUsuario();

            var dbcontext = new ApplicationDbContext(opciones, servicioUsuario, eventosDbContext: null);
            return dbcontext;
        }

        /*Puede que en diferentes versionesd de EF Core de cierto errores o entre en conflictos con las tablas temporales,
         por lo que deberemos especificar lo tipos de datos en las columnas PeriodStart y PeriodEnd
        en todas las configuraciones de las respectivas entidades; en nuestro caso las entidades Facturas y Generos
        
         builder.Property<Datetime>("PeriodStart").HasColumnType("datetime2");
         builder.Property<Datetime>("PeriodEnd").HasColumnType("datetime2");
        
         builder.Property<DateTime>("Desde").HasColumnType("datetime2");
         builder.Property<DateTime>("Hasta").HasColumnType("datetime2");
        
         Además de ello deberemos evitar el uso de DataSeeding, ya que esto inserta data en tablas que usan tablas temporales
        lo cual, en diferentes versiones de EF Core, puede generar errores.
        
         Luego deberemos instalar el NuGet en el proyecto que estam */
    }
}
