# Changelog

Breaking changes come first in each entry.

## 2.26.0 (2026-11-21)

First release of the template.

- go-httpbin 2.26.0 on the official image `ghcr.io/mccutchen/go-httpbin:2.26.0@sha256:873b4fdb27fe7cc66fa12cb9362574e1b0bf31df7ca8a71b2502988327a0b8a4`.
- Listens on Railway's `PORT` (8080). Railway's edge headers (`X-Railway-*`) are left out of echoed responses.
- Request limits set explicitly: 1 MiB bodies, 10 s maximum response time. JSON logs.
- Health check path: `/status/200`.
