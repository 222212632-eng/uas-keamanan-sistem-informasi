# Test Plan

| ID | Scenario | Baseline test | Hardening | Retest metric |
|---|---|---|---|---|
| S1 | Unauthorized DB access | Attempt connection from unauthorized source | Host/network restriction | Access Success Rate |
| S2 | Privilege abuse | Attempt unnecessary DDL/DCL operation | Least privilege | Unauthorized Operation Rate |
| S3 | Data exposure | Read selected sensitive field | Encryption + access control | Readable Exposure Rate |
| S4 | Unauthorized modification | Attempt modification beyond account need | Privilege restriction + audit | Modification Success / Audit Coverage |
| S5 | Outdated DBMS | Version/vulnerability assessment | Patch/upgrade | Vulnerability status |

## Ethical boundary

Tests are limited to the isolated laboratory. Do not run these procedures against public,
campus, organizational, or third-party systems.
