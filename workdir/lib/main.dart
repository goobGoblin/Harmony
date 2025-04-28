import 'package:http/http.dart' as http;
import 'pages/pages.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import 'pages/web_view_container.dart';
import 'pages/dependencies.dart';
import 'package:flutter_application_1/theme/theme.dart';
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
    globals.userDoc = await getTempData();
  } else {
    log('User logged in: ${FirebaseAuth.instance.currentUser?.email}');
    myInitRout = '/home';
    globals.userDoc = await getUserData();

    var spotifyAccount = globals.userDoc['Linked Accounts']['Spotify'];
    if (spotifyAccount is bool && spotifyAccount || 
        spotifyAccount is List && spotifyAccount.isNotEmpty && spotifyAccount[0]) {
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
  var userAlbums = [];
  if (globals.userDoc != null) {
    userAlbums = globals.userDoc['albums'];
  }

  runApp(
    MaterialApp(
      theme: ThemeData(
        // Set the primary color of the app
        primaryColor: AppColors.primary,
        
        // Set the background color for scaffolds
        scaffoldBackgroundColor: AppColors.secondary,
        
        // Set the overall color scheme
        colorScheme: ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.primary,
          background: AppColors.background,
          error: StreamingServiceColors.youtube,
          onPrimary: AppColors.text,
          onSecondary: AppColors.text,
          onSurface: AppColors.text,
          onBackground: AppColors.text,
        ),
        
        // Text theme with white text
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.text),
          bodyMedium: TextStyle(color: AppColors.text),
          bodySmall: TextStyle(color: AppColors.text),
          // Other text styles...
        ),
        
        // Other theme properties...
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
        '/signUp': (context) => const SignUpRoute(),
        '/signIn': (context) => const SignInRoute(),
        '/home': (context) => MainLayout2(child: const Home2Route()),
        '/currentlyPlaying':
            (context) => MainLayout2(child: const CurrentlyPlaying()),
        '/playlists': (context) => MainLayout2(child: const Playlists()),
        '/albums': (context) => MainLayout2(child: Albums(albums: (userAlbums))),
        '/artists': (context) => MainLayout2(child: const Artists()),
        '/songs':
            (context) =>
                MainLayout2(child: const Songs(thisName: "Songs", tracks: {})),
        '/downloads': (context) => MainLayout2(child: const Downloads()),
        '/settings': (context) => MainLayout2(child: const SettingsRoute()),
        '/connectedApps': (context) => MainLayout2(child: const ConnectedApps2()),
        '/myAccount': (context) => MainLayout2(child: const MyAccount()),
        '/preferences': (context) => MainLayout2(child: const Preferences()),
      },
    ),
  );
  //thisConnection.connect(); //Useful to turn off when working on UI
}

//used for anything that needs to be a list of widgets
