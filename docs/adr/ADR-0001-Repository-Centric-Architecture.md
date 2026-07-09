# ADR-0001: Repository-Centric Architecture

## Status

Accepted

## Context

DevForge Toolkit needs to manage business knowledge stored outside the toolkit itself.

## Decision

The toolkit will operate on a `DevForgeRepository` object loaded from a repository path.

Commands should accept a repository object instead of assuming global state.

## Consequences

- The toolkit can manage multiple repositories.
- Tests can use a sample repository.
- Business data remains separate from toolkit source code.
- Future features can build on a shared repository model.
