# go-httpbin for Railway: the official image, pinned by version and digest.
# The image is distroless (no shell), so this file only sets safe defaults for a
# public instance. Any of them can be overridden with a Railway service variable.
FROM ghcr.io/mccutchen/go-httpbin:2.26.0@sha256:873b4fdb27fe7cc66fa12cb9362574e1b0bf31df7ca8a71b2502988327a0b8a4

# PORT: Railway sets it; 8080 is go-httpbin's own default and the domain's target port.
# EXCLUDE_HEADERS: hide Railway's edge headers (X-Railway-*) from /headers, /get,
#   /anything and friends, so responses show what the client sent
#   (upstream "Production considerations" #5).
# MAX_BODY_SIZE / MAX_DURATION: per-request limits for a public instance
#   (upstream's defaults, set explicitly so they are easy to find and change).
ENV PORT=8080 \
    HOST=0.0.0.0 \
    EXCLUDE_HEADERS="x-railway-*" \
    MAX_BODY_SIZE=1048576 \
    MAX_DURATION=10s \
    LOG_FORMAT=json

EXPOSE 8080
ENTRYPOINT ["/usr/bin/go-httpbin"]
