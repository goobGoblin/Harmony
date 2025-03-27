import 'dependencies.dart';

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
