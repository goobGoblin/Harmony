import requests
from firebase_admin import credentials, firestore
import firebase_admin
import json
import import_utils


# SoundCloud API credentials (Ask Ethan for Info)
authFile = {
    "SoundCloud": {
        "client_id": "",
        "client_secret": "",
        "redirect_uri": ""
    }
}

TOKEN_URL = "https://api.soundcloud.com/oauth2/token"
USER_INFO_URL = "https://api.soundcloud.com/me"
USER_PLAYLISTS_URL = "https://api.soundcloud.com/me/playlists"

# Exchanging authorization code for access token
def get_access_token(auth_code):
    # Exchanges authorization code for access token.
    data = {
        "client_id": authFile["SoundCloud"]["client_id"],
        "client_secret": authFile["SoundCloud"]["client_secret"],
        "redirect_uri": authFile["SoundCloud"]["redirect_uri"],
        "code": auth_code,
        "grant_type": "authorization_code"
    }
    
    response = requests.post(TOKEN_URL, data=data)
    
    if response.status_code == 200:
        return response.json()["access_token"]
    else:
        raise Exception("Failed to get access token from SoundCloud")

# Fetches user info from SoundCloud
def get_soundcloud_user_info(access_token):
    headers = {"Authorization": f"OAuth {access_token}"}
    response = requests.get(USER_INFO_URL, headers=headers)
    if response.status_code == 200:
        return response.json()
    return None

# Fetches user playlists from SoundCloud
def get_soundcloud_playlists(access_token):
    headers = {"Authorization": f"OAuth {access_token}"}
    response = requests.get(USER_PLAYLISTS_URL, headers=headers)
    if response.status_code == 200:
        return response.json()
    return None

# Imports SoundCloud playlists into Firestore
def import_soundcloud_playlists(access_token, firebase_id, db):
    user_info = get_soundcloud_user_info(access_token)
    if not user_info:
        return {"error": "Failed to retrieve SoundCloud user data"}

    playlists = get_soundcloud_playlists(access_token)
    if not playlists:
        return {"error": "Failed to retrieve SoundCloud playlists"}

    # Firestore references
    userDocRef = db.collection("Users").document(firebase_id)
    fireBaseDocRef = db.collection("Songs")

    for i, playlist in enumerate(playlists):

        track_list = []
        for track in playlist.get("tracks", []):
            songDocRef = {
                "Name": track["title"],
                "Artist": track["user"]["username"],
                "Album": None,  # SoundCloud does not have albums
                "Images": track.get("artwork_url"),
                "URI": track["permalink_url"],
                "LinkedService": ["SoundCloud"],
            }
            track_list.append(import_utils.addSongToDataBase(songDocRef, fireBaseDocRef))

        playlistDocRef = {
            "Name": playlist["title"],
            "Tracks": {"Tracklist": track_list, "Number of Tracks": len(track_list)},
            "LinkedServices": ["SoundCloud"],
            "Description": playlist.get("description", ""),
            "Images": playlist.get("artwork_url"),
            "URI": playlist["permalink_url"],
            "ExternalURL": playlist["permalink_url"],
            "Owner": playlist["user"]["username"],
        }
        import_utils.addPlaylistToDatabase(playlistDocRef, userDocRef)

    return {"message": "Playlists imported successfully"}

# Adds song to Firestore and returns reference ID
#Depreciated
# def add_song_to_database(song, fireBaseDocRef):
#     # Adds song to Firestore and returns reference ID.
#     doc_ref = fireBaseDocRef.document()
#     doc_ref.set(song)
#     return doc_ref.id

# # Adds playlist to Firestore under user data
# def add_playlist_to_database(playlist, userDocRef):
#     # Adds playlist to Firestore under user data.
#     userDocRef.collection("Playlists").document().set(playlist)
