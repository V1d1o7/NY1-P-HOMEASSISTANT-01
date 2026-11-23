#!/bin/sh
# Outputs {"label_colors": [...]} for the label_colors command_line sensor (CL.yaml).
# The token is read from secrets.yaml at runtime so nothing sensitive lives in this file.
TOKEN=$(grep -E '^todoist_api_token:' /config/secrets.yaml | head -n 1 | cut -d: -f2- | tr -d " \"'\r")

printf '{"label_colors":%s}\n' "$(
    curl -s https://api.todoist.com/api/v1/labels \
        -H "Authorization: Bearer $TOKEN" \
        -H 'Accept: application/json' | jq '.results'
)"
