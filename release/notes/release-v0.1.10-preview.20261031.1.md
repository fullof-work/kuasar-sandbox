<!-- kuasar-release-notes {"version":"release-v0.1.10-preview.20261031.1","aggregate_sha":"9b5e7ca9a5e7a3a003231ae3c55fb5d9c896eeaf","components":{"accelerator":"v0.1.9-preview.20261031.1","connector":"v0.1.6","sandboxer":"v0.1.10-preview.20261031.1","orchestrator":"v0.1.10-preview.20261031.1","runtime":"runtime-v0.1.10-preview.20261031.1","vmlinux":"vmlinux-v0.1.5"}} -->
# Kuasar Sandbox release-v0.1.10-preview.20261031.1

<!-- kuasar-release-notice -->
## Important upgrade notice

**[Sandboxer #378](https://github.com/kuasar-sandbox/sandboxer/issues/378) affects all earlier versions. All older deployments should upgrade to `release-v0.1.10` as soon as possible.**

**#378 影响此前所有版本，建议所有旧版部署尽快升级至 `release-v0.1.10`。** <!-- docs:allow-han -->

Upgrade the selected Sandboxer and its bundled patched Cloud Hypervisor v51.1 together, including running old processes. The v51.1 version string alone does not identify the #378 fix. Released pages must not regain stale parent-snapshot bytes. Lost release history in old snapshots cannot be reconstructed; validate important snapshots against expected application state.
<!-- /kuasar-release-notice -->

## Highlights

Released-page correctness, dirty-memory compaction, recoverable startup and Store/ring/output fixes. Snapshot version 1 remains supported.

## Component versions

| Release unit | Version |
|---|---|
| `accelerator` | `v0.1.9-preview.20261031.1` |
| `connector` | `v0.1.6` |
| `sandboxer` | `v0.1.10-preview.20261031.1` |
| `orchestrator` | `v0.1.10-preview.20261031.1` |
| `runtime` | `runtime-v0.1.10-preview.20261031.1` |
| `vmlinux` | `vmlinux-v0.1.5` |

## Asset categories

16 assets: 12 component archives, platform, two native Workbench images and `SHA256SUMS`. Verify hashes; extract products and platform together. Import Workbench separately with `docker load -i`. Registry: `ghcr.io/kuasar-sandbox/workbench:v0.1.10-preview.20261031.1`.

## Supported environment

Linux x86_64/aarch64. System mode requires documented cgroup v2, 4 KiB pages, KVM/TUN, UFFD/BPF and Docker prerequisites, and trusts administrators. Cases and `qualification_scope` below define coverage; ARM Workbench `artifact-only` is not system execution.

## Quick Start

[Quick Start](https://github.com/kuasar-sandbox/kuasar-sandbox/blob/release-v0.1.10-preview.20261031.1/docs/quickstart.md).

## Production deployment

[Deployment](https://github.com/kuasar-sandbox/kuasar-sandbox/blob/release-v0.1.10-preview.20261031.1/docs/deployment.md). Validate workloads/recovery and production credentials, TLS, storage and networking.

## Known limitations

- Old notification-suppressing CH remains affected; replacing only Sandboxer is insufficient.
- Store objects remain revocable, not crash-atomic. Concurrent unlink/abort can cause actual absence, not visibility lag; real write/sync errors still fail.
- Cache `disk_bytes` is soft aging, not a quota; abnormal exit may lose unflushed cache data.
- Output receipt is bounded best-effort after transport failure/timeout, not sink-fsync confirmation.
- v3 disks: 1 TiB; v4: 32 GiB. Old binaries cannot read v3 above 32 GiB. Demo credentials/TLS are evaluation-only.

## Security

[Private vulnerability reporting](https://github.com/kuasar-sandbox/kuasar-sandbox/security/advisories/new). No #378 exploitability claim.

## Versioning and release channels

Development Preview; not the separately qualified Stable release. Historical tags/assets remain immutable.

## Component updates

### accelerator

Successful uploads need no read-after-write inspection (#209); validation, pre-upload dedup and real sync errors remain. Includes presence encoding, Store draining/socket activation and cache aging.

### connector

Unchanged `v0.1.6`.

### sandboxer

Paired CH/capture #378 fix, dirty-memory compaction and launch confirmation; bounded final-output receipt (#381) and atomic shared-ring index ordering (#383). No claim that #383 explains all past guest failures.

### orchestrator

Recoverable startup and snapshot-compaction assertions; links selected dependency inputs.

### runtime

Rebuilt with selected dependencies including sandbox-init; runtime source unchanged.

### vmlinux

Unchanged `vmlinux-v0.1.5`; no kernel update.
