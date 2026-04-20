# Image de base
FROM debian:bookworm-slim

# Metadata
LABEL maintainer="hugo.bourhis@viacesi.fr"
LABEL description="Image LAMP simple"

# Mode non interactif
ENV DEBIAN_FRONTEND=noninteractive

# Installer Apache + PHP
RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    libapache2-mod-php \
    && apt-get clean

# Fix warning Apache (ServerName)
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Supprimer la page par défaut
RUN rm -rf /var/www/html/index.html

# Dossier de travail
WORKDIR /var/www/html

# Copier les fichiers
COPY . /var/www/html

# Port
EXPOSE 80

# Lancer Apache
CMD ["apachectl", "-D", "FOREGROUND"]
