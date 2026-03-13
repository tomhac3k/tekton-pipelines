# Use nginx unprivileged image (already configured for non-root)
FROM nginxinc/nginx-unprivileged:stable-alpine

# Copy website files
COPY ./html /usr/share/nginx/html

# Expose non-privileged port
EXPOSE 8080

# Container starts nginx automatically
