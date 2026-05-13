# 1. Sets the base image (a lightweight version of Python 3.10)
FROM python:3.10-slim

# 2. Creates and moves into the /app directory inside the container
WORKDIR /app

# 3. Updates the OS package manager, installs PostgreSQL drivers, and cleans up
# (The cleanup 'rm -rf' keeps the final image size smaller)
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# 4. Copies all files from your current local folder into the /app folder
COPY . .

# 5. Installs Python libraries without saving temporary download files (saves space)
RUN pip install --no-cache-dir -r requirements.txt

# 6. Mentions that the container is designed to be accessed on port 8000
EXPOSE 8000

# 7. Defines the command to run the database migrations and then start the server
CMD ["python". " manage.py", " migrate", "&&", "python", " manage.py", " runserver", " 0.0.0.0:8000"]
