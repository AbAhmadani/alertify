library alertify;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'src/alert_notifier.dart';
part 'src/widget_alert.dart';

class Alertify {
  static BuildContext? _context; // Store the context here

  // Initialize the Alertify with context
  static void init(BuildContext context) {
    _context = context;
  }

  static void showAlert({
    required String alertKey,
    required String message,
    required AlertType type,
    int? duration,
    VoidCallback? onShow,
    VoidCallback? onClose,
  }) {
    // Check if the context is initialized
    if (_context == null) {
      throw Exception(
          "Alertify is not initialized. Call Alertify.init(context) in main.");
    }

    _context!.read<AlertNotifier>().showAlert(
          alertKey: alertKey,
          message: message,
          type: type,
          duration: duration,
          onShow: onShow,
          onClose: onClose,
        );
  }
}
