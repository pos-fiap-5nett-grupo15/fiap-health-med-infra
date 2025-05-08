FROM mcr.microsoft.com/mssql/server:2017-latest

RUN apt-get update
RUN apt-get install -y gettext-base
# Create a config directory
RUN mkdir -p /usr/config
WORKDIR /usr/config

# Bundle config source
COPY . /usr/config


# Grant permissions
RUN chmod 111 /usr/config/entrypoint.sh /usr/config/configure-db.sh

#add mssql user
RUN groupadd -g 10001 mssql && \
    useradd -u 10001 -g mssql -s /bin/bash -m mssql

USER mssql

ENTRYPOINT ["./entrypoint.sh"]