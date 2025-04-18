from googleapiclient.discovery import build
from firebase_admin import firestore
from import_utils import addSongToDataBase, addPlaylistToDataBase

# Setup
def get_youtube_service(api_key):
    return build("youtube", "v3", developerKey=api_key)

def get_youtube_user_info(service):
    response = service.channels().list(part="snippet", mine=True).execute()
    return response.get("items", [])[0]["snippet"] if response["items"] else None

def get_youtube_playlists(service):
    playlists = service.playlists().list(part="snippet", mine=True, maxResults=25).execute()
    return playlists.get("items", [])

def get_playlist_items(service, playlist_id):
    results = service.playlistItems().list(
        part="snippet",
        maxResults=50,
        playlistId=playlist_id
    ).execute()
    return results.get("items", [])

def import_youtube_playlists(api_key, uid):
    service = get_youtube_service(api_key)
    db = firestore.client()
    user_ref = db.collection("Users").document(uid)
    songs_ref = db.collection("Songs")

    playlists = get_youtube_playlists(service)

    for playlist in playlists:
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
                "Images": None,
                "URI": f"https://www.youtube.com/watch?v={video_snippet['resourceId']['videoId']}",
                "LinkedService": ["YouTube"]
            }

            # Add song to Songs collection
            song_ref = addSongToDataBase(song_dict, songs_ref)
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
            "Images": None,  # Could be updated to fetch thumbnails
            "URI": f"https://www.youtube.com/playlist?list={playlist_id}",
            "ExternalURL": f"https://www.youtube.com/playlist?list={playlist_id}",
            "Owner": playlist_owner
        }

        # Add playlist to user doc
        addPlaylistToDataBase(playlist_dict, user_ref)

    return f"Successfully imported {len(playlists)} playlists from YouTube for user {uid}"
