FROM nginx:1.25 AS PROD

# setup node
RUN apt-get update && apt-get install -y ca-certificates curl gnupg
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update && apt-get install nodejs -y && apt-get install -y git

# Install rue-ui without pip-installing GDAL
RUN git clone --branch updates --single-branch https://github.com/kartoza/rue-ui.git /app

WORKDIR /app

RUN npm install

# Copy nginx config
COPY deployment/ui/default.conf /etc/nginx/conf.d/default.conf

# Copy entrypoint script
COPY deployment/ui/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose nginx port
EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

# ============================
# DEV
# ============================
FROM prod AS dev

EXPOSE 5173

