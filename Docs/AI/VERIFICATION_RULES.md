# Mock Verification Rules and Critical Issue Scoring

## Purpose

SurakshaNet AI MVP verification is a deterministic mock scoring system that gives reviewers consistent decision support for civic safety incidents. It must not be treated as final truth, and it must not automatically publish sensitive incidents, legal claims, corruption allegations, identity-risk reports, or helper-location details.

The rules below define the MVP contract for:

* Severity classification.
* Confidence scoring.
* Critical issue detection.
* Sensitive report flagging.
* Geo-fence radius suggestions.
* Department routing suggestions.
* Native-language alert draft inputs.
* Practical solution suggestion categories.

## Non-Negotiable Safety Rules

1. AI verification is decision support only.
2. Human review is required before legal, corruption, petition, violence, identity-risk, or sensitive public publishing workflows.
3. Public outputs must use approximate area labels and must not expose reporter identity, exact coordinates, raw private evidence, contact details, or sensitive media metadata.
4. Critical alerts may be recommended only as drafts until a reviewer verifies the incident or an emergency-safe workflow is explicitly approved.
5. Score overrides, reviewer decisions, alert creation, public publishing, helper visibility, and exact-location consent changes must be auditable.
6. The mock scorer should prefer `needs_review` when evidence is ambiguous, sensitive, or potentially harmful if published incorrectly.

## MVP Input Fields

| Field | Required | Example | Scoring use | Privacy note |
| --- | --- | --- | --- | --- |
| `incidentType` | Yes | `electric_hazard` | Base severity, department, radius, solution template | Public labels must avoid accusations. |
| `description` | Yes | `Open wire near school gate` | Urgency keywords, sensitivity keywords, confidence hints | Do not send unnecessary identity/contact details to future AI services. |
| `approximateLocation` | Yes | `Ward 12, near market` | Radius selection, duplicate grouping, public alert area | Public surfaces use approximate area only. |
| `latitude` / `longitude` | Internal where consented | `18.5204`, `73.8567` | Duplicate proximity and reviewer map | Exact coordinates are reviewer/internal data only. |
| `reportedAtUtc` | Yes | `2026-06-04T10:00:00Z` | Recency score and active danger priority | No special public exposure. |
| `mediaMetadata` | Optional | Photo count, timestamp, file type | Confidence boost; evidence freshness | Do not expose raw media or EXIF publicly. |
| `reporterTrustSignals` | Optional | Prior verified reports, account age | Small confidence adjustment | Do not expose identity publicly. |
| `nearbyDuplicateCount` | Optional | `3` | Confidence and urgency boost | Aggregate only. |
| `sensitiveKeywords` | Derived | `assault`, `bribe`, `minor` | Sensitive report flag and human review gate | Never publish without review. |
| `languagePreference` | Optional | `hi-IN`, `mr-IN`, `en-IN` | Alert draft localization | Translation is draft content only. |

## Supported MVP Incident Types

| Incident type | Base severity | Default department | Default radius | Default solution category |
| --- | --- | --- | --- | --- |
| `flood` | High | Disaster Management / Municipal Drainage | 800 m | Flood safety and drainage escalation |
| `electric_hazard` | High | Electricity Department | 500 m | Electrical hazard safety |
| `pothole` | Medium | Roads / Public Works Department | 250 m | Road repair escalation |
| `road_hazard` | Medium | Roads / Traffic Department | 300 m | Road safety and barricading |
| `unsafe_area` | Medium | Local Safety / Police Liaison | 400 m | Area safety review |
| `general_civic_safety` | Low | Municipal Grievance Cell | 200 m | General civic guidance |

## Score Components

The mock scorer should calculate transparent component scores before producing final recommendations. Scores can be implemented as points or normalized values, but reviewer-facing output should include the final band and concise rationale.

### Severity Points

| Signal | Condition | Points |
| --- | --- | ---: |
| Base flood or electric hazard | `incidentType` is `flood` or `electric_hazard` | +45 |
| Base road/unsafe hazard | `incidentType` is `pothole`, `road_hazard`, or `unsafe_area` | +30 |
| Base general civic safety | `incidentType` is `general_civic_safety` | +15 |
| Active danger keywords | Description contains `live wire`, `sparking`, `fire`, `rising water`, `trapped`, `collapse`, `blocked ambulance`, or equivalent local-language terms | +30 |
| Injury or vulnerable people nearby | Description mentions injury, children, school, hospital, elderly, disability, or crowd exposure | +20 |
| Major access disruption | Road blocked, bridge unsafe, public transport blocked, evacuation route affected | +15 |
| Weather/time worsening | Heavy rain, night visibility risk, flood rising, traffic peak, festival/crowd event | +10 |
| Stale without duplicate confirmation | Older than 24 hours and no duplicate or media confirmation | -10 |

### Confidence Points

