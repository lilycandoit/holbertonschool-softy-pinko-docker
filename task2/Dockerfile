# Use the latest Nginx image as the base
FROM nginx:latest

# Copy the HTML, CSS, and JS files to the Nginx html directory
COPY ./index.html /usr/share/nginx/html/index.html
COPY ./styles.css /usr/share/nginx/html/styles.css
COPY ./script.js /usr/share/nginx/html/script.js

# Expose port 80 for the web server
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]