FROM jenkins/jenkins:lts

USER root

# Modernized installation block:
# 1. Removes the unneeded software-properties-common package
# 2. Dynamically fetches your Mac's architecture (arm64) using dpkg
# 3. Dynamically identifies the underlying Debian version name
RUN apt-get update -y && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update -y && \
    apt-get install -y docker-ce docker-ce-cli containerd.io && \
    apt-get clean

# Create docker group if it doesn't exist and append jenkins user to it
RUN groupadd -f docker && \
    usermod -aG docker jenkins

# Setup storage layer boundaries
RUN mkdir -p /var/lib/docker
VOLUME /var/lib/docker

# Revert execution space to the safe unprivileged jenkins user context
USER jenkins