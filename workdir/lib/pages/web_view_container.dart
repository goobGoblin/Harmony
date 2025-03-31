import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  final String url; // Accept URL as a parameter
  const WebViewExample({super.key, required this.url});

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  // Declare the WebViewController
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the WebView and its controller
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(
            Uri.parse(widget.url),
          ); // Load the URL passed from the constructor
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('External Website')),
      body: WebViewWidget(
        controller: _controller,
      ), // Use WebViewWidget to display the WebView
    );
  }
}
