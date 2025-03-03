import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/themes.dart';

class _CustomTheme extends InheritedWidget {
  final CustomThemeState data;

  _CustomTheme({required this.data, Key? key, required Widget child})
    : super(key: key, child: child);

  @override
  bool updateShouldNotify(_CustomTheme oldWidget) {
    return true;
  }
}

class CustomTheme extends StatefulWidget {
  final Widget child;
  final bool isDark;

  const CustomTheme({required this.child, required this.isDark, Key? key})
    : super(key: key);

  @override
  CustomThemeState createState() => CustomThemeState();

  static ThemeData of(BuildContext context) {
    final _CustomTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_CustomTheme>();
    return inheritedTheme!.data.theme;
  }

  static CustomThemeState instanceOf(BuildContext context) {
    _CustomTheme inheritedThemeState =
        (context.dependOnInheritedWidgetOfExactType<_CustomTheme>()
            as _CustomTheme);
    return inheritedThemeState.data;
  }
}

class CustomThemeState extends State<CustomTheme> {
  late ThemeData _theme;

  ThemeData get theme => _theme;

  @override
  void initState() {
    _theme = Themes.getTheme(widget.isDark);
    super.initState();
  }

  @override
  void changeTheme(bool isDark) {
    setState(() {
      _theme = Themes.getTheme(isDark);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _CustomTheme(data: this, child: widget.child);
  }
}
