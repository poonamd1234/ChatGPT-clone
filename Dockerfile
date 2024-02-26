FROM python:3.10-slim

WORKDIR /aiBot

COPY . /aiBot/

# Install dos2unix and convert line endings to Unix format
RUN apt-get update && \
    apt-get install dos2unix -y && \
    dos2unix envSetup.sh && \
    apt-get remove --purge dos2unix -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install dependencies and set up environment
RUN apt-get update && \
    apt-get install python3-dev -y && \
    chmod +x envSetup.sh && \
    ./envSetup.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8000

ENV DJANGO_SETTINGS_MODULE=django_chatbot.settings

CMD ["/aiBot/env/bin/gunicorn", "django_chatbot.wsgi:application", "--bind", "0.0.0.0:8000"]
