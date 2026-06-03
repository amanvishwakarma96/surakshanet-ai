# API Modules

## MVP API Module Plan

| Module | Purpose | MVP Endpoints Later | Privacy/Audit Notes |
| --- | --- | --- | --- |
| Auth | Register, login, token refresh, roles | `/auth/register`, `/auth/login`, `/auth/me` | Do not log passwords or tokens. |
| Users | User profile and consent settings | `/users/me`, `/users/me/consent` | Protect identity and contact data. |
| Incidents | Submit and view reports | `/incidents`, `/incidents/{id}`, `/incidents/my` | Public responses use approximate location. |
| Verification | Score and review incidents | `/incidents/{id}/verification` | Human review required for sensitive outputs. |
| Geo-fences | Define alert areas | `/geofences`, `/geofences/suggest` | Keep radius explainable and adjustable. |
| Alerts | Notify nearby users | `/alerts`, `/alerts/nearby` | Avoid exact reporter location. |
| Public Board | Show verified civic issues | `/public-issues`, `/public-issues/{id}` | No silent delete; status changes are audited. |
| Solutions | Suggest actions and departments | `/solutions`, `/incidents/{id}/solutions` | Avoid legal advice in MVP. |
| Helper Requests | Match helpers and people in need | `/helper-requests`, `/helper-requests/{id}/consent` | Approximate location first, exact location by consent only. |
| Audit Logs | Track sensitive actions | `/audit-logs` for authorized admins | Read access is restricted. |

## API Design Notes

* Use DTOs that separate internal/private fields from public response models.
* Validate all inputs server-side.
* Use role-based authorization for admin, reviewer, and helper workflows.
* Return stable error responses for mobile clients.
