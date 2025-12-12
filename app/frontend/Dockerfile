FROM nginx:alpine

# Install tools needed for variable injection (gettext provides envsubst)
RUN apk add --no-cache bash gettext

# Copy files
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/
COPY docker-entrypoint.sh /

# Make the script executable
RUN chmod +x /docker-entrypoint.sh

# Set the entrypoint to run the injection script before starting Nginx
ENTRYPOINT ["/docker-entrypoint.sh"]