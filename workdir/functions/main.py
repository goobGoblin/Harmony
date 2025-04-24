#Contributers: Harrison Reed
#Date: 3/2/2025
#Description: This is the server(backend) for the harmony app.
#It will handle all the requests from the client and send them to the appropriate API. 
#It will also handle the database and store all the data.


# from bottle import route, run, request, response
from firebase_functions import https_fn, firestore_fn, options
from spotipy.oauth2 import SpotifyClientCredentials
import json
import os
import firebase_admin
from firebase_admin import credentials, firestore, initialize_app
from lastfm_utils import handle_auth_request, get_user_loved_tracks
# from flask import jsonify
import google.cloud.firestore
import spotipy
import soundcloud_utils
import ytmusicapi_utils
import spotify_utils as su
import import_utils
# import lastfm

authFile = open("auth.json", "r")

authFile = json.load(authFile)

cred = credentials.Certificate(authFile["Firebase"])
            
firebase_admin.initialize_app(cred)
            
db = firestore.client()


@https_fn.on_request()#("/Spotify", method=["POST"])
def spotify_api(request: https_fn.Request) -> https_fn.Response:
        print(request)
        try:
            params = request.get_json()  # Handle incoming params
            
        except:
            print("Error")
            return https_fn.Response("Error")
            #params = request.query.decode()
        
        #load correct part of json
        params = json.loads(params['data'])
    
        if(params['Spotify']):
            print("Spotify")
            #TODO implement albums 
            #TODO Finish playlist implementation
            #TODO implement user data
            thisResponse = ""
            #global connection
            sp = spotipy.Spotify(auth_manager=SpotifyClientCredentials(client_id=authFile["Spotify"]["client_id"],
                                                            client_secret=authFile["Spotify"]["client_secret"],))
                                                            # redirect_uri=authFile["Spotify"]["redirect_uri"],
                                                            # scope=authFile["Spotify"]["scope"]))#request info from harrison)
            
            #user connection
            print(sp)
            user = spotipy.Spotify(auth=params['Spotify'])
            userInfo = user.me()
            
            #Check if user wants to import their playlists
            print(params['Options'])
            print(params['Options']['Albums'])
            if(params['Options']['Playlists'] == True):
                print("Importing Playlists")
                try:    
                    su.importPlaylists(user, userInfo, db, params, sp)
                    thisResponse = thisResponse + "Playlists imported successfully!"
                except Exception as e:
                    print(f"Playlists import failed!{e}")          
                    return https_fn.Response("Playlists import failed!")
            
            #Check if user wants to import their albums
            if(params['Options']['Albums'] == True):
                print("Importing Albums")
                su.importAlbums(user, db, params)
                thisResponse = thisResponse + "Albums imported successfully!"
        
        return https_fn.Response(thisResponse)

#----------------------------------------------------------------------------------------------
#TODO Update this to handle firebase function requests
#TODO Note: Youtube must be implemented in flutter frontend
@https_fn.on_request()#("/Youtube", method=["POST"])
def youtube_api(request: https_fn.Request) -> https_fn.Response:
    try:
        params = json.loads(request.body.read())  # Handle incoming params
    except:
        params = request.query.decode()

    if "Youtube" in params and "FirebaseID" in params:
        print("YouTube Music Integration")

        access_token = params["Youtube"]
        firebase_id = params["FirebaseID"]

        # Initialize YTMusic with credentials
        ytmusic = ytmusicapi_utils.get_ytmusic_credentials(access_token)

        if not ytmusic:
            #response.status = 400
            return {"error": "Failed to authenticate with YouTube Music API"}

        # Fetch user info and playlists
        user_info = ytmusicapi_utils.get_user_info(ytmusic)
        if not user_info:
            #response.status = 400
            return {"error": "Failed to retrieve user data"}

        playlists = ytmusicapi_utils.get_user_playlists(ytmusic)
        if not playlists:
            #response.status = 400
            return {"error": "Failed to retrieve user playlists"}

        # Process playlists and store in Firebase
        result = ytmusicapi_utils.import_youtube_playlists_to_firestore(playlists, firebase_id, db)

        return {"message": "Playlists imported successfully", "data": result}
    else:
        #response.status = 400
        return {"error": "Invalid request"}

#----------------------------------------------------------------------------------------------
#TODO Update this to handle firebase function requests
#TODO Note: Soundcloud must be implemented in flutter frontend
@https_fn.on_request()#("/Soundcloud", method=["POST"])
def soundcloud_api(request: https_fn.Request) -> https_fn.Response:
    """Handles SoundCloud authentication and playlist import."""
    try:
        params = json.loads(request.body.read())
    except:
        params = request.query.decode()

    if "SoundCloud" in params and "FirebaseID" in params:
        print("SoundCloud Integration")

        access_token = params["SoundCloud"]
        firebase_id = params["FirebaseID"]

        # Import playlists from SoundCloud using the access token and Firebase ID
        result = soundcloud_utils.import_soundcloud_playlists(access_token, firebase_id,db)

        if "error" in result:
            #response.status = 400  # Set HTTP status to 400 if there's an error
            return result  # Return the error message

        #response.status = 200  # Set HTTP status to 200 for successful response
        return result  # Return success message

    #response.status = 400  # Set HTTP status to 400 if the request is invalid
    return {"error": "Invalid request"}

