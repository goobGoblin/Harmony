import 'package:flutter/material.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//
class SpotifyParser extends ChangeNotifier {
  //locals
  dynamic _playlists;
  var _token = '';
  var _db;

  void firebaseInit() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    log('Playlist data: $_playlists');
    log('Firebase initialized');
    //retrivePlaylists();
    FirebaseFirestore.instance.collection('Users').add({'Name': 'Test'});
  }

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

  void connect() async {
    try {
      await SpotifySdk.connectToSpotifyRemote(
        clientId: "", //please contact me for the client id
        redirectUrl: "http://localhost:8888/callback",
      );
    } catch (e) {
      log('Error: ${parseError(e.toString())}');
    }

    // Get the authentication token
    setToken(
      await SpotifySdk.getAccessToken(
        clientId: "", //please contact me for the client id
        redirectUrl: "http://localhost:8888/callback",
      ),
    );
    //firebaseInit();
    play("spotify:track:7221xIgOnuakPdLqT0F3nP");
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
    SpotifySdk.play(spotifyUri: uri);
  }

  void pause() async {
    SpotifySdk.pause();
  }

  void resume() async {
    SpotifySdk.resume();
  }

  void skipNext() async {
    SpotifySdk.skipNext();
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
}
