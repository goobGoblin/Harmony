
from googleapiclient.discovery import build
from google.oauth2.credentials import Credentials
from firebase_admin import firestore
from google.auth.transport.requests import Request
from import_utils import addSongToDataBase, addPlaylistToDataBase

# Setup
def get_youtube_service(access_token, refresh_token, client_id):
    print("Access token" , access_token)
    print("Refresh token" , refresh_token)
    print("Client ID" , client_id)
    credentials = Credentials(token=access_token,
                              refresh_token=refresh_token,
                                client_id=client_id,
                                token_uri="https://oauth2.googleapis.com/token",
                                scopes=["https://www.googleapis.com/auth/youtube.readonly"]
                              )
    
    if(credentials.expired and credentials.refresh_token):
        credentials.refresh(Request())
    return build("youtube", "v3", credentials=credentials)

def get_youtube_user_info(service):
    response = service.channels().list(part="snippet", mine=True).execute()
    print("User info" , response)
    return response.get("items", [])[0]["snippet"] if response["items"] else None

def get_youtube_playlists(service):
    playlists = service.playlists().list(part="snippet", maxResults=25, mine=True).execute() 
    return playlists.get("items", [])

def get_playlist_items(service, playlist_id):
    results = service.playlistItems().list(
        part="snippet",
        maxResults=50,
        playlistId=playlist_id
    ).execute()
    return results.get("items", [])

def import_youtube_playlists(access_token, refresh_token, client_id ,uid, db):
    service = get_youtube_service(access_token, refresh_token, client_id)
    user_ref = db.collection("Users").document(uid)
    songs_ref = db.collection("Songs")

    playlists = get_youtube_playlists(service)
    temp = get_youtube_user_info(service)

    print("Playlists" , playlists)
    
    for playlist in playlists:
        
        #check if the playlist is a music playlist
        if(not ("music" in playlist["snippet"]["description"].lower())):
            continue
        
        playlist_id = playlist["id"]
        playlist_snippet = playlist["snippet"]
        playlist_title = playlist_snippet.get("title")
        playlist_description = playlist_snippet.get("description", "")
        playlist_owner = {"displayName": playlist_snippet.get("channelTitle", None)}

        playlist_items = get_playlist_items(service, playlist_id)

        songs_list = []
        for item in playlist_items:
            video_snippet = item["snippet"]
            song_dict = {
                "Name": video_snippet.get("title", "Unknown Title"),
                "Artist": [{"name": video_snippet.get("videoOwnerChannelTitle", "Unknown Artist")}],
                "Album": "YouTube Playlist",
                "Images": [video_snippet["thumbnails"]["maxres"]],
                "URI": f"https://www.youtube.com/watch?v={video_snippet['resourceId']['videoId']}",
                "LinkedService": ["YouTube"]
            }
            
            # Add song to Songs collection
            song_ref = addSongToDataBase(song_dict, songs_ref, "YouTube")
            if song_ref:
                songs_list.append(song_ref)

        # Construct the playlist dict
        playlist_dict = {
            "Name": playlist_title,
            "Tracks": {
                "Tracklist": songs_list,
                "Number of Tracks": len(songs_list)
            },
            "LinkedServices": ["YouTube"],
            "Description": playlist_description,
            "Images": [playlist["snippet"]["thumbnails"]["maxres"]],  # Could be updated to fetch thumbnails
            "URI": f"https://www.youtube.com/playlist?list={playlist_id}",
            "ExternalURL": f"https://www.youtube.com/playlist?list={playlist_id}",
            "Owner": playlist_owner
        }

        print("this playlist" , playlist)
        print("this playlist dict" , playlist_dict)
        # Add playlist to user doc
        addPlaylistToDataBase(playlist_dict, user_ref, "YouTube")

    return f"Successfully imported {len(playlists)} playlists from YouTube for user {uid}"

