import 'package:flutter/material.dart';
import 'package:riceking_app/pages/camera_page.dart';
import 'package:riceking_app/pages/encyclopedia_page.dart';
import 'package:riceking_app/pages/about_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rice Disease Detection',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rice Disease Detection')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EncyclopediaPage()));
              },
              child: Text('小百科'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPage()));
              },
              child: Text('拍照辨識'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
              },
              child: Text('關於我們'),
            ),
          ],
        ),
      ),
    );
  }
}
