import 'package:flutter/material.dart';
import 'spotify_parser.dart';
import 'package:animations/animations.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_application_1/customThemes.dart'; //TODO
// import 'package:flutter_application_1/themes.dart';

//establish spotify connection
SpotifyParser spotifyConnection = SpotifyParser();

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
      'fName': 'NA',
      'lName': 'NA',
      'bio': 'NA',
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

  if (docSnapshot != null) {
    log('Document exists');
  } else {
    log("Document does not exist");
  }
  return docSnapshot;
}

Future<void> sendRequest(String type, Map<String, String> thisData) async {
  log("Sending request");
  var url = Uri.http(
    '192.168.0.31:8080',
    '/',
    thisData,
  ); //TODO: Change to localhost
  log("Sending request");
  http.Response response;

  try {
    if (type == 'GET') {
      response = await http.get(url);
    } else if (type == 'POST') {
      response = await http.post(url);
    } else {
      response = http.Response('Invalid request type', 400);
    }

    log("Response status: ${response.statusCode}");
  } catch (e) {
    log("Error: $e");
  }
}
//TODO: Research buttons more

Future<void> main() async {
  //initalize firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  log('Firebase initialized');

  var myInitRout = '/';
  //check if user is logged in
  if (FirebaseAuth.instance.currentUser == null) {
    log('No user logged in');
    myInitRout = '/signUp';
  } else {
    log('User logged in: ${FirebaseAuth.instance.currentUser?.email}');
    myInitRout = '/home';
  }

  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(176, 27, 62, 180),
          elevation: 5,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      //handle routes(aka pages)
      initialRoute: myInitRout, //default route
      routes: {
        '/signUp': (context) => const SignUpRoute(),
        '/signIn': (context) => const SignInRoute(),
        '/home': (context) => const HomeRoute(),
        '/currentlyPlaying': (context) => const CurrentlyPlaying(),
        '/playlists': (context) => const Playlists(),
        '/albums': (context) => const Albums(),
        '/artists': (context) => const Artists(),
        '/songs': (context) => const Songs(),
        '/downloads': (context) => const Downloads(),
        '/settings': (context) => const Settings(),
        '/connectedApps': (context) => const ConnectedApps(),
        '/myAccount': (context) => const MyAccount(),
        '/preferences': (context) => const Preferences(),
      },
    ),
  );
  //thisConnection.connect(); //Useful to turn off when working on UI
}

//sign up page
class SignUpRoute extends StatelessWidget {
  const SignUpRoute({super.key});

  @override
  Widget build(BuildContext context) {
    //used to store user input
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),

            ElevatedButton(
              onPressed: () async {
                AnimatedRotation(
                  turns: 1,
                  duration: const Duration(seconds: 1),
                  child: const Icon(Icons.refresh),
                );
                var result = await createFirebaseAccount(
                  emailController.text,
                  passwordController.text,
                  usernameController.text,
                );

                if (result == 'Account created successfully') {
                  Navigator.pushNamed(context, '/home');
                } else {
                  SnackBar thisSnackBar = SnackBar(content: Text(result));
                  ScaffoldMessenger.of(context).showSnackBar(thisSnackBar);
                  //Navigator.pushNamed(context, '/home');
                }
              },
              child: const Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signIn');
              },
              child: const Text('Already have an account?'),
            ),
          ],
        ),
      ),
    );
  }
}

//sign in page
class SignInRoute extends StatelessWidget {
  const SignInRoute({super.key});

  @override
  Widget build(BuildContext context) {
    //used to store user input
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await loginFirebaseAccount(
                  usernameController.text,
                  passwordController.text,
                );

                if (result == 'Logged in successfully') {
                  Navigator.pushNamed(context, '/home');
                } else {
                  SnackBar thisSnackBar = SnackBar(content: Text(result));
                  ScaffoldMessenger.of(context).showSnackBar(thisSnackBar);
                  //Navigator.pushNamed(context, '/home');
                }
              },
              child: const Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // This widget is the home page of your application. It is stateful, meaning
    // that it has a State object (defined below) that contains fields that affect
    // how it looks.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Harmony'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //playlists navigation
            ElevatedButton(
              onPressed: () async {
                Navigator.pushNamed(context, '/playlists');

                // Map<String, String> thisData = {'lat': '0', 'lon': '0'};
                // await sendRequest('POST', thisData);
              },
              child: const Text('Playlists'),
            ),
            //artists navigation
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/artists');
              },
              child: const Text('Artists'),
            ),
            //albums navigation
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/albums');
              },
              child: const Text('Albums'),
            ),
            //songs navigation
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/songs');
              },
              child: const Text('Songs'),
            ),
            //downloads navigation
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/downloads');
              },
              child: const Text('Downloads'),
            ),

            //currently playing navigation
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/currentlyPlaying');
              },
              child: const Text('Currently Playing'),
            ),
          ],
        ),
      ),

      //currentlyPlaying: const CurrentlyPlaying(title: 'Currently Playing'),
    );
  }
}

