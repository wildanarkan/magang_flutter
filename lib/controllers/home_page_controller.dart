import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class HomePageController extends GetxController {
  var startTime = ''.obs;
  var endTime = ''.obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadStartTime();
    _updateEndTime();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      _updateEndTime();
    });
  }

  void _loadStartTime() {
    String? storedStartTime = storage.read('startTime');
    if (storedStartTime == null || !_isToday(storedStartTime)) {
      startTime.value = DateFormat.Hm().format(DateTime.now());
      storage.write('startTime', startTime.value);
    } else {
      startTime.value = storedStartTime;
    }
  }

  void _updateEndTime() {
    endTime.value = DateFormat.Hm().format(DateTime.now());
  }

  bool _isToday(String time) {
    DateTime now = DateTime.now();
    DateTime storedTime = DateFormat.Hm().parse(time);
    return now.day == storedTime.day &&
           now.month == storedTime.month &&
           now.year == storedTime.year;
  }
}
