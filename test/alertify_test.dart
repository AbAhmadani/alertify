import 'package:flutter_test/flutter_test.dart';
import 'package:alertify/alertify.dart'; // Adjust the import based on your package structure

void main() {
  group('AlertNotifier Tests', () {
    late AlertNotifier alertNotifier;

    setUp(() {
      // Set up a fresh instance of AlertNotifier before each test
      alertNotifier = AlertNotifier();
    });

    test('Initial state should have no alerts', () {
      expect(alertNotifier.alerts.isEmpty, true);
    });

    test('showAlert should add an alert', () {
      alertNotifier.showAlert(
        key: 'alert1',
        message: 'Test Alert',
        type: AlertType.success,
        duration: 3,
      );
      expect(alertNotifier.alerts.containsKey('alert1'), true);
    });

    test('hideAlert should remove an alert', () {
      alertNotifier.showAlert(
        key: 'alert1',
        message: 'Test Alert',
        type: AlertType.success,
      );
      alertNotifier.hideAlert('alert1');
      expect(alertNotifier.alerts.containsKey('alert1'), false);
    });

    test('getMessage should return correct message', () {
      alertNotifier.showAlert(
        key: 'alert1',
        message: 'Test Alert',
        type: AlertType.success,
      );
      expect(alertNotifier.getMessage('alert1'), 'Test Alert');
    });

    test('getDuration should return correct duration', () {
      alertNotifier.showAlert(
        key: 'alert1',
        message: 'Test Alert',
        type: AlertType.success,
        duration: 5,
      );
      expect(alertNotifier.getDuration('alert1'), 5);
    });

    test('isVisible should return true for active alerts', () {
      alertNotifier.showAlert(
        key: 'alert1',
        message: 'Test Alert',
        type: AlertType.success,
      );
      expect(alertNotifier.isVisible('alert1'), true);
    });

    test('isVisible should return false for removed alerts', () {
      alertNotifier.showAlert(
        key: 'alert1',
        message: 'Test Alert',
        type: AlertType.success,
      );
      alertNotifier.hideAlert('alert1');
      expect(alertNotifier.isVisible('alert1'), false);
    });
  });
}