# @https_fn.on_request()#("/LastFM", method=["POST"])
# def lastfm_api(request: https_fn.Request) -> https_fn.Response:
#     """Handles LastFM authentication and playlist import."""
#     try:
#         params = json.loads(request.body.read())
#     except:
#         params = request.query.decode()

#     if "LastFM" in params and "FirebaseID" in params:
#         print("LastFM Integration")

#         access_token = params["LastFM"]
#         firebase_id = params["FirebaseID"]

#         # Import playlists from LastFM using the access token and Firebase ID
#         result = import_utils.import_lastfm_playlists(access_token, firebase_id, db)

    
#     return https_fn.Response("LastFM API not implemented yet.")
        # if "error" in result:
        #     response.status = 400

@https_fn.on_request()
def lastfm_auth(request: https_fn.Request) -> https_fn.Response:
    """HTTP Cloud Function to authenticate with Last.fm API.
    
    Supports two methods:
    1. OAuth flow (GET to get auth URL, POST with token to complete)
    2. Direct username/password authentication (POST with username/password)
    """
    
    # print("temp")
    try:
       # logger.info(f"Last.fm auth request: {request.method}")
        
        # CORS Headers for cross-origin requests
        if request.method == 'OPTIONS':
            # Handle preflight requests
            headers = {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Max-Age': '3600'
            }
            return https_fn.Response('', 204, headers)
            
        # Set CORS headers for the main request
        headers = {
            'Access-Control-Allow-Origin': '*'
        }
        
        # Handle the main request
        response = handle_auth_request(request, db)
        
        # If response is a tuple (response, status_code), add headers
        if isinstance(response, tuple):
            return (response[0], response[1], {**headers, **response[2]} if len(response) > 2 else headers)
        
        # If response is just the response object, add headers
        return https_fn.Response(response, 200, headers)
        
    except Exception as e:
        #logger.error(f"Error in lastfm_auth: {e}")
        return https_fn.Response("Error in lastfm_auth " + e)
    

@https_fn.on_request()
def lastfm_loved_tracks(request: https_fn.Request) -> https_fn.Response:
    """HTTP Cloud Function to get loved tracks from Last.fm."""
    print("temp")
    try:
        # Only accept GET requests
        # if request.method != 'GET':
        #     return https_fn.Response("Method not allowed(Only GET Requests)")
            
        # Get Firebase UID from request
        firebase_uid = request.args.get('uid')
        
        if not firebase_uid:
            return https_fn.Response("Missing required parameter: uid") 
            
        # Get loved tracks for the user
        result = get_user_loved_tracks(firebase_uid, db)
        
        if result.get("success", False):
            return https_fn.Response(result)
        else:
            return https_fn.Response(result)
            
    except Exception as e:
        #logger.error(f"Error in lastfm_loved_tracks: {e}")
        return https_fn.Response("Error in lastfm_loved_tracks")
        


#-----------------------------------------------------------------------------------------------
#TODO Update this to handle firebase function requests
#TODO Note: AppleMusic must be implemented in flutter frontend

@https_fn.on_request()#("/AppleMusic", method=["POST"])
def applemusic_api(request: https_fn.Request) -> https_fn.Response:
    return https_fn.Response("Apple Music API not implemented yet.")
        # if(params['AppleMusic']):
        #     print("AppleMusic")
        #     #TODO implement applemusic api
        
#-----------------------------------------------------------------------------------------------
#TODO Update this to handle firebase function requests
#TODO Note: Bandcamp must be implemented in flutter frontend
@https_fn.on_request()#("/Bandcamp", method=["POST"])
def bandcamp_api(request: https_fn.Request) -> https_fn.Response:
    return https_fn.Response("Bandcamp API not implemented yet.")
        # if(params['Bandcamp']):
        #     print("Bandcamp")
        #     #TODO implement bandcamp api
        
@https_fn.on_call(secrets=["SPOTIFY_CLIENT_ID"])
def secret_handler(request: https_fn.Request) -> dict:
    #TODO: handle different secrets using the request object
    #i.e. use switch statement to determine which secret to return
    
    client_id = os.environ.get("SPOTIFY_CLIENT_ID", "")
    
    return {"ClientID": client_id}
#-----------------------------------------------------------------------------------------------
