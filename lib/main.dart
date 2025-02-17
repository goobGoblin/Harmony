import 'package:flutter/material.dart';
import 'spotify_parser.dart';
import 'package:animations/animations.dart';
// import 'package:flutter_application_1/customThemes.dart'; //TODO
// import 'package:flutter_application_1/themes.dart';

//establish spotify connection
SpotifyParser thisConnection = SpotifyParser();

//TODO: Research buttons more

void main() {
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
      initialRoute: '/', //default route
      routes: {
        '/': (context) => const HomeRoute(),
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

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
              onPressed: () {
                Navigator.pushNamed(context, '/playlists');
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

class Playlists extends StatelessWidget {
  const Playlists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("TODO"), //thisConnection.getPlaylists()),
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
                  onPressed: () {
                    //TODO: thisConnection.signOut();
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
            Text("TODO"), //thisConnection.getConnectedApps()),
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

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   bool _isPlaying = true;
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       if (_isPlaying) {
//         _isPlaying = false;
//         thisConnection.pause();
//       } else {
//         _isPlaying = true;
//         thisConnection.resume();
//       }
//       _counter++;
//     });
//   }

//   // class CurrentlyPlaying extends StatefulWidget {
//   //   const CurrentlyPlaying({super.key, required this.title});

//   //   final String title;

//   //   @override
//   //   State<CurrentlyPlaying> createState() => _CurrentlyPlayingState();
//   // }

//   // class _CurrentlyPlaying extends State<CurrentlyPlaying> {
//   //   String _currentlyPlaying = "Nothing is currently playing";

//   //   void _updateCurrentlyPlaying() {
//   //     setState(() {
//   //       _currentlyPlaying = thisConnection.getCurrentlyPlaying();
//   //     });
//   //   }

//   //   @override
//   //   Widget build(BuildContext context) {
//   //     return Scaffold(
//   //       appBar: AppBar(
//   //         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//   //         title: Text(widget.title),
//   //       ),
//   //       body: Center(
//   //         child: Column(
//   //           mainAxisAlignment: MainAxisAlignment.center,
//   //           children: <Widget>[
//   //             Text(_currentlyPlaying),
//   //           ],
//   //         ),
//   //       ),
//   //       floatingActionButton: FloatingActionButton(
//   //         onPressed: _updateCurrentlyPlaying,
//   //         tooltip: 'Update',
//   //         child: const Icon(Icons.refresh),
//   //       ),
//   //     );
//   //   }
//   // }
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//}
