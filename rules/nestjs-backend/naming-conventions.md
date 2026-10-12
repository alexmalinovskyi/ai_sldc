# Naming Conventions

| Artifact | File name | Class name |
|---|---|---|
| Module | `auth.module.ts` | `AuthModule` |
| Controller | `auth.controller.ts` | `AuthController` |
| Service | `auth.service.ts` | `AuthService` |
| Repository | `post.repository.ts` | `PostRepository` |
| Entity | `user.entity.ts` | `UserEntity` |
| DTO (create) | `create-post.dto.ts` | `CreatePostDto` |
| DTO (response) | `post.response.ts` | `PostResponseDto` |
| Use case | `activate-subscription.usecase.ts` | `ActivateSubscriptionUseCase` |
| Guard | `auth.guard.ts` | `AuthGuard` |
| Decorator | `roles.decorator.ts` | — (function) |
| Mapper | `post.mapper.ts` | `PostMapper` |
| Enum | `subscription-status.enum.ts` | `SubscriptionStatusEnum` |
| Exception | `not-found.exception.ts` | `NotFoundException` |
| Interface | `text-analyzer.interface.ts` | `ITextAnalyzer` |
| Spec | `auth.service.spec.ts` | — |

**Always kebab-case for file names. Always PascalCase for class names.**

Interface names are prefixed with `I` (e.g., `ITextAnalyzer`, `IUseCase`).
