library alertify;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'src/alert_notifier.dart';
part 'src/widget_alert.dart';

class Alertify {
  static void showAlert(
    BuildContext context, {
    required String key,
    required String message,
    required AlertType type,
    int? duration,
  }) {
    context.read<AlertNotifier>().showAlert(
          key: key,
          message: message,
          type: type,
          duration: duration ?? 3,
        );
  }
}
