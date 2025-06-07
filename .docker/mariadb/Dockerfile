FROM mariadb:11.7.2

RUN apt update && apt -y upgrade && apt install pv && apt autoremove && apt clean

RUN useradd -m -u 1000 dockerUser
