FROM curlimages/curl:latest AS builder
WORKDIR /downloads

# download d3 and replace the download url in the index file
COPY docs/index.html index.html
RUN curl -L --no-progress-meter -o d3.js https://d3js.org/d3.v4.min.js
RUN sed -i 's|<script src="https://d3js.org/d3.v4.min.js"></script>|<script src="d3.js"></script>|' index.html

# download nginx prometheus exporter
ARG NGINX_EXPORTER_VERSION=1.3.0
RUN curl -L --no-progress-meter -o nginx-prometheus-exporter.tar.gz https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v${NGINX_EXPORTER_VERSION}/nginx-prometheus-exporter_${NGINX_EXPORTER_VERSION}_linux_amd64.tar.gz && \
    tar -xzvf nginx-prometheus-exporter.tar.gz && \
    chmod +x nginx-prometheus-exporter

FROM nginxinc/nginx-unprivileged:stable-alpine
COPY deployment/nginx.conf /etc/nginx/conf.d/default.conf
COPY docs/*.js /usr/share/nginx/html/
COPY docs/*.css /usr/share/nginx/html/
COPY --from=builder /downloads/d3.js /usr/share/nginx/html/d3.js
COPY --from=builder /downloads/index.html /usr/share/nginx/html/index.html
COPY --from=builder /downloads/nginx-prometheus-exporter /usr/local/bin/nginx-prometheus-exporter

CMD ["sh", "-c", "nginx -g 'daemon off;' & nginx-prometheus-exporter --web.listen-address=:9113"]
