import 'package:http/http.dart' as http;
import 'pages/pages.dart';
//import 'audioHandler.dart';
// import 'package:flutter_application_1/customThemes.dart'; //TODO
// import 'package:flutter_application_1/themes.dart';

//establish spotify connection
// SpotifyParser spotifyConnection = SpotifyParser();

//create audio handler
//MyAudioHandler audioHandler = MyAudioHandler();

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

  var userDoc = null;

  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    log('Firebase initialized');
  } catch (e) {
    log('Error initializing firebase: $e');
  }
  var myInitRout = '/';
  //check if user is logged in
  if (FirebaseAuth.instance.currentUser == null) {
    log('No user logged in');
    myInitRout = '/signUp';
  } else {
    log('User logged in: ${FirebaseAuth.instance.currentUser?.email}');
    myInitRout = '/home';
    userDoc = await getUserData();

    if (userDoc['Linked Accounts']['Spotify'][0]) {
      spotifyConnection.reconnect();
    }
  }

  //initialize audio handler
  // audioHandler = await AudioService.init(
  //   builder: () => MyAudioHandler(),
  //   config: const AudioServiceConfig(
  //     androidNotificationChannelId: 'com.example.flutter_application_1',
  //     androidNotificationChannelName: 'Audio playback',
  //     androidNotificationOngoing: true,
  //     androidStopForegroundOnPause: true,
  //   ),
  // );

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
        '/songs': (context) => const Songs(thisName: "Songs", tracks: {}),
        '/downloads': (context) => const Downloads(),
        '/settings': (context) => const SettingsRoute(),
        '/connectedApps': (context) => const ConnectedApps(),
        '/myAccount': (context) => const MyAccount(),
        '/preferences': (context) => const Preferences(),
      },
    ),
  );
  //thisConnection.connect(); //Useful to turn off when working on UI
}

//used for anything that needs to be a list of widgets





