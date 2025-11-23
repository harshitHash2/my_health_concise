import 'health_metric.dart';

class HealthData {
  final String user;
  final DateTime lastUpdated;
  final List<HealthMetric> metrics;

  const HealthData({
    required this.user,
    required this.lastUpdated,
    required this.metrics,
  });
}
