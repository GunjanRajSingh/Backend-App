FROM python:3.9

WORKDIR /app

# Your commands rewritten for Docker environment
RUN apt-get update && \
    apt-get install -y curl gnupg unixodbc unixodbc-dev && \
    curl https://packages.microsoft.com/keys/microsoft.asc \
        -o /usr/share/keyrings/microsoft.gpg && \
    curl https://packages.microsoft.com/config/debian/12/prod.list \
        > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql17 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy your project
COPY . .

# pip install (your command)
RUN pip install -r requirements.txt

# Run uvicorn (your command)
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
