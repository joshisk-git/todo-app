# 1. Sets the base operating system and environment
FROM python:3.10-slim

# 2. Creates and sets the active directory inside the container
WORKDIR /app

# 3. Moves your code from your computer into the container
COPY . .

# 4. Downloads and installs the "brains" of your app
RUN pip install --no-cache-dir -r requirements.txt

# 5. Tells Docker which port the app listens on (documentation only)
EXPOSE 8000

# 6. The actual command that starts your application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
