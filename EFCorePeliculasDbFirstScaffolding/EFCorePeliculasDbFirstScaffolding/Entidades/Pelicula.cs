using System;
using System.Collections.Generic;

namespace EFCorePeliculasDbFirstScaffolding.Entidades
{
    public partial class Pelicula
    {
        public Pelicula()
        {
            PeliculasActores = new HashSet<PeliculasActore>();
            PeliculasAlquilables = new HashSet<PeliculasAlquilable>();
            Generos = new HashSet<Genero>();
            SalasDeCines = new HashSet<SalasDeCine>();
        }

        public int Id { get; set; }
        public string Titulo { get; set; } = null!;
        public bool EnCartelera { get; set; }
        public DateTime FechaEstreno { get; set; }
        public string? PosterUrl { get; set; }

        public virtual ICollection<PeliculasActore> PeliculasActores { get; set; }
        public virtual ICollection<PeliculasAlquilable> PeliculasAlquilables { get; set; }

        public virtual ICollection<Genero> Generos { get; set; }
        public virtual ICollection<SalasDeCine> SalasDeCines { get; set; }
    }
}
