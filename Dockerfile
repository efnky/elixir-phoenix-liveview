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

FROM elixir:1.18-slim
ENV LANG=C.UTF-8
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends openssl && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -g 1001 app && \
    useradd -u 1001 -g app app
COPY --from=builder /app/_build/prod/rel/elixir_phoenix_liveview ./
EXPOSE 8080
USER 1001
ENV PORT=8080
CMD ["bin/elixir_phoenix_liveview", "start"]