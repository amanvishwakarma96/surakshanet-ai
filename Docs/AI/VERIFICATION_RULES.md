# Verification Rules

## MVP Approach

Use mock/scoring logic as decision support. The MVP must not treat AI output as final truth, and human verification is required for legal, corruption, petition, and sensitive public publishing workflows.

## Input Fields

* Incident type
* Description
* Approximate location
* Optional media metadata
* Reporter trust signals, if available
* Duplicate reports nearby
* Time since report
* Sensitive keywords or safety indicators

## Scoring Logic

| Signal | Example | Effect |
| --- | --- | --- |
| Hazard type | Electric wire, flood, unsafe area | Raises severity and alert urgency. |
| Description urgency | Injuries, active danger, children nearby | Raises critical flag. |
| Nearby duplicates | Multiple reports in same area | Raises confidence. |
| Media present | Photo/video metadata available | Raises confidence but still requires review. |
| Sensitive report flag | Corruption, identity risk, violence, legal claim | Requires human review and privacy controls. |

## Recommended Action

* Low severity: queue for review and solution suggestions.
* Medium severity: recommend department routing and public-board review.
* High severity: recommend reviewer escalation and geo-fenced alert.
* Sensitive: restrict public visibility and require human review.

## Example JSON

```json
{
  "incidentType": "electric_hazard",
  "severity": "high",
  "confidenceScore": 0.78,
  "criticalIssue": true,
  "suggestedRadiusMeters": 500,
  "suggestedDepartment": "Electricity Department",
  "sensitiveReport": false,
  "recommendedAction": "Escalate to reviewer and prepare nearby safety alert"
}
```

## Future AI Upgrade Path

* Add language detection and native-language alert generation.
* Add image-assisted hazard classification after consent and safety review.
* Add duplicate clustering and trend detection.
* Move advanced model logic to a separate Python FastAPI service only after backend contracts stabilize.
