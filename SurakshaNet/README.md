# SurakshaNet AI

SurakshaNet AI is a verification-first civic safety and public accountability MVP. It helps citizens report high-risk civic hazards quickly, supports AI-assisted/human verification, creates geo-fenced danger alerts, routes incidents to departments, protects citizen identity, supports public accountability, accepts solution suggestions, and enables verified helper requests.

## Folder structure

```text
SurakshaNet/
├── Mobile/suraksha_net_app/          # Flutter citizen app
├── Web/suraksha_net_admin/           # Admin web placeholder
├── Server/SurakshaNet.Api/           # .NET 8 Web API
├── DB/Scripts/                       # SQL Server operational scripts
├── DB/SeedData/                      # Seed data scripts
├── DB/SurakshaNet_DB_Schema.sql      # SQL Server schema
├── Backup/DB_Backup/                 # DB backup placeholder docs
├── Backup/Media_Backup/              # Media backup placeholder docs
└── Backup/ReadMe_Backup_Strategy.md  # Backup/restore strategy
```

## Technology stack

- **Mobile:** Flutter, Dart, Provider, `http`, `shared_preferences`, map and push placeholders.
- **Server:** .NET 8 Web API, Entity Framework Core, SQL Server, JWT auth, role-based authorization, Swagger.
- **Database:** SQL Server schema for users, incidents, media, verification logs, geo-fences, alerts, departments, public board, solutions, petitions, helper requests, and audit logs.
- **Backup:** SQL backup/restore scripts plus encrypted media/audit backup strategy.

## MVP features

### Citizen mobile app

- Splash screen.
- Login/register screen with mock-mode fallback.
- Home screen with one-tap hazard buttons for accident, flood, electric danger, pothole, open manhole, women safety, corruption, helper request, and solution suggestion.
- Incident reporting with category, location placeholder, description, media placeholder, anonymous/protected identity toggle, and submit action.
- My Reports list with MVP status flow.
- Risk Map screen with map placeholder and nearby alert list.
- Alert details with risk type, severity, distance, suggested action, and safe route placeholder.
- Verified helper request screen with immediate-danger branch.
- Solution suggestion form.
- Profile screen with verification level, language preference, trusted contacts placeholder, and push notification placeholder.

### API/backend

- Auth: register/login.
- Users: profile, profile update, request verification.
- Incidents: create, list, detail, status update, verify, reject, mark duplicate, assign department.
- Geo-fences: create, active list, nearby list, resolve.
- Alerts: send/list.
- Departments: list/create.
- Public board: publish, list, detail, support, request hide.
- Solutions: create, list by incident, support, expert review, status update.
- Petitions: create, list, support, verify.
- Helper: request, nearby, accept, close, report misuse.
- Audit: by incident and by user.

## How to run the Flutter app

```bash
cd SurakshaNet/Mobile/suraksha_net_app
flutter pub get
flutter run --dart-define=API_BASE_URL=http://localhost:5000/api
```

If the API is unavailable, the app demonstrates the MVP flow with local mock state.

## How to run the .NET API

```bash
cd SurakshaNet/Server/SurakshaNet.Api
dotnet restore
dotnet run
```

Swagger is enabled in development at `/swagger`.

## SQL Server setup

1. Create a database named `SurakshaNetDb`.
2. Run `DB/SurakshaNet_DB_Schema.sql`.
3. Run `DB/SeedData/SurakshaNet_SeedData.sql`.
4. Update the API connection string through environment configuration.

## Environment configuration

Use environment variables or .NET user secrets for runtime values:

```bash
ConnectionStrings__DefaultConnection="Server=localhost;Database=SurakshaNetDb;User Id=...;Password=...;TrustServerCertificate=True"
Jwt__Key="replace-with-strong-secret-at-least-32-characters"
Jwt__Issuer="SurakshaNet.Api"
Jwt__Audience="SurakshaNet.Clients"
```

Do not commit production secrets, connection strings, JWT keys, or backup files.

## Sample API flow

1. `POST /api/auth/register` to create a citizen user.
2. `POST /api/auth/login` to receive a JWT.
3. `POST /api/incidents` with an electric/flood/accident report.
4. `GET /api/incidents` to list reports.
5. `GET /api/geofences/active` to see critical danger zones created by mock AI.
6. `POST /api/solutions` to submit a solution suggestion.
7. `POST /api/public-board/publish/{incidentId}` to publish a verified issue with identity protection.

## Security and privacy notes

- Reporter identity is hidden publicly when `IsAnonymous` is true.
- Sensitive reports show `Identity Protected` publicly.
- Exact user location is not shown publicly for sensitive categories.
- Helper requests expose approximate location first; exact location requires consent.
- Public accountability records are not silently deleted; hiding requires a reason and audit log.
- Every status change creates an audit log.
- Corruption reports should not expose accused-person details publicly in the MVP.
- AI verification is decision support only and does not make final legal decisions.

## Future modules

- Production-grade Flutter map integration and safe routing.
- Push notification integration.
- Media upload, redaction, hashing, and malware scanning.
- Python FastAPI AI service replacement.
- Admin web console.
- Department SLA dashboards.
- Petition workflows and legal escalation with stronger human review.
- Multi-language native alert templates.
