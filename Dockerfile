FROM debian:bullseye-slim

WORKDIR /opt/pgtde/

ENV POSTGRES_USER=postgresql
ENV POSTGRES_PASSWORD=changeme
ENV POSTGRES_DB_NAME=postgresql
ENV POSTGRES_PORT=5432
ENV POSTGRES_TDE_KEY=THIS_IS_A_SUPER_SECRET_KEY

COPY scripts/*.sh /opt/pgtde/

RUN chmod +x /opt/pgtde/*.sh

RUN apt-get update && \
  apt-get install -y make tar curl gcc readline-common libreadline-dev lib32z1 lib32z1-dev perl libperl-dev python python-dev tcl gettext libssl-dev bison flex

RUN curl -o tde.tar.gz https://download.cybertec-postgresql.com/postgresql-12.3_TDE_1.0.tar.gz && \
  tar -zxf tde.tar.gz && \
  mkdir tde && \
  tar -zxf tde.tar.gz -C tde --strip-components 1 && \
  cd tde && \
  ./configure --prefix=/usr/local/pg12tde --with-openssl --with-perl --with-python && \
  make install && \
  cd contrib && \
  make install

RUN adduser --disabled-password --gecos "" --no-create-home postgresql

RUN mkdir -p /var/lib/pgsql/data

RUN chown -R postgresql:postgresql /var/lib/pgsql
RUN chown -R postgresql:postgresql /opt/pgtde

RUN ln -sf /proc/1/fd/1 /var/lib/pgsql/logfile

EXPOSE 5432

USER postgresql

RUN echo "listen_addresses = '*'" >> /var/lib/pgsql/data/postgresql.conf && \
  echo "port = ${POSTGRES_PORT}" >> /var/lib/pgsql/data/postgresql.conf && \
  echo "host  all all   0.0.0.0/0   md5" >> /var/lib/pgsql/data/pg_hba.conf && \
  echo "host  all all   ::/0   md5" >> /var/lib/pgsql/data/pg_hba.conf 

ENTRYPOINT /opt/pgtde/entrypoint.sh