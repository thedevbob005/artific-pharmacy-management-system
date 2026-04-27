import 'package:bcrypt/bcrypt.dart';

import '../../../core/constants/permissions.dart';
import '../../../data/database/app_database.dart';

class AuthRepository {
  const AuthRepository(this._database);

  final AppDatabase _database;

  Future<({String username, UserRole role})?> login({
    required String username,
    required String password,
  }) async {
    final user = await _database.userDao.findByUsername(username);
    if (user == null) {
      return null;
    }

    final ok = BCrypt.checkpw(password, user.passwordHash);
    if (!ok) {
      return null;
    }

    return (username: user.username, role: _toRole(user.role));
  }

  UserRole _toRole(String value) {
    return UserRole.values.firstWhere(
      (role) => role.name == value,
      orElse: () => UserRole.cashier,
    );
  }
}
