import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'dart:io';

import 'result_page.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  late List<CameraDescription> cameras;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _wakeUpServer();  // 在這裡呼叫，開啟 App 就會喚醒伺服器
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller?.initialize();
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _wakeUpServer() async {
    try {
      var response = await http.get(Uri.parse('https://ricekingapp.onrender.com/'));
      if (response.statusCode == 200) {
        print('伺服器已喚醒！狀態碼：${response.statusCode}');
      } else {
        print('喚醒伺服器失敗，狀態碼：${response.statusCode}');
      }
    } catch (e) {
      print('喚醒伺服器失敗: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  void _takePicture() async {
    try {
      final image = await _controller?.takePicture();
      setState(() {
        imagePath = image?.path;
      });

      if (imagePath != null) {
        uploadImage(imagePath!);
      }
    } catch (e) {
      print('拍照錯誤: $e');
    }
  }

  Future<void> uploadImage(String imagePath) async {
    try {
      File imageFile = File(imagePath);
      var uri = Uri.parse("http://192.168.68.112:5000/upload"); // 替換為你的 API URL
      var request = http.MultipartRequest("POST", uri)
        ..files.add(await http.MultipartFile.fromPath(
          'file',
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
        ));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var resultJson = jsonDecode(responseData.body);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetectionResultPage(resultData: resultJson),
          ),
        );
      } else {
        print("上傳失敗，狀態碼：${response.statusCode}");
      }
    } catch (e) {
      print("上傳圖片失敗: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text('拍照頁面')),
      body: Column(
        children: [
          Expanded(child: CameraPreview(_controller!)),
          if (imagePath != null)
            Image.file(File(imagePath!), height: 200),
          ElevatedButton(onPressed: _takePicture, child: Text('拍照')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('返回主頁'),
          ),
        ],
      ),
    );
  }
}
