# External Providers (AI, Payments, Auth strategies, etc.)

- Never import external provider SDKs directly in feature services.
- Each provider category has an interface (e.g. `ITextAnalyzer`, `IPaymentProvider`, `IAuthStrategy`) and a DI token — **even when only one implementation exists today.** "Only one option so far" is not an exception to this rule; it's exactly when the factory is cheapest to set up correctly, before a second implementation forces a rewrite of the wiring.
- A provider category is never considered done with just an interface + one `useClass` binding. It needs all three:
  1. **The interface + DI token** — `src/libs/<category>/interfaces/<category>.interface.ts`.
  2. **One class per concrete implementation**, each registered as its own injectable provider (not instantiated with `new` inside the factory) — `src/libs/<category>/services/<impl>.service.ts` or `src/modules/<domain>/impl/<provider>/`.
  3. **A factory provider** — `src/libs/<category>/factories/<category>.factory.ts` (per `module-structure.md`'s shared-lib shape) — that injects every concrete implementation plus `ConfigService`, and selects one at startup based on config. Feature code depends on the interface's DI token only; it never sees, imports, or branches on a concrete implementation class.
- **Never bind a concrete class directly to the category's DI token** (`{ provide: TOKEN, useClass: SomeImpl }`) — that's the exact shortcut this rule exists to prevent, even with only one implementation. Always go through the factory.
- The factory reads a dedicated config var (e.g. `ACCESS_POINT_PROVIDER_IMPL`) — defaulted in the Joi schema when there's a sensible default (e.g. `'mock'` until a real vendor is chosen), required when there isn't.
- Webhook events are received in a dedicated controller, dispatched via a use case, never processed inline in the controller.
