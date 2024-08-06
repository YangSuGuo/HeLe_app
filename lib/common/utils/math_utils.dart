import 'dart:math';

import 'package:hele_app/model/rating.dart';

class MathUtils {
  /// 计算标准差
  static double calculateStandardDeviation(
      int? total, Count? count, double? averageScore) {
    if (total == null || total == 0 || count == null || averageScore == null)
      return 0.0;

    // 评分分布转换为List，用于计算
    List<int> scoresDistribution = [
      count.the1 ?? 0,
      count.the2 ?? 0,
      count.the3 ?? 0,
      count.the4 ?? 0,
      count.the5 ?? 0,
      count.the6 ?? 0,
      count.the7 ?? 0,
      count.the8 ?? 0,
      count.the9 ?? 0,
      count.the10 ?? 0,
    ];

    double sumOfSquares = 0;
    for (int i = 0; i < scoresDistribution.length; i++) {
      int rating = i + 1;
      // 计算每个评分的方差，然后累加 （评分 - 平均分)^2 * 评分人数
      sumOfSquares +=
          pow((rating.toDouble() - averageScore), 2) * scoresDistribution[i];
    }

    // 计算方差，然后取平方根得到标准差
    double variance = sumOfSquares / total;
    return sqrt(variance);
  }
}
