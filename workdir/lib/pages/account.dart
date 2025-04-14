import 'dependencies.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  _MyAccount createState() => _MyAccount();
}

class _MyAccount extends State<MyAccount> {
  String _uName = globals.userDoc["username"];

  void updateUName(String newUName) {
    setState(() {
      _uName = newUName;
    });
  }

  bool isLinked(String service) {
    if (globals.userDoc["Linked Accounts"][service] == null) {
      log(globals.userDoc["Linked Accounts"][service].toString());
      log(service.toString());
      return false;
    } else {
      return globals.userDoc["Linked Accounts"][service][0];
    }
  }

  updateUserDoc() async {
    globals.userDoc = await getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();
    final globals = Provider.of<Globals>(context);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("My Account"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: const Text("Username"),
                  subtitle: Text(_uName),
                  onLongPress:
                      () => {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Username"),
                              content: TextField(
                                controller: _textController,
                                decoration: const InputDecoration(
                                  hintText: "Enter new username",
                                ),
                              ),

                              actions: [
                                TextButton(
                                  onPressed: () {
                                    globals.userDoc.reference.update({
                                      'username': _textController.text,
                                    });
                                    updateUserDoc();
                                    updateUName(_textController.text);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        ),
                      }, //thisConnection.getMyAccount()),
                ),
                Divider(),
                ListTile(
                  title: const Text("Email"),
                  subtitle: Text(
                    globals.userDoc["email"],
                  ), //thisConnection.getMyAccount()),
                ),
                Divider(),
                ListTile(
                  title: const Text("Linked Accounts"),
                  subtitle: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Spotify"),
                          SizedBox(height: 5),
                          Text(
                            isLinked("Spotify") ? "Linked" : "Not Linked",
                            style: TextStyle(
                              color:
                                  isLinked("Spotify")
                                      ? Colors.green
                                      : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("YouTube Music"),
                          SizedBox(height: 5),
                          Text(
                            isLinked("YouTube Music") ? "Linked" : "Not Linked",
                            style: TextStyle(
                              color:
                                  isLinked("YouTube Music")
                                      ? Colors.green
                                      : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Apple Music"),
                          SizedBox(height: 5),
                          Text(
                            isLinked("Apple Music") ? "Linked" : "Not Linked",
                            style: TextStyle(
                              color:
                                  isLinked("Apple Music")
                                      ? Colors.green
                                      : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ), //thisConnection.getMyAccount()),
                ),
              ],
            ),
            //thisConnection.getMyAccount()),
          ],
        ),
      ),
    );
  }
}
