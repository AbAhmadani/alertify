part of alertify;

enum AlertType {
  success,
  error,
  warning,
  info,
}

class AlertNotifier extends ChangeNotifier {
  final Map<String, AlertData> _alerts = {}; // Store alerts
  Map<String, AlertData> get alerts => _alerts;

  void showAlert({
    required String alertKey,
    required String message,
    required AlertType type,
    int? duration,
    Function()? onShow,
    Function()? onClose,
  }) {
    _alerts[alertKey] = AlertData(message, type, duration, onShow, onClose);
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

  bool isVisible(String key) {
    return _alerts.containsKey(key);
  }

  String getMessage(String key) {
    return _alerts[key]?.message ?? '';
  }

  AlertType getType(String key) {
    return _alerts[key]?.type ?? AlertType.info;
  }

  int getDuration(String key) {
    return _alerts[key]?.duration ?? 2;
  }
}

class AlertData {
  final String message;
  final AlertType type;
  final int? duration;
  final Function()? onShow;
  final Function()? onClose;

  AlertData(this.message, this.type, this.duration, this.onShow, this.onClose);
}
