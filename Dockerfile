FROM ubuntu:latest

# Install cowsay and fortune
RUN apt-get update && \
    apt-get install -y fortune-mod cowsay netcat&& \
    rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the script into the container
COPY wisecow.sh /app/wisecow.sh

# Make the script executable
RUN chmod +x /app/wisecow.sh

# Expose the port the service runs on
EXPOSE 4499

# Run the script when the container starts
CMD ["/app/wisecow.sh"]
