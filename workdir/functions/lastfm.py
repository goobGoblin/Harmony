import hashlib
import requests
import logging
import json
from flask import jsonify, Request
import firebase_admin
from firebase_admin import firestore
import pylast
import time
import os

# Configure logging
logger = logging.getLogger('lastfm')
logger.setLevel(logging.INFO)

# Try to connect to firebase app and print error upon failure
try:
    db = firestore.client()
except Exception as e:
    logger.error(f"Could not initialize Firestore client: {e}")
    db = None

def get_lastfm_credentials():
    """Retrieve Last.fm API credentials from Firestore."""
    try:
        # Retrieve credentials from the LastFM document in Firestore
        config_doc = db.collection('Private').document('LastFM').get()
        
        if not config_doc.exists:
            raise ValueError("Last.fm configuration not found in Firestore")
            
        config_data = config_doc.to_dict()
        
        api_key = config_data.get('API_KEY')
        api_secret = config_data.get('SECRET')
        
        if not api_key or not api_secret:
            raise ValueError("Missing Last.fm API credentials in Firestore")
            
        return api_key, api_secret
    except Exception as e:
        logger.error(f"Error retrieving Last.fm credentials: {str(e)}")
        raise Exception(f"Error retrieving Last.fm credentials: {str(e)}")

def generate_api_signature(params, secret):
    """
    Generate a Last.fm API call signature
    
    Args:
        params (dict): Parameters for the API call
        secret (str): API secret
    
    Returns:
        str: The API signature
    """
    # Sort the parameter names alphabetically
    sorted_keys = sorted(params.keys())
    
    # Concatenate parameter name and value pairs
    signature_string = ''.join([f"{k}{params[k]}" for k in sorted_keys])
    
    # Append the secret
    signature_string += secret
    
    # Create md5 hash
    return hashlib.md5(signature_string.encode('utf-8')).hexdigest()

def lastfm_connect(username=None, password_hash=None):
    """Connect to Last.fm API using the application credentials."""
    try:
        api_key, api_secret = get_lastfm_credentials()
        
        network = pylast.LastFMNetwork(
            api_key=api_key,
            api_secret=api_secret,
            username=username,
            password_hash=password_hash
        )
        return network
    except Exception as e:
        logger.error(f"Failed to connect to Last.fm: {e}")
        raise

def get_auth_url():
    """
    Get a Last.fm authorization URL for the application.
    
    Returns:
        str: The authorization URL
    """
    api_key, _ = get_lastfm_credentials()
    callback_url = "https://us-central1-EECS-582-Projectcloudfunctions.net/lastfm_callback"
    return f"https://www.last.fm/api/auth/?api_key={api_key}&cb={callback_url}"

def get_session_key(token):
    """
    Exchange a token for a session key
    
    Args:
        token (str): The token received from Last.fm auth callback
    
    Returns:
        str: The session key
    """
    api_key, api_secret = get_lastfm_credentials()
    
    params = {
        "api_key": api_key,
        "method": "auth.getSession",
        "token": token
    }
    
    # Generate API signature
    params["api_sig"] = generate_api_signature(params, api_secret)
    
    # Add format parameter after generating signature (per Last.fm docs)
    params["format"] = "json"
    
    response = requests.get("https://ws.audioscrobbler.com/2.0/", params=params)
    
    if response.status_code != 200:
        logger.error(f"Error getting session key: {response.text}")
        raise Exception(f"Error getting session key: {response.text}")
    
    data = response.json()
    
    if "error" in data:
        logger.error(f"Last.fm error: {data['message']}")
        raise Exception(f"Last.fm error: {data['message']}")
    
    return data["session"]["key"]

def authenticate_with_password(username, password, firebase_uid):
    """
    Authenticate with Last.fm using username and password
    
    Args:
        username (str): Last.fm username
        password (str): Last.fm password
        firebase_uid (str): Firebase user ID
    
    Returns:
        dict: Result of authentication
    """
    try:
        # Create MD5 hash of password (required by Last.fm)
        password_hash = hashlib.md5(password.encode('utf-8')).hexdigest()
        
        # Connect to Last.fm
        network = lastfm_connect(username, password_hash)
        
        # Verify credentials by fetching user info
        user = network.get_user(username)
        
        # Try to perform a simple operation to verify authentication
        user_info = {'name': user.get_name()}
        
        # The authentication was successful, get a session key
        api_key, api_secret = get_lastfm_credentials()
        
        params = {
            "api_key": api_key,
            "method": "auth.getMobileSession",
            "username": username,
            "password": password_hash
        }
        
        # Generate API signature
        params["api_sig"] = generate_api_signature(params, api_secret)
        
        # Add format parameter after generating signature
        params["format"] = "json"
        
        response = requests.post("https://ws.audioscrobbler.com/2.0/", data=params)
        
        if response.status_code != 200:
            logger.error(f"Error getting session key: {response.text}")
            raise Exception(f"Error getting session key: {response.text}")
        
        data = response.json()
        
        if "error" in data:
            logger.error(f"Last.fm error: {data.get('message', 'Unknown error')}")
            raise Exception(f"Last.fm error: {data.get('message', 'Unknown error')}")
        
        # Extract session key
        session_key = data["session"]["key"]
        
        # Store the session key in Firebase
        if db:
            # Update user document
            db.collection('Users').document(firebase_uid).set({
                'Linked Accounts': {
                    'LastFM': [True, session_key]
                }
            }, merge=True)
            
            return {
                "success": True,
                "message": "Last.fm account linked successfully",
                "username": username,
                "session_key": session_key
            }
        else:
            return {
                "success": False,
                "error": "Firestore database connection not available"
            }
            
    except Exception as e:
        logger.error(f"Error authenticating with LastFM: {str(e)}")
        return {
            "success": False,
            "error": f"Authentication failed: {str(e)}"
        }

