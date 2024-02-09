import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<File?> imageFiles = [null, null, null];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capturing Images'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              for (int i = 0; i < 3; i++)
                Container(
                  width: double.infinity,
                  height: 240,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(width: 8, color: Colors.black12),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: imageFiles[i] != null
                      ? Image.file(
                    imageFiles[i]!,
                    width: double.infinity,
                    height: 240,
                    fit: BoxFit.cover,
                  )
                      : const Center(
                    child: Text(
                      'Image should appear here',
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => getImage(source: ImageSource.camera),
                      child: const Text('Capture Image', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => getImage(source: ImageSource.gallery),
                      child: const Text('Select Image', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void getImage({required ImageSource source}) async {
    final List<XFile>? files = await ImagePicker().pickMultiImage();

    if (files != null) {
      setState(() {
        for (int i = 0; i < files.length && i < 3; i++) {
          imageFiles[i] = File(files[i].path);
        }
      });
    }
  }
}
