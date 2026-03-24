# Use the lightweight Alpine version of the official httpd image
FROM arm64v8/httpd:alpine

# Optional: Copy your custom HTML files into the default Apache public folder
COPY ./index.html /usr/local/apache2/htdocs/index.html

# Expose port 80
EXPOSE 80
