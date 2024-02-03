﻿using System.ComponentModel.DataAnnotations.Schema;

namespace EFCorePeliculas.Entidades
{
    public class SalaDeCine:IId
    {
        public int Id { get; set; }
        public decimal Precio { get; set; }
        public int CineId { get; set; }
        public  Cine Cine { get; set; }
        public  TipoSalaDeCine TipoSalaDeCine { get; set; }
        public  HashSet<Pelicula> Peliculas { get; set; }
        public Moneda Moneda { get; set; }
    }
}
