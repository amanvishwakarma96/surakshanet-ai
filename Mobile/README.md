# Mobile

Flutter mobile app foundation for SurakshaNet AI lives in `Mobile/suraksha_net_app/`.

## What is included

* Minimal Flutter package configuration.
* Material 3 app shell with centralized navigation routes and theme.
* Clean starter folders for `core/`, `features/`, and `shared/` code.
* API service placeholder in mock mode with local configuration.
* Initial MVP screens:
  * Splash
  * Login / Register
  * Home
  * Report Incident
  * My Reports
  * Nearby Alerts
  * Profile
* Widget test coverage for splash, reporting, report history, and the mock geo-fence alert flow.

## Privacy and safety defaults

* Login/Register is mock-only and does not send or store credentials.
* Incident reporting captures category, approximate area, description, and sensitivity while avoiding exact coordinates in the foundation flow.
* Public-facing copy uses approximate location language. Nearby alerts can simulate approximate-area matching without enabling exact GPS sharing.
* Exact location sharing is shown as disabled by default and reserved for consent-based helper flows.
* AI verification is presented as decision support only; sensitive publishing requires human review.

## How to run

From `Mobile/suraksha_net_app/`:

```bash
flutter pub get
flutter run
```

## How to test

From `Mobile/suraksha_net_app/`:

```bash
flutter test
```

## Current limitations

* No generated Android, iOS, or web runner projects are included yet.
* API integration is not implemented; screens use mock static state.
* Incident reporting saves to an in-memory mock repository; media upload, geolocation, and backend submission are placeholders for later scoped tasks.
* Nearby alerts use mock verified geo-fenced alerts with approximate safety radii until the backend `GET /api/geofences/alerts/nearby` endpoint is wired into the Flutter API service.
* Helper request flows are placeholders for later scoped tasks.
