# Use Cases

- Implement `IUseCase<Input, Output>` (`src/common/usecases/interfaces/usecase.interface.ts`).
- Use cases live in `src/common/usecases/<domain>/`.
- One class per file. One responsibility per use case.
- Input type goes in a separate `<name>.input.ts` file alongside the use case.
- Use cases are injectable NestJS providers registered in the module that needs them.
- Write a `.spec.ts` for every use case with meaningful business-logic tests.
