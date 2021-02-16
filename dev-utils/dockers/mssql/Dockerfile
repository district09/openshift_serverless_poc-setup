FROM microsoft/mssql-server-linux:latest

USER root

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV ACCEPT_EULA=y
ENV SA_PASSWORD=DEV-pw-123

# Bundle app source
COPY . /usr/src/app

# Remove windows carriage returns from scripts
RUN sed -i 's/\r$//' ./*.sh

# Grant permissions for the import-data script to be executable
RUN chmod +x ./*.sh

CMD /bin/bash ./entrypoint.sh

RUN echo $ACCEPT_EULA
