import '../../../core/di/service_locator.dart';
import '../../../data/database/app_database.dart';

class DashboardRepository {
  DashboardRepository({AppDatabase? database}) : _database = database ?? getIt<AppDatabase>();

  final AppDatabase _database;

  Future<DashboardMetrics> loadMetrics() => _database.dashboardDao.getMetrics();
}
