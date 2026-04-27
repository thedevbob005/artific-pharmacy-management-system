# Phase 1 Progress Log

## Completed in this increment

- Scaffolded Flutter desktop app entry with `window_manager` defaults for minimum size and hidden title bar.
- Added Fluent application root, theme support, and router setup.
- Added baseline authentication BLoC with login/logout/theme toggle events.
- Added role permission matrix constants for all five defined roles.
- Added core domain services for GST tax calculation, FEFO allocation, and FY invoice generation.
- Added Drift database foundation (`users`, `products`, `batches`, `inventory_adjustments`, `audit_logs`, `invoices`) with seed admin user.
- Added auth persistence via `AuthRepository` with bcrypt password verification.
- Added POS BLoC with cart item add flow, FEFO-based allocation, and tax/discount-aware totals.
- Added inventory BLoC + DAO CRUD primitives with mandatory stock-adjustment audit logging.
- Added dashboard repository/BLoC with live KPI metrics from Drift queries.
- Expanded unit and BLoC tests for auth, inventory/audit logging, and POS flow.

## Phase 1 status

All previously listed "remaining Phase 1" action items are now implemented at baseline level:

1. ✅ Drift schema + seed logic
2. ✅ Auth persistence + bcrypt hashing
3. ✅ POS BLoC (cart + discount + tax + FEFO)
4. ✅ Inventory CRUD baseline + stock adjustment audit logs
5. ✅ Dashboard metrics powered by live DB queries

## Next suggested steps (post-Phase-1 hardening)

1. Add richer POS UI widgets (barcode listener, hold/recall, payment split dialog).
2. Add complete database table set from implementation plan (full 20+ schema).
3. Add integration tests (`integration_test/`) for end-to-end POS and inventory workflows.
4. Add migration strategy for future schema versions.
