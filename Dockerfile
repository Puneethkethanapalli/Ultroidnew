# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables for time zone and install dependencies
ENV TZ=Asia/Kolkata

# Install necessary dependencies, including tzdata for time zone handling
RUN apt-get update && \
    apt-get install -y \
    tzdata \
    python3 \
    python3-pip \
    git \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Configure the timezone correctly
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Copy the application code and .env file into the container
COPY . /root/TeamUltroid/
COPY .env /root/TeamUltroid/

# Install dependencies via the installer script
COPY installer.sh /root/TeamUltroid/
RUN bash /root/TeamUltroid/installer.sh

# Load environment variables from the .env file
RUN set -o allexport; source /root/TeamUltroid/.env; set +o allexport

# Set working directory to where the code is located
WORKDIR /root/TeamUltroid

# Expose necessary ports (if applicable)
# EXPOSE 8080

# Start the bot with the startup script
CMD ["bash", "startup"]
