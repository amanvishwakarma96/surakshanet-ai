# Schema vs EF Model Mismatch Report

## Purpose

During the BL-00 reproducible build and contract baseline, we compared the SQL schema defined in `DB/Scripts/001_CreateMvpSchema.sql` with the Entity Framework (EF) Core models and API DTOs in the server code to identify mismatches. This report summarises the discrepancies discovered.

## Findings

- **Incident category taxonomy:** The SQL schema allows categories such as `Flood`, `ElectricHazard`, `Pothole`, `RoadHazard`, `UnsafeArea`, `HelperRequest`, `CorruptionComplaint` and `Other`【60file0†L97-L116】.  The MVP backlog defines categories flood, electric hazard, pothole/road hazard, unsafe area, and general civic safety【68file0†L31-L38】.  Categories like `HelperRequest` and `CorruptionComplaint` are not part of the current MVP scope and should remain deferred until those modules are implemented.
- **Status definitions:** The `Incidents` table includes status values `Submitted`, `UnderReview`, `Verified`, `Rejected`, `Escalated`, `Resolved`, and `Closed`【60file0†L116-L118】, while the backlog and user stories use states like `submitted`, `needs_review`, `verified`, `rejected`, `published`, and `resolved`【53file0†L83-L93】.  These should be aligned to avoid confusion.
- **Verification status:** The schema defines `Pending`, `AutoScored`, `NeedsHumanReview`, `HumanVerified`, and `Rejected`【60file0†L117-L118】.  User stories refer to `submitted`, `needs_review`, `verified`, `rejected`, `published`, and `resolved`【53file0†L79-L95】.  A unified enumeration should be chosen.
- **Additional entities:** Tables such as `PublicIssues`, `Solutions`, `HelperRequests`, and `Petitions` exist in the schema【60file0†L115-L116】 but there are no corresponding EF entity classes or controllers in the server code.  These modules are scaffolded in documentation only and should not be used until the related backlog items are in active scope.
- **Field names and lengths:** Some field names and lengths in the SQL schema differ from the DTOs. For example, the `Description` field allows up to 2000 characters in the schema【60file0†L95-L97】, whereas the mobile report form suggests a shorter description limit【68file0†L31-L38】.  These constraints should be harmonised across layers.

## Recommendations

1. Align the incident category enum in the server models and mobile app with the categories defined in the MVP backlog, treating helper requests and corruption complaints as deferred P1 items.
2. Standardise incident `Status` and `VerificationStatus` enumerations across the database, EF models, API DTOs, and user stories.
3. Defer creating EF entities or controllers for `PublicIssues`, `Solutions`, `HelperRequests`, and `Petitions` until their backlog items (BL‑10 through BL‑13) are in active scope.
4. Review and harmonise field lengths and required fields between the schema and forms, updating either the schema or the form validations as needed.

This report should be referenced when implementing BL‑00 and subsequent tasks to ensure the data model remains consistent across the stack.
