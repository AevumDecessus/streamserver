#!/usr/bin/env bash
if [ ! -d "$PWD/docker-nginx-rtmp" ]; then
    if hash git 2>/dev/null; then
        # Checkout the dockerfile repo
        git clone https://github.com/AevumDecessus/docker-nginx-rtmp.git
    else
        echo "GIT is not installed, please install it before running"
        exit 1
    fi
else
    echo "docker-nginx-rtmp directory found, not pulling again"
fi
if hash docker-compose 2>/dev/null; then
    # Run our server
    docker-compose up -d
else
    echo "docker-compose is not installed, please install it before running"
    exit 1
fi
