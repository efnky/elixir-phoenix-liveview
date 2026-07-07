FROM elixir:1.18-alpine AS builder
RUN apk add --no-cache git
ENV MIX_ENV=prod
WORKDIR /app
COPY mix.exs mix.lock ./
RUN mix deps.get --only prod
COPY config ./config
COPY lib ./lib
COPY priv ./priv
COPY assets ./assets
RUN mix compile && mix assets.deploy && mix release

FROM alpine:3.21
ENV LANG=C.UTF-8
WORKDIR /app
RUN apk add --no-cache openssl ncurses-libs libstdc++ libgcc && \
    addgroup -g 1001 -S app && \
    adduser -u 1001 -S app -G app
COPY --from=builder --chown=1001:1001 /app/_build/prod/rel/elixir_phoenix_liveview ./
EXPOSE 8080
USER 1001
ENV PORT=8080
CMD ["bin/elixir_phoenix_liveview", "start"]