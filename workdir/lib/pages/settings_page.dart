import 'dependencies.dart';

class SettingsRoute extends StatelessWidget {
  const SettingsRoute({super.key});

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
