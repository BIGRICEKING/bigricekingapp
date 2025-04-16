import 'package:flutter/material.dart';

class EncyclopediaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('小百科')),
      body: Center(
        child: Text('這裡顯示病害資訊或圖片說明'),
      ),
    );
  }
}
