import '../../domain/entities/health_data.dart';
import '../../domain/repositories/health_repository.dart';
import '../datasources/health_local_data_source.dart';

class HealthRepositoryImpl implements HealthRepository {
  final HealthLocalDataSource localDataSource;

  HealthRepositoryImpl(this.localDataSource);

  @override
  Future<HealthData> getHealthData() async {
    final model = await localDataSource.getHealthData();
    return model.toEntity();
  }
}
