# Module Structure

Every feature module in `src/modules/<name>/` must follow this layout:

```
<name>/
  <name>.module.ts        # required
  <name>.controller.ts    # required (unless no HTTP routes)
  <name>.service.ts       # required
  <name>.service.spec.ts  # required for services with logic
  dto/
    create-<name>.dto.ts
    update-<name>.dto.ts  # if applicable
    <name>.response.ts
  mappers/
    <name>.mapper.ts      # only if entity ↔ DTO conversion is non-trivial
  types/
    index.ts              # TypeScript interfaces specific to this module
  utils/                  # Utility functions specific to this module
```

**Shared libs** in `src/libs/<name>/` use:

```
<name>/
  <name>.module.ts
  constants/
  clients/
  factories/
  interfaces/
  services/
```
