#!/bin/bash

# run_from_hub.sh (for Linux/macOS)

echo "Project is being launched using images from Docker Hub..."
echo "To access the application: http://localhost:5000"

echo "To quit from app press Ctrl+C"

# Open the Streamlit app in the default browser based on the OS
echo "Opening application in browser..."
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux (e.g., Ubuntu, Debian, Fedora, WSL)
    xdg-open http://localhost:5000 &> /dev/null
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    open http://localhost:5000
else
    echo "Unsupported OS for automatic browser opening."
fi

# Uses the compose file prepared for deployment
# Start services in the foreground and ensure they stop when the terminal closes.
docker-compose -f docker-compose.prod.yml up

# The 'docker-compose up' command above will stop when Ctrl+C is pressed or the terminal is closed.
# The line below cleans up containers and networks after services are stopped.
echo "Services are being stopped and cleaned up..."
docker-compose -f docker-compose.prod.yml down --volumes --remove-orphans

echo "Operation complete. Ctrl+C to quit"

# This command acts like 'pause' in batch files.
# It waits for the user to press any key before the script exits.
read -n 1 -s -r -p "Press any key to quit..."
echo # Add a newline after the "Press any key" prompt for cleaner output.

# Exit the script
exit 0