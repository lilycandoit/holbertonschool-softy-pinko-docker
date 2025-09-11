# Use the latest Nginx image as the base
FROM nginx:latest

# Copy static files to Nginx's HTML directory
# The trailing slash on the source directory is important to copy its contents.
COPY ./softy-pinko-front-end/ /var/www/html/softy-pinko-front-end/

# Copy your Nginx config file to the proper location
COPY ./softy-pinko-front-end.conf /etc/nginx/conf.d/default.conf

# Expose port 9000 for the web server
EXPOSE 9000

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]