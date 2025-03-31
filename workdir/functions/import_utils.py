from firebase_admin import credentials, firestore

#----------------------------------------------------------------------------------------------
#Note to get list of songs first call addSongToDataBase it will return the document reference to the song

#validates playlist being added to database
def validate_playlist(thisDict: dict):
    # playlistDocRef = {
    #                 'Name' : playlist['name'],
    #                 'Tracks' : {"Tracklist": songsList, "Number of Tracks": len(songsList)},
    #                 'LinkedServices' : {'Spotify'},
    #                 'Description' : playlist['description'],
    #                 'Images' : playlist.get("images"),
    #                 'URI' : playlist['uri'],
    #                 'ExternalURL' : playlist['external_urls']['spotify'],
    #                 'Owner' : playlist['owner'],
                    
    #             }
    assert "Name" in thisDict, "Name of playlist is required"
    assert isinstance(thisDict["Name"], str), "Name of playlist must be a string"
    ###############################################################################
    assert "Tracks" in thisDict, "Tracks in the form of a dictionary is required"
    assert isinstance(thisDict['Tracks'], dict), "Tracks must be a dictionary"
    assert "Tracklist" in thisDict["Tracks"], "Tracklist in the form of a list of references to documents is required"
    assert "Number of Tracks" in thisDict["Tracks"], "Number of Tracks in the form of an integer is required"
    assert isinstance(thisDict["Tracks"]["Number of Tracks"], int), "Number of Tracks must be an integer"
    assert isinstance(thisDict["Tracks"]["Tracklist"], list), "Tracklist must be a list"
    ##############################################################################
    assert "LinkedServices" in thisDict, "LinkedServices in the form of a list of strings is required"
    assert isinstance(thisDict["LinkedServices"], list), "LinkedServices must be a list"
    assert isinstance(thisDict["LinkedServices"][0], str), "LinkedServices must be a list of strings"
    ##############################################################################
    assert "Description" in thisDict, "Description of playlist is required(Or Null if not available)"
    assert isinstance(thisDict["Description"], (str, type(None))), "Description of playlist must be a string or none"
    ##############################################################################
    assert "Images" in thisDict, "Images in the form of a list of dictionaries is required(Or Null if not available)"
    assert isinstance(thisDict["Images"], (list, type(None))), "Images must be a list, or none"
    if thisDict["Images"] is not None:
        assert isinstance(thisDict["Images"][0], dict), "Images must be a list of dictionaries"
        assert "url" in thisDict["Images"][0], "url of image is required"
        assert isinstance(thisDict["Images"][0]["url"], (str, type(None))), "url of image must be a string"
        assert "height" in thisDict["Images"][0], "height of image is required"
        assert isinstance(thisDict["Images"][0]["height"], (int, type(None))), "height of image must be an integer"
        assert "width" in thisDict["Images"][0], "width of image is required"
        assert isinstance(thisDict["Images"][0]["width"], (int, type(None))), "width of image must be an integer"
    ##############################################################################
    assert "URI" in thisDict, "URI of playlist is required"
    assert isinstance(thisDict["URI"], str), "URI of playlist must be a string"
    ##############################################################################
    assert "ExternalURL" in thisDict, "ExternalURL of playlist is required"
    assert isinstance(thisDict["ExternalURL"], str), "ExternalURL of playlist must be a string"
    ##############################################################################
    assert "Owner" in thisDict, "Owner of playlist is required(Or Null if not available)"
    assert isinstance(thisDict["Owner"], (dict, type(None))), "Owner of playlist must be a dictionary or none"
    
    
    return True


#Implement this as it is more efficient
# def check_document_exists(collection_name, field, value):
#     collection_ref = db.collection(collection_name)
#     query = collection_ref.where(field, "==", value).limit(1)
#     results = query.get()


def inDatabase(doc1, dbQuerey):
    
    if(isinstance(dbQuerey, firestore.DocumentSnapshot)):
        #case when there is a document snapshot
        for doc2 in dbQuerey.to_dict()["playlists"]:
            if doc1 == doc2:
                print("Document already exists")
                return [True, doc2]
    else:
    #case when there is a collection
        for doc2 in dbQuerey:
            if doc1 == doc2.to_dict():
                print("Document already exists")
                return [True, doc2]
            
            
    return [False, None]
