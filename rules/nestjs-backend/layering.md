# Layering

```
Controller → Service → Repository → Entity
                  ↘ UseCase (cross-domain logic)
```

- **Controllers** handle only HTTP: extract params, call service/usecase, return response DTO. No business logic.
- **Services** orchestrate within their own domain only: call their own repositories, mappers, and intra-module services. No raw SQL. Never reach into a sibling domain — that belongs in a use case.
- **Repositories** own all database queries for their entity. Extend TypeORM `Repository<Entity>`. Never put query logic in services.
- **Use cases** (`src/common/usecases/`) handle cross-module domain logic. Implement `IUseCase<Input, Output>`. Services from different modules wire together here.
- **Entities** are pure TypeORM models. No business methods on entities.
- **Mappers** are static classes. Only transform entity ↔ DTO. No DB calls.

**Cross-domain wiring goes in use cases, not services.** A service must never import another module's service unless that module explicitly exports it and the coupling is domain-appropriate. Prefer use cases for multi-service orchestration.
