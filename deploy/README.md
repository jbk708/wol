# Deploying WoL to kl-remote

```
push to main ─▶ GitHub Actions (publish.yml) ─▶ ghcr.io/jbk708/wol:main (+ :sha-<commit>)
                                                        │
kl-remote: wol-update.timer (every 5 min) ── docker compose pull / up -d
                                                        │
Internet ─▶ Cloudflare (weboflife3.org) ─▶ cloudflared tunnel qiita-explore ─▶ 127.0.0.1:8096 ─▶ wol (nginx)
```

The host already has a GHCR credential for `jbk708` in `~/.docker/config.json`, so `docker compose pull` works whether the package is public or private.

## One-time setup on kl-remote

```sh
# From this repo, on your laptop:
ssh kl-remote 'mkdir -p ~/wol ~/.config/systemd/user'
scp compose.yml deploy/wol-update.sh kl-remote:wol/
scp deploy/wol-update.service deploy/wol-update.timer kl-remote:.config/systemd/user/

# On kl-remote:
~/wol/wol-update.sh                       # first pull + start
curl -sS http://127.0.0.1:8096/healthz    # ok
systemctl --user daemon-reload
systemctl --user enable --now wol-update.timer
```

## Cloudflare

1. **DNS** (Cloudflare dashboard → weboflife3.org → DNS). Add two proxied CNAMEs:
   `@` → `3840fd04-8019-4553-8caf-9a956458375e.cfargotunnel.com` and `www` → the same target.
   Don't use `cloudflared tunnel route dns` here. The host's `cert.pem` belongs to the
   knight-lab-dev.org zone, so the command would create `weboflife3.org.knight-lab-dev.org` instead.
2. **Ingress** on kl-remote. Restarting cloudflared drops all existing hostnames for a second or two:
   ```sh
   cp ~/.cloudflared/config.yml ~/.cloudflared/config.yml.bak-$(date +%Y%m%d-%H%M%S)
   # insert above the `- service: http_status:404` catch-all:
   #   - hostname: weboflife3.org
   #     service: http://localhost:8096
   #   - hostname: www.weboflife3.org
   #     service: http://localhost:8096
   ~/.local/bin/cloudflared tunnel ingress validate
   systemctl --user restart cloudflared
   ```
   Then check that every hostname in the config still answers. nginx redirects `www` to the apex.

## Operating

| Task | Command (on kl-remote) |
| --- | --- |
| What's running | `docker inspect wol --format '{{index .Config.Labels "org.opencontainers.image.revision"}}'` |
| Update log | `journalctl --user -u wol-update --since today` |
| Deploy now | `systemctl --user start wol-update` |
| Pin / roll back | `echo WOL_IMAGE=ghcr.io/jbk708/wol:sha-<commit> > ~/wol/.env && ~/wol/wol-update.sh` |
| Resume tracking main | `rm ~/wol/.env && ~/wol/wol-update.sh` |
| Pause updates | `systemctl --user stop wol-update.timer` |
