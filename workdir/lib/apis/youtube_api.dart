import 'dart:io';

import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../pages/dependencies.dart';

class YoutubeAPI extends ChangeNotifier {
  //locals
  var _currentlyPlaying = {};
  dynamic _playlists;
  String _token = '';
  var _db;

  Future<void> sendRequest(Map<String, dynamic> thisData) async {
    try {

      //use this for local testing
      // FirebaseFunctions functions = FirebaseFunctions.instanceFor(
      //   region: 'us-central1',
      // );
      // final origin =
      //     Platform.isAndroid ? 'http://10.0.2.2:5001' : 'http://localhost:5001';
      // functions.useFunctionsEmulator("10.0.2.2", 5001);

      //use this for production
      FirebaseFunctions functions = FirebaseFunctions.instance;
      HttpsCallable callable = functions.httpsCallable('youtube_api');
      final results = await callable.call(jsonEncode(thisData));
      
      log('Results: $results');
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<Map> getClientID() async {
    var clientID;
    try {
      FirebaseFunctions functions = FirebaseFunctions.instanceFor(
        region: 'us-central1',
      );
      //functions.useFunctionsEmulator('127.0.0.1', 5001);
      HttpsCallable callable = functions.httpsCallable('secret_handler');
      final result = await callable.call({"key": "YOUTUBE_CLIENT_ID"});
      clientID = result.data;
    } catch (e) {
      log('Error: $e');
    }

    return clientID;
  }

  Future<String?> getChannelId(String username, String apiKey) async {
    const String baseUrl = 'https://www.googleapis.com/youtube/v3/channels';

    try {
      final url = '$baseUrl?part=id&forUsername=$username&key=$apiKey';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final items = json['items'] as List;

        if (items.isNotEmpty) {
          return items[0]['id'];
        }
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }

  Future<GoogleSignInAuthentication> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/youtube.readonly',
        'https://www.googleapis.com/auth/youtube', // <-- Important
      ],
    );

    try {
      // await googleSignIn.disconnect();
      await googleSignIn.signOut(); // Sign out any previous user
      // Disconnect any previous user
    } catch (e) {
      log('Error signing out: $e');
    }
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      // The user canceled the sign-in
      return Future.error('User canceled the sign-in');
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    return googleAuth;
  }

  void connect(
    String firebaseID,
    String channelName,
    Map<String, bool> options,
  ) async {
    String channelId =
        await getChannelId(
          channelName,
          'AIzaSyD1Fw1voezTfk4tTrC6l1HQudXl3TLh9CE',
        ) ??
        '';

    log('Channel ID: $channelId');

    if (channelId.isEmpty) {
      log('Error: Channel does not exist');
      return;
    }

    //get access token
    GoogleSignInAuthentication googleAuth;

    try {
      googleAuth = await signInWithGoogle();
    } catch (e) {
      log('Error signing in: $e');
      return;
    }

    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
          'Linked Accounts': {
            'Youtube': [true, googleAuth.accessToken, googleAuth.idToken],
          },
        }, SetOptions(merge: true));

    Map<String, dynamic> thisData = {
      'FirebaseID': firebaseID,
      'ChannelID': channelId,
      'Options': options,
      'AccessToken': googleAuth.accessToken,
      'RefreshToken': googleAuth.idToken,
    };

    log("Sending request to backend: $thisData");
    await sendRequest(thisData);
  }

  Future<Uri> play(String thisUri) async {
    final yt = YoutubeExplode();
    final manifest = await yt.videos.streamsClient.getManifest(thisUri);
    final streamInfo = manifest.audioOnly.withHighestBitrate();
    //final stream = yt.videos.streamsClient.get(streamInfo);
    //globals.currentStream = stream;
    log('Stream: ${streamInfo.url}');
    return streamInfo.url;
  }
}
