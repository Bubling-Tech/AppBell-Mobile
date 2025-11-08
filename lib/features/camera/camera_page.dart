import 'package:flutter/material.dart';

import '../../shared_widgets/gradient_button.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Câmera', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          const Center(
            child: Icon(Icons.camera_alt, size: 120, color: Colors.white24),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
              child: GradientButton(
                text: 'Usar foto (mock)',
                onPressed: () {
                  Navigator.pop(context);
                },
                height: 52,
                borderRadius: BorderRadius.circular(26),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
