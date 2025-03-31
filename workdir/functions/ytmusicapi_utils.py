from ytmusicapi import YTMusic
from firebase_admin import firestore
import import_utils


# Initialize YTMusic using credentials
def get_ytmusic_credentials(access_token):
    try:
        # Assume `access_token` allows you to create the OAuth credentials (OAuth2 setup)
        ytmusic = YTMusic('oauth.json')  # Use the OAuth credentials JSON for initialization
        return ytmusic
    except Exception as e:
        print("Failed to initialize YouTube Music API:", e)
        return None

# Fetch user info from YouTube Music
def get_user_info(ytmusic):
    try:
        user_info = ytmusic.get_account_settings()
        return user_info
    except Exception as e:
        print("Failed to retrieve user info:", e)
        return None

# Fetch user playlists from YouTube Music
def get_user_playlists(ytmusic):
    try:
        playlists = ytmusic.get_library_playlists()
        return playlists
    except Exception as e:
        print("Failed to retrieve user playlists:", e)
        return None

# Import YouTube Music playlists into Firestore
def import_youtube_playlists_to_firestore(playlists, firebase_id,db):
    userDocRef = db.collection('Users').document(firebase_id)
    fireBaseDocRef = db.collection('Songs')
    result = []

    for playlist in playlists:
        track_list = []
        for track in playlist.get('tracks', []):
            songDocRef = {
                "Name": track['title'],
                "Artist": track['artists'],
                "Album": track.get('album', {}).get('name', ''),
                "Images": track.get('album', {}).get('images', []),
                "URI": track['videoId'],
                "LinkedService": ["YouTube Music"],
            }
            # Add song to database
            song_ref = import_utils.addSongToDataBase(songDocRef, fireBaseDocRef)
            track_list.append(song_ref)

        playlistDocRef = {
            "Name": playlist["title"],
            "Tracks": {"Tracklist": track_list, "Number of Tracks": len(track_list)},
            "LinkedServices": ["YouTube Music"],
            "Description": playlist.get("description", ""),
            "Images": playlist.get("images", []),
            "URI": playlist["playlistId"],
            "ExternalURL": f"https://music.youtube.com/playlist?list={playlist['playlistId']}",
            "Owner": user_info.get("user", {}).get("name", ""),
        }

        # Add playlist to Firestore
        import_utils.addPlaylistToDataBase(playlistDocRef, userDocRef)
        result.append(playlist["title"])

    return result

# Add song to Firestore
#Depreciatied
# def add_song_to_database(song, fireBaseDocRef):
#     doc_ref = fireBaseDocRef.document()
#     doc_ref.set(song)
#     return doc_ref.id

# # Add playlist to Firestore
# def add_playlist_to_database(playlist, userDocRef):
#     userDocRef.collection("Playlists").document().set(playlist)
