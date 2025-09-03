import 'package:flutter/material.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

//TODO move firebase to backend
//
class SpotifyAPI extends ChangeNotifier {
  //locals
  var _currentlyPlaying = {};
  dynamic _playlists;
  String _token = '';
  var _db;

  Future<void> sendRequest(String type, Map<String, dynamic> thisData) async {
      log("Sending request");
      var url = Uri.https('backend.hpreed.dev','/Spotify'); //TODO: Change to localhost
      log("Sending request");
      http.Response response;

      try {
        if (type == 'GET') {
          response = await http.get(url);
        } else if (type == 'POST') {
          log("Sending post request");
          response = await http.post(
            url,
            headers: {'Content-Type': 'application/json'},

            body: jsonEncode(thisData),
          );
        } else {
          response = http.Response('Invalid request type', 400);
        }

        log("Response status: ${response.statusCode}");
      } catch (e) {
        log("Error: $e");
      }
    }
    // try {
    //   FirebaseFunctions functions = FirebaseFunctions.instance;
    //   HttpsCallable callable = functions.httpsCallable('spotify_api');
    //   final results = await callable.call(jsonEncode(thisData));
    //   log('Results: $results');
    // } catch (e) {
    //   log('Error: $e');
    // }
  //}

  // void firebaseInit() async {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );

  //   log('Playlist data: $_playlists');
  //   log('Firebase initialized');
  //   //retrivePlaylists();
  //   FirebaseFirestore.instance.collection('Users').add({'Name': 'Test'});
  // }

  static String parseError(String error) {
    switch (error) {
      case 'authentication_error':
        return 'Authentication error';
      case 'no_active_device':
        return 'No active device';
      case 'premium_required':
        return 'Premium required';
      case 'unknown_error':
        return 'Unknown error';
      default:
        return 'Unknown error';
    }
  }

  Future<Map> getClientID() async {
    var clientID;
    // FirebaseFunctions functions = FirebaseFunctions.instanceFor(
    //   region: 'us-central1',
    // );
      final response = await http.post(
      Uri.https("backend.hpreed.dev", "/spotify_client_id"),
      headers: {"Content-Type": "application/json"},
    );

    final data = jsonDecode(response.body);
    // log(data);
    // Map<String, dynamic> data = {'key': 'SPOTIFY_CLIENT_ID'};
    // var url = Uri.https('backend.hpreed.dev','/Spotify_Secret');
    //functions.useFunctionsEmulator('127.0.0.1', 5001);
    // HttpsCallable callable = functions.httpsCallable('secret_handler');
    // log("callable: $callable");
    // final result = await callable.call(jsonEncode(data));
    // log("Result: $result");  
    // clientID = result.data;
    // log('ClientID: $clientID');
    // } catch (e) {
    //   log('Error: $e');
    // }

    return data;
  }

  void reconnect() async {
    //grab token from firebase
    var clientID = getClientID();

    try {
      var temp = SpotifySdk.connectToSpotifyRemote(
        clientId:
            (await clientID)["ClientID"],
        redirectUrl: "http://localhost:8888/callback",
      );
      log('Connected: $temp');
    } catch (e) {
      log('Error: ${parseError(e.toString())}');
    }
  }

