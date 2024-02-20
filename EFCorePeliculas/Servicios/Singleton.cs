using EFCorePeliculas.Entidades;
using Microsoft.EntityFrameworkCore;

namespace EFCorePeliculas.Servicios
{
    public class Singleton
    {
        //private readonly ApplicationDbContext _context;

        //public Singleton(ApplicationDbContext context)
        //{
        //    this._context = context;
        //}

        /*Si ejecutamos esto nos dará error: Cannot consume scoped service 'EFCorePeliculas.ApplicationDbContext' from Singleton 'EFCorePeliculas.Servicios.Singleton'
         para resolverlo podemos crear una especie de "scope artificial - contexto artificial" dentro de esta clase para que con ese scope poder así obtener una instancia
        del ApplicationDbContext. Para ello inyectamos el servicio IServerProvider*/

        private readonly IServiceProvider _serviceProvider;

        public Singleton(IServiceProvider serviceProvider)
        {
            this._serviceProvider = serviceProvider;
        }

        /*Método a modo de ejemplo*/

        public async Task<IEnumerable<Genero>> ObtenerGeneros()
        {
            await using (var scope = _serviceProvider.CreateAsyncScope())
            {
                var context= scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
                return await context.Generos.ToListAsync();
            }
        }


        /*Luego inyectamos en Program el servicio singleton
         builder.Services.AddSingleton<Singleton>();*/
    }
}
