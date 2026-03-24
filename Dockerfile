# Use the minimal Red Hat UBI 9 micro image (arm64)
FROM registry.access.redhat.com/ubi9/ubi-micro:latest

# Install httpd
# Note: ubi-micro doesn't have a package manager, so we use ubi-minimal 
# if you need a truly 'micro' build, or just use ubi-minimal for simplicity.
FROM registry.access.redhat.com/ubi9/ubi-minimal:latest

RUN microdnf install -y httpd && \
    microdnf clean all

# OpenShift Requirement: Apache usually listens on 80 (root only). 
# We must change it to a non-privileged port like 8080.
RUN sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf && \
    chgrp -R 0 /var/log/httpd /var/run/httpd && \
    chmod -R g=u /var/log/httpd /var/run/httpd

# Optional: Add your content
# COPY index.html /var/www/html/index.html

# Use a non-root user (OpenShift will override this, but it's best practice)
USER 1001

EXPOSE 8080

CMD ["httpd", "-D", "FOREGROUND"]
