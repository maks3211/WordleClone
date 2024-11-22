import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/providers/level_provider.dart';
import 'package:wordle_app/providers/user_provider.dart';
import 'package:wordle_app/utils/chart_series.dart';


class WinChart extends StatefulWidget {
  const WinChart({super.key});

  @override
  State<WinChart> createState() => _WinChartState();
}

class _WinChartState extends State<WinChart> {
  double selectedLevel = 5;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final initialLevel = Provider.of<LevelProvider>(context, listen: false).level;
      setState(() {
        selectedLevel = initialLevel;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LevelProvider>(
      builder: (_, levelNotifier, __) {
        return Consumer<UserProvider>(
          builder: (_, userProvider, __) {
            return FutureBuilder<List<BarChartGroupData>>(
              future: getSeries(level: levelNotifier.level.toInt(), user: userProvider.username),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Błąd: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  final series = snapshot.data!;
                  return BarChart(
                    BarChartData(
                      barTouchData: barTouchData,
                      barGroups: series,
                      titlesData: const FlTitlesData(
                        show: true,
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: const FlGridData(show: false),
                    ),
                  );
                } else {
                  return const SizedBox(); // Pusty widget w przypadku braku danych
                }
              },
            );
          },
        );
      },
    );
  }
  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      getTooltipColor: (group) => Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {

        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );
}