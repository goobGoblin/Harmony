import os
import logging
import functions_framework
from flask import jsonify, request
import firebase_admin
from firebase_admin import credentials

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('main')

# Initialize Firebase Admin SDK if not already initialized
try:
    app = firebase_admin.get_app()
    logger.info("Firebase app already initialized")
except ValueError:
    # For deployment or emulator
    try:
        logger.info("Initializing Firebase app")
        firebase_admin.initialize_app()
    except Exception as e:
        logger.warning(f"Firebase initialization error: {e}")
        # Fallback to service account if available
        service_account_path = 'serviceAccountKey.json'
        if os.path.exists(service_account_path):
            logger.info(f"Initializing Firebase with service account: {service_account_path}")
            cred = credentials.Certificate(service_account_path)
            firebase_admin.initialize_app(cred)
        else:
            logger.error("No service account found and default initialization failed")

# Import Last.fm functions after Firebase is initialized
from lastfm import handle_auth_request, get_user_loved_tracks

@functions_framework.http
def lastfm_auth(request):
    """HTTP Cloud Function to authenticate with Last.fm API.
    
    Supports two methods:
    1. OAuth flow (GET to get auth URL, POST with token to complete)
    2. Direct username/password authentication (POST with username/password)
    """
    try:
        logger.info(f"Last.fm auth request: {request.method}")
        
        # CORS Headers for cross-origin requests
        if request.method == 'OPTIONS':
            # Handle preflight requests
            headers = {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Max-Age': '3600'
            }
            return ('', 204, headers)
            
        # Set CORS headers for the main request
        headers = {
            'Access-Control-Allow-Origin': '*'
        }
        
        # Handle the main request
        response = handle_auth_request(request)
        
        # If response is a tuple (response, status_code), add headers
        if isinstance(response, tuple):
            return (response[0], response[1], {**headers, **response[2]} if len(response) > 2 else headers)
        
        # If response is just the response object, add headers
        return (response, 200, headers)
        
    except Exception as e:
        logger.error(f"Error in lastfm_auth: {e}")
        return jsonify({
            "success": False,
            "error": str(e)
        }), 500, {'Access-Control-Allow-Origin': '*'}

@functions_framework.http
def lastfm_loved_tracks(request):
    """HTTP Cloud Function to get loved tracks from Last.fm."""
    try:
        # Only accept GET requests
        if request.method != 'GET':
            return jsonify({
                "success": False,
                "error": "Only GET method is supported"
            }), 405
            
        # Get Firebase UID from request
        firebase_uid = request.args.get('uid')
        
        if not firebase_uid:
            return jsonify({
                "success": False,
                "error": "Missing required parameter: uid"
            }), 400
            
        # Get loved tracks for the user
        result = get_user_loved_tracks(firebase_uid)
        
        if result.get("success", False):
            return jsonify(result)
        else:
            return jsonify(result), 400
            
    except Exception as e:
        logger.error(f"Error in lastfm_loved_tracks: {e}")
        return jsonify({
            "success": False,
            "error": str(e)
        }), 500

# Example of using HTTP On-Request for other functions
@functions_framework.http
def hello_world(request):
    """Simple HTTP function to test deployment."""
    return jsonify({
        "message": "Hello from Firebase Functions!",
        "firebase": "Initialized" if firebase_admin._apps else "Not initialized"
    })
