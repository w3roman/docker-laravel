FROM mariadb:11.8.6

RUN apt update && \
    apt upgrade -y && \
    apt install -y --no-install-recommends pv && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 1000 dockerUser
