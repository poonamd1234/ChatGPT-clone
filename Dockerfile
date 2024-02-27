FROM debian:bookworm

# Change Debian mirror to http://ftp.us.debian.org/debian/
RUN sed -i 's/http:\/\/deb.debian.org\/debian\//http:\/\/ftp.us.debian.org\/debian\//' /etc/apt/sources.list

WORKDIR /aiBot

COPY . /aiBot/

RUN apt-get update && \
    apt-get install -y python3-dev && \
    chmod +x envSetup.sh && \
    ./envSetup.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8000

ENV DJANGO_SETTINGS_MODULE=django_chatbot.settings

CMD ["/aiBot/env/bin/gunicorn", "django_chatbot.wsgi:application", "--bind", "0.0.0.0:8000"]
