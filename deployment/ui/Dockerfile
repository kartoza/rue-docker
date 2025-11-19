FROM nginx:1.25 AS PROD

# setup node
RUN apt-get update && apt-get install -y ca-certificates curl gnupg
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update && apt-get install nodejs -y && apt-get install -y git

# Install rue-ui without pip-installing GDAL
RUN git clone https://github.com/kartoza/rue-ui.git /app

# ENV
ARG VITE_API_URL
ARG VITE_MAPBOX_TOKEN

ENV VITE_API_URL=$VITE_API_URL
ENV VITE_MAPBOX_TOKEN=$VITE_MAPBOX_TOKEN

WORKDIR /app

RUN npm install
RUN npm run build

# Deploy build to nginx
RUN rm -rf /usr/share/nginx/html/* && \
    cp -r dist/* /usr/share/nginx/html/


COPY deployment/ui/default.conf /etc/nginx/conf.d/default.conf

# Expose nginx port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

# ============================
# DEV
# ============================
FROM prod AS dev

EXPOSE 5173

