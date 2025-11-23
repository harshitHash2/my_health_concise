import 'package:flutter/material.dart';

import '../../../../core/utils/status_color_mapper.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/entities/health_metric.dart';
import '../screens/metric_detail_screen.dart';

class MetricCard extends StatelessWidget {
  final HealthMetric metric;

  const MetricCard({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    final bgColor = StatusColorMapper.background(context, metric.status);

    return Hero(
      tag: 'metric_${metric.name}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.pushNamed(
              context,
              MetricDetailScreen.routeName,
              arguments: metric,
            );
          },
          child: AppCard(
            background: bgColor,
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
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            metric.value.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            metric.unit,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Normal range: ${metric.range}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
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
    );
  }
}
