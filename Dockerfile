# Use the official Ubuntu 20.04 image as a base
FROM ubuntu:20.04

# Set the environment variable to prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install required packages (MySQL server, Python, etc.)
RUN apt-get update && apt-get install -y \
    mysql-server \
    python3-pip \
    python3-setuptools \
    && rm -rf /var/lib/apt/lists/*  # Clean up temporary files to reduce image size

# Install Python requirements
RUN pip3 install --upgrade pip

# Copy requirements.txt into the image
COPY requirements.txt /app/requirements.txt

# Install the dependencies from the requirements.txt
RUN pip3 install -r /app/requirements.txt

# Copy your files into the Docker image
COPY . /app

# Set the working directory to the copied files
WORKDIR /app

# Expose MySQL default port
EXPOSE 3306

# Start MySQL service and any other necessary services or commands
CMD service mysql start && tail -f /dev/null

