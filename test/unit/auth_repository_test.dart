import 'package:bcrypt/bcrypt.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:artific_pharmacy_management_system/core/constants/permissions.dart';
import 'package:artific_pharmacy_management_system/data/database/app_database.dart';
import 'package:artific_pharmacy_management_system/features/auth/repository/auth_repository.dart';

void main() {
  late AppDatabase database;
  late AuthRepository repository;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    repository = AuthRepository(database);

    await database.into(database.users).insert(
      UsersCompanion.insert(
        username: 'tester',
        passwordHash: BCrypt.hashpw('secret', BCrypt.gensalt()),
        role: UserRole.pharmacist.name,
      ),
    );
  });

  tearDown(() async {
    await database.close();
  });

  test('returns user session when credentials are correct', () async {
    final session = await repository.login(username: 'tester', password: 'secret');

    expect(session?.username, 'tester');
    expect(session?.role, UserRole.pharmacist);
  });

  test('returns null for invalid credentials', () async {
    final session = await repository.login(username: 'tester', password: 'wrong-password');
    expect(session, isNull);
  });
}
