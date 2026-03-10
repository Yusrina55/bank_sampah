import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme.dart';

class TransactionChartSection extends StatelessWidget {
  const TransactionChartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: bordergrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Keuntungan Tiap Bulan (dalam Ribu)",
            style: medium12,
          ),
          const SizedBox(height: 20),

          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 800,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: blue1,
                    tooltipRoundedRadius: 8,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        rod.toY.toInt().toString(),
                        regular12.copyWith(
                          color: white,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 200,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: regular12.copyWith(
                            fontSize: 10,
                            color: textgrey2,
                          ),
                        );
                      },
                      reservedSize: 28,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(fontSize: 10);
                        switch (value.toInt()) {
                          case 0:
                            return Text('M1', style: style);
                          case 1:
                            return Text('M2', style: style);
                          case 2:
                            return Text('M3', style: style);
                          case 3:
                            return Text('M4', style: style);
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: 200,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: bordergrey,
                      strokeWidth: 1,
                    );
                  },
                ),
                barGroups: [
                  _barData(0, 500),
                  _barData(1, 450),
                  _barData(2, 700),
                  _barData(3, 750),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _barData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 18,
          borderRadius: BorderRadius.circular(6),
          color: blue1,
        ),
      ],
    );
  }
}