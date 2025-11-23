import 'package:hive/hive.dart';

import '../models/health_data_model.dart';
import '../models/health_metric_model.dart';

class HealthLocalDataSource {
  final Box _box;

  HealthLocalDataSource(this._box);

  Future<HealthDataModel> getHealthData() async {
    final data = _box.get('user_health');
    if (data != null) {
      return HealthDataModel.fromJson(
        Map<String, dynamic>.from(data as Map),
      );
    }

    // Seed with initial JSON
    final seed = _seedData();
    await _box.put('user_health', seed.toJson());
    return seed;
  }

  HealthDataModel _seedData() {
  return HealthDataModel(
    user: 'Harshit Chauhan',
    lastUpdated: DateTime.now().toLocal().toString().split(' ').first,
    metrics: [
      // Original 5
      HealthMetricModel(
        name: 'Hemoglobin',
        value: 9.5,
        unit: 'g/dL',
        status: 'low',
        range: '12 - 16',
        history: [9.2, 9.3, 9.5],
      ),
      HealthMetricModel(
        name: 'Vitamin D',
        value: 20,
        unit: 'ng/mL',
        status: 'low',
        range: '30 - 80',
        history: [18, 19, 20],
      ),
      HealthMetricModel(
        name: 'Fasting Glucose',
        value: 138,
        unit: 'mg/dL',
        status: 'high',
        range: '70 - 100',
        history: [142, 140, 138],
      ),
      HealthMetricModel(
        name: 'Platelets',
        value: 210,
        unit: 'K/uL',
        status: 'normal',
        range: '150 - 450',
        history: [205, 208, 210],
      ),
      HealthMetricModel(
        name: 'WBC Count',
        value: 7.5,
        unit: 'K/uL',
        status: 'normal',
        range: '4 - 11',
        history: [7.2, 7.3, 7.5],
      ),

      // New Dummy Metrics (10 more)
      HealthMetricModel(
        name: 'RBC Count',
        value: 4.1,
        unit: 'M/uL',
        status: 'low',
        range: '4.5 - 5.9',
        history: [3.9, 4.0, 4.1],
      ),
      HealthMetricModel(
        name: 'Calcium',
        value: 8.7,
        unit: 'mg/dL',
        status: 'normal',
        range: '8.5 - 10.5',
        history: [8.4, 8.6, 8.7],
      ),
      HealthMetricModel(
        name: 'Creatinine',
        value: 1.3,
        unit: 'mg/dL',
        status: 'high',
        range: '0.6 - 1.2',
        history: [1.1, 1.2, 1.3],
      ),
      HealthMetricModel(
        name: 'Cholesterol',
        value: 210,
        unit: 'mg/dL',
        status: 'high',
        range: '< 200',
        history: [198, 205, 210],
      ),
      HealthMetricModel(
        name: 'HDL Cholesterol',
        value: 42,
        unit: 'mg/dL',
        status: 'normal',
        range: '40 - 60',
        history: [38, 40, 42],
      ),
      HealthMetricModel(
        name: 'LDL Cholesterol',
        value: 145,
        unit: 'mg/dL',
        status: 'high',
        range: '< 130',
        history: [138, 140, 145],
      ),
      HealthMetricModel(
        name: 'Triglycerides',
        value: 165,
        unit: 'mg/dL',
        status: 'high',
        range: '< 150',
        history: [160, 162, 165],
      ),
      HealthMetricModel(
        name: 'Blood Pressure (Systolic)',
        value: 128,
        unit: 'mmHg',
        status: 'normal',
        range: '90 - 130',
        history: [125, 126, 128],
      ),
      HealthMetricModel(
        name: 'Blood Pressure (Diastolic)',
        value: 88,
        unit: 'mmHg',
        status: 'high',
        range: '60 - 80',
        history: [82, 85, 88],
      ),
      HealthMetricModel(
        name: 'Body Temperature',
        value: 98.4,
        unit: '°F',
        status: 'normal',
        range: '97°F - 99°F',
        history: [98.0, 98.2, 98.4],
      ),
      HealthMetricModel(
        name: 'Heart Rate',
        value: 92,
        unit: 'bpm',
        status: 'high',
        range: '60 - 90',
        history: [88, 90, 92],
      ),
      HealthMetricModel(
        name: 'Oxygen Saturation',
        value: 96,
        unit: '%',
        status: 'normal',
        range: '95 - 100',
        history: [95, 96, 96],
      ),
    ],
  );
}
}
