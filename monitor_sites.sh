#!/bin/bash

# Path to the file containing list of porn site domains
PORN_SITES_FILE="/path/to/porn_sites.txt"

# Path to the log file where we store detected visits
LOG_FILE="/path/to/alert_log.txt"

# Function to send an alert (e.g., an email or a system log entry)
send_alert() {
  local site="$1"
  echo "$(date): ALERT! Access to $site detected." >> "$LOG_FILE"
  # Here you can add more actions like sending an email or system notification
}

# Monitor network traffic (using tcpdump or similar tool)
# Replace 'eth0' with the appropriate network interface
tcpdump -l -n -i eth0 | while read -r line; do
  # Check each line of the output against the list of porn sites
  while IFS= read -r site; do
    if echo "$line" | grep -q "$site"; then
      send_alert "$site"
    fi
  done < "$PORN_SITES_FILE"
done
