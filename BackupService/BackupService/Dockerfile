FROM ubuntu:latest

RUN apt-get update && apt-get install -y cron postgresql-client dotnet-runtime-8.0 dotnet-sdk-8.0

COPY BackupService/backup_start.sh /app/backup_start.sh

RUN chmod +x /app/backup_start.sh

ENV BACKUP_DELAY=5

RUN echo 'SHELL=/bin/bash' > /etc/cron.d/backup-cron && \
    echo 'PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin' >> /etc/cron.d/backup-cron && \
    echo "0 */${BACKUP_DELAY} * * * root /app/backup_start.sh >> /var/log/cron.log 2>&1" >> /etc/cron.d/backup-cron && \
    chmod 0644 /etc/cron.d/backup-cron && \
    crontab /etc/cron.d/backup-cron && \
    touch /var/log/cron.log

CMD service cron start && tail -f /var/log/cron.log

WORKDIR /app

ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["BackupService/BackupService.csproj", "BackupService/"]
RUN dotnet restore "BackupService/BackupService.csproj"
COPY . .
WORKDIR "/src/BackupService"
RUN dotnet build "BackupService.csproj" -c $BUILD_CONFIGURATION -o /app/build
