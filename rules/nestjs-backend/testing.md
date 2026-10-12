# Testing

- Test files: `<name>.spec.ts` alongside the file under test (inside `src/`).
- E2E tests: `test/` at project root.
- Use `@nestjs/testing` `Test.createTestingModule()` for unit tests.
- Mock dependencies with `useValue: mockService` (typed as `jest.Mocked<T>`). Never use the real database in unit tests.
- Fixture data: `@faker-js/faker` for realistic fake values.
- Test file structure: one `describe` per class, one `it` per behaviour (not per method).
- Run `npm run test` before committing. All tests must pass.
- Run `npm run type-check` and `npm run lint:check` before committing.
