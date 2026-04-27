# Development Setup (Flutter + Requirements)

This project requires Flutter and Dart (bundled with Flutter) to run tests and code generation.

## Quick setup

```bash
./scripts/install_requirements.sh
```

The script installs Flutter **3.35.7 (stable)** into `~/toolchains/flutter`, runs `flutter doctor -v`, and then runs `flutter pub get`.

## Manual setup (if you prefer)

1. Install Flutter stable from official sources.
2. Add `flutter/bin` to your `PATH`.
3. In this repository run:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter test
```

## Network/proxy note

If installation fails with `403 Forbidden` while downloading Flutter or apt packages, your environment is likely behind a restricted proxy/firewall.
Configure egress access (or mirror Flutter artifacts internally), then rerun setup.
