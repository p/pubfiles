# Project Instructions for Claude

## Ruby Exception Formatting

**REQUIRED:** All exception reporting must include both `#{e.class}` and `#{e}` in that order.

**FORBIDDEN:** Do not use `#{e.message}` or just `#{e}` alone.

Pattern: `"<context>: #{e.class}: #{e}"`

This applies to all Ruby code in this repository (logs, stderr, stdout, error messages, etc.).