  void connect(String FirebaseID, Map<String, bool> options) async {
    //await SpotifySdk.disconnect();
    //get secret token
    var clientID = getClientID();


    //testing for web app
    if (kIsWeb) {
  String clientId = (await clientID)["ClientID"];
  String redirectUri = "https://backend.hpreed.dev/spotify_auth"; // your HTML file
  String scopes = "user-library-read,user-read-playback-state,user-modify-playback-state";

  String authUrl =
      "https://accounts.spotify.com/authorize?response_type=code&client_id=$clientId&scope=$scopes&redirect_uri=$redirectUri";

  // Open popup window inside user gesture
  final popup = html.window.open(authUrl, 'SpotifyAuth', 'width=500,height=600');

  // Listen for messages from the popup
  html.window.onMessage.listen((event) async {
    if (event.data is String && event.data.startsWith("?code=")) {
      final queryParams = Uri.splitQueryString(event.data.substring(1));
      final code = queryParams['code'];
      print('Received auth code: $code');
      
      //close the popup
      popup?.close();

      // Exchange code for token
      final res = await http.post(
        Uri.parse("https://backend.hpreed.dev/spotify_token"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"code": code}),
      );

      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        final accessToken = json["access_token"];
        final refreshToken = json["refresh_token"];
        print("Spotify access token: $accessToken");

        // Store token in your app
        setToken(accessToken);

        FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
          'Linked Accounts': {
            'Spotify': [true, _token],
          },
        }, SetOptions(merge: true));

          log('Token: $_token');
          print('Token: $_token');
          //connect to backend
          Map<String, dynamic> thisData = {
            'Spotify': _token.toString(),
            'FirebaseID': FirebaseID,
            'Options': options,
          };

          //TODO implement what the api should do in the backend
          log('Sending request');
          print('sending request');
          await sendRequest('POST', thisData);

      } else {
        print("Error exchanging code: ${res.body}");
      }

      try {
      var temp = SpotifySdk.connectToSpotifyRemote(
        clientId:
            (await clientID)["ClientID"],
        redirectUrl: "http://localhost:8888/callback",
        scope:
            "user-library-read ,app-remote-control, user-read-playback-state, user-modify-playback-state, user-read-currently-playing, playlist-read-private, playlist-read-collaborative",
      );
      print('Connected: $temp');
    } catch (e) {
      print('Error: ${e.toString()}');
    }

    }
  });
}

    //for mobile applications
    else{
    try {
      var temp = SpotifySdk.connectToSpotifyRemote(
        clientId:
            (await clientID)["ClientID"],
        redirectUrl: "http://localhost:8888/callback",
        scope:
            "user-library-read ,app-remote-control, user-read-playback-state, user-modify-playback-state, user-read-currently-playing, playlist-read-private, playlist-read-collaborative",
      );
      log('Connected: $temp');
    } catch (e) {
      log('Error: ${e.toString()}');
    }

    // Get the authentication token
    try {
      setToken(
        await SpotifySdk.getAccessToken(
          clientId:
              (await clientID)["ClientID"],
          redirectUrl: "http://localhost:8888/callback",
          scope:
              "user-library-read ,app-remote-control, user-read-playback-state, user-modify-playback-state, user-read-currently-playing, playlist-read-private, playlist-read-collaborative",
        ),
      );
    } catch (e) {
      log('Error: ${e.toString()}');
    }
    
    //firebaseInit();
    //set value in users collection to true for spotify, and add users token
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
          'Linked Accounts': {
            'Spotify': [true, _token],
          },
        }, SetOptions(merge: true));

    log('Token: $_token');
    print('Token: $_token');
    //connect to backend
    Map<String, dynamic> thisData = {
      'Spotify': _token.toString(),
      'FirebaseID': FirebaseID,
      'Options': options,
    };

    //TODO implement what the api should do in the backend
    log('Sending request');
    print('sending request');
    await sendRequest('POST', thisData);
    }
  }

  void retrivePlaylists() async {
    final response = await http.get(
      //playlists uri, using access token to get user's playlists
      Uri.parse('https://api.spotify.com/v1/me/playlists'),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      dynamic temp = await jsonDecode(response.body)['items'];
      setPlaylists(temp);
    } else {
      throw Exception('Failed to load playlists: ${response.statusCode}');
    }

    _db = FirebaseFirestore.instance.collection('Playlists');

    log('Playlist data: $_playlists');
    //add playlists to firebase
    for (var playlist in _playlists) {
      final playlistData = <String, dynamic>{
        'name': playlist['name'],
        'uri': playlist['uri'],
        'image': playlist['images'][0]['url'],
      };

      _db.add(playlistData);
    }
  }

  String getToken() {
    return _token;
  }

  dynamic getPlaylists() {
    return _playlists;
  }

  void setToken(String token) {
    _token = token;
  }

  void setPlaylists(dynamic playlists) {
    _playlists = playlists;
  }

  void play(String uri) async {
    print(_token);
    if(kIsWeb){

      //check available devices
      final devices = await http.get(
        Uri.parse('https://api.spotify.com/v1/me/player/devices'),
        headers: {
          'Authorization': 'Bearer $_token',
        },
      );

      print(devices.body);
      //get raw json
      final Map<String, dynamic> deviceRaw = jsonDecode(devices.body);
      var deviceID = deviceRaw['devices'][0]['id'];

      final response = await http.put(
        Uri.parse('https://api.spotify.com/v1/me/player/play?device_id=$deviceID'),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'uris': ['$uri']
        }),
      );

        if (response.statusCode == 204) {
        print("Playback started successfully");
      } else {
        print("Error playing track: ${response.statusCode} ${response.body}");
      }
    }
    else{
    SpotifySdk.play(spotifyUri: uri);
    }
  }

  void pause() async {
    SpotifySdk.pause();
  }

  void resume() async {
    SpotifySdk.resume();
  }

  void skipNext() async {
    SpotifySdk.skipNext();
    var temp = SpotifySdk.getPlayerState().asStream();
    log('temp: $temp');
  }

  void skipPrevious() async {
    SpotifySdk.skipPrevious();
  }

  void seekTo(int position) async {
    SpotifySdk.seekTo(positionedMilliseconds: position);
  }

  void disconnect() async {
    SpotifySdk.disconnect();
  }

  void subscribeToPlayerContext() {
    SpotifySdk.subscribePlayerContext();
  }

  void subscribeToPlayerState() {
    SpotifySdk.subscribePlayerState();
  }

  void subscribeToCapabilities() {
    SpotifySdk.subscribeCapabilities();
  }

  //Used for testing will be removed
  void setCurrentlyPlaying(var data) {
    _currentlyPlaying = data;
  }

  dynamic getCurrentlyPlaying() {
    return _currentlyPlaying;
  }
}
