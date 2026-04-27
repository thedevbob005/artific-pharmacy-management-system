# Phase 1 Progress Log

## Completed in this increment

- Scaffolded Flutter desktop app entry with `window_manager` defaults for minimum size and hidden title bar.
- Added Fluent application root, theme support, and router setup.
- Added baseline authentication BLoC with login/logout/theme toggle events.
- Added role permission matrix constants for all five defined roles.
- Added phase scaffold pages for Dashboard, POS, and Inventory.
- Implemented core domain services for:
  - GST tax calculation (`TaxEngine`)
  - FEFO allocation (`FefoService`)
  - Financial-year invoice number generation (`InvoiceNumberService`)
- Added unit tests for domain services.
- Added developer setup automation script for Flutter SDK installation and dependency bootstrapping (`scripts/install_requirements.sh`).

## Next suggested steps (remaining Phase 1)

1. Add Drift schema (`app_database.dart`, tables, DAOs) and seed logic.
2. Wire real auth persistence + bcrypt hashing.
3. Implement POS BLoC with cart, discount, tax, and FEFO integration.
4. Implement inventory CRUD + stock adjustment audit logs.
5. Build dashboard widgets from live DB queries.
