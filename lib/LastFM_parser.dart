import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto/crypto.dart';

class LastFMParser extends ChangeNotifier {
  dynamic _playlists;
  String _token = '';
  var _db;

  Future<void> sendRequest(String type, Map<String, dynamic> thisData) async {
    log("Sending request");
    var url = Uri.http(
      '192.168.0.31:8080',
      '/LastFM',
    );
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

 

  static String parseError(String error) {
    switch (error) {
      case 'authentication_error':
        return 'Authentication error';
      case 'invalid_credentials':
        return 'Invalid username or password';
      case 'session_expired':
        return 'Session expired';
      default:
        return 'Unknown error';
    }
  }

  Future<void> connect(String username, String password) async {
    var params = {
      'method': 'auth.getMobileSession',
      'username': username,
      'password': password,
      'api_key': "", // Replace with your Last.fm API key
    };
    
    params['api_sig'] = _generateApiSig(params);

    var url = Uri.https('ws.audioscrobbler.com', '/2.0/');
    var response = await http.post(url, body: params);
    
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setToken(jsonResponse['session']['key']);
      storeSessionKey();
    } else {
      log("Failed to authenticate: ${response.body}");
    }
  }

  void storeSessionKey() async {
    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).set({
      'Linked Accounts': {
        'LastFM': [true, _token],
      },
    }, SetOptions(merge: true));
  }

  String _generateApiSig(Map<String, String> params) {
    var sortedKeys = params.keys.toList()..sort();
    String sigString = "";
    
    for (var key in sortedKeys) {
      sigString += "$key${params[key]}";
    }
    sigString += ""; // Replace with your Last.fm shared secret
    
    return md5.convert(utf8.encode(sigString)).toString();
  }

  void setToken(String token) {
    _token = token;
  }

  String getToken() {
    return _token;
  }
  
  Future<void> retrieveLovedTracks(String username) async {
    final response = await http.get(
      Uri.parse('https://ws.audioscrobbler.com/2.0/?method=user.getlovedtracks&user=$username&api_key=&format=json'),
    );

    if (response.statusCode == 200) {
      dynamic temp = jsonDecode(response.body)['lovedtracks']['track'];
      _playlists = temp;
      storeLovedTracks();
    } else {
      throw Exception('Failed to load loved tracks: ${response.statusCode}');
    }
  }

  void storeLovedTracks() async {
    _db = FirebaseFirestore.instance.collection('LovedTracks');

    for (var track in _playlists) {
      final trackData = <String, dynamic>{
        'name': track['name'],
        'artist': track['artist']['name'],
        'url': track['url'],
        'image': track['image'][2]['#text'],
      };

      _db.add(trackData);
    }
  }
}
