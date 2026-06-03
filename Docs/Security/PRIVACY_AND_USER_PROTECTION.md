# Privacy and User Protection

## Core Principles

* Protect user identity by default.
* Share approximate location first.
* Require explicit consent for exact location sharing.
* Keep audit logs for sensitive actions.
* Treat public publishing as a moderated workflow.
* Use AI as decision support only.

## MVP Risk Controls

| Risk | Affected Module | Severity | Recommended Protection | MVP Implementation Note |
| --- | --- | --- | --- | --- |
| Reporter identity exposure | Incidents, Public Board | High | Separate private reporter fields from public views. | Public issue DTOs must hide identity. |
| Exact location leakage | Incidents, Alerts, Helpers | High | Store exact location privately and display approximate area. | Exact location requires consent. |
| Misuse of helper flow | Helper Requests | High | Verify helper status and limit visible requester data. | Start with approximate matching only. |
| False or defamatory reports | Public Board | High | Human review before public publishing. | Sensitive categories remain unpublished until reviewed. |
| Unauthorized admin access | Backend, Audit | High | JWT, role-based authorization, least privilege. | Admin actions must be audited. |
| Silent deletion of public records | Public Board | Medium | Use status transitions and audit history. | Deletion requires explicit policy later. |
| Evidence misuse | Incident Media | High | Restrict access and log evidence views. | Media access requires role checks. |

## Required Security Review Areas

* Anonymous reporting.
* Protected identity.
* Exact location sharing.
* Helper safety.
* Public board privacy.
* Corruption complaint privacy.
* Role-based access.
* Audit logging.
