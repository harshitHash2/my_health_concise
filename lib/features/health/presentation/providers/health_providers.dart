import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';

import '../../../../core/constants/hive_boxes.dart';
import '../../data/datasources/health_local_data_source.dart';
import '../../data/repositories/health_repository_impl.dart';
import '../../domain/entities/health_data.dart';
import '../../domain/entities/health_metric.dart';
import '../../domain/repositories/health_repository.dart';

enum HealthStatusFilter { all, normal, high, low }

final hiveBoxProvider = Provider<Box>((ref) {
  return Hive.box(HiveBoxes.healthDataBox);
});

final healthLocalDataSourceProvider =
    Provider<HealthLocalDataSource>((ref) {
  final box = ref.watch(hiveBoxProvider);
  return HealthLocalDataSource(box);
});

final healthRepositoryProvider = Provider<HealthRepository>((ref) {
  final ds = ref.watch(healthLocalDataSourceProvider);
  return HealthRepositoryImpl(ds);
});

final healthDataProvider = FutureProvider<HealthData>((ref) async {
  final repo = ref.watch(healthRepositoryProvider);
  return repo.getHealthData();
});

final statusFilterProvider =
    StateProvider<HealthStatusFilter>((ref) => HealthStatusFilter.all);

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredMetricsProvider =
    Provider<List<HealthMetric>>((ref) {
  final asyncData = ref.watch(healthDataProvider);
  final filter = ref.watch(statusFilterProvider);
  final query = ref.watch(searchQueryProvider);

  return asyncData.maybeWhen(
    data: (data) {
      var list = data.metrics;

    
      list = list.where((m) {
        if (filter == HealthStatusFilter.all) return true;
        if (filter == HealthStatusFilter.normal &&
            m.status == HealthStatus.normal) {
          return true;
        }
        if (filter == HealthStatusFilter.high &&
            m.status == HealthStatus.high) {
          return true;
        }
        if (filter == HealthStatusFilter.low &&
            m.status == HealthStatus.low) {
          return true;
        }
        return false;
      }).toList();

      
      if (query.isNotEmpty) {
        list = list
            .where((m) =>
                m.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }

      return list;
    },
    orElse: () => [],
  );
});
