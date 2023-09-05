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

            /*De esta forma mapeamos los datos espaciales para este caso particular*/
            CreateMap<Cine, CineDTO>()
                .ForMember(dto => dto.Latitud, ent => ent.MapFrom(prop => prop.Ubicacion.Y))
                .ForMember(dto => dto.Longitud, ent => ent.MapFrom(prop => prop.Ubicacion.X));
        }
    }
}
