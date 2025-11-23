enum HealthStatus { normal, high, low }

class HealthMetric {
  final String name;
  final double value;
  final String unit;
  final HealthStatus status;
  final String range;
  final List<double> history;

  const HealthMetric({
    required this.name,
    required this.value,
    required this.unit,
    required this.status,
    required this.range,
    required this.history,
  });
}
