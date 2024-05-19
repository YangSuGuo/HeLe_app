import 'package:flutter/material.dart';
import 'package:hele_app/Application.dart';

import 'common/flavors/build_config.dart';
import 'common/flavors/env_config.dart';
import 'common/flavors/environment.dart';

void main() {
  EnvConfig devConfig = EnvConfig(
    appName: "Flutter",
    baseUrl: "https://",
    shouldCollectCrashLog: true,
  );

  BuildConfig.instantiate(
    envType: Environment.DEVELOPMENT,
    envConfig: devConfig,
  );

  runApp(const Application());
}