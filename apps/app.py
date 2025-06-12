from flask import Flask, jsonify
import requests
import socket
from datetime import datetime
import os
import logging
from dotenv import load_dotenv

load_dotenv()
# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = Flask(__name__)

# Configuration
WEATHER_API_KEY = os.getenv('WEATHER_API_KEY')
WEATHER_API_URL = 'https://api.openweathermap.org/data/2.5/weather'
API_VERSION = os.getenv('RELEASE_VERSION', '0.0.1')
REQUEST_TIMEOUT = 5

def format_datetime():
    """Format current datetime as YYMMDDHHmm"""
    now = datetime.now()
    return now.strftime('%y%m%d%H%M')

def get_hostname():
    """Get system hostname"""
    try:
        return socket.gethostname()
    except:
        return 'server1'

def get_weather_data():
    """Fetch weather data from OpenWeatherMap API"""
    try:
        params = {
            'q': 'Dhaka,BD',
            'appid': WEATHER_API_KEY,
            'units': 'metric'
        }
        
        response = requests.get(
            WEATHER_API_URL, 
            params=params, 
            timeout=REQUEST_TIMEOUT
        )
        response.raise_for_status()
        
        data = response.json()
        return {
            'temperature': str(round(data['main']['temp'])),
            'temp_unit': 'c'
        }
    except requests.exceptions.RequestException as e:
        logger.error(f'Weather API error: {e}')
        # Return fallback data if API fails
        return {
            'temperature': '25',
            'temp_unit': 'c'
        }
    except Exception as e:
        logger.error(f'Unexpected error getting weather data: {e}')
        return {
            'temperature': '25',
            'temp_unit': 'c'
        }

def check_weather_api_health():
    """Check if weather API is reachable"""
    try:
        params = {
            'q': 'Dhaka,BD',
            'appid': WEATHER_API_KEY,
            'units': 'metric'
        }
        
        response = requests.get(
            WEATHER_API_URL, 
            params=params, 
            timeout=3
        )
        return response.status_code == 200
    except:
        return False

@app.route('/')
def root():
    """Root endpoint with API information"""
    return jsonify({
        'message': 'Weather REST API',
        'version': API_VERSION,
        'endpoints': [
            'GET /api/hello - Main API endpoint with weather data',
            'GET /api/health - Health check endpoint',
            'GET / - This endpoint'
        ]
    })

@app.route('/api/hello')
def api_hello():
    """Main API endpoint returning hostname, datetime, version and weather data"""
    try:
        weather_data = get_weather_data()
        
        response_data = {
            'hostname': get_hostname(),
            'datetime': format_datetime(),
            'version': API_VERSION,
            'weather': {
                'dhaka': weather_data
            }
        }
        
        return jsonify(response_data)
    
    except Exception as e:
        logger.error(f'Error in /api/hello: {e}')
        return jsonify({
            'error': 'Internal server error',
            'message': 'Failed to fetch data'
        }), 500

@app.route('/api/health')
def api_health():
    """Health check endpoint"""
    try:
        # Check weather API health
        weather_api_healthy = check_weather_api_health()
        
        health_status = {
            'status': 'ok' if weather_api_healthy else 'degraded',
            'timestamp': datetime.now().isoformat(),
            'hostname': get_hostname(),
            'version': API_VERSION,
            'services': {
                'api': 'healthy',
                'weather_api': 'healthy' if weather_api_healthy else 'unhealthy'
            }
        }
        
        status_code = 200 if weather_api_healthy else 503
        return jsonify(health_status), status_code
        
    except Exception as e:
        logger.error(f'Error in health check: {e}')
        return jsonify({
            'status': 'error',
            'timestamp': datetime.now().isoformat(),
            'hostname': get_hostname(),
            'error': str(e),
            'services': {
                'api': 'error',
                'weather_api': 'error'
            }
        }), 503

@app.errorhandler(404)
def not_found(error):
    """Handle 404 errors"""
    return jsonify({
        'error': 'Not Found',
        'message': 'The requested endpoint was not found'
    }), 404

@app.errorhandler(500)
def internal_error(error):
    """Handle 500 errors"""
    return jsonify({
        'error': 'Internal Server Error',
        'message': 'An unexpected error occurred'
    }), 500

if __name__ == '__main__':
    port = int(os.getenv('PORT', 5000))
    debug = os.getenv('FLASK_ENV') == 'development'
    
    print(f"Starting Weather REST API on port {port}")
    print(f"Health check: http://localhost:{port}/api/health")
    print(f"Main endpoint: http://localhost:{port}/api/hello")
    
    app.run(host='0.0.0.0', port=port, debug=debug)