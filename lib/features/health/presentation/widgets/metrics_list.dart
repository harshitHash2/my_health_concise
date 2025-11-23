import 'package:flutter/material.dart';

import '../../domain/entities/health_metric.dart';
import 'metric_card.dart';

class MetricsList extends StatelessWidget {
  final List<HealthMetric> metrics;

  const MetricsList({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    if (metrics.isEmpty) {
      return const Center(
        child: Text('No metrics found'),
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: ListView.builder(
        key: ValueKey(metrics.length),
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: metrics.length,
        itemBuilder: (context, index) {
          final metric = metrics[index];
          return MetricCard(metric: metric);
        },
      ),
    );
  }
}
