#!/bin/bash

#URL of the application
APP_URL="http://example.com"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

check_application_status() {
    http_status=$(curl -s -o /dev/null -w "%{http_code}" "$APP_URL")

    if [ "$http_status" -eq 200 ]; then
        log "Application is UP. HTTP Status Code: $http_status"
    else
        log "Application is DOWN. HTTP Status Code: $http_status"
    fi
}


check_application_status
