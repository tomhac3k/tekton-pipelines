# Use nginx unprivileged image (already configured for non-root)
FROM nginxinc/nginx-unprivileged:alpine3.23-perl

# Copy website files
COPY index.html /usr/share/nginx/html

# Expose non-privileged port
EXPOSE 8080

# Container starts nginx automatically
