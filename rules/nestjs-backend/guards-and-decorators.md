# Guards and Decorators

- Apply authentication guards at the controller class level for all protected routes.
- Use param decorators to extract user context from the JWT payload — keep it out of services.
- Use composite decorators (`applyDecorators`) to bundle `SetMetadata` + `UseGuards` into a single method-level decorator. Do not add guards separately when a composite decorator already applies them.
- Do not put auth or access-control logic inside services — keep it in guards and decorators.
