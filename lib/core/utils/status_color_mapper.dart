
import 'package:flutter/material.dart';
import '../../features/health/domain/entities/health_metric.dart';

class StatusColorMapper {
 
  static Color background(BuildContext context, HealthStatus status) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (status) {
      case HealthStatus.normal:
        return isDark
            ? const Color(0xFF1B3A2C)
            : const Color(0xFFDFF5E4);

      case HealthStatus.high:
        return isDark
            ? const Color(0xFF4A2E00) 
            : const Color(0xFFFFF0D3);

      case HealthStatus.low:
        return isDark
            ? const Color(0xFF4A1F1F)
            : const Color(0xFFFFE0E0);
    }
  }


  static Color badge(HealthStatus status) {
    switch (status) {
      case HealthStatus.normal:
        return Colors.green;
      case HealthStatus.high:
        return Colors.orange;
      case HealthStatus.low:
        return Colors.red;
    }
  }


  static String label(HealthStatus status) {
    switch (status) {
      case HealthStatus.normal:
        return 'Normal';
      case HealthStatus.high:
        return 'High';
      case HealthStatus.low:
        return 'Low';
    }
  }
}
