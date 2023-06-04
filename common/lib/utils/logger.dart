import 'dart:math';

import 'time.dart';

void logger(String logStr) {
  const int LOG_LEN = 300;
  const int MAX_SLICE_SIZE = 10;

  String prefix = "[${getCurrentTime()}] ";
  String postfix = "";

  if (logStr.length < LOG_LEN) {
    print("$prefix $logStr$postfix");
  } else {
    int sliceCnt = (logStr.length / LOG_LEN).floor();
    for (int i = 0; i <= min(sliceCnt, MAX_SLICE_SIZE); i++) {
      final end = min(logStr.length, LOG_LEN * (i + 1));
      if (i > 0) prefix = "";
      if (sliceCnt > MAX_SLICE_SIZE && i >= MAX_SLICE_SIZE) {
        postfix = "...";
      }
      print("$prefix${logStr.substring(LOG_LEN * i, end)}$postfix");
      postfix = "";
    }
  }
}
