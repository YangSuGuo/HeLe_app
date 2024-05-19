import 'package:logger/logger.dart';

class EnvConfig {
  final String appName;
  final String baseUrl;
  final bool shouldCollectCrashLog;

  late final Logger logger;

  EnvConfig({
    required this.appName,
    required this.baseUrl,
    this.shouldCollectCrashLog = false,
  }) {
    logger = Logger(
      printer: PrettyPrinter(
          methodCount: 2,
          // 要显示的方法调用数
          errorMethodCount: 8,
          // 如果提供了 StackTrace，则调用方法的次数
          lineLength: 120,
          // 输出宽度
          colors: true,
          // 彩色日志消息
          printEmojis: true,
          // 为每条日志消息打印一个表情符号
          printTime: false // 每个日志打印是否应包含时间戳
          ),
    );
  }
}
