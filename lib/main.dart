import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'utils/state_logger.dart';

void main() {
  runApp(ProviderScope(observers: [StateLogger()], child: MyApp()));
}
