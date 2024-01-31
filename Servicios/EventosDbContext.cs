using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace EFCorePeliculas.Servicios
{
    public interface IEventoDbContext
    {
        void ManejarState(object sender, EntityStateChangedEventArgs args);
        void ManejarTracked(object sender, EntityTrackedEventArgs args);
    }
    public class EventosDbContext:IEventoDbContext
    {
        private readonly ILogger<EventosDbContext> _logger;
        public EventosDbContext(ILogger<EventosDbContext> logger)
        {
            this._logger = logger;
        }

        public void ManejarTracked(object sender, EntityTrackedEventArgs args)
        {
            var mensaje =$"Entidad: {args.Entry}, estado: {args.Entry.State}";
            _logger.LogInformation(mensaje);
        }

        public void ManejarState(object sender,EntityStateChangedEventArgs args) 
        {
            var mensaje=$"Entidad: {args.Entry.Entity}, estado anterior: {args.OldState} - estado nuevo: {args.NewState}";
            _logger.LogInformation(mensaje);
        }
    }
}
