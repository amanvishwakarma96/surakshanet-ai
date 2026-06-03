# MVP Test Plan

## Test Strategy

QA should verify functional behavior, negative cases, privacy protections, security controls, and edge cases before any pilot use.

## Initial Test Cases

| Test Case ID | Module | Scenario | Steps | Expected Result | Priority | Test Type |
| --- | --- | --- | --- | --- | --- | --- |
| QA-INC-001 | Incidents | Submit valid hazard report | Enter type, description, approximate location, submit. | Report is accepted and status is submitted. | P0 | Functional |
| QA-INC-002 | Incidents | Missing required fields | Submit without hazard type or description. | Validation error is shown. | P0 | Negative |
| QA-PRV-001 | Public Board | Reporter privacy | View public issue created from report. | Reporter identity and exact coordinates are hidden. | P0 | Privacy |
| QA-AI-001 | Verification | High-risk electric hazard | Score report with electric danger keywords. | High severity and reviewer escalation are recommended. | P0 | Functional |
| QA-ALT-001 | Alerts | Nearby alert | Create verified critical incident with radius. | Nearby users receive alert without exact reporter location. | P0 | Functional/Privacy |
| QA-HLP-001 | Helper Requests | Approximate helper request | Create helper request. | Helpers see approximate area only until consent. | P1 | Privacy |
| QA-SEC-001 | Admin | Unauthorized audit access | Request audit logs without admin role. | Access is denied. | P0 | Security |

## Acceptance Gate

Before MVP pilot, all P0 functional, privacy, and security test cases must pass or have documented risk acceptance.
