# DevForge Toolkit Architecture

DevForge Toolkit is a PowerShell module for managing structured maker-business knowledge repositories.

## Core Layers

1. Markdown files store human-readable knowledge.
2. Front matter stores structured entity metadata.
3. The entity engine converts Markdown into objects.
4. The repository object provides querying, validation and reporting.
5. Public commands expose useful workflows.

## Main Concepts

- Repository
- Entity
- Metadata
- Relationships
- Validation
- Reports
- Graphs

## Design Principle

The toolkit manages data, but does not own it. Business knowledge remains in the DevForge HQ repository.
