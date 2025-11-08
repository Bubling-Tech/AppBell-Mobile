import 'package:flutter/foundation.dart';
import 'package:to_com_bell_app/core/utils/result.dart';

class CheckinController extends ChangeNotifier {
  Result<void> status = Result.idle();

  Future<void> realizarCheckin() async {
    status = Result.loading();
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 800));
    status = Result.success(null);
    notifyListeners();
  }

  void reset() {
    status = Result.idle();
    notifyListeners();
  }
}
