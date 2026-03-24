# Use the RHEL 9 Universal Base Image
FROM registry.access.redhat.com/ubi9/ubi:latest

# Install httpd and clean metadata to keep the image small
RUN dnf install -y httpd && \
    dnf clean all

# Copy your local website files into the default Apache document root
# Ensure your 'index.html' is in the same folder as this Containerfile
COPY ./index.html /var/www/html/index.html

# OpenShift/Kubernetes specific: 
# Change permissions so the 'root' group can read/write.
# OpenShift runs containers with a random UID that belongs to the root group.
RUN chown -R apache:root /var/www/html && \
    chmod -R g+w /var/www/html

# Expose port 8080 (standard for non-root Apache)
EXPOSE 8080

# Change the default port from 80 to 8080 in the config file
# (Ports below 1024 require root privileges, which OpenShift stays away from)
RUN sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf

# Start the Apache server in the foreground
CMD ["httpd", "-D", "FOREGROUND"]
