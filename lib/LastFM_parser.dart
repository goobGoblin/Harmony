import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LastFMParser extends ChangeNotifier {
  dynamic _playlists;
  String _token = '';
  String _username = '';
  bool _isAuthenticated = false;
  final _secureStorage = FlutterSecureStorage();
  
  // Getters
  String getToken() => _token;
  String getUsername() => _username;
  bool isAuthenticated() => _isAuthenticated;
  dynamic getPlaylists() => _playlists;
  
  // Initialize from Firebase (check if user has connected LastFM)
  
  Future<void> initialize() async {
    try {
      var userId = FirebaseAuth.instance.currentUser!.uid;
      var userData = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();
      
      var linkedAccounts = userData.data()?['Linked Accounts'];
      if (linkedAccounts != null && 
          linkedAccounts['LastFM'] != null && 
          linkedAccounts['LastFM'][0] == true) {
        _token = linkedAccounts['LastFM'][1];
        _username = linkedAccounts['LastFM_username'] ?? '';
        _isAuthenticated = true;
        log('LastFM already authenticated with token: $_token');
      }
    } catch (e) {
      log('Error initializing LastFM: $e');
    }
  }

  // Send request to our backend API
  Future<Map<String, dynamic>> sendRequest(String type, Map<String, dynamic> thisData) async {
    log("Sending LastFM request");
    var url = Uri.http(
      '192.168.0.31:8080',
      '/LastFM',
    );
    
    http.Response response;

    try {
      if (type == 'GET') {
        response = await http.get(url);
      } else if (type == 'POST') {
        log("Sending LastFM post request");
        response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(thisData),
        );
      } else {
        return {'error': 'Invalid request type'};
      }

      log("LastFM response status: ${response.statusCode}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'error': 'Request failed with status: ${response.statusCode}'};
      }
    } catch (e) {
      log("LastFM error: $e");
      return {'error': e.toString()};
    }
  }

  // Error parsing
  static String parseError(String error) {
    switch (error) {
      case 'authentication_error':
        return 'Authentication error';
      case 'invalid_credentials':
        return 'Invalid username or password';
      case 'session_expired':
        return 'Session expired';
      default:
        return 'Unknown error: $error';
    }
  }

  // Connect with username and password
  Future<String> connect(String username, String password) async {
  try {
    // Save username for later use
    _username = username;
    
    // Send data to backend for authentication and import
    Map<String, dynamic> thisData = {
      'LastFM': '', // Empty token for new authentication
      'FirebaseID': FirebaseAuth.instance.currentUser!.uid,
      'username': username,
      'password': password,
      'Options': {
        'Loved Tracks': true,
        'Timeline': true,
        'Timeline_Limit': 200,
        'Top Tracks': true,
        'Top Artists': true,
      },
    };
    
    var response = await sendRequest('POST', thisData);
    
    if (response.containsKey('error')) {
      return 'Error: ${response['error']}';
    }
    
    // Extract the token from the response
    if (response.containsKey('token')) {
      _token = response['token'];
    } else {
      log("Warning: No token received from server");
    }
    
    // Update state if successful
    _isAuthenticated = true;
    
    // Store LastFM connection info in Firebase
    await storeSessionKey();
    
    return 'LastFM connected successfully';
  } catch (e) {
    log("Error connecting to LastFM: $e");
    return 'Connection failed: $e';
  }
}

  // Store session key in Firebase
  Future<void> storeSessionKey() async {
    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).set({
      'Linked Accounts': {
        'LastFM': [true, _token],
        'LastFM_username': _username,
      },
    }, SetOptions(merge: true));
    
    // Also store securely on device
    await _secureStorage.write(key: 'lastfm_token', value: _token);
    await _secureStorage.write(key: 'lastfm_username', value: _username);
  }

  // Set token
  void setToken(String token) {
    _token = token;
    notifyListeners();
  }
  
  // Disconnect from LastFM
  Future<void> disconnect() async {
    _token = '';
    _username = '';
    _isAuthenticated = false;
    
    // Update Firebase to show LastFM is no longer connected
    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).set({
      'Linked Accounts': {
        'LastFM': [false, null],
        'LastFM_username': null,
      },
    }, SetOptions(merge: true));
    
    // Clear stored credentials
    await _secureStorage.delete(key: 'lastfm_token');
    await _secureStorage.delete(key: 'lastfm_username');
    
    notifyListeners();
  }

  // Retrieve user's loved tracks
  Future<List<dynamic>> retrieveLovedTracks() async {
    if (!_isAuthenticated) {
      throw Exception('Not authenticated with LastFM');
    }
    
    try {
      Map<String, dynamic> thisData = {
        'LastFM': _token,
        'FirebaseID': FirebaseAuth.instance.currentUser!.uid,
        'username': _username,
        'Options': {
          'Loved Tracks': true,
        },
      };
      
      var response = await sendRequest('POST', thisData);
      
      if (response.containsKey('error')) {
        throw Exception(response['error']);
      }
      
      // The backend has already imported the data to Firebase
      // Now we can retrieve it directly from Firebase
      var userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
          
      var playlists = userDoc.data()?['playlists'] ?? [];
      _playlists = playlists.where((p) => p['Name'].contains('LastFM Loved Tracks')).toList();
      
      return _playlists;
    } catch (e) {
      log("Error retrieving loved tracks: $e");
      throw Exception('Failed to retrieve loved tracks: $e');
    }
  }
  
  // Get user's recent tracks
  Future<List<dynamic>> retrieveRecentTracks() async {
    if (!_isAuthenticated) {
      throw Exception('Not authenticated with LastFM');
    }
    
    try {
      Map<String, dynamic> thisData = {
        'LastFM': _token,
        'FirebaseID': FirebaseAuth.instance.currentUser!.uid,
        'username': _username,
        'Options': {
          'Timeline': true,
          'Timeline_Limit': 200,
        },
      };
      
      await sendRequest('POST', thisData);
      
      // Get the results from Firebase
      var userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
          
      var playlists = userDoc.data()?['playlists'] ?? [];
      var recentTracks = playlists.where((p) => p['Name'].contains('LastFM History')).toList();
      
      return recentTracks;
    } catch (e) {
      log("Error retrieving recent tracks: $e");
      throw Exception('Failed to retrieve recent tracks: $e');
    }
  }
  
  // Get user's top tracks
  Future<List<dynamic>> retrieveTopTracks() async {
    if (!_isAuthenticated) {
      throw Exception('Not authenticated with LastFM');
    }
    
    try {
      Map<String, dynamic> thisData = {
        'LastFM': _token,
        'FirebaseID': FirebaseAuth.instance.currentUser!.uid,
        'username': _username,
        'Options': {
          'Top Tracks': true,
        },
      };
      
      await sendRequest('POST', thisData);
      
      // Get the results from Firebase
      var userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
          
      var playlists = userDoc.data()?['playlists'] ?? [];
      var topTracks = playlists.where((p) => p['Name'].contains('LastFM Top Tracks')).toList();
      
      return topTracks;
    } catch (e) {
      log("Error retrieving top tracks: $e");
      throw Exception('Failed to retrieve top tracks: $e');
    }
  }
  
  // Get all Last.fm playlists
  Future<List<dynamic>> getAllPlaylists() async {
    if (!_isAuthenticated) {
      throw Exception('Not authenticated with LastFM');
    }
    
    try {
      // Get all playlists from Firebase
      var userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
          
      var allPlaylists = userDoc.data()?['playlists'] ?? [];
      var lastfmPlaylists = allPlaylists.where((p) => 
        p['LinkedServices'] != null && 
        p['LinkedServices'].contains('LastFM')).toList();
      
      _playlists = lastfmPlaylists;
      return _playlists;
    } catch (e) {
      log("Error retrieving Last.fm playlists: $e");
      throw Exception('Failed to retrieve Last.fm playlists: $e');
    }
  }
}
