# Exceptions

- Throw only domain exceptions from `src/common/exceptions/` (e.g., `NotFoundException`, `AlreadyExistsException`).
- Never throw raw `HttpException` from services or use cases. Only the global filter and controller layer deal with HTTP semantics.
- To add a new exception:
  1. Create `src/common/exceptions/<name>.exception.ts` extending `BaseDomainException`.
  2. Add an entry to `InternalExceptionCodeEnum`.
  3. Map it in `internal.to.external.exception.mapper.ts`.
- The global `GlobalExceptionFilter` handles mapping — do not add `try/catch` blocks that swallow exceptions.
