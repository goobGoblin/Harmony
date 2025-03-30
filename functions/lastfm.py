# functions/lastfm.py

import hashlib
import requests
from flask import jsonify
from firebase_admin import firestore

# Initialize Firestore client
db = firestore.client()

def get_lastfm_credentials():
    """Retrieve Last.fm API credentials from Firestore."""
    try:
        # Retrieve credentials from the LastFM document in Firestore
        config_doc = db.collection('Config').document('LastFM').get()
        
        if not config_doc.exists:
            raise ValueError("Last.fm configuration not found in Firestore")
            
        config_data = config_doc.to_dict()
        
        api_key = config_data.get('API_KEY')
        api_secret = config_data.get('SECRET')
        
        if not api_key or not api_secret:
            raise ValueError("Missing Last.fm API credentials in Firestore")
            
        return api_key, api_secret
    except Exception as e:
        raise Exception(f"Error retrieving Last.fm credentials: {str(e)}")

def handle_auth_request(request):
    """Handle Last.fm authentication request."""
    # Set CORS headers for the preflight request
    if request.method == 'OPTIONS':
        headers = {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET, POST',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Max-Age': '3600'
        }
        return ('', 204, headers)
    
    # Set CORS headers for the main request
    headers = {'Access-Control-Allow-Origin': '*'}
    
    try:
        # Get Last.fm API credentials from Firestore
        try:
            LASTFM_API_KEY, LASTFM_API_SECRET = get_lastfm_credentials()
        except Exception as e:
            return jsonify({'success': False, 'error': str(e)}), 500, headers
            
        LASTFM_AUTH_URL = "https://ws.audioscrobbler.com/2.0/"
        
        request_json = request.get_json(silent=True)
        
        if not request_json:
            return jsonify({'success': False, 'error': 'No JSON data provided'}), 400, headers
        
        # Check if username and password are provided
        username = request_json.get('username')
        password = request_json.get('password')
        
        if not username or not password:
            return jsonify({'success': False, 'error': 'Username and password are required'}), 400, headers
        
        # Generate API signature for Last.fm authentication
        api_sig = generate_api_signature({
            'method': 'auth.getMobileSession',
            'username': username,
            'password': password,
            'api_key': LASTFM_API_KEY
        }, LASTFM_API_SECRET)
        
        # Request body for Last.fm authentication
        payload = {
            'method': 'auth.getMobileSession',
            'username': username,
            'password': password,
            'api_key': LASTFM_API_KEY,
            'api_sig': api_sig,
            'format': 'json'
        }
        
        # Send request to Last.fm API
        response = requests.post(LASTFM_AUTH_URL, data=payload)
        lastfm_data = response.json()
        
        # Check if authentication was successful
        if 'error' in lastfm_data:
            return jsonify({
                'success': False,
                'error': lastfm_data.get('message', 'Authentication failed')
            }), 401, headers
        
        # Extract session key from response
        session_key = lastfm_data.get('session', {}).get('key')
        
        if not session_key:
            return jsonify({
                'success': False,
                'error': 'Failed to retrieve session key'
            }), 500, headers
        
        # Return success response with the session key
        return jsonify({
            'success': True,
            'message': 'Last.fm authentication successful',
            'username': username,
            'session_key': session_key
        }), 200, headers
    
    except Exception as e:
        return jsonify({
            'success': False, 
            'error': f'An error occurred: {str(e)}'
        }), 500, headers

def generate_api_signature(params, api_secret):
    """Generate Last.fm API call signature."""
    # Sort keys alphabetically as required by Last.fm
    sorted_keys = sorted(params.keys())
    
    # Concatenate parameters
    signature = ''.join([f"{k}{params[k]}" for k in sorted_keys])
    
    # Append API secret
    signature += api_secret
    
    # Create MD5 hash
    return hashlib.md5(signature.encode('utf-8')).hexdigest()
