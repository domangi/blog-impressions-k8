FROM bitwalker/alpine-elixir-phoenix:1.9.0 as releaser

ADD . /app
WORKDIR /app

# Install Hex + Rebar
RUN mix do local.hex --force, local.rebar --force

ENV MIX_ENV=prod
RUN mix do deps.get --only $MIX_ENV, deps.compile

RUN MIX_ENV=prod mix compile
RUN MIX_ENV=prod mix release

########################################################################

FROM bitwalker/alpine-elixir-phoenix:1.9.0

EXPOSE 4000
ENV PORT=4000 \
    MIX_ENV=prod \
    SHELL=/bin/bash

WORKDIR /app
COPY --from=releaser app/_build/prod/rel/impressions .

CMD ["./bin/impressions", "start"]
