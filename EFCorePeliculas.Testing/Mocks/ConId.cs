﻿using EFCorePeliculas.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EFCorePeliculas.Testing.Mocks
{
    internal class ConId : IId
    {
        //public int Id { get => throw new NotImplementedException(); set => throw new NotImplementedException(); }
        public int Id { get; set; }
    }
}
