#!/usr/bin/env bash
# Script to install cloudflared if missing and launch a Cloudflare Tunnel for Sugar Market

echo "Checking cloudflared..."
if ! command -v cloudflared &> /dev/null; then
    echo "cloudflared not found in PATH. Downloading..."
    ARCH=$(uname -m)
    if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
        CF_ARCH="arm64"
    else
        CF_ARCH="amd64"
    fi
    curl -L "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-${CF_ARCH}.deb" -o /tmp/cloudflared.deb
    sudo dpkg -i /tmp/cloudflared.deb || {
        echo "dpkg failed, installing binary to /usr/local/bin/cloudflared..."
        curl -L "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-${CF_ARCH}" -o /tmp/cloudflared
        chmod +x /tmp/cloudflared
        sudo mv /tmp/cloudflared /usr/local/bin/cloudflared
    }
fi

echo "Starting Cloudflare Tunnel pointing to http://localhost:3000..."
cloudflared tunnel --url http://localhost:3000
