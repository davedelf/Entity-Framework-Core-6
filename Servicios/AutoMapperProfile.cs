using AutoMapper;
using EFCorePeliculas.DTOs;
using EFCorePeliculas.Entidades;
using Microsoft.AspNetCore.Mvc;
using NetTopologySuite;
using NetTopologySuite.Geometries;

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

            CreateMap<Genero, GeneroDTO>();
            CreateMap<Pelicula, PeliculaDTO>()
                .ForMember(dto => dto.Cines, ent => ent.MapFrom(prop => prop.SalasDeCine.Select(s => s.Cine)))
                .ForMember(dto => dto.Actores, ent => ent.MapFrom(prop => prop.PeliculasActores.Select(pa => pa.Actor)));

            var geometryFactory = NtsGeometryServices.Instance.CreateGeometryFactory(srid: 4326);

            CreateMap<CineCreacionDTO, Cine>()
            //Ignoro el mapeo del ObservableCollection
                .ForMember(ent=>ent.SalasDeCine, opciones=>opciones.Ignore())
                .ForMember(ent => ent.Ubicacion,
                    dto => dto.MapFrom(campo => 
                        geometryFactory.CreatePoint(new Coordinate(campo.Latitud, campo.Longitud))));

            CreateMap<CineOfertaCreacionDTO, CineOferta>();
            CreateMap<SalaDeCineCreacionDTO,SalaDeCine>();

            /*Con esto mapeo un listado de enteros (int) a un listado de Generos*/
            CreateMap<PeliculaCreacionDTO, Pelicula>()
                .ForMember(ent => ent.Generos, dto => dto.MapFrom(campo => campo.Generos.Select(id => new Genero()
                {
                    Id = id,
                })))
                .ForMember(ent=>ent.SalasDeCine,
                    dto=>dto.MapFrom(campo=>campo.SalasDeCine.Select(id=> new SalaDeCine() 
                    { 
                        Id = id 
                    })));
            CreateMap<PeliculaActorCreacionDTO, PeliculaActor>();

            CreateMap<ActorCreacionDTO, Actor>();

        }
    }
}
