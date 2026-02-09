import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  int sensorValue = 300; // 👈 dummy value

  Color getAlertColor(int value) {
    if (value <= 200) {
      return Colors.green;
    } else if (value <= 300) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String getAlertText(int value) {
    if (value <= 200) {
      return "✅ Water level normal";
    } else if (value <= 300) {
      return "⚠️ Possible leakage detected";
    } else {
      return "🚨 CRITICAL WATER LEAKAGE!";
    }
  }

  Future<void> takePhoto() async {
    final XFile? photo =
        await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        _image = File(photo.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color alertColor = getAlertColor(sensorValue);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Leak Alert"),
        backgroundColor: alertColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              getAlertText(sensorValue),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: alertColor,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            Text(
              "Sensor Value: $sensorValue",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            _image != null
                ? Image.file(_image!, height: 200)
                : const Text("No photo taken yet"),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: takePhoto,
              icon: const Icon(Icons.camera_alt),
              label: const Text("Take Photo"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: alertColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
