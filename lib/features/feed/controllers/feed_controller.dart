import 'package:flutter/foundation.dart';
import 'package:to_com_bell_app/core/mock/mock_data.dart';

class FeedController extends ChangeNotifier {
  List<Map<String, String>> stories = mockStories;

  Future<void> realizarCheckin(VoidCallback onCompleted) async {
    await Future.delayed(const Duration(milliseconds: 600));
    onCompleted();
  }
}
