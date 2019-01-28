# Use an official Elixir runtime as a parent image
FROM elixir:latest

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex package manager
RUN mix local.hex --force

# Compile the project
RUN mix deps.get
RUN mix local.rebar --force
RUN mix deps.compile

CMD ["/app/entrypoint.sh"]