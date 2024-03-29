﻿// <auto-generated />
using System;
using System.Reflection;
using EFCorePeliculas.Entidades;
using Microsoft.EntityFrameworkCore.Metadata;

#pragma warning disable 219, 612, 618
#nullable disable

namespace EFCorePeliculas.CompiledModels
{
    internal partial class PagoTarjetaEntityType
    {
        public static RuntimeEntityType Create(RuntimeModel model, RuntimeEntityType baseEntityType = null)
        {
            var runtimeEntityType = model.AddEntityType(
                "EFCorePeliculas.Entidades.PagoTarjeta",
                typeof(PagoTarjeta),
                baseEntityType,
                discriminatorProperty: "TipoPago");

            var ultimosCuatroDigitos = runtimeEntityType.AddProperty(
                "UltimosCuatroDigitos",
                typeof(string),
                propertyInfo: typeof(PagoTarjeta).GetProperty("UltimosCuatroDigitos", BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly),
                fieldInfo: typeof(PagoTarjeta).GetField("<UltimosCuatroDigitos>k__BackingField", BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.DeclaredOnly));
            ultimosCuatroDigitos.AddAnnotation("Relational:ColumnType", "char(4)");
            ultimosCuatroDigitos.AddAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.None);

            return runtimeEntityType;
        }

        public static void CreateAnnotations(RuntimeEntityType runtimeEntityType)
        {
            runtimeEntityType.AddAnnotation("DiscriminatorValue", TipoPago.Tarjeta);
            runtimeEntityType.AddAnnotation("Relational:FunctionName", null);
            runtimeEntityType.AddAnnotation("Relational:Schema", null);
            runtimeEntityType.AddAnnotation("Relational:SqlQuery", null);
            runtimeEntityType.AddAnnotation("Relational:TableName", "Pagos");
            runtimeEntityType.AddAnnotation("Relational:ViewName", null);
            runtimeEntityType.AddAnnotation("Relational:ViewSchema", null);

            Customize(runtimeEntityType);
        }

        static partial void Customize(RuntimeEntityType runtimeEntityType);
    }
}
