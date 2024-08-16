FROM quorumengineering/quorum-maker:latest

# Create the /quorum-maker directory if it doesn't exist
RUN mkdir -p /quorum-maker

# Copy setup.sh and qm.variables into the container
COPY setup.sh /quorum-maker/setup.sh
COPY qm.variables /quorum-maker/qm.variables

# Set permissions
RUN chmod +x /quorum-maker/setup.sh

# Set the working directory
WORKDIR /quorum-maker

# Define the entrypoint
ENTRYPOINT ["/quorum-maker/setup.sh"]

