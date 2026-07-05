FROM hexpm/elixir:1.17.3-erlang-27.2.1-alpine-3.21.2 AS builder

WORKDIR /app

ENV MIX_ENV=prod

RUN apk add --no-cache build-base git nodejs npm

COPY mix.exs mix.lock ./
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get --only prod

COPY config ./config
COPY lib ./lib
COPY priv ./priv
COPY assets ./assets
COPY .formatter.exs ./

RUN mix deps.compile
RUN mix assets.deploy
RUN mix compile
RUN mix release

FROM alpine:3.21

RUN apk add --no-cache libstdc++ openssl ncurses-libs

WORKDIR /app

RUN addgroup -g 1001 -S appuser && \
    adduser -u 1001 -S appuser -G appuser

COPY --from=builder --chown=appuser:appuser /app/_build/prod/rel/elixir_phoenix_liveview ./

ENV HOME=/app
ENV PORT=8080
ENV PHX_SERVER=true

EXPOSE 8080

USER appuser

CMD ["bin/elixir_phoenix_liveview", "start"]