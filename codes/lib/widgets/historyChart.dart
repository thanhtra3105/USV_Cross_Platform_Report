// Trong historyChart.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart'; // 👈 Cần thêm thư viện intl để định dạng thời gian
import 'dart:math';

class HistoryChart extends StatelessWidget {
  final String title;
  final Map<String, List<FlSpot>> dataSets;
  final Map<String, Color> colors;
  // BỎ: final List<String> timeLabels; // 👈 Bỏ đi

  const HistoryChart({
    super.key,
    required this.title,
    required this.dataSets,
    required this.colors,
    // BỎ: required this.timeLabels,
  });

  // ... (giữ nguyên _sortedSpots)

  @override
  Widget build(BuildContext context) {
    const int maxPoints = 6;

    final limitedDataSets = {
      for (var entry in dataSets.entries)
        // Lấy danh sách điểm từ cuối
        entry.key: entry.value.length > maxPoints
            ? entry.value.sublist(entry.value.length - maxPoints)
            : entry.value,
    };

    final allSpots = limitedDataSets.values.expand((list) => list).toList();

    double? minX;
    double? maxX;

    if (allSpots.isNotEmpty) {
      minX = allSpots.map((spot) => spot.x).reduce(min);
      maxX = allSpots.map((spot) => spot.x).reduce(max);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 250,
          child: LineChart(
            LineChartData(
              // Đặt minX và maxX để trục X thể hiện mốc thời gian
              minX: minX,
              maxX: maxX,
              minY: 5,
              maxY: 12,
              gridData: FlGridData(show: true),
              borderData: FlBorderData(show: true),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 35,
                    interval: 2,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles:
                        allSpots.isNotEmpty, // Chỉ hiển thị nếu có dữ liệu
                    reservedSize: 30, // Tăng reservedSize để nhãn không bị cắt
                    interval:
                        1000 *
                        3, // Khoảng cách giữa các nhãn (ví dụ: 3 giây, tương ứng với chu kỳ update)
                    getTitlesWidget: (value, meta) {
                      // Chuyển mốc thời gian Unix (double) sang DateTime
                      final dateTime = DateTime.fromMillisecondsSinceEpoch(
                        value.toInt(),
                      );

                      // Định dạng thời gian (ví dụ: HH:mm:ss)
                      final formatter = DateFormat('HH:mm:ss');
                      final timeString = formatter.format(dateTime);

                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        // Xoay nhãn để dễ đọc hơn nếu cần
                        child: Transform.rotate(
                          angle: -3.14 / 6, // Xoay 30 độ
                          child: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              timeString,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              lineBarsData: limitedDataSets.entries.map((entry) {
                // ... (logic tạo LineChartBarData không đổi)
                final spots = _sortedSpots(entry.value);
                return LineChartBarData(
                  spots: spots,
                  isCurved: false,
                  color: colors[entry.key],
                  barWidth: 2,
                  isStrokeCapRound: false,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) =>
                        FlDotCirclePainter(
                          radius: 3,
                          color: colors[entry.key]!,
                        ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: dataSets.keys.map((name) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 12, height: 12, color: colors[name]),
                const SizedBox(width: 4),
                Text(name),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  List<FlSpot> _sortedSpots(List<FlSpot> spots) {
    final sorted = [...spots];
    sorted.sort((a, b) => a.x.compareTo(b.x));
    return sorted;
  }
}
