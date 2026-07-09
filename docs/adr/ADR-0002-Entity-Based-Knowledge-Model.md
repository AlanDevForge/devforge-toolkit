# ADR-0002: Entity-Based Knowledge Model

## Status

Accepted

## Context

Machines, products, materials, suppliers and workflows share common metadata.

## Decision

All knowledge items are represented as entities with common fields:

- Id
- Title
- Type
- Status
- Created
- Updated
- Tags
- Relationships
- Path
- Body

## Consequences

- Queries can work across all entity types.
- Validation can be consistent.
- Relationships can reference stable IDs.
- Website generation and reports can reuse the same model.
