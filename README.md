# 🌦️ Weather App

A simple Python-based weather application that fetches and displays current weather data using a public API.

## 📁 Project Structure

weather-app/

├── apps/

│ └── app.py

├── requirements.txt

├── Dockerfile

├── docker-compose.yaml

├── .env

└── README.md


## 🚀 Features

- Fetches live weather data from OpenWeatherMap API
- Lightweight and containerized using Docker
- Configurable via environment variable (`WEATHER_API_KEY`)

## 🔧 Requirements

- Python 3.11+
- Docker
- (Optional) Docker Compose

## ⚙️ Setup & Run

### 🐳 Run with Docker

1. Build the image:
   ```bash
   docker build -t weather-app .

2. Run the container:
    ```bash
    docker run --env-file .local-env -p 5000:5000 weather-app

### 🐳 Run with Docker Compose (Recommended)

Build and start the app:

``` bash
docker compose up --build