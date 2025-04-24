import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
export 'firebase_options.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:cloud_firestore/cloud_firestore.dart';

Future<String> createFirebaseAccount(
  String email,
  String password,
  String username,
) async {
  // Create a new user with a username and password
  //TODO: ensure email is to lower
  try {
    //TODO: this produces a user credential look into flutter secure storage for this
    final uCred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    log(uCred.toString());
    //If error occurs, such as does not have permission to access
    //change the settings in the firstore console
    var userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(uCred.user?.uid);

    //set up inital elements
    await userDoc.set({
      'email': email,
      'Linked Accounts': {
        'Spotify': false,
        'Apple Music': false,
        'YouTube Music': false,
      },
      'UserCreateTags': [null],
      'lName': 'NA',
      'bio': 'NA',
      'fName': 'NA',
      'profilePic': 'NA',
      'username': username,
      'userRatings': [null],
      'playlists': [null],
      'friends': [null],
      'artists': [null],
      'albums': [null],
      'songs': [null],
      'downloads': [null],
      'preferences': {
        'theme': 'light',
        'language': 'en',
        'notifications': true,
        'location': true,
        'dataUsage': true,
      },
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    } else if (e.code == 'invalid-email') {
      return 'The email address is badly formatted.';
    }
    log(e.code.toString());
    return 'Error: ${e.code}';
  } catch (e) {
    log(e.toString());
    return 'Error: $e';
  }

  return 'Account created successfully';
}

Future<String> loginFirebaseAccount(String email, String password) async {
  log("Logging in");
  log(email);
  log(password);
  try {
    //TODO: this produces a user credential look into flutter secure storage for this
    final token = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    log(token.toString());
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return ('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      return ('Wrong password provided for that user.');
    }

    return 'Error: ${e.code}';
  }

  return 'Logged in successfully';
}

Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
  var docSnapshot =
      FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

  log('Document exists');
  return docSnapshot;
}

Future<List<dynamic>> getGlobalSongData(Map<String, dynamic> tracks) async {
  //store result of each occurence
  var results = [];

  log(tracks.toString());

  //when there are no tracks passed assume the request wants all songs
  if (tracks['Tracklist'] == null) {
    var docSnapshot =
        await FirebaseFirestore.instance.collection('Songs').get();
    return docSnapshot.docs;
  }

  for (var thisRef in tracks['Tracklist']) {
    var docSnapshot =
        await FirebaseFirestore.instance
            .collection('Songs')
            .doc(thisRef.id)
            .get();

    log('Document exists');
    results.add(docSnapshot);
  }
  log(results.toString());

  return results;
}

Future<List<dynamic>> getGlobalAlbumData(List<dynamic> albums) async {
  //store result of each occurence
  var results = [];

  log(albums.toString());

  //when there are no tracks passed assume the request wants all songs
  if (albums.length < 1) {
    log('No albums passed');
    var docSnapshot =
        await FirebaseFirestore.instance.collection('Playlists').get();
    return docSnapshot.docs;
  }

  log('Albums passed');
  for (var thisRef in albums) {
    if (thisRef == null) {
      continue;
    }
    var docSnapshot =
        await FirebaseFirestore.instance
            .collection('Albums')
            .doc(thisRef.id)
            .get();

    var temp = docSnapshot.data();
    log('Document exists $temp');
    results.add(temp);
  }
  log(results.toString());

  return results;
}
