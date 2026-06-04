# Server

.NET 8 Web API backend for SurakshaNet AI.

## Current API Foundation

The initial backend project lives in `Server/SurakshaNet.Api/` and includes:

- ASP.NET Core Web API targeting .NET 8
- Swagger/OpenAPI for development environments
- Entity Framework Core with SQL Server configuration
- DTO, service, repository, controller, data, and model folders
- Basic health endpoint at `GET /api/health`
- ASP.NET Core health check endpoint at `GET /health/live`
- Initial module status endpoint at `GET /api/modules`
- Foundation models for Auth/Users, Incidents, GeoFences, PublicBoard, Solutions, HelperRequests, and AuditLogs

## Configuration

Use `appsettings.Example.json` as the template for environment-specific configuration. Do not commit real SQL Server credentials, JWT secrets, or other sensitive values.

For local development, set `Jwt:Secret` through user secrets or environment variables if authentication token validation is needed. Without a configured JWT secret, authentication middleware is intentionally not enabled so public foundation endpoints and Swagger can run during early MVP setup.

## Run Locally

From `Server/SurakshaNet.Api/`:

```bash
dotnet restore
dotnet build
dotnet run
```

Open Swagger at `/swagger` in the Development environment.