def handle_auth_request(request):
    """
    Handle Last.fm authentication request
    
    Args:
        request (Request): The HTTP request object
    
    Returns:
        Response: HTTP response
    """
    try:
        if request.method == 'GET':
            # Generate auth URL and redirect user
            auth_url = get_auth_url()
            return jsonify({
                "success": True,
                "auth_url": auth_url
            })
        
        elif request.method == 'POST':
            data = request.get_json()
            
            if not data:
                return jsonify({
                    "success": False,
                    "error": "Missing request data"
                }), 400
                
            # Check which authentication method to use
            if 'username' in data and 'password' in data and 'firebase_uid' in data:
                # Username/password authentication
                result = authenticate_with_password(
                    data['username'], 
                    data['password'],
                    data['firebase_uid']
                )
                
                if result["success"]:
                    return jsonify(result)
                else:
                    return jsonify(result), 400
                    
            elif 'token' in data and 'firebase_uid' in data:
                # OAuth token authentication
                token = data['token']
                firebase_uid = data['firebase_uid']
                
                # Get session key from Last.fm
                session_key = get_session_key(token)
                
                # Store the session key in Firebase
                if db:
                    # Update user document
                    db.collection('Users').document(firebase_uid).set({
                        'Linked Accounts': {
                            'LastFM': [True, session_key]
                        }
                    }, merge=True)
                    
                    return jsonify({
                        "success": True,
                        "message": "Last.fm account linked successfully"
                    })
                else:
                    return jsonify({
                        "success": False,
                        "error": "Firestore database connection not available"
                    }), 500
            else:
                return jsonify({
                    "success": False,
                    "error": "Missing required fields (either token+firebase_uid or username+password+firebase_uid)"
                }), 400
                
    except Exception as e:
        logger.error(f"Error handling Last.fm auth request: {str(e)}")
        return jsonify({
            "success": False,
            "error": str(e)
        }), 500

def get_user_loved_tracks(firebase_uid):
    """
    Get loved tracks for a user from Last.fm
    
    Args:
        firebase_uid (str): Firebase user ID
    
    Returns:
        list: List of loved tracks
    """
    try:
        # Get user's Last.fm session key from Firestore
        user_doc = db.collection('Users').document(firebase_uid).get()
        
        if not user_doc.exists:
            raise ValueError("User document not found")
            
        user_data = user_doc.to_dict()
        
        if not user_data.get('Linked Accounts', {}).get('LastFM'):
            raise ValueError("User has not linked Last.fm account")
            
        linked_accounts = user_data.get('Linked Accounts', {})
        lastfm_data = linked_accounts.get('LastFM', [])
        
        if not lastfm_data or len(lastfm_data) < 2 or not lastfm_data[0]:
            raise ValueError("Last.fm account not properly linked")
            
        session_key = lastfm_data[1]
        
        # Connect to Last.fm
        api_key, api_secret = get_lastfm_credentials()
        
        params = {
            "api_key": api_key,
            "method": "user.getLovedTracks",
            "sk": session_key,
            "limit": 200  # Get up to 200 loved tracks
        }
        
        # Generate API signature
        params["api_sig"] = generate_api_signature(params, api_secret)
        
        # Add format parameter after generating signature
        params["format"] = "json"
        
        response = requests.get("https://ws.audioscrobbler.com/2.0/", params=params)
        
        if response.status_code != 200:
            logger.error(f"Error getting loved tracks: {response.text}")
            raise Exception(f"Error getting loved tracks: {response.text}")
        
        data = response.json()
        
        if "error" in data:
            logger.error(f"Last.fm error: {data['message']}")
            raise Exception(f"Last.fm error: {data['message']}")
        
        # Process and format the loved tracks
        loved_tracks = []
        
        if "lovedtracks" in data and "track" in data["lovedtracks"]:
            tracks = data["lovedtracks"]["track"]
            
            # Ensure tracks is a list (Last.fm returns a single item as a dict, not in a list)
            if not isinstance(tracks, list):
                tracks = [tracks]
                
            for track in tracks:
                track_data = {
                    "Name": track.get("name"),
                    "Artist": track.get("artist", {}).get("name"),
                    "URL": track.get("url"),
                    "Images": track.get("image", []),
                    "Date": track.get("date", {}).get("uts") if "date" in track else None,
                    "URI": track.get("url"),  # Last.fm doesn't provide a URI, so use URL
                    "LinkedService": ["LastFM"]
                }
                loved_tracks.append(track_data)
                
        # Store loved tracks in Firestore
        fireBaseDocRef = db.collection('Songs')
        lovedTracksRefs = []
        
        for track in loved_tracks:
            # Check if the song already exists in the database
            songs_query = fireBaseDocRef.where("Name", "==", track["Name"]).where("Artist", "==", track["Artist"]).limit(1).get()
            
            if not songs_query:
                # Add new song
                song_ref = fireBaseDocRef.add(track)[0]
                lovedTracksRefs.append(song_ref)
            else:
                # Reference existing song
                lovedTracksRefs.append(songs_query[0].reference)
        
        # Update user's loved tracks
        db.collection('Users').document(firebase_uid).set({
            'LovedTracks': {
                'LastFM': {
                    'Tracks': lovedTracksRefs,
                    'Count': len(lovedTracksRefs),
                    'LastUpdated': firestore.SERVER_TIMESTAMP
                }
            }
        }, merge=True)
        
        return {
            "success": True,
            "tracks_count": len(loved_tracks),
            "tracks": loved_tracks
        }
        
    except Exception as e:
        logger.error(f"Error getting loved tracks: {str(e)}")
        return {
            "success": False,
            "error": str(e)
        }
