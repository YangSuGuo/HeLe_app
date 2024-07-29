# HeLe

## 项目简介

这是一个基于Flutter的跨平台App，主要使用bangumi开源API作为数据源。
实现跨平台的影视进度管理，未来实现本地进度管理进度数据上传云平台和影视资源更新与上线通知推送。

## 功能列表

- MD3 主题
- ... ...

## 项目依赖
~~~yaml
  # 国际化
  flutter_localizations: # 国际化
    sdk: flutter
  intl: ^0.19.0 # 国际化

  # 界面UI
  cupertino_icons: ^1.0.6 # icon
  font_awesome_flutter: ^10.7.0 # icon
  auto_size_text: ^3.0.0 # 文本自适应
  expand_widget: ^3.1.1 # 文本折叠
  loading_animation_widget: ^1.2.1 # 加载动画
  fl_chart: ^0.68.0 # 图表
  flutter_smart_dialog: ^4.9.6+1 # 弹窗
  custom_sliding_segmented_control: ^1.8.3 # 分段器
  gap: ^3.0.1 # 间隔

  # 网络请求
  dio: ^5.4.3+1 # 网络请求

  cookie_jar: ^4.0.8
  dio_cookie_manager: ^3.1.1
  connectivity_plus: ^6.0.1
  dio_http2_adapter: ^2.3.1+1

  # 开发工具
  cached_network_image: ^3.3.1 # 图片缓存
  flutter_screenutil: ^5.9.0 # 屏幕适配
  flutter_svg: ^2.0.10+1 # svg显示
  url_launcher: ^6.2.6 # url跳转
  easy_debounce: ^2.0.3 # 防抖
  share_plus: ^9.0.0 # 分享
  logger: ^2.3.0 # log
  nil: ^1.1.1 # 占位符

  # 状态管理
  get: ^4.6.6 # 路由 & 状态管理
  provider: ^6.1.2 # 状态管理

  # 本地存储
  shared_preferences: ^2.2.3 # 本地状态存储
~~~

## 项目环境
~~~
 Flutter (Channel stable, 3.22.2, on Microsoft Windows [版本 10.0.19045.3930], locale zh-CN)
 • Flutter version 3.22.2 on channel stable at H:\SDKs\Flutter
 • Upstream repository https://github.com/flutter/flutter.git
 • Framework revision 761747bfc5 (6 weeks ago), 2024-06-05 22:15:13 +0200
 • Engine revision edd8546116
 • Dart version 3.4.3
 • DevTools version 2.34.3
 • Pub download mirror https://pub.flutter-io.cn
 • Flutter download mirror https://storage.flutter-io.cn
~~~

## 项目结构
... ...

## 项目预览

| ![hele_app](https://t.tutu.to/img/8dq8i) | ![hele_app](https://t.tutu.to/img/8d9nJ) | ![hele_app](https://t.tutu.to/img/8dUeo) | ![hele_app](https://t.tutu.to/img/8dk1I) |
| :--------------------------------------: | :--------------------------------------: | :--------------------------------------: | :--------------------------------------: |
|                  动漫页                  |                  漫画页                  |                  资料页                  |                  资料页                  |



## 项目打包

```sh
flutter build apk --split-per-abi --obfuscate --split-debug-info=H:\Logs
```

#### 国际化重新生成
```sh
flutter gen-l10n
```

#### 数据库重新生成
```sh
dart run build_runner build
```
