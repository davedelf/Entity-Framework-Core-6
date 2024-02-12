using AutoMapper;
using EFCorePeliculas.Entidades;
using System.Collections.ObjectModel;

namespace EFCorePeliculas.Servicios
{
    public interface IActualizadorObservableCollection
    {
        void Actualizar<ENT, DTO>(ObservableCollection<ENT> entidades, IEnumerable<DTO> dtos)
            where ENT : IId
            where DTO : IId;
    }


    //Este servicio nos permite actualizar un ObservableCollection a partir de un IEnumerable
    public class ActualizadorObservableCollection:IActualizadorObservableCollection
    {
        private readonly IMapper _mapper;

        public ActualizadorObservableCollection(IMapper mapper)
        {
            this._mapper = mapper;
        }

        //ENT sería quien tiene el ObservableCollection - SalasDeCine - y DTO lo que viene del front-end
        public void Actualizar<ENT,DTO>(ObservableCollection<ENT> entidades, IEnumerable<DTO> dtos)
            where ENT:IId
            where DTO:IId
        {
            /* Creamos un pequeño algoritmo que nos permita ABM de entidades
            Entonces creamos una comparación entre entidades y dtos y veremos qué cosas son nuevas,
            qué ya no se utiliza y qué hay que actualizar*/

            var diccionarioEntidades = entidades.ToDictionary(x => x.Id);
            var diccionarioDtos=dtos.ToDictionary(x => x.Id);

            var idsEntidades = diccionarioEntidades.Select(x => x.Key);
            var idsDtos = diccionarioDtos.Select(x => x.Key);

            //Aquellas entidades que están en dtos pero no en entidades, es decir, lo que vamos a crear nuevo
            var crear=idsDtos.Except(idsEntidades);
            var borrar = idsDtos.Except(idsDtos);
            var actualizar = idsEntidades.Intersect(idsDtos);

            foreach(var id in crear)
            {
                var entidad = _mapper.Map<ENT>(diccionarioDtos[id]);
                entidades.Add(entidad);
            }

            foreach(var id in borrar)
            {
                var entidad = diccionarioEntidades[id];
                entidades.Remove(entidad);
            }

            foreach(var id in actualizar)
            {
                var dto = diccionarioDtos[id];
                var entidad = diccionarioEntidades[id];
                entidad = _mapper.Map(dto, entidad);
            }
        }
    }
}
