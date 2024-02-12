using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace EFCorePeliculas.Entidades.Conversiones
{
    public class MonedaASimboloConverter:ValueConverter<Moneda,string>
    {
        //Le paso los dos métodos para realizar la conversión
        public MonedaASimboloConverter()
            :base(
                 valor =>MapeoMonedaString(valor),
                 valor=>MapeoStringMoneda(valor))
        {
            
        }

        
        //Estos dos métodos me van a permitir realizar la conversion bidireccional
        private static string MapeoMonedaString(Moneda valor)
        {
            return valor switch
            {
                Moneda.Dolar => "$",
                Moneda.PesoArgentino => "ARS",
                Moneda.Euro => "€",
                _ => ""
            };
        }

        private static Moneda MapeoStringMoneda(String valor)
        {
            return valor switch
            {
                "$" => Moneda.Dolar,
                "ARS" => Moneda.PesoArgentino,
                "€" => Moneda.Euro,
                _ => Moneda.Desconocida
            };
        }
    }
}
