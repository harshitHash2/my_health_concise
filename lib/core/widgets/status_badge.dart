import 'package:flutter/material.dart';

import '../../features/health/domain/entities/health_metric.dart';
import '../utils/status_color_mapper.dart';

class StatusBadge extends StatelessWidget {
  final HealthStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final color = StatusColorMapper.badge(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color),
      ),
      child: Text(
        StatusColorMapper.label(status),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
