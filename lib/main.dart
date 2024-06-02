import 'package:flutter/material.dart';
import 'package:hele_app/Application.dart';

import 'common/flavors/build_config.dart';
import 'common/flavors/env_config.dart';
import 'common/flavors/environment.dart';

void main() {
  // 开发环境配置
  EnvConfig devConfig = EnvConfig(
    appName: "Flutter",
  );

  // 设置环境配置
  BuildConfig.instantiate(
    envType: Environment.DEVELOPMENT,
    envConfig: devConfig,
  );

  runApp(const Application());
}