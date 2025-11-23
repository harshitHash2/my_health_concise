import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/constants/hive_boxes.dart';
import 'features/health/data/models/health_data_model.dart';
import 'features/health/data/models/health_metric_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  // Hive
  //   ..registerAdapter(HealthMetricModelAdapter())
  //   ..registerAdapter(HealthDataModelAdapter());

  Hive.registerAdapter(HealthMetricModelAdapter());
  Hive.registerAdapter(HealthDataModelAdapter());

  await Hive.openBox(HiveBoxes.healthDataBox);

  runApp(const ProviderScope(child: PersonalHealthInsightsApp()));
}
