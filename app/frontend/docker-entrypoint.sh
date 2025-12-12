#!/bin/sh
# Use envsubst to replace the ${BACKEND_API_URL} placeholder in index.html with the environment variable
# The syntax ${VAR_NAME} is used for standard environment variables.
envsubst '$$BACKEND_API_URL' < /usr/share/nginx/html/index.html > /tmp/index.html
mv /tmp/index.html /usr/share/nginx/html/index.html

# Start the Nginx process
exec nginx -g "daemon off;"