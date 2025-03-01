using ECommerceApp.API;

var builder = WebApplication.CreateBuilder(args);

// Explicitly configure Kestrel to listen on all interfaces
builder.WebHost.ConfigureKestrel(serverOptions =>
{
    serverOptions.ListenAnyIP(80);
});

var startup = new Startup();
startup.ConfigureServices(builder.Services);

var app = builder.Build();
startup.Configure(app, app.Environment);

app.Run();