using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace EFCorePeliculas.Servicios
{
    public interface IEventoDbContext
    {
        void ManejarSaveChangesFailed(object sender, SaveChangesFailedEventArgs args);
        void ManejarSavedChanges(object sender, SavedChangesEventArgs args);
        void ManejarSavingChanges(object sender, SavingChangesEventArgs args);
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

        public void ManejarSavingChanges(object sender, SavingChangesEventArgs args)
        {
            var entidades = ((ApplicationDbContext)sender).ChangeTracker.Entries();

            foreach(var entidad in entidades)
            {
                var mensaje = $"Entidad {entidad.Entity} va a ser {entidad.State}";
                _logger.LogInformation(mensaje);
            }
        }

        public void ManejarSavedChanges(object sender, SavedChangesEventArgs args)
        {
            var mensaje = $"Fueron guardadas {args.EntitiesSavedCount} entidades";
            _logger.LogInformation(mensaje);
        }

        public void ManejarSaveChangesFailed(object sender, SaveChangesFailedEventArgs args)
        {
            _logger.LogError(args.Exception, "Error en el SaveChanges");
        }
    }
}
