import 'dependencies.dart';

class Albums extends StatelessWidget {
  final List<dynamic> albums;
  const Albums({super.key, required this.albums});

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
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: FutureBuilder(
            future: getGlobalAlbumData(albums),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  //collection data
                  var temp = snapshot.data;
                  //log("Album data: $temp");
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: createListOfAlbums(temp!, context),
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
    );
  }
}
