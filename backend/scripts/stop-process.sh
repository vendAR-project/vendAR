#!/bin/bash
sudo chmod +x stop-process.sh
# Check if any processes are running before attempting to kill them
if pgrep -f "java -jar vendar-0.0.1-SNAPSHOT.jar" > /dev/null; then
    # Processes are running, so proceed to kill them
    
    ps -ef | grep vendar-0.0.1-SNAPSHOT.jar | grep -v grep | awk '{print $2}' | xargs kill
else
    # No processes are running, so no need to kill them
    echo "No processes found to kill. Deployment will proceed."
fi