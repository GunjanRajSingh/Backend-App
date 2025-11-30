FROM python:3.9-slim

# Install required tools
RUN apt-get update && apt-get install -y curl gnupg apt-transport-https

# Add Microsoft repo
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list

# Install ODBC drivers
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc unixodbc-dev

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
