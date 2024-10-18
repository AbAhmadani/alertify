# Alertify

**Alertify** is a simple and customizable alert system for Flutter applications that allows developers to easily display notifications of various types, including success, error, warning, and info messages. With Alertify, you can enhance the user experience by providing clear feedback and alerts throughout your application.

## Features

- **Multiple Alert Types:** Display alerts for success, error, warning, and info messages.
- **Customizable Duration:** Set the duration for how long alerts are shown.
- **Callbacks:** Define actions for when alerts are shown or closed.
- **Easy Integration:** Seamlessly integrate with the Provider package for state management.
- **Lightweight:** Simple to use and integrate into any Flutter project.

## Getting Started

To get started with Alertify, ensure you have Flutter installed on your machine. If you haven’t already, create a new Flutter project:

```bash
flutter create my_project
cd my_project
```

## Usage

To use the `Alertify` package in your Flutter project, follow these steps:

### Step 1: Add Dependency

Add the `alertify` package to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  alertify: ^1.0.0  # Check for the latest version on pub.dev
  provider: ^6.0.5   # Ensure provider is included for state management
```

### Step 2: Initialize AlertNotifier

In your `main.dart` file, wrap your app with `ChangeNotifierProvider` to initialize `AlertNotifier`:

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alertify/alertify.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AlertNotifier(),
      child: MyApp(),
    ),
  );
}

@override
Widget build(BuildContext context) {
  Alertify.init(context); // Initialize with main context
  ...
}
```

### Step 3: Use AlertWidget in Your App

You can use the `AlertWidget` and show alerts as follows:

```dart
AlertWidget(alertKey: "your_alert_key"),

Alertify.showAlert(
  context,
  alertKey: 'your_alert_key',
  message: 'This is a message alert!',
  type: AlertType.success, // Choose between success/error/warning/info
  duration: 3, // Optional: Default is 2 seconds
  onShow: () => print('Alert shown!'),
  onClose: () => print('Alert closed!'),
);
```

## Conclusion

With Alertify, you can easily implement a responsive alert system in your Flutter applications, enhancing user interaction and experience. For more information and updates, feel free to check the [pub.dev package page](https://pub.dev/packages/alertify).
