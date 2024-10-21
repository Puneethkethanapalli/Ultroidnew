# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables for time zone
ENV TZ=Asia/Kolkata

# Install necessary dependencies, including tzdata, python3, pip3, virtualenv, and screen (if required)
RUN apt-get update && \
    apt-get install -y \
    tzdata \
    python3 \
    python3-pip \
    python3-dev \
    git \
    curl \
    bash \
    virtualenv \
    screen \
    && rm -rf /var/lib/apt/lists/*

# Configure the timezone correctly
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set the working directory for your app
WORKDIR /root/TeamUltroid

# Copy the application code and necessary files into the container
COPY . /root/TeamUltroid/

# Install Python dependencies from requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

# Install dependencies from re*/st*/op*.txt files
RUN pip3 install --no-cache-dir -r re*/st*/op*.txt

# Optionally create and activate a virtual environment (this is optional and depends on your needs)
# RUN python3 -m venv /root/TeamUltroid/venv
# RUN /bin/bash -c "source /root/TeamUltroid/venv/bin/activate"

# Expose any ports if required (you can add this if your app listens on a specific port)
# EXPOSE 8080

# Run the bot with the provided Python module
CMD ["python3", "-m", "pyUltroid"]