#----------------------------------------------------------------------------------------------

#note userDocRef in this instance will likely be the user document reference
#If it is trying to grab a collection this will be different
def addPlaylistToDataBase(thisDict: dict, userDocRef: firestore.DocumentReference):
    result = None
    try:
        if(validate_playlist(thisDict)):
            isInDatabase = inDatabase(thisDict, userDocRef.get())
            if(not(isInDatabase[0])):
                        result = userDocRef.update({
                            "playlists" : firestore.ArrayUnion([thisDict])
                        })
            else:
                result = isInDatabase[1]
                
                
    except AssertionError as e:
        print("Assertion error", e)
    except Exception as e:
        print("Playlist exception:",e, "line", e.__traceback__.tb_lineno)
    print(result) 
    return result
        
        
#---------------------------------------------------------------------------------------------
#validates song being added to database
def validate_song(thisDict: dict):
    # songDocRef = {
    #                     'Name' : song['track']['name'],
    #                     'Artist' : song['track']['artists'],
    #                     'Album' : song['track']['album']['name'],
    #                     'Images' : song.get("track").get("album").get("images"),
    #                     'URI' : song['track']['uri'],
    #                     "LinkedService" : {"Spotify"},
    #                 }
    assert "Name" in thisDict, "Name of song is required"
    assert isinstance(thisDict["Name"], str), "Name of song must be a string"
    ###############################################################################
    assert "Artist" in thisDict, "Artist of song is required"
    assert isinstance(thisDict["Artist"], list), "Artist must be a list(Note this is the case for multiple artists)"
    assert isinstance(thisDict["Artist"][0], dict), "Artist must be a list of dictionaries"
    assert "name" in thisDict["Artist"][0], "name of artist is required"
    ################################################################################
    assert "Album" in thisDict, "Album of song is required"
    assert isinstance(thisDict["Album"], str), "Album of song must be a string"
    ###############################################################################
    assert "Images" in thisDict, "Images in the form of a list of dictionaries is required(Or Null if not available)"
    assert isinstance(thisDict["Images"], (list, type(None))), "Images must be a list"
    if thisDict["Images"] is not None:
        assert isinstance(thisDict["Images"][0], dict), "Images must be a list of dictionaries"
        assert "height" in thisDict["Images"][0], "height of image is required"
        assert "width" in thisDict["Images"][0], "width of image is required"
        assert "url" in thisDict["Images"][0], "url of image is required"
        assert isinstance(thisDict["Images"][0]["url"], (str, type(None))), "url of image must be a string"
        assert isinstance(thisDict["Images"][0]["height"], (int, type(None))), "height of image must be an integer"
        assert isinstance(thisDict["Images"][0]["width"], (int, type(None))), "width of image must be an integer"
    ###############################################################################
    ###############################################################################
    assert "URI" in thisDict, "URI of song is required"
    assert isinstance(thisDict["URI"], str), "URI of song must be a string"
    ###############################################################################
    assert "LinkedService" in thisDict, "LinkedServices of song is required(Or Null if not available)"
    assert isinstance(thisDict["LinkedService"], list), "LinkedServices must be a list"
    assert isinstance(thisDict["LinkedService"][0], str), "LinkedServices must be a list of strings"
    ###############################################################################
    return True


#TODO implement Album insertion form as well
#TODO implement Artist insertion form as well
def addSongToDataBase(thisDict: dict, fireBaseDocRef: firestore.DocumentReference):
    
    result = None
    
    try:
        if(validate_song(thisDict)):
            isInDatabase = inDatabase(thisDict, fireBaseDocRef.get())
            if(not(isInDatabase[0])):
                result = fireBaseDocRef.add(thisDict)
            else:
                #update linked service
                isInDatabase[1].to_dict().update({
                    "LinkedService" : firestore.ArrayUnion(["Spotify"])
                })
                result = isInDatabase[1].reference
    except AssertionError as e:
        print("Assertion Error:", e)
    except Exception as e:
        print("Song exception:", e, "line", e.__traceback__.tb_lineno)
  
    return result
#---------------------------------------------------------------------------------------------