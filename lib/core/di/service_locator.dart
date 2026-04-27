import 'package:get_it/get_it.dart';

import '../../data/database/app_database.dart';
import '../../domain/services/fefo_service.dart';
import '../../domain/services/invoice_number.dart';
import '../../domain/services/tax_engine.dart';
import '../../features/auth/repository/auth_repository.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  if (!getIt.isRegistered<AppDatabase>()) {
    getIt.registerLazySingleton<AppDatabase>(AppDatabase.new);
  }

  getIt.registerLazySingleton<TaxEngine>(TaxEngine.new);
  getIt.registerLazySingleton<FefoService>(FefoService.new);
  getIt.registerLazySingleton<InvoiceNumberService>(InvoiceNumberService.new);
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(getIt<AppDatabase>()));
}
