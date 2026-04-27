#!/usr/bin/env bash
set -euo pipefail

FLUTTER_VERSION="3.35.7"
FLUTTER_CHANNEL="stable"
INSTALL_DIR="${HOME}/toolchains"
FLUTTER_DIR="${INSTALL_DIR}/flutter"

log() {
  printf '\n[%s] %s\n' "$(date -u +%H:%M:%S)" "$1"
}

ensure_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    log "Missing required command: $1"
    exit 1
  fi
}

install_flutter() {
  mkdir -p "${INSTALL_DIR}"

  if [ -x "${FLUTTER_DIR}/bin/flutter" ]; then
    log "Flutter already installed at ${FLUTTER_DIR}"
    return 0
  fi

  local archive="flutter_linux_${FLUTTER_VERSION}-${FLUTTER_CHANNEL}.tar.xz"
  local url="https://storage.googleapis.com/flutter_infra_release/releases/${FLUTTER_CHANNEL}/linux/${archive}"

  log "Downloading Flutter ${FLUTTER_VERSION} (${FLUTTER_CHANNEL})"
  if curl -fL "${url}" -o "/tmp/${archive}"; then
    tar -xf "/tmp/${archive}" -C "${INSTALL_DIR}"
    rm -f "/tmp/${archive}"
    log "Installed Flutter SDK to ${FLUTTER_DIR}"
    return 0
  fi

  log "Direct archive download failed; trying git fallback"
  if git clone --depth 1 -b "${FLUTTER_CHANNEL}" https://github.com/flutter/flutter.git "${FLUTTER_DIR}"; then
    log "Installed Flutter SDK via git clone"
    return 0
  fi

  log "Unable to install Flutter automatically. Check firewall/proxy and retry."
  return 1
}

main() {
  ensure_cmd curl
  ensure_cmd git

  install_flutter

  export PATH="${FLUTTER_DIR}/bin:${PATH}"

  log "Running flutter doctor"
  flutter doctor -v

  log "Fetching project dependencies"
  flutter pub get

  log "Setup complete"
}

main "$@"
