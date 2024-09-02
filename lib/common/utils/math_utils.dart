import 'dart:math';

import 'package:hele_app/model/rating.dart';

class MathUtils {
  /// 计算标准差
  static double calculateStandardDeviation(int? total, Count? count, double? averageScore) {
    if (total == null || total == 0 || count == null || averageScore == null) return 0.0;

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
      sumOfSquares += pow((rating.toDouble() - averageScore), 2) * scoresDistribution[i];
    }

    // 计算方差，然后取平方根得到标准差
    double variance = sumOfSquares / total;
    return sqrt(variance);
  }

  // 评分计数
  static Count countRating(List<double> ratings) {
    Count count = Count(the1: 0, the2: 0, the3: 0, the4: 0, the5: 0, the6: 0, the7: 0, the8: 0, the9: 0, the10: 0);
    List<double> ratingsList = ratings;
    for (double rating in ratingsList) {
      int roundedScore = rating.round();
      if (roundedScore >= 1 && roundedScore <= 10) {
        count.the1 += roundedScore == 1 ? 1 : 0;
        count.the2 += roundedScore == 2 ? 1 : 0;
        count.the3 += roundedScore == 3 ? 1 : 0;
        count.the4 += roundedScore == 4 ? 1 : 0;
        count.the5 += roundedScore == 5 ? 1 : 0;
        count.the6 += roundedScore == 6 ? 1 : 0;
        count.the7 += roundedScore == 7 ? 1 : 0;
        count.the8 += roundedScore == 8 ? 1 : 0;
        count.the9 += roundedScore == 9 ? 1 : 0;
        count.the10 += roundedScore == 10 ? 1 : 0;
      }
    }
    print("评分分布：${count.toList().toString()}");
    return count;
  }
}
