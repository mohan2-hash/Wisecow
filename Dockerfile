# Use an appropriate base image with a lightweight OS
FROM debian:stable-slim

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    netcat-openbsd \
    fortune-mod \
    cowsay \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Add /usr/games to the PATH environment variable
ENV PATH="/usr/games:${PATH}"

#Setting working directory
WORKDIR /usr/src/app

# Copy the application into the container
COPY . .

# Make the shell script executable
RUN chmod +x wisecow.sh

# Expose the port the server will run on
EXPOSE 4499

# Set the entrypoint to run the shell script
ENTRYPOINT ["./wisecow.sh"]
