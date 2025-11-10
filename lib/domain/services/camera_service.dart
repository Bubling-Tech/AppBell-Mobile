import 'package:flutter/widgets.dart';

abstract class CameraService {
  Future<void> openCameraAndReturn(BuildContext context);
}
