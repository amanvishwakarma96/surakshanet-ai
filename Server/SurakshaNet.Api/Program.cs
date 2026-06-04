using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using SurakshaNet.Api.Authentication;
using SurakshaNet.Api.Data;
using SurakshaNet.Api.DTOs;
using SurakshaNet.Api.Repositories;
using SurakshaNet.Api.Services;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers()
    .ConfigureApiBehaviorOptions(options =>
    {
        options.InvalidModelStateResponseFactory = context =>
        {
            var errors = context.ModelState
                .Where(entry => entry.Value?.Errors.Count > 0)
                .ToDictionary(
                    entry => entry.Key,
                    entry => entry.Value!.Errors
                        .Select(error => string.IsNullOrWhiteSpace(error.ErrorMessage)
                            ? "The submitted value is invalid."
                            : error.ErrorMessage)
                        .ToArray());

            return new BadRequestObjectResult(new ValidationErrorResponse(
                "validation_failed",
                "One or more request fields are invalid.",
                errors));
        };
    });
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "SurakshaNet AI API",
        Version = "v1",
        Description = "Verification-first civic safety and public accountability API foundation."
    });

    var securityScheme = new OpenApiSecurityScheme
    {
        Name = "Authorization",
        Description = "Enter a JWT bearer token when authentication is enabled.",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.Http,
        Scheme = JwtBearerDefaults.AuthenticationScheme,
        BearerFormat = "JWT",
        Reference = new OpenApiReference
        {
            Type = ReferenceType.SecurityScheme,
            Id = JwtBearerDefaults.AuthenticationScheme
        }
    };

    options.AddSecurityDefinition(JwtBearerDefaults.AuthenticationScheme, securityScheme);
    options.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        [securityScheme] = Array.Empty<string>()
    });
});

builder.Services.AddDbContext<SurakshaNetDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("SurakshaNetDb")));

builder.Services.AddScoped<IIncidentRepository, IncidentRepository>();
builder.Services.AddScoped<IAlertRepository, AlertRepository>();
builder.Services.AddScoped<IAuditLogRepository, AuditLogRepository>();
builder.Services.AddScoped<IIncidentService, IncidentService>();
builder.Services.AddScoped<IGeoFenceAlertService, GeoFenceAlertService>();
builder.Services.AddScoped<IAuditLogService, AuditLogService>();
builder.Services.AddScoped<IModuleStatusService, ModuleStatusService>();

var jwtSecret = builder.Configuration["Jwt:Secret"];
if (!string.IsNullOrWhiteSpace(jwtSecret))
{
    builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
        .AddJwtBearer(options =>
        {
            options.TokenValidationParameters = new TokenValidationParameters
            {
                ValidateIssuer = true,
                ValidateAudience = true,
                ValidateLifetime = true,
                ValidateIssuerSigningKey = true,
                ValidIssuer = builder.Configuration["Jwt:Issuer"],
                ValidAudience = builder.Configuration["Jwt:Audience"],
                IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSecret))
            };
        });
}
else
{
    builder.Services.AddAuthentication("Disabled")
        .AddScheme<AuthenticationSchemeOptions, DisabledAuthenticationHandler>("Disabled", options => { });
}

builder.Services.AddAuthorization();
builder.Services.AddHealthChecks();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(options =>
    {
        options.SwaggerEndpoint("/swagger/v1/swagger.json", "SurakshaNet AI API v1");
    });
}

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();
app.MapHealthChecks("/health/live");

app.Run();