class CurrentlyPlaying extends StatelessWidget {
  const CurrentlyPlaying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Currently Playing"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("TODO"), //thisConnection.getCurrentlyPlaying()),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      //   tooltip: 'Back',
      //   child: const Icon(Icons.arrow_back),
      // ),
    );
  }
}

//used for anything that needs to be a list of widgets
List<Widget> createListOfWidgets(List<dynamic> thisList) {
  List<Widget> thisWidgets = [];
  for (var i = 0; i < thisList.length; i++) {
    var newButton = ElevatedButton(
      onPressed: () {
        log(thisList[i]["uri"]);
        spotifyConnection.play(thisList[i]["uri"]);
      },
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: Colors.black),
          ),
        ),
      ),
      child: Text(thisList[i]["name"]),
    );
    //add the new button to the list
    thisWidgets.add(newButton);
  }
  return thisWidgets;
}

class Playlists extends StatelessWidget {
  const Playlists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var docSnapshot =
        FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get();

    var thisPlaylists = [];

    if (docSnapshot != null) {
      log('Document exists');
    } else {
      log("Document does not exist");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Playlists"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  //collection data
                  var temp = snapshot.data?.data();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: createListOfWidgets(temp!['playlists']),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
              return const Text('Loading...');
            },
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      //   tooltip: 'Back',
      //   child: const Icon(Icons.arrow_back),
      // ),
    );
  }
}

class Albums extends StatelessWidget {
  const Albums({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Albums"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("TODO"), //thisConnection.getAlbums()),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      //   tooltip: 'Back',
      //   child: const Icon(Icons.arrow_back),
      // ),
    );
  }
}

class Artists extends StatelessWidget {
  const Artists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Artists"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("TODO"), //thisConnection.getArtists()),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      //   tooltip: 'Back',
      //   child: const Icon(Icons.arrow_back),
      // ),
    );
  }
}

class Songs extends StatelessWidget {
  const Songs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Songs"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("TODO"), //thisConnection.getSongs()),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      //   tooltip: 'Back',
      //   child: const Icon(Icons.arrow_back),
      // ),
    );
  }
}

class Downloads extends StatelessWidget {
  const Downloads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Downloads"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("TODO"), //thisConnection.getDownloads()),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      //   tooltip: 'Back',
      //   child: const Icon(Icons.arrow_back),
      // ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Settings"),
      ),
      body: Align(
        alignment: Alignment.topCenter,

        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/myAccount');
              },
              child: const Text('My Account'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/preferences');
              },
              child: const Text('Preferences'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/connectedApps');
              },
              child: const Text('Connected Apps'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    //TODO: thisConnection.signOut();
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, '/signUp');
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                    foregroundColor: WidgetStateProperty.all<Color>(
                      Colors.white,
                    ),
                  ),
                  child: const Text('Sign Out'),
                ),
              ],
            ),
            //TODO: Add settings
          ],
        ),
      ),
    );
  }
}

class ConnectedApps extends StatelessWidget {
  const ConnectedApps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Connected Apps"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                spotifyConnection.connect(
                  FirebaseAuth.instance.currentUser!.uid,
                );
              },
              //TODO: Add visuals for if an account is connected or not
              child: const Text("Spotify"),
            ), //thisConnection.getConnectedApps()),
          ],
        ),
      ),
    );
  }
}

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("My Account"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("TODO"), //thisConnection.getMyAccount()),
          ],
        ),
      ),
    );
  }
}

class Preferences extends StatelessWidget {
  const Preferences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Preferences"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("TODO"), //thisConnection.getPreferences()),
          ],
        ),
      ),
    );
  }
}
