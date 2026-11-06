
# IRIS — Incident Response Intelligence System

IRIS is an AI-powered cybersecurity incident investigation assistant built using Switch.

## Features

- Custom AI agent: IRIS Commander
- OpenAI Codex integration
- Slack integration for security alert investigation
- MITRE ATT&CK technique mapping
- Incident severity and confidence assessment
- Structured incident investigation reports
- Human approval before response actions
- Windows Security Event ID 4625 collection using PowerShell
- JSON export of collected events

## Technology Stack

- Switch
- OpenAI Codex
- Slack
- PowerShell
- JSON
- MITRE ATT&CK

## Windows Event Collector

The PowerShell collector retrieves Windows Security Event ID 4625 records from the last 7 days and exports them to `windows_4625.json`.

### Run

Open PowerShell as Administrator, navigate to the project folder, and execute:

```powershell
.\iris_collector.ps1
```

The JSON output is saved in the project directory.

The collector has been tested successfully and exported two matching events.

## Switch Setup

1. Create a custom agent named `IRIS Commander` in Switch.
2. Configure OpenAI Codex as its provider.
3. Add instructions for cybersecurity incident investigation.
4. Connect the Slack integration.
5. Add the agent to the security investigation room.
6. Mention `@iris-commander` in the Slack channel to send an alert for investigation.

## Incident Investigation

IRIS analyzes security alerts and provides:

- Incident classification
- Severity and confidence
- MITRE ATT&CK mapping
- Confirmed evidence
- Assumptions and unknowns
- Investigation recommendations
- Additional evidence requirements

## Human Approval

IRIS provides investigation assistance and recommendations. Response and remediation actions require human approval.

## Project Status

Hackathon prototype. The Switch agent, Slack integration, incident investigation workflow, and Windows Event ID 4625 JSON collector have been tested. Automated event forwarding to IRIS is not yet implemented.
