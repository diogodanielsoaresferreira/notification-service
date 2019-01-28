#!/bin/bash
# Docker entrypoint script.

# Wait until RabbitMQ and manager is ready
sleep 15

exec iex -S mix