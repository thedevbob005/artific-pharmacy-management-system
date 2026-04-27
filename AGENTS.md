# AGENTS.md — APMS by Artific

## Project Overview

**APMS by Artific** is an advanced pharmacy management system for Indian single-store pharmacies, built as a **Flutter Desktop application** (Windows-first). It handles billing/POS, inventory (FEFO), GST compliance, Schedule H1/NDPS registers, purchases, returns, reporting, and more.

## Architecture

### Stack
- **Flutter Desktop** (Windows-first, Dart language)
- **UI**: `fluent_ui` ^4.15 (Microsoft Fluent Design System)
- **Window**: `window_manager` (custom title bar, sizing)
- **State Management**: `flutter_bloc` ^9.x (BLoC pattern — event-driven)
- **Database**: `drift` ^2.32 + SQLite (local-first, type-safe, reactive)
- **DI**: `get_it` + `injectable`
- **PDF/Print**: `pdf` + `printing` packages
- **Thermal Printing**: `unified_esc_pos_printer` (ESC/POS)
- **Email**: `mailer` (configurable SMTP)
- **Charts**: `fl_chart`
- **Packaging**: `msix` (Windows installer)

### Pattern
The project follows **Clean Architecture** with a **feature-first** folder structure:

```
lib/
├── core/          # Theme, routing, DI, constants, utils
├── data/          # Database (Drift tables, DAOs), repositories, models
├── domain/        # Abstract repos, business services (tax engine, FEFO, etc.)
├── features/      # Feature modules (auth, pos, inventory, purchases, etc.)
│   └── <feature>/
│       ├── bloc/      # BLoC (events, states, bloc class)
│       ├── pages/     # Full-screen page widgets
│       └── widgets/   # Feature-specific reusable widgets
└── shared/        # Cross-feature reusable widgets, extensions
```

### Database
- **Drift** with SQLite — all tables defined in `lib/data/database/tables/`
- **DAOs** in `lib/data/database/daos/` — one DAO per feature domain
- **Code generation**: run `dart run build_runner build` after modifying tables
- **Migrations**: handled via `schemaVersion` in `app_database.dart`
- Monetary values use `real` (double) with 2-decimal rounding in Dart logic

## Coding Conventions

### Dart / Flutter
- **Dart 3.x** with strict analysis (`analysis_options.yaml`)
- Use `const` constructors wherever possible
- Prefer **immutable state** — BLoC states should be `@immutable` classes with `Equatable`
- Use **freezed** or manual `copyWith` for complex state objects
- All BLoC events must be sealed classes
- **No `setState`** in feature pages — always use BLoC

### Naming
- Files: `snake_case.dart`
- Classes: `PascalCase`
- BLoC events: `<Feature><Action>` (e.g., `CartItemAdded`, `CartItemRemoved`)
- BLoC states: `<Feature>State` with status enum (e.g., `CartState` with `CartStatus.initial|loading|loaded|error`)
- Database tables: `PascalCase` Drift classes mapping to `snake_case` SQLite tables
- DAOs: `<Entity>Dao` (e.g., `ProductDao`, `InvoiceDao`)

### UI
- **All UI built with `fluent_ui` widgets** — do NOT use Material or Cupertino widgets
- Key Fluent widgets: `NavigationPane`, `ContentDialog`, `InfoBar`, `CommandBar`, `AutoSuggestBox`, `NumberBox`, `DatePicker`, `TreeView`, `DataTable` (Fluent variant)
- Use `FluentTheme.of(context)` for colors and typography — never hardcode colors
- Support both **dark and light** themes
- Minimum window size: **1024 × 768**

### State Management Rules
- One BLoC per feature screen (e.g., `PosBloc`, `InventoryBloc`)
- Shared data BLoCs for cross-feature state (e.g., `AuthBloc`, `SettingsBloc`)
- Use `BlocProvider` at the route level, not globally (except auth)
- Use `BlocSelector` for granular rebuilds
- Heavy computation (reports, PDF generation) must run in **Isolates** via `compute()`

### Error Handling
- All repository methods return typed results (no raw exceptions in UI)
- Use `try/catch` in BLoC `on<Event>` handlers, emit error states
- Show errors via Fluent `InfoBar` (severity: error/warning/info/success)
- Never silently swallow exceptions

## Domain Rules (Indian Pharmacy)

