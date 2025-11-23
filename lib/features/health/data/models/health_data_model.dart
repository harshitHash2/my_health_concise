
import 'package:hive/hive.dart';
import 'package:my_health_concise/features/health/domain/entities/health_data.dart';

import 'health_metric_model.dart';

part 'health_data_model.g.dart';

@HiveType(typeId: 1)
class HealthDataModel {
  @HiveField(0)
  String user;

  @HiveField(1)
  String lastUpdated;

  @HiveField(2)
  List<HealthMetricModel> metrics;

  HealthDataModel({
    required this.user,
    required this.lastUpdated,
    required this.metrics,
  });

  factory HealthDataModel.fromJson(Map<String, dynamic> json) {
    return HealthDataModel(
      user: json['user'],
      lastUpdated: json['last_updated'],
      metrics: (json['metrics'] as List)
          .map((m) => HealthMetricModel.fromJson(m))
          .toList(),
    );
  }
  
  Map<String, dynamic> toJson() => {
        'user': user,
        'last_updated': lastUpdated,
        'metrics': metrics.map((e) => e.toJson()).toList(),
      };

      HealthData toEntity() {
    return HealthData(
      user: user,
      lastUpdated: DateTime.parse(lastUpdated),
      metrics: metrics.map((m) => m.toEntity()).toList(),
    );
  }
}
