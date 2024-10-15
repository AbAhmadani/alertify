<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

Alertify is a simple and customizable alert system for Flutter applications that allows developers to easily display notifications of various types, including success, error, warning, and info messages. With Alertify, you can enhance the user experience by providing clear feedback and alerts throughout your application.

## Features

- Display alerts with different types (success, error, warning, info).
- Customizable alert duration.
- Callbacks for when alerts are shown or closed.
- Easy integration with the Provider package for state management.
- Lightweight and easy to use.

## Getting started

To get started with Alertify, ensure you have Flutter installed on your machine. If you haven’t already, create a new Flutter project:

```bash
flutter create my_project
cd my_project

## Usage

To use the `Alertify` package in your Flutter project, follow the steps below:

### Step 1: Add Dependency

First, add the `alertify` package to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  alertify: ^1.0.0  # Check for the latest version on pub.dev
  provider: ^6.0.0   # Also ensure provider is added for state management

### Step 2: Add ChangeNotifierProvider

Add ChangeNotifierProvider in Main to Initialize AlertNotifier

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

### Step 3: Use of AlertWidget in Your App

AlertWidget(uniqueKey: "your_alert_Key"),

final alertNotifier = Provider.of<AlertNotifier>(context);

alertNotifier.showAlert(
                  key: 'your_alert_Key',
                  message: 'This is a message alert!',
                  type: AlertType.success/error/warning/info,
                  duration: 3, //Optional Default 2 sec
                  onShow: () => print('Alert shown!'),
                  onClose: () => print('Alert closed!'),
                );
