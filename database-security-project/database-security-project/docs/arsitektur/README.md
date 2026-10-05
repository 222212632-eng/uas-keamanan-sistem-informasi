# Laboratory Architecture

```text
+-----------------------+       Host-only Network       +--------------------------+
| Kali Linux / Tester   | ----------------------------> | MariaDB Target VM       |
| Security assessment   |     192.168.56.0/24           | Synthetic DB             |
| S1-S5 test cases      |                                | db_statistik             |
+-----------------------+                                +--------------------------+
          |                                                        |
          +-------------------- Evidence ---------------------------+
                                   |
                         Results / Before-After
```

## Security layers

1. Account hardening
2. Least privilege / access control
3. Network exposure restriction
4. Encryption for selected sensitive data
5. Audit logging
6. Patch/update management

## Evaluation cycle

`Baseline → Vulnerability Assessment → Controlled Test → Hardening → Retest → Before/After Analysis`

All values in this repository's current results are marked as **simulation/benchmark**.
