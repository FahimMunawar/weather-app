# Use official Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Set the working directory to apps/
WORKDIR /app/apps

# Command to run the app
CMD ["python", "app.py"]
