using EFCorePeliculas;
using EFCorePeliculas.CompiledModels;
using EFCorePeliculas.Servicios;
using Microsoft.EntityFrameworkCore;
using System.Text.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers()
    .AddJsonOptions(opciones => opciones.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles);
//Con esta línea corregimos el error de datos referenciados que no se muestran en el endpoint al ejecutarlo, como ser ejemplo, Pelicula
//referencia a Genero y Genero referencia a Pelicula, lo que se traduce en un 'ciclo' o 'cycle'
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");

/*Esto es Inyección de dependencias; nos permite acceder al ApplicationDbContext sin tener que instanciarlo*/
//builder.Services.AddDbContextFactory
//builder.Services.AddPooledDbContextFactory
builder.Services.AddDbContextFactory<ApplicationDbContext>(opciones =>
{
    
    opciones.UseSqlServer(connectionString, sqlServer => sqlServer.UseNetTopologySuite());

    /* De esta forma el comportamiento será global y no tendremos que especificarlo en cada endpoint */
    opciones.UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking);

    //opciones.UseLazyLoadingProxies();

    //Modelos compilados
    //opciones.UseModel(ApplicationDbContextModel.Instance);
});

//builder.Services.AddDbContext<ApplicationDbContext>();

//Inyección de dependencias ObtenerUsuarioId

builder.Services.AddScoped<IServicioUsuario, ServicioUsuario>();
builder.Services.AddScoped<IEventoDbContext, EventosDbContext>();
builder.Services.AddScoped<IActualizadorObservableCollection, ActualizadorObservableCollection>();

//builder.Services.AddSingleton<Singleton>();

builder.Services.AddAutoMapper(typeof(Program));
var app = builder.Build();

/*Esto lo que hace es crear un contexto a partir del cual voy a poder instanciar el ApplicationDbContext, porque recordamos que el ApplicationDbContext lo estamos utilizando como un servicio, es decir que lo inyectamos a través del sistema de inyección de dependencias de .NET Core y para rescatarlo en la clase Program debo utilizar un scope*/

using (var scope = app.Services.CreateScope())
{
    var applicationDbContext = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
    /*Sabemos que la clase Program se correrá al comienzo de ejecutar la aplicación entonces colocamos:*/
    //applicationDbContext.Database.Migrate();

    /*Y de esta forma vamos a poder ejecutar las migraciones al momento de cargar la aplicación*/
}


// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