| Signal | Condition | Points |
| --- | --- | ---: |
| Clear description | At least 30 useful characters and not only generic text such as `help` | +15 |
| Approximate location present | Area/landmark/ward is supplied | +15 |
| Fresh report | Reported within last 6 hours | +10 |
| Media metadata present | Photo/video metadata is present and allowed | +15 |
| Nearby duplicate reports | 1 duplicate within 300 m and 12 hours | +10 |
| Multiple duplicate reports | 2 or more duplicates within 300 m and 12 hours | +20 |
| Reporter positive history | Prior verified reports or trusted civic/helper role | +10 |
| Conflicting duplicate evidence | Nearby reports contradict type/status | -15 |
| Very vague report | No clear hazard, location, or actionable detail | -20 |

### Sensitivity Triggers

Any of the following should set `sensitiveReport = true` and force `recommendedStatus = needs_review` unless a reviewer explicitly approves a safer workflow:

| Trigger group | Examples | Required handling |
| --- | --- | --- |
| Legal or corruption allegation | Bribe, fraud, named official accusation, petition demand | Human review; avoid public accusation language. |
| Personal identity risk | Names, phone numbers, addresses, license plates, faces of vulnerable people | Redact before public use. |
| Violence or abuse | Assault, harassment, threat, domestic violence, weapon, mob | Human review; do not crowd-alert details that could endanger people. |
| Children or vulnerable persons | Minor, school child, elderly person needing exact-location help | Approximate area by default; exact location only with consent and need-to-know access. |
| Private property or medical details | Medical condition, private home, personal documents | Restrict visibility and require reviewer review. |

## Severity Bands

Compute `severityScore` from severity points, clamp it to `0..100`, then map it to a band.

| Severity score | Severity | Meaning | Default reviewer action |
| ---: | --- | --- | --- |
| `0-24` | `low` | Non-urgent civic issue or unclear safety impact | Queue for review and solution suggestion. |
| `25-49` | `medium` | Actionable issue with localized risk | Route to department and review for public board eligibility. |
| `50-74` | `high` | Serious hazard or wider public disruption | Escalate to reviewer; prepare alert draft if verified. |
| `75-100` | `critical` | Active danger, vulnerable exposure, or fast escalation risk | Urgent reviewer escalation; prepare geo-fenced alert draft and high-priority department routing. |

## Confidence Bands

Compute `confidenceScore` from confidence points as `clamp(points / 100, 0.05, 0.95)` for MVP simplicity.

| Confidence score | Confidence band | Meaning |
| ---: | --- | --- |
| `< 0.35` | `low` | Insufficient or vague evidence; needs review before action. |
| `0.35-0.69` | `medium` | Plausible and actionable; reviewer can triage with caution. |
| `>= 0.70` | `high` | Strong supporting signals; still decision support only. |

## Critical Issue Detection

Set `criticalIssue = true` when any of the following are true:

1. `severityScore >= 75`.
2. `incidentType` is `electric_hazard` and the description indicates live wire, sparking, fire, shock, fallen pole, transformer blast, or water contact.
3. `incidentType` is `flood` and the description indicates trapped people, rising water, road closure, evacuation issue, submerged electrical equipment, or hospital/school impact.
4. Any incident mentions injury plus active public exposure.
5. Any incident mentions children, school, hospital, elderly, or disabled persons plus active danger.
6. Duplicate reports indicate fast spread or repeated confirmation of the same active hazard.

Critical issue detection should raise priority, but it must not bypass sensitive-report controls or human review gates.

## Recommended Status Rules

| Condition | Recommended status | Notes |
| --- | --- | --- |
| `sensitiveReport = true` | `needs_review` | Human review and privacy redaction required. |
| `criticalIssue = true` and confidence is medium/high | `needs_review` | Escalate reviewer queue and draft alert. |
| High severity and low confidence | `needs_review` | Potentially dangerous but not enough evidence. |
| Medium severity and medium/high confidence | `submitted` or `needs_review` | Depends on reviewer workload; no automatic publication. |
| Low severity and low/medium confidence | `submitted` | Queue normally with solution guidance. |
| Clearly invalid/spam after reviewer review | `rejected` | Rejection is reviewer action, not automatic mock AI action. |

The mock scorer should never return `verified`, `published`, or `resolved` as an automated final status.

## Geo-Fence Radius Suggestions

Radius must be an approximate safety zone, not an exact reporter location. Reviewers may override radius with an audit reason.

| Incident / condition | Suggested radius |
| --- | ---: |
| General civic safety, low severity | 200 m |
| Pothole or localized road hazard | 250-300 m |
| Unsafe area or localized public safety concern | 400 m |
| Electric hazard | 500 m |
| Flood or waterlogging affecting roads | 800 m |
| Critical flood, evacuation route impact, or fast-spreading hazard | 1000-1500 m |
| Sensitive report without verified public safety need | 0 m public alert; reviewer-only handling |

## Department Routing Rules

