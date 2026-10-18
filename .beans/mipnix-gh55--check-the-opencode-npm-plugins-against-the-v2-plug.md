---
# mipnix-gh55
title: check the opencode npm plugins against the v2 plugin API
status: todo
type: task
priority: normal
created_at: 2026-10-16T12:37:47Z
updated_at: 2026-10-16T12:37:47Z
---

`vibecoding-opencode` loads two npm plugins:

- `@tarquinen/opencode-dcp@latest`
- `@mohak34/opencode-notifier@latest`

They were written against opencode 1. opencode 2 reworked the plugin hook
names, so whether either still loads is unverified. The `pin-opencode-2`
change carried them over unchanged, which is the status quo rather than a
regression, but a start-up error is possible.

Check each against the v2 plugin API and drop or replace what no longer works.
Related: a `prose-lint` equivalent for opencode would be a plugin on
`tool.execute.after`, so this is a good moment to learn the API.
