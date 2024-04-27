#!/bin/bash
sudo chmod +x stop-process.sh
ps -ef | grep vendar-0.0.1-SNAPSHOT.jar | grep -v grep | awk '{print $2}' | xargs kill