#!/usr/bin/env bash
if hash docker-compose 2>/dev/null; then
    # Run our server
    docker-compose up -d
else
    echo "docker-compose is not installed, please install it before running"
    exit 1
fi
