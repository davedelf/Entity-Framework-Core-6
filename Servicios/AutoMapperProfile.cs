using AutoMapper;
using EFCorePeliculas.DTOs;
using EFCorePeliculas.Entidades;

namespace EFCorePeliculas.Servicios
{
    public class AutoMapperProfile:Profile
    {
       public AutoMapperProfile() 
        {
            /*Aca debo especificar de donde hacia donde va la proyección*/
            CreateMap<Actor, ActorDTO>();
        }
    }
}
