import 'package:flutter/material.dart';
import 'alert_screen.dart';

class LiveSensorScreen extends StatelessWidget {
  const LiveSensorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int dummyValue = 300;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Sensor Data'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Water Level',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '$dummyValue',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AlertScreen()),
                  );
                },
                child: const Text('Go to Alert Screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
