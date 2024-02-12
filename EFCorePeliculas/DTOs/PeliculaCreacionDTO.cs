using Microsoft.AspNetCore.Mvc.ApplicationModels;

namespace EFCorePeliculas.DTOs
{
    public class PeliculaCreacionDTO
    {
        public string Titulo { get; set; }
        public bool EnCartelera { get; set; }
        public DateTime FechaEstreno { get; set; }
        public List<int> Generos { get; set; }
        public List<int> SalasDeCine { get; set; }
        /*También vamos a tener una lista de actores, pero como vamos a almacenar data sobre ellos (id, personaje) necesitamos
         una lista de DTOs de Actor*/
        public List<PeliculaActorCreacionDTO> PeliculasActores { get; set; }
    }
}
