import asyncio
import import_utils

def importPlaylists(user, userInfo, db, params, sp):
    print("Importing Playlists")
                
                #get user playlists
    playlists = user.user_playlists(userInfo['id'])
    
    #used for setting user data
    userDocRef = db.collection('Users').document(params['FirebaseID'])
    #used for setting global songs
    fireBaseCollectionRef = db.collection('Songs')
    i = 0
    for playlist in playlists['items']:
        if i == 7: #TODO remove this in production
            break
        thisSong = sp.user_playlist_tracks(userInfo['id'], playlist['id'])
        songsList = []
        for song in thisSong['items']:
            song.setdefault(None)
            songDocRef = {
                'Name' : song['track']['name'],
                'Artist' : song['track']['artists'],
                'Album' : song['track']['album']['name'],
                'Images' : song.get("track").get("album").get("images"),
                'URI' : song['track']['uri'],
                "LinkedService" : ["Spotify"],
            }
            #add to global and playlist songs
            songsList.append(import_utils.addSongToDataBase(songDocRef, fireBaseCollectionRef, "Spotify"))
            print(songsList)
        #add to user playlists songs as reference if not songDocRef in userDocRef.get().to_dict():
        playlistDocRef = {
            'Name' : playlist['name'],
            'Tracks' : {"Tracklist": songsList, "NumberOfTracks": len(songsList)},
            'LinkedServices' : ['Spotify'],
            'Description' : playlist['description'],
            'Images' : playlist.get("images"),
            'URI' : playlist['uri'],
            'ExternalURL' : playlist['external_urls']['spotify'],
            'Owner' : playlist['owner'],
            
        }
        print(playlistDocRef)
        import_utils.addPlaylistToDataBase(playlistDocRef, userDocRef, "Spotify")
        i += 1
    return
        
def importAlbums(user ,db, params):
    print("Importing Albums")
    
    #get user albums
    albums = user.current_user_saved_albums()
    
    #used for setting user data
    userDocRef = db.collection('Users').document(params['FirebaseID'])
    #used for setting global songs
    fireSongCollectionRef = db.collection('Songs')
    fireAlbumCollectionRef = db.collection('Albums')
    i = 0
    for album in albums['items']:
        if i == 10:
            break
        songsList = []
        for song in album["album"]["tracks"]["items"]:
            songDoc = {
                'Name' : song['name'],
                'Artist' : song['artists'],
                'Album' :album['album']['name'],
                'Images' : album['album']['images'],
                'URI' : song['uri'],
                "LinkedService" : ["Spotify"],
            }
            songsList.append(import_utils.addSongToDataBase(songDoc, fireSongCollectionRef, "Spotify"))
            
        albumDoc = {
            'Name' : album['album']['name'],
            "Tracks" : {"Tracklist" : songsList, "NumberOfTracks" : len(songsList)},
            'Artist' : album['album']['artists'],
            'Images' : album['album']['images'],
            'URI' : album['album']['uri'],
            "LinkedService" : ["Spotify"],
            
        }
        print(f"albumDoc {albumDoc}")
        albumRef = asyncio.run(import_utils.addAlbumToDatabase(albumDoc, fireAlbumCollectionRef, "Spotify"))
        print(albumRef)
        print(f"albumRef {albumRef}")
        import_utils.addAlbumToUser(albumRef, userDocRef)
        i = i + 1
    return