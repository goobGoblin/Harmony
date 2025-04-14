// widgets/main_layout.dart

import 'dependencies.dart'; // If you store global variables here

class MainLayout extends StatefulWidget {
  const MainLayout({super.key, required this.child});
  final Widget child;

  @override
  _MainLayout createState() => _MainLayout();
}

class _MainLayout extends State<MainLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Access Globals here
    final globals = Provider.of<Globals>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Player App')),
      body: Column(
        children: [
          Text(
            'Current Index: ${globals.currentIndex}',
          ), // Example usage of globals
          globals.bottomPlayer, // Display the bottom player
        ],
      ),
      bottomSheet: globals.bottomPlayer, // Access bottomPlayer in bottomSheet
    );
  }
}
