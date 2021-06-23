import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'hexColor.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('343A40'),
        elevation: 0,
        toolbarHeight: 70,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('プライバシーポリシー'),
      ),
      body: WebView(
        initialUrl: 'https://lab316.github.io/app-static-page/ja/privacy.html?company=coalabo,%20inc.&department=%E9%96%8B%E7%99%BA%E6%8B%85%E5%BD%93%E8%80%85&email=developer.ikep%40gmail.com',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
