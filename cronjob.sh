#!/bin/bash

# Set your variables here
TOKEN="YOUR_TELEGRAM_BOT_TOKEN"
CHAT_ID="YOUR_TELEGRAM_CHAT_ID"

# Get Mina status information
mina_status=$(/usr/local/bin/mina client status)

# Check if Mina status is not empty (indicating a successful command execution)
if [ -n "$mina_status" ]; then
    # Extract relevant information from the status output
    block_height=$(echo "$mina_status" | grep -E "Block height:" | awk '{print $3}')
    local_uptime=$(echo "$mina_status" | grep -E "Local uptime:" | awk '{print $3}')
    peers=$(echo "$mina_status" | grep -E "Peers:" | awk '{print $2}')
    sync_status=$(echo "$mina_status" | grep -E "Sync status:" | awk '{print $3}')
    producers_running=$(echo "$mina_status" | grep -E "Block producers running:" | awk '{print $4}')
    next_block=$(echo "$mina_status" | grep -E "Next block will be produced in:" | awk '{print $6}')
    external_ip=$(echo "$mina_status" | grep -E "External IP:" | awk '{print $3}')

    # Prepare the message
    message="Mina Status:
    - Block Height: $block_height
    - Local Uptime: $local_uptime
    - Peers: $peers
    - Sync Status: $sync_status
    - Block Producers Running: $producers_running
    - Next Block in: $next_block
    - External IP: $external_ip"

    # Send the result to the specified Telegram channel
    /usr/bin/curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$message"
else
    # If Mina status is empty, send an error message
    error_message="Failed to retrieve Mina status. Please check your Mina configuration and try again."
    /usr/bin/curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$error_message"
fi
