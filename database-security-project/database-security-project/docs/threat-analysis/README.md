# Threat / Exploit Analysis

> **Status: SIMULATION / BENCHMARK.** This file is not a record of an actual exploit execution.

## Objective

Analyze a database-related threat/exploit scenario in an isolated laboratory and map observable
security behavior to relevant indicators and MITRE ATT&CK techniques where the mapping is
supported.

## Threat scenario

- Target: synthetic MariaDB database.
- Environment: isolated virtual laboratory.
- Primary security objectives: confidentiality, integrity, accountability.
- Example threat reference: CVE-2025-21490 is retained as a threat-analysis reference in the report.
- Mitigations: patch/update, least privilege, network restriction, monitoring/audit logging.

## Simulated indicators of compromise

| Indicator | Example |
|---|---|
| Source address | 192.168.56.101 / unknown source |
| Destination | TCP/3306 |
| Account | analyst / app_user / unknown |
| Suspicious action | repeated denied privilege operation |
| Log indicator | timestamped CONNECT, SELECT, UPDATE, DROP DENIED |
| Process/service | MariaDB server process |

## MITRE ATT&CK mapping

The report uses ATT&CK identifiers only as contextual mappings. They should be revalidated
against the exact observed behavior before claiming an actual technique match.

- T1190 — Exploit Public-Facing Application: contextual only; the isolated DB service is not a public service.
- T1098 — Account Manipulation: contextual to privilege/account abuse.
- T1071.004 — DNS: **not directly applicable to the database query itself** and should not be claimed
  as an observed technique without supporting network evidence.

Therefore, ATT&CK mapping is intentionally conservative in this simulation.
