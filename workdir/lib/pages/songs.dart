import 'dependencies.dart';

//Songs Class
class Songs extends StatelessWidget {
  final String thisName;
  final Map<String, dynamic> tracks;
  const Songs({super.key, required this.thisName, required this.tracks});

  @override
  Widget build(BuildContext context) {
    var docSnapshot =
        FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get();

    var theseSongs = [];

    //log('Document exists');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(thisName),
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
            future: getGlobalSongData(tracks),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  //collection data
                  var temp = snapshot.data;
                  //("Song data: $temp.toString()");
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: createListOfSongs(temp, context),
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
