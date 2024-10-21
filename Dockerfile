# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set timezone
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required dependencies (adjust as necessary for your app)
RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip \
    git \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Copy the current code in the working directory (where the Dockerfile resides) into the container
COPY . /root/TeamUltroid/

# Copy installer script and execute it
COPY installer.sh /root/TeamUltroid/
RUN bash /root/TeamUltroid/installer.sh

# Change working directory to where the code is located
WORKDIR /root/TeamUltroid

# Expose necessary ports (if applicable)
# EXPOSE 8080

# Start the bot with the startup script
CMD ["bash", "startup"]
