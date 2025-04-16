import 'package:flutter/material.dart';
import 'encyclopedia_page.dart';

class DetectionResultPage extends StatelessWidget {
  final Map<String, dynamic> resultData;

  DetectionResultPage({required this.resultData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('檢測結果')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '病害名稱：${resultData["disease"]}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EncyclopediaPage()));
              },
              child: Text('前往小百科'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('返回首頁'),
            ),
          ],
        ),
      ),
    );
  }
}
