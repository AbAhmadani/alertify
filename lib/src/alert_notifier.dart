part of alertify;

enum AlertType {
  success,
  error,
  warning,
  info,
}

class AlertNotifier with ChangeNotifier {
  final Map<String, AlertInfo> _alerts = {};

  void showAlert({
    required String key,
    required String message,
    required AlertType type,
    int? duration,
    Function? onShow,
    Function? onClose,
  }) {
    _alerts[key] = AlertInfo(
      message: message,
      type: type,
      onClose: onClose,
      duration: duration,
    );
    notifyListeners();

    onShow?.call();
  }

  void hideAlert(String key) {
    if (_alerts.containsKey(key)) {
      _alerts[key]?.onClose?.call();
      _alerts.remove(key);
      notifyListeners();
    }
  }

  bool isVisible(String key) => _alerts.containsKey(key);

  String getMessage(String key) => _alerts[key]?.message ?? '';

  AlertType getType(String key) => _alerts[key]?.type ?? AlertType.info;

  int getDuration(String key) => _alerts[key]?.duration ?? 2;

  /// Get all alerts.
  Map<String, AlertInfo> get alerts => _alerts;
}

class AlertInfo {
  final String message;
  final AlertType type;
  final Function? onClose;
  final int? duration;

  AlertInfo({
    required this.message,
    required this.type,
    this.onClose,
    this.duration,
  });
}
