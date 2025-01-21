import 'package:api_project/core/bloc/bloc.dart';
import 'package:api_project/my_app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(DevicePreview(enabled: true, builder: (context) => const MyApp()));
}
