#!/bin/bash

# Print the current directory for debugging
echo "Current directory: $(pwd)"

# Check if qm.variables exists and source it
if [ -f /quorum-maker/qm.variables ]; then
    echo "Sourcing qm.variables..."
    source /quorum-maker/qm.variables
else
    echo "Error: qm.variables not found"
    exit 1
fi

# Fix for automatically exporting ports on Mac OS
os=$(uname)
if [ "$os" = "Darwin" ]; then
    touch /quorum-maker/.qm_export_ports
fi

# Check if the variable 'line' is set
if [ -z "$line" ]; then
    echo "Error: Variable 'line' is not set."
    exit 1
fi

# Run Docker container
docker run -it --rm -v $(pwd)/$line:/$(basename $(pwd)) -w /$(basename $(pwd)) $dockerImage lib/menu.sh "$@"

# Check if .nodename file exists and handle it
if [ -f .nodename ]; then
    nodename=$(cat .nodename)
    rm -f .nodename
    cd "$nodename"
    ./start.sh "$@"
else
    echo ".nodename file not found."
fi

