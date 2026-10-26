# Choosing Slopfree Zones

## The inclusion test

A path is a slopfree zone when **all** of these hold:

1. **The failure is expensive.** A plausible wrong edit causes data loss or corruption, a credential or secret that is unreadable, leaked or revoked, or a break in code the project cannot update.
2. **It is hard to undo.** A revert does not fix it. Examples: the migration has already run, a leaked token cannot be recalled, a published SDK version is in other people's lockfiles, an upstream has revoked users' grants.
3. **Tests won't reliably catch it.** It depends on production data, real upstreams, other people's callers or timing.

If only the first holds, the path needs good tests, not a zone. "Important" or "complex" alone does not qualify.

## Categories to survey

| Category | Look for | Typical failure |
| --- | --- | --- |
| Data and migrations | schema definitions, migration directories and their config, migration runners, DB connection and pool setup | A migration runs at boot against production with no down migration. A wrong connection setting takes every request down. |
| Credentials and encryption | envelope or KMS code, key derivation, token storage and refresh, OAuth and JWT handling, log redaction | Every stored secret becomes unreadable. Keys are invalidated. Grants are revoked upstream. A secret appears in logs. |
| Identity and authorization | authorization servers, session issuance, permission checks that every route depends on | Impersonation, or one tenant reads another tenant's data. |
| Code you don't control the callers of | SDKs shipped to host pages or other teams, public wire protocols, published packages, webhook payload shapes | Callers break, and you can't make them upgrade. |
| Money and irreversible side effects | billing, payouts, outbound email or SMS senders, deletion jobs | Duplicate charges, mass messages, deletes with no way back. |
| Release and infrastructure (optional) | IaC for stateful resources, production deploy config | A destroyed database or bucket, or a broken rollout. |

Tests next to zone code belong to the zone. Weakening a test there is as risky as editing the code. Prefer a pattern that covers both (`client*.ts` matches `client.ts` and `client.test.ts`).

## Usually not zones

- UI, styling and copy, even when they ship to production.
- Routes and business logic that tests cover and a revert fixes.
- Generated code that is regenerated from a source of truth (protect the source). Migrations are the exception: they are generated once and then fixed forever.
- Lockfiles, formatting config and CI lint config: annoying to break, cheap to fix.
- Whole apps or repositories. A zone that covers everything gets ignored.

## Writing the reason

Give each zone or group one concrete failure that the user would recognise, in their project's terms. Bad: "security-sensitive code". Good: "a mistake makes every stored credential unreadable or gets users' authorizations revoked upstream". The same sentence goes in the `.slopfree` group comment and in the summary in `AGENTS.md`.
