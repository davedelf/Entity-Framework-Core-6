using Microsoft.EntityFrameworkCore;

namespace EFCorePeliculas.Entidades.Seeding
{
    public class SeedingFacturas
    {
        public static void Seed(ModelBuilder modelBuilder)
        {
            var factura1 = new Factura() { Id = 1, FechaCreacion = new DateTime(2002, 1, 24) };

            var detalle1 = new List<DetalleFactura>()
            {
                new DetalleFactura() {Id=1, FacturaId=factura1.Id, Precio=350.99m },
                new DetalleFactura() {Id=2, FacturaId=factura1.Id, Precio=10 },
                new DetalleFactura() {Id=3, FacturaId=factura1.Id, Precio=45.50m },
            };

            var factura2 = new Factura() { Id = 2, FechaCreacion = new DateTime(2002, 1, 24) };

            var detalle2 = new List<DetalleFactura>()
            {
                new DetalleFactura() {Id=4, FacturaId=factura2.Id, Precio=17.99m },
                new DetalleFactura() {Id=5, FacturaId=factura2.Id, Precio=14 },
                new DetalleFactura() {Id=6, FacturaId=factura2.Id, Precio=45 },
                new DetalleFactura() {Id=7, FacturaId=factura2.Id, Precio=100},
            };

            var factura3 = new Factura() { Id = 3, FechaCreacion = new DateTime(2002, 1, 24) };

            var detalle3 = new List<DetalleFactura>()
            {
                new DetalleFactura() {Id=8, FacturaId=factura3.Id, Precio=371 },
                new DetalleFactura() {Id=9, FacturaId=factura3.Id, Precio=114.99m },
                new DetalleFactura() {Id=10, FacturaId=factura3.Id, Precio=425 },
                new DetalleFactura() {Id=11, FacturaId=factura3.Id, Precio=1000 },
                new DetalleFactura() {Id=12, FacturaId=factura3.Id, Precio=5 },
                new DetalleFactura() {Id=13, FacturaId=factura3.Id, Precio=2.99m },
            };

            var factura4 = new Factura() { Id = 4, FechaCreacion = new DateTime(2002, 1, 24) };

            var detalle4 = new List<DetalleFactura>()
            {
                new DetalleFactura() {Id=14, FacturaId=factura4.Id, Precio=50 },

            };

            modelBuilder.Entity<Factura>().HasData(factura1, factura2, factura3, factura4);
            modelBuilder.Entity<DetalleFactura>().HasData(detalle1);
            modelBuilder.Entity<DetalleFactura>().HasData(detalle2);
            modelBuilder.Entity<DetalleFactura>().HasData(detalle3);
            modelBuilder.Entity<DetalleFactura>().HasData(detalle4);
        }
    }
}