| Incident type / signal | Primary route | Secondary route |
| --- | --- | --- |
| Flood, waterlogging, blocked drains | Disaster Management / Municipal Drainage | Traffic Police if roads are blocked |
| Electric hazard, fallen wire, transformer issue | Electricity Department | Fire/Emergency liaison if fire or injury is mentioned |
| Pothole, broken road, open manhole | Roads / Public Works Department | Traffic Department if immediate traffic risk |
| Unsafe area, repeated harassment, lighting issue | Local Safety / Police Liaison | Municipal Lighting or Ward Office |
| Waste, sanitation, general civic issue | Municipal Grievance Cell | Ward Office |
| Legal/corruption/petition terms | Reviewer / Legal-safe moderation queue | Relevant department only after review |

## Solution Suggestion Rules

Solution suggestions must be practical civic guidance and safety precautions. They must avoid legal advice, accusations, promises, or instructions that place users in danger.

| Incident type | Safe suggestion examples |
| --- | --- |
| Flood | Avoid walking/driving through water, keep distance from submerged electrical points, route to drainage/disaster team. |
| Electric hazard | Keep people away, do not touch wires or poles, route urgently to electricity department. |
| Pothole / road hazard | Suggest barricade/marking by authorities, road repair routing, caution for two-wheelers and night traffic. |
| Unsafe area | Improve lighting/patrol review, encourage reporting patterns without naming accused persons publicly. |
| General civic safety | Route to municipal grievance workflow and provide status tracking guidance. |
| Sensitive report | Provide only reviewer-facing guidance until redaction and human review are complete. |

## Native-Language Alert Drafting

The mock system may prepare an alert draft in the user's preferred language, but translation is not verification. Native-language alert text should follow this structure:

1. Hazard type in plain language.
2. Approximate area only.
3. Immediate safety action.
4. Verification status label such as `under review` or `verified by reviewer`.
5. No reporter identity, exact coordinates, private evidence, or unreviewed allegations.

Example English draft:

```text
Safety alert under review: Electric hazard reported near Ward 12 market area. Please keep distance from wires or poles and use alternate routes until authorities review the issue.
```

## Output Contract

```json
{
  "incidentType": "electric_hazard",
  "severityScore": 82,
  "severity": "critical",
  "confidenceScore": 0.78,
  "confidenceBand": "high",
  "criticalIssue": true,
  "sensitiveReport": false,
  "recommendedStatus": "needs_review",
  "suggestedRadiusMeters": 500,
  "suggestedDepartment": "Electricity Department",
  "solutionCategory": "Electrical hazard safety",
  "alertDraftAllowed": true,
  "recommendedAction": "Urgent reviewer escalation; prepare nearby safety alert draft after verification",
  "rationale": [
    "Electric hazard has high base severity",
    "Description indicates live wire or active danger",
    "Nearby duplicate reports increase confidence"
  ]
}
```

## Example Scenarios

### Critical Electric Hazard

Input summary: `electric_hazard`, live wire near school gate, 2 duplicate reports, photo metadata present.

Expected output:

* Severity: `critical`.
* Confidence: `high`.
* Critical issue: `true`.
* Sensitive report: `false` unless identities/faces/minors are exposed in evidence.
* Radius: `500 m`.
* Department: Electricity Department.
* Recommended action: urgent reviewer escalation and verified alert draft.

### Flood With Road Closure

Input summary: `flood`, rising water blocking a main road near hospital, fresh report, one duplicate.

Expected output:

* Severity: `critical`.
* Confidence: `medium` or `high` depending on evidence.
* Critical issue: `true`.
* Radius: `1000-1500 m` if road closure affects emergency access.
* Department: Disaster Management / Municipal Drainage, with Traffic Police as secondary route.

### Pothole With Limited Detail

Input summary: `pothole`, vague description, approximate location present, no media, no duplicates.

Expected output:

* Severity: `medium`.
* Confidence: `low`.
* Critical issue: `false` unless injury/active traffic danger is mentioned.
* Radius: `250 m`.
* Department: Roads / Public Works Department.
* Recommended action: queue for review and ask for clearer details when possible.

### Sensitive Unsafe Area Report

Input summary: `unsafe_area`, names an accused person and includes harassment details.

Expected output:

* Severity: at least `medium`, possibly `high` if active danger is described.
* Sensitive report: `true`.
* Critical issue: depends on active danger or vulnerable exposure.
* Public alert: not allowed by default.
* Recommended action: human review, redaction, privacy controls, and safe routing.

## Reviewer Override and Audit Requirements

Reviewers may override severity, critical flag, radius, department, status, and public alert eligibility. Each override must record:

* Actor and role.
* Incident ID.
* Previous recommendation.
* New reviewer decision.
* Reason for override.
* Timestamp.
* Whether public visibility, alerting, helper visibility, or exact-location access changed.

## Future AI Upgrade Path

* Add local-language keyword dictionaries and reviewer-approved translations.
* Add duplicate clustering and incident trend detection after location privacy rules are stable.
* Add image-assisted hazard classification only after consent, media redaction, and reviewer safety controls exist.
* Add model-backed summarization for reviewer notes, not public claims, with strict prompt and audit controls.
* Move advanced model logic to a separate Python FastAPI service only after backend contracts and privacy boundaries stabilize.
