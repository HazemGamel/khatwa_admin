import 'dart:io';

import 'package:flutter/material.dart';
import 'core/http_override.dart';
import 'core/services/cache_storage_services.dart';
import 'app/app.dart';
import 'package:flutter/services.dart';
import 'core/errors/widget_error.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheStorageServices.init();
  HttpOverrides.global = MyHttpOverrides();
  setupOrientation();
  customErrorWidget();
  runApp(const SeliveryControl());
}

setupOrientation() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}
