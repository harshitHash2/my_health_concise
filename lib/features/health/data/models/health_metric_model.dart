
import 'package:hive/hive.dart';
import 'package:my_health_concise/features/health/domain/entities/health_metric.dart';

part 'health_metric_model.g.dart';

@HiveType(typeId: 0)
class HealthMetricModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  double value;

  @HiveField(2)
  String unit;

  @HiveField(3)
  String status;

  @HiveField(4)
  String range;

  @HiveField(5)
  List<double> history;

  HealthMetricModel({
    required this.name,
    required this.value,
    required this.unit,
    required this.status,
    required this.range,
    required this.history,
  });

  // Optional JSON helpers (keep or remove)
  factory HealthMetricModel.fromJson(Map<String, dynamic> json) {
    return HealthMetricModel(
      name: json['name'],
      value: (json['value'] as num).toDouble(),
      unit: json['unit'],
      status: json['status'],
      range: json['range'],
      history: List<double>.from(json['history'].map((x) => x.toDouble())),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'value': value,
        'unit': unit,
        'status': status,
        'range': range,
        'history': history,
      };
      HealthMetric toEntity() {
    return HealthMetric(
      name: name,
      value: value,
      unit: unit,
      status: _statusFromString(status),
      range: range,
      history: history,
    );
  }

  static HealthStatus _statusFromString(String value) {
    switch (value.toLowerCase()) {
      case 'normal':
        return HealthStatus.normal;
      case 'high':
        return HealthStatus.high;
      case 'low':
      default:
        return HealthStatus.low;
    }
  }
}