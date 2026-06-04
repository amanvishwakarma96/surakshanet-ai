# Mobile

Flutter mobile app foundation for SurakshaNet AI lives in `Mobile/suraksha_net_app/`.

## What is included

* Minimal Flutter package configuration.
* Material 3 app shell with centralized navigation routes and theme.
* Clean starter folders for `core/`, `features/`, and `shared/` code.
* API service placeholder in mock mode.
* Initial MVP screens:
  * Splash
  * Login / Register
  * Home
  * Profile
* Widget test coverage for the splash entry screen.

## Privacy and safety defaults

* Login/Register is mock-only and does not send or store credentials.
* Public-facing copy uses approximate location language.
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
* Incident reporting, media upload, geolocation, alerts, and helper request flows are placeholders for later scoped tasks.
