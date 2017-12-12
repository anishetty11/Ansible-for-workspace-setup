FROM ubuntu
MAINTAINER sois

# If using a proxy server, uncomment the below line, and modify the proxy
# address and port number
# RUN echo "Acquire::http::Proxy "http:172.16.19.10:80";" | cat > /etc/apt/apt.conf
RUN apt-get update
RUN apt-get install -y apache2

EXPOSE 80

CMD ["apache2ctl","-D","FOREGROUND"]
