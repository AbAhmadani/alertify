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

  void hideAlert(String alertKey) {
    if (_alerts.containsKey(alertKey)) {
      _alerts[alertKey]?.onClose?.call();
      _alerts.remove(alertKey);
      notifyListeners();
    }
  }

  bool isVisible(String alertKey) {
    return _alerts.containsKey(alertKey);
  }

  String getMessage(String alertKey) {
    return _alerts[alertKey]?.message ?? '';
  }

  AlertType getType(String alertKey) {
    return _alerts[alertKey]?.type ?? AlertType.info;
  }

  int getDuration(String alertKey) {
    return _alerts[alertKey]?.duration ?? 2;
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
