# SurakshaNet.Api

.NET 8 Web API MVP for SurakshaNet AI.

## Run locally

```bash
cd SurakshaNet/Server/SurakshaNet.Api
dotnet restore
dotnet run
```

Open Swagger at `https://localhost:<port>/swagger` in development.

## Configuration

Set the following values through user secrets, environment variables, or a local non-committed settings file:

- `ConnectionStrings__DefaultConnection`
- `Jwt__Key`
- `Jwt__Issuer`
- `Jwt__Audience`

The checked-in `appsettings.json` uses development placeholders only.

## Implemented MVP flow

- Register/login with JWT.
- Create/list/detail incidents using DTOs.
- Mock AI verification assigns severity and detects critical cases.
- Critical cases create active geo-fences and alert records.
- Helper requests use approximate location first.
- Solution suggestions are submitted for verification.
- Verified issues can be published to the public board with protected reporter identity.
- Status changes, publication, helper operations, and verification actions create audit logs.

## Sample request/response

### Register

`POST /api/auth/register`

```json
{
  "fullName": "Citizen User",
  "mobile": "+910000000002",
  "email": "citizen@suraksha.local",
  "password": "Password123!",
  "preferredLanguage": "en"
}
```

### Create critical incident

`POST /api/incidents`

```json
{
  "category": "Electric Pole / Live Wire Danger",
  "title": "Live wire in flooded water",
  "description": "Live wire in flooded water near bus stop",
  "latitude": 12.971600,
  "longitude": 77.594600,
  "locationText": "MG Road bus stop",
  "isAnonymous": true
}
```

Expected MVP response includes `severity: Critical`, `status: AI Checked`, and the server creates a critical geo-fence plus alert.

## Security/privacy notes

- AI is decision support only; human review remains required for sensitive/legal/corruption/public-publishing workflows.
- Public reporter identity is hidden for anonymous and sensitive categories.
- Sensitive public summaries should avoid exact locations and accused-person details.
- Public issues are not deleted directly; they can be hidden only with reason and audit log.
