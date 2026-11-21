[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/go-httpbin?utm_medium=integration&utm_source=button&utm_campaign=go-httpbin)

# go-httpbin on Railway

One-click [go-httpbin](https://github.com/mccutchen/go-httpbin) on Railway, built from this repo. go-httpbin is a fast, single-binary Go port of [httpbin.org](https://httpbin.org): an HTTP request and response service for testing HTTP clients, webhooks, proxies, retries and timeouts.

**Version:** go-httpbin **2.26.0**. The service builds `FROM ghcr.io/mccutchen/go-httpbin:2.26.0@sha256:873b4fdb27fe7cc66fa12cb9362574e1b0bf31df7ca8a71b2502988327a0b8a4`, the official image (distroless, non-root), pinned by version and digest.

## What you get

| Service | Built from | What it does | Volume |
|---|---|---|---|
| **go-httpbin** (public) | this repo's `Dockerfile` | The httpbin API on `PORT` (8080) behind Railway's HTTPS domain, with its endpoint list at `/`. Health check: `/status/200` | none needed |

go-httpbin keeps no data: every response is built from the request. A redeploy or restart loses nothing, so the template has no volume and no database.

Try it after deploy (replace `YOUR-DOMAIN` with the service's Railway domain):

```sh
curl https://YOUR-DOMAIN/get?hello=world
curl -X POST https://YOUR-DOMAIN/post -H 'content-type: application/json' -d '{"hello":"world"}'
curl -i https://YOUR-DOMAIN/status/418
curl https://YOUR-DOMAIN/delay/3
curl -N https://YOUR-DOMAIN/sse
```

## Variables

The deploy form asks for nothing. The `Dockerfile` sets these defaults; override any of them with a service variable:

| Variable | Default | What it does |
|---|---|---|
| `PORT` | `8080` | Listen port. The public domain targets it |
| `EXCLUDE_HEADERS` | `x-railway-*` | Headers dropped from echoed responses (comma-separated, `*` suffix wildcard). Hides Railway's own edge headers |
| `MAX_BODY_SIZE` | `1048576` | Largest request or response body, in bytes |
| `MAX_DURATION` | `10s` | Longest a response may take (`/delay`, `/drip`) |
| `LOG_FORMAT` | `json` | `json` or `text` |

Optional, from [upstream's configuration](https://github.com/mccutchen/go-httpbin#configuration):

- `ALLOWED_REDIRECT_DOMAINS`: comma-separated allowlist for `/redirect-to`. Set it if your instance is public, so it can't be used as an open redirect.
- `PREFIX`: serve everything under a path such as `/httpbin`.
- `USE_REAL_HOSTNAME`, `USE_FULL_VERSION`, `LOG_LEVEL`, `HTTPBIN_ENV_*` (values shown at `/env`).

An httpbin instance is meant to be public and has no login. Anyone with the URL can send it requests, so keep the limits above sensible.

## Updates

Each new go-httpbin release becomes a commit to `main` here: the pinned version and digest in the `Dockerfile` plus an entry in [CHANGELOG.md](CHANGELOG.md). Railway then shows an "update available" notice on your deployed service, and you choose when to apply it. Nothing is stored, so an update needs no migration.

## Run it locally

```sh
docker build -t go-httpbin-railway .
docker run --rm -p 8080:8080 go-httpbin-railway
# open http://localhost:8080
```

## Licence

go-httpbin is MIT ([mccutchen/go-httpbin](https://github.com/mccutchen/go-httpbin)). The wrapper files in this repo are MIT.
