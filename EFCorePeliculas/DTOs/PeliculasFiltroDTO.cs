namespace EFCorePeliculas.DTOs
{
    public class PeliculasFiltroDTO
    {
        /*Aqui colocamos los tipos de datos para los filtros que me interesen*/
        public string Titulo { get; set; }
        public int GeneroId { get; set; }
        public bool EnCartelera { get; set; }
        public bool ProximosEstrenos { get; set; }
    }
}
