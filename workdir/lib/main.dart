import 'package:http/http.dart' as http;
import 'pages/pages.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import 'pages/web_view_container.dart';
import 'pages/dependencies.dart';


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

  //var userDoc = null;

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
    globals.userDoc = await getUserData();

    if (globals.userDoc['Linked Accounts']['Spotify'][0]) {
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
    ChangeNotifierProvider(
      create: (context) => Globals(),
      child: MaterialApp(
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
        initialRoute: myInitRout,
        //for navigation to webview
        onGenerateRoute: (settings) {
          // Check for routes that expect a URL parameter
          if (settings.name == '/webViewContainer') {
            final String url = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => WebViewExample(url: url), // Pass URL here
            );
          }
          return null; // Return null for unknown routes
        },
        //default route
        routes: {
          '/signUp': (context) => MainLayout(child: const SignUpRoute()),
          '/signIn': (context) => MainLayout(child: const SignInRoute()),
          '/home': (context) => MainLayout(child: const HomeRoute()),
          '/currentlyPlaying':
              (context) => MainLayout(child: const CurrentlyPlaying()),
          '/playlists': (context) => MainLayout(child: const Playlists()),
          '/albums': (context) => MainLayout(child: const Albums()),
          '/artists': (context) => MainLayout(child: const Artists()),
          '/songs':
              (context) =>
                  MainLayout(child: const Songs(thisName: "Songs", tracks: {})),
          '/downloads': (context) => MainLayout(child: const Downloads()),
          '/settings': (context) => MainLayout(child: const SettingsRoute()),
          '/connectedApps':
              (context) => MainLayout(child: const ConnectedApps()),
          '/myAccount': (context) => MainLayout(child: const MyAccount()),
          '/preferences': (context) => MainLayout(child: const Preferences()),
        },
      ),
    ),
  );
  //thisConnection.connect(); //Useful to turn off when working on UI
}

//used for anything that needs to be a list of widgets
