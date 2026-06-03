# MVP Backlog

| Priority | Feature | User Story | Acceptance Criteria | Dependencies | Developer Notes |
| --- | --- | --- | --- | --- | --- |
| P0 | One-tap incident reporting | As a citizen, I want to submit a hazard quickly so nearby people and authorities can be informed. | User can select type, description, approximate location, optional media, and submit. | Mobile, Backend, DB | Exact location must not be public by default. |
| P0 | Incident verification status | As an operator, I want reports to move through review states so public data is trusted. | Reports have status, verification notes, and audit log entries. | Backend, DB, AI | AI support cannot final-approve sensitive workflows. |
| P0 | Geo-fenced alerts | As a nearby citizen, I want safety alerts relevant to my area. | Verified critical incidents can generate radius-based alerts. | Backend, DB, Mobile | Radius should be suggested by rules and adjustable by reviewer. |
| P0 | Privacy protection | As a reporter, I want my identity protected from public exposure. | Public views hide identity and exact location. | All modules | Security review required before public publishing. |
| P1 | Public accountability board | As a community member, I want to track verified civic issues. | Verified issues show status, department, area, and updates. | Backend, DB, Web/Mobile | Records are not silently deleted. |
| P1 | Solution hub | As a citizen, I want practical suggestions for resolving or escalating issues. | Issues can have suggested actions and department guidance. | AI, Backend | Avoid legal advice in MVP. |
| P1 | Verified helper requests | As a user in need, I want to request help without exposing exact location immediately. | Helper requests show approximate area and require consent for exact location. | Mobile, Backend, Security | Helper safety checks must be documented. |
| P2 | Petition/legal-aid planning | As a citizen, I may need escalation paths for unresolved issues. | Future scope documented, no automated legal workflow in MVP. | Product, Security | Human review required later. |
