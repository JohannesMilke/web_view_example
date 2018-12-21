import 'dart:async';

import 'package:advent21_web_view/data/data.dart';
import 'package:advent21_web_view/model/web_page.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  @override
  WebViewWidgetState createState() => WebViewWidgetState();
}

class WebViewWidgetState extends State<WebViewWidget> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  int currentPageIndex;

  @override
  void initState() {
    super.initState();
    currentPageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final WebPage currentPage = webPages[currentPageIndex];

    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: currentPage.url,
          javaScriptMode: JavaScriptMode.unrestricted,
          onWebViewCreated: _controller.complete,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTapNavigation,
          currentIndex: currentPageIndex,
          items: webPages
              .map((webPage) => BottomNavigationBarItem(
                  icon: Icon(Icons.school), title: Text(webPage.title)))
              .toList()),
    );
  }

  void onTapNavigation(int index) {
    setState(() {
      currentPageIndex = index;
    });

    final WebPage currentPage = webPages[currentPageIndex];

    _controller.future.then((WebViewController controller) {
      controller.loadUrl(currentPage.url);
    });
  }
}
