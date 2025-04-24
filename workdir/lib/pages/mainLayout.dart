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
    return Scaffold(
      body: Stack(
        children: [
          widget.child,
          Align(
            alignment: Alignment.bottomCenter,
            child: ValueListenableBuilder<Widget>(
              valueListenable: globals.bottomPlayerListener,
              builder: (context, player, _) => player,
            ),
          ),
        ],
      ),
    );
  }
}
