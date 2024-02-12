using System.ComponentModel.DataAnnotations.Schema;

namespace EFCorePeliculas.Entidades
{
    public class Persona
    {
        public int Id { get; set; }
        public string Nombre { get; set; }

        /*Con InverseProperty especificamos cual es la correspondencia de llaves, es decir, para los mensajes enviados
         deberá coincidir con Emisor y para mensajes recibidos coincidirá con Receptor.*/
        [InverseProperty("Emisor")]
        public List<Mensaje> MensajesEnviados { get; set; }
        [InverseProperty("Receptor")]
        public List<Mensaje> MensajesRecibidos { get; set; }
    }
}
