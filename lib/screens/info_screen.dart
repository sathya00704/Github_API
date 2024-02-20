import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InfoScreen extends StatefulWidget {
  //const InfoScreen({Key? key}) : super(key: key);
  String title;
  String url;
  InfoScreen(this.title,this.url);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final _key = UniqueKey();
  Completer<WebViewController>? _controller;
  int _position = 1;

  @override
  void initState() {
    super.initState();
    _controller = Completer<WebViewController>();
  }

  void doneLoading(String url) {
    setState(() {
      _position = 0;
    });
  }

  void startLoading(String url) {
    setState(() {
      _position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _position,
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: widget.url,
            onWebViewCreated: (WebViewController webViewController) {
              if (!_controller!.isCompleted) {
                _controller!.complete(webViewController);
              }
            },
            onPageFinished: doneLoading,
            onPageStarted: startLoading,
          ),
          Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