### GST Tax Engine (`lib/domain/services/tax_engine.dart`)
- Rates: 0%, 5%, 12%, 18% — determined by product HSN code
- **Intra-state** (same state): split into CGST + SGST (each = rate/2)
- **Inter-state**: use full IGST rate
- Discounts reduce taxable value BEFORE tax calculation
- Round final totals to nearest rupee

### FEFO (`lib/domain/services/fefo_service.dart`)
- **First Expiry, First Out** — always allocate from batch with earliest `exp_date`
- If quantity spans multiple batches, create multiple invoice items (one per batch)
- **Never sell expired batches** — block at POS level
- Returned items go back to their original batch

### Invoice Numbering (`lib/domain/services/invoice_number.dart`)
- Sequential per Indian financial year (April 1 – March 31)
- Format: `INV-{FY}-{sequence}` (e.g., `INV-2526-00001`)
- Must be unique and gap-free within a financial year

### Schedule H1 Compliance
- When any H1-classified product is added to cart, system MUST prompt for:
  - Prescriber name + address
  - Patient name + registration number
- Entry auto-logged to `h1_register` table
- Records retained for 3 years minimum

### Roles & Permissions
Five roles with this permission matrix:

| Module | Admin | Pharmacist | Cashier | Accountant | Auditor |
|--------|-------|-----------|---------|------------|---------|
| Billing/POS | R/W/D | R/W | R/W | R | R |
| Inventory | R/W/D | R/W | – | R | R |
| Purchases | R/W/D | R/W | – | R/W | R |
| Returns | R/W/D | R/W | – | R/W | R |
| Customers | R/W/D | R/W | R/W | R | R |
| H1 Register | R/W | R/W | – | R | R |
| Reports | R/W | R/W | – | R/W | R |
| Accounting | R/W | – | – | R/W | R |
| User Mgmt | R/W/D | – | – | – | R |
| Backup | R/W | – | – | – | – |
| Audit Logs | R/W | R | – | – | R |

## Testing

- **Unit tests** in `test/unit/` — tax engine, FEFO logic, invoice numbering, permission checks
- **BLoC tests** using `bloc_test` — event→state transitions for all BLoCs
- **Drift tests** — in-memory SQLite for DAO operations
- **Integration tests** in `test/integration/` — full user flows (POS, purchase, return)
- Run all: `flutter test`
- Run integration: `flutter test integration_test/`

## Build & Run

```bash
# Install dependencies
flutter pub get

# Generate Drift code
dart run build_runner build --delete-conflicting-outputs

# Run in debug mode (desktop)
flutter run -d windows

# Run tests
flutter test

# Build Windows release
flutter build windows --release

# Package as MSIX installer
dart run msix:create
```

## Key Files

| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry, window_manager initialization |
| `lib/app.dart` | FluentApp root, theme, routing |
| `lib/data/database/app_database.dart` | Drift database (all tables, version, migrations) |
| `lib/domain/services/tax_engine.dart` | GST calculation engine |
| `lib/domain/services/fefo_service.dart` | FEFO batch allocation algorithm |
| `lib/features/pos/bloc/cart_bloc.dart` | POS cart state management |
| `lib/features/auth/bloc/auth_bloc.dart` | Authentication state |
| `lib/core/theme/` | Fluent theme configuration |
| `docs/implementation-plan.md` | Full implementation plan (6-phase rollout, stack, schema, verification) |
| `docs/deep-research-report.md` | Deep research report — detailed module specs, workflows, data models, ER/sequence diagrams |
| `docs/Advanced Pharmacy Software Specification (India – Single Store).pdf` | Original PDF specification (22 pages) — executive summary, all modules, DB schema, roadmap, Indian regulatory citations |

## Important Notes

1. **No Material/Cupertino** — this is a Fluent UI app. Use only `fluent_ui` widgets.
2. **All monetary math** must use `double` with explicit 2-decimal rounding (`(value * 100).round() / 100`). Never display unrounded currency.
3. **Invoices are immutable** — once saved, they cannot be edited or deleted. Corrections are made via credit notes (returns).
4. **Audit everything** — all create/update/delete operations on key entities must write to `audit_logs`.
5. **Offline-first** — the app uses local SQLite. No network dependency for core operations.
6. **Indian financial year** — April 1 to March 31. All FY-scoped logic (invoice numbers, reports, GSTR) uses this calendar.
