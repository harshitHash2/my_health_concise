import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_health_concise/features/health/presentation/providers/theme_provider.dart';

import '../../../../core/utils/status_color_mapper.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/entities/health_metric.dart';
import '../widgets/trend_chart.dart';

class MetricDetailScreen extends StatelessWidget {
  static const routeName = '/metric-detail';

  final HealthMetric metric;

  const MetricDetailScreen({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    final bgColor = StatusColorMapper.background(context, metric.status);

    return Scaffold(
      appBar: AppBar(
        title: Text(metric.name),
        actions: [
    Consumer(
      builder: (context, ref, _) {
        final themeMode = ref.watch(themeModeProvider);

        return IconButton(
          // icon: new Icon(Icons.medical_information),
          icon: Icon(
            themeMode == ThemeMode.dark
                ? Icons.light_mode   
                : Icons.dark_mode,
          ),
          onPressed: () {
            final notifier = ref.read(themeModeProvider.notifier);

            notifier.state =
                themeMode == ThemeMode.light
                    ? ThemeMode.dark     
                    : ThemeMode.light;   
          },
        );
      },
    ),
  ],
      ),
      body: AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  color: bgColor.withOpacity(0.3),
  child: SafeArea(
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'metric_${metric.name}',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,         
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Expanded(                   
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              metric.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  metric.value.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  metric.unit,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Normal range: ${metric.range}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      StatusBadge(status: metric.status),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Trend',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              height: 220,
              child: TrendChart(metric: metric),
            ),

            const SizedBox(height: 24),

            Text(
              _trendDescription(metric),
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    ),
  ),
),
      // body: AnimatedContainer(
      //   duration: const Duration(milliseconds: 300),
      //   color: bgColor.withOpacity(0.3),
      //   child: SafeArea(
      //     child: SingleChildScrollView(
      //       padding: const EdgeInsets.all(16),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Hero(
      //             tag: 'metric_${metric.name}',
      //             child: Material(
      //               color: Colors.transparent,
      //               child: Container(
      //                 padding: const EdgeInsets.all(16),
      //                 decoration: BoxDecoration(
      //                   color: bgColor,
      //                   borderRadius: BorderRadius.circular(16),
      //                 ),
      //                 child: Row(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Flexible(
      //                       child: Column(
      //                         crossAxisAlignment:
      //                             CrossAxisAlignment.start,
      //                         children: [
      //                           Text(
      //                             metric.name,
      //                             style: const TextStyle(
      //                               fontSize: 18,
      //                               fontWeight: FontWeight.w700,
      //                             ),
      //                           ),
      //                           const SizedBox(height: 8),
      //                           Row(
      //                             crossAxisAlignment:
      //                                 CrossAxisAlignment.end,
      //                             children: [
      //                               Text(
      //                                 metric.value.toStringAsFixed(1),
      //                                 style: const TextStyle(
      //                                   fontSize: 28,
      //                                   fontWeight: FontWeight.bold,
      //                                 ),
      //                               ),
      //                               const SizedBox(width: 4),
      //                               Text(
      //                                 metric.unit,
      //                                 style: const TextStyle(
      //                                   fontSize: 16,
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                           const SizedBox(height: 6),
      //                           Text(
      //                             'Normal range: ${metric.range}',
      //                             style: TextStyle(
      //                               fontSize: 13,
      //                               color: Colors.grey.shade800,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                     const SizedBox(width: 12),
      //                     StatusBadge(status: metric.status),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //           const SizedBox(height: 24),
      //           const Text(
      //             'Trend',
      //             style: TextStyle(
      //               fontSize: 16,
      //               fontWeight: FontWeight.w600,
      //             ),
      //           ),
      //           const SizedBox(height: 8),
      //           TrendChart(metric: metric),
      //           const SizedBox(height: 24),
      //           Text(
      //             _trendDescription(metric),
      //             style: const TextStyle(fontSize: 14),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  String _trendDescription(HealthMetric metric) {
    if (metric.history.length < 2) return 'Not enough data for trend.';

    final first = metric.history.first;
    final last = metric.history.last;

    if (last > first) {
      return 'This metric is trending up over time.';
    } else if (last < first) {
      return 'This metric is trending down over time.';
    } else {
      return 'This metric has remained stable over time.';
    }
  }
}
