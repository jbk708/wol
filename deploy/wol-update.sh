#!/usr/bin/env bash
# Pull the newest ghcr.io/jbk708/wol image and recreate the container only if it changed.
# Run by wol-update.timer every 5 minutes; safe to run by hand.
set -euo pipefail

cd "${WOL_DIR:-$HOME/wol}"

before=$(docker inspect --format '{{.Image}}' wol 2>/dev/null || true)
docker compose pull --quiet
docker compose up -d --remove-orphans --quiet-pull
after=$(docker inspect --format '{{.Image}}' wol)

if [[ "$before" != "$after" ]]; then
    rev=$(docker inspect --format '{{index .Config.Labels "org.opencontainers.image.revision"}}' wol)
    echo "wol updated: ${before:-none} -> $after (commit ${rev:-unknown})"
    # Old :main images are left dangling by the pull; keep a week of them for quick rollback.
    docker image prune -f \
        --filter "label=org.opencontainers.image.source=https://github.com/jbk708/wol" \
        --filter "until=168h" >/dev/null
fi
