# DTOs

- All DTOs use `class-validator` decorators for validation and `@ApiProperty` / `@ApiPropertyOptional` for Swagger docs.
- Request DTOs: validate every field. Use `@IsOptional()` only when the field is truly optional in business logic.
- Response DTOs: plain classes (no validation decorators). Populate via mapper, not directly from the entity in the controller.
- Paginated responses use `PaginatedResponseDto<T>` from `src/common/dto/`.
- Never expose internal IDs, passwords, tokens, or sensitive columns in response DTOs.
