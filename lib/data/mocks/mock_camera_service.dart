import 'package:flutter/material.dart';

import '../../domain/services/camera_service.dart';
import '../../routes/app_router.dart';

class MockCameraService implements CameraService {
  const MockCameraService();

  @override
  Future<void> openCameraAndReturn(BuildContext context) async {
    await Navigator.of(context).pushNamed('/camera');
    goHome(context);
  }
}
