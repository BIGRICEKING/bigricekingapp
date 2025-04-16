import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('關於我們')),
      body: Center(
        child: Text('我們是一個致力於農業科技的團隊 :)'),
      ),
    );
  }
}
