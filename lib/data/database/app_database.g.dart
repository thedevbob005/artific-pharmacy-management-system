// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    username,
    passwordHash,
    role,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String passwordHash;
  final String role;
  final DateTime createdAt;
  const User({
    required this.id,
    required this.username,
    required this.passwordHash,
    required this.role,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['password_hash'] = Variable<String>(passwordHash);
    map['role'] = Variable<String>(role);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      passwordHash: Value(passwordHash),
      role: Value(role),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      role: serializer.fromJson<String>(json['role']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'role': serializer.toJson<String>(role),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? passwordHash,
    String? role,
    DateTime? createdAt,
  }) => User(
    id: id ?? this.id,
    username: username ?? this.username,
    passwordHash: passwordHash ?? this.passwordHash,
    role: role ?? this.role,
    createdAt: createdAt ?? this.createdAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      role: data.role.present ? data.role.value : this.role,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, passwordHash, role, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.passwordHash == this.passwordHash &&
          other.role == this.role &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> passwordHash;
  final Value<String> role;
  final Value<DateTime> createdAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.role = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String passwordHash,
    required String role,
    this.createdAt = const Value.absent(),
  }) : username = Value(username),
       passwordHash = Value(passwordHash),
       role = Value(role);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? passwordHash,
    Expression<String>? role,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (role != null) 'role': role,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? username,
    Value<String>? passwordHash,
    Value<String>? role,
    Value<DateTime>? createdAt,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      passwordHash: passwordHash ?? this.passwordHash,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hsnCodeMeta = const VerificationMeta(
    'hsnCode',
  );
  @override
  late final GeneratedColumn<String> hsnCode = GeneratedColumn<String>(
    'hsn_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gstRateMeta = const VerificationMeta(
    'gstRate',
  );
  @override
  late final GeneratedColumn<double> gstRate = GeneratedColumn<double>(
    'gst_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mrpMeta = const VerificationMeta('mrp');
  @override
  late final GeneratedColumn<double> mrp = GeneratedColumn<double>(
    'mrp',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lowStockThresholdMeta = const VerificationMeta(
    'lowStockThreshold',
  );
  @override
  late final GeneratedColumn<double> lowStockThreshold =
      GeneratedColumn<double>(
        'low_stock_threshold',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(10),
      );
  static const VerificationMeta _isH1Meta = const VerificationMeta('isH1');
  @override
  late final GeneratedColumn<bool> isH1 = GeneratedColumn<bool>(
    'is_h1',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_h1" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    barcode,
    hsnCode,
    gstRate,
    mrp,
    lowStockThreshold,
    isH1,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('hsn_code')) {
      context.handle(
        _hsnCodeMeta,
        hsnCode.isAcceptableOrUnknown(data['hsn_code']!, _hsnCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_hsnCodeMeta);
    }
    if (data.containsKey('gst_rate')) {
      context.handle(
        _gstRateMeta,
        gstRate.isAcceptableOrUnknown(data['gst_rate']!, _gstRateMeta),
      );
    } else if (isInserting) {
      context.missing(_gstRateMeta);
    }
    if (data.containsKey('mrp')) {
      context.handle(
        _mrpMeta,
        mrp.isAcceptableOrUnknown(data['mrp']!, _mrpMeta),
      );
    } else if (isInserting) {
      context.missing(_mrpMeta);
    }
    if (data.containsKey('low_stock_threshold')) {
      context.handle(
        _lowStockThresholdMeta,
        lowStockThreshold.isAcceptableOrUnknown(
          data['low_stock_threshold']!,
          _lowStockThresholdMeta,
        ),
      );
    }
    if (data.containsKey('is_h1')) {
      context.handle(
        _isH1Meta,
        isH1.isAcceptableOrUnknown(data['is_h1']!, _isH1Meta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      hsnCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hsn_code'],
      )!,
      gstRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gst_rate'],
      )!,
      mrp: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mrp'],
      )!,
      lowStockThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}low_stock_threshold'],
      )!,
      isH1: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_h1'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String name;
  final String? barcode;
  final String hsnCode;
  final double gstRate;
  final double mrp;
  final double lowStockThreshold;
  final bool isH1;
  final DateTime createdAt;
  const Product({
    required this.id,
    required this.name,
    this.barcode,
    required this.hsnCode,
    required this.gstRate,
    required this.mrp,
    required this.lowStockThreshold,
    required this.isH1,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['hsn_code'] = Variable<String>(hsnCode);
    map['gst_rate'] = Variable<double>(gstRate);
    map['mrp'] = Variable<double>(mrp);
    map['low_stock_threshold'] = Variable<double>(lowStockThreshold);
    map['is_h1'] = Variable<bool>(isH1);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      hsnCode: Value(hsnCode),
      gstRate: Value(gstRate),
      mrp: Value(mrp),
      lowStockThreshold: Value(lowStockThreshold),
      isH1: Value(isH1),
      createdAt: Value(createdAt),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      hsnCode: serializer.fromJson<String>(json['hsnCode']),
      gstRate: serializer.fromJson<double>(json['gstRate']),
      mrp: serializer.fromJson<double>(json['mrp']),
      lowStockThreshold: serializer.fromJson<double>(json['lowStockThreshold']),
      isH1: serializer.fromJson<bool>(json['isH1']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'barcode': serializer.toJson<String?>(barcode),
      'hsnCode': serializer.toJson<String>(hsnCode),
      'gstRate': serializer.toJson<double>(gstRate),
      'mrp': serializer.toJson<double>(mrp),
      'lowStockThreshold': serializer.toJson<double>(lowStockThreshold),
      'isH1': serializer.toJson<bool>(isH1),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Product copyWith({
    int? id,
    String? name,
    Value<String?> barcode = const Value.absent(),
    String? hsnCode,
    double? gstRate,
    double? mrp,
    double? lowStockThreshold,
    bool? isH1,
    DateTime? createdAt,
  }) => Product(
    id: id ?? this.id,
    name: name ?? this.name,
    barcode: barcode.present ? barcode.value : this.barcode,
    hsnCode: hsnCode ?? this.hsnCode,
    gstRate: gstRate ?? this.gstRate,
    mrp: mrp ?? this.mrp,
    lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
    isH1: isH1 ?? this.isH1,
    createdAt: createdAt ?? this.createdAt,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      hsnCode: data.hsnCode.present ? data.hsnCode.value : this.hsnCode,
      gstRate: data.gstRate.present ? data.gstRate.value : this.gstRate,
      mrp: data.mrp.present ? data.mrp.value : this.mrp,
      lowStockThreshold: data.lowStockThreshold.present
          ? data.lowStockThreshold.value
          : this.lowStockThreshold,
      isH1: data.isH1.present ? data.isH1.value : this.isH1,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('barcode: $barcode, ')
          ..write('hsnCode: $hsnCode, ')
          ..write('gstRate: $gstRate, ')
          ..write('mrp: $mrp, ')
          ..write('lowStockThreshold: $lowStockThreshold, ')
          ..write('isH1: $isH1, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    barcode,
    hsnCode,
    gstRate,
    mrp,
    lowStockThreshold,
    isH1,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.barcode == this.barcode &&
          other.hsnCode == this.hsnCode &&
          other.gstRate == this.gstRate &&
          other.mrp == this.mrp &&
          other.lowStockThreshold == this.lowStockThreshold &&
          other.isH1 == this.isH1 &&
          other.createdAt == this.createdAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> barcode;
  final Value<String> hsnCode;
  final Value<double> gstRate;
  final Value<double> mrp;
  final Value<double> lowStockThreshold;
  final Value<bool> isH1;
  final Value<DateTime> createdAt;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.barcode = const Value.absent(),
    this.hsnCode = const Value.absent(),
    this.gstRate = const Value.absent(),
    this.mrp = const Value.absent(),
    this.lowStockThreshold = const Value.absent(),
    this.isH1 = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.barcode = const Value.absent(),
    required String hsnCode,
    required double gstRate,
    required double mrp,
    this.lowStockThreshold = const Value.absent(),
    this.isH1 = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       hsnCode = Value(hsnCode),
       gstRate = Value(gstRate),
       mrp = Value(mrp);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? barcode,
    Expression<String>? hsnCode,
    Expression<double>? gstRate,
    Expression<double>? mrp,
    Expression<double>? lowStockThreshold,
    Expression<bool>? isH1,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (barcode != null) 'barcode': barcode,
      if (hsnCode != null) 'hsn_code': hsnCode,
      if (gstRate != null) 'gst_rate': gstRate,
      if (mrp != null) 'mrp': mrp,
      if (lowStockThreshold != null) 'low_stock_threshold': lowStockThreshold,
      if (isH1 != null) 'is_h1': isH1,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? barcode,
    Value<String>? hsnCode,
    Value<double>? gstRate,
    Value<double>? mrp,
    Value<double>? lowStockThreshold,
    Value<bool>? isH1,
    Value<DateTime>? createdAt,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      hsnCode: hsnCode ?? this.hsnCode,
      gstRate: gstRate ?? this.gstRate,
      mrp: mrp ?? this.mrp,
      lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
      isH1: isH1 ?? this.isH1,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (hsnCode.present) {
      map['hsn_code'] = Variable<String>(hsnCode.value);
    }
    if (gstRate.present) {
      map['gst_rate'] = Variable<double>(gstRate.value);
    }
    if (mrp.present) {
      map['mrp'] = Variable<double>(mrp.value);
    }
    if (lowStockThreshold.present) {
      map['low_stock_threshold'] = Variable<double>(lowStockThreshold.value);
    }
    if (isH1.present) {
      map['is_h1'] = Variable<bool>(isH1.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('barcode: $barcode, ')
          ..write('hsnCode: $hsnCode, ')
          ..write('gstRate: $gstRate, ')
          ..write('mrp: $mrp, ')
          ..write('lowStockThreshold: $lowStockThreshold, ')
          ..write('isH1: $isH1, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BatchesTable extends Batches with TableInfo<$BatchesTable, Batche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BatchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _batchNumberMeta = const VerificationMeta(
    'batchNumber',
  );
  @override
  late final GeneratedColumn<String> batchNumber = GeneratedColumn<String>(
    'batch_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expDateMeta = const VerificationMeta(
    'expDate',
  );
  @override
  late final GeneratedColumn<DateTime> expDate = GeneratedColumn<DateTime>(
    'exp_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    batchNumber,
    expDate,
    quantity,
    purchasePrice,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'batches';
  @override
  VerificationContext validateIntegrity(
    Insertable<Batche> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('batch_number')) {
      context.handle(
        _batchNumberMeta,
        batchNumber.isAcceptableOrUnknown(
          data['batch_number']!,
          _batchNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_batchNumberMeta);
    }
    if (data.containsKey('exp_date')) {
      context.handle(
        _expDateMeta,
        expDate.isAcceptableOrUnknown(data['exp_date']!, _expDateMeta),
      );
    } else if (isInserting) {
      context.missing(_expDateMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasePriceMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Batche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Batche(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      batchNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_number'],
      )!,
      expDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}exp_date'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BatchesTable createAlias(String alias) {
    return $BatchesTable(attachedDatabase, alias);
  }
}

class Batche extends DataClass implements Insertable<Batche> {
  final int id;
  final int productId;
  final String batchNumber;
  final DateTime expDate;
  final double quantity;
  final double purchasePrice;
  final DateTime createdAt;
  const Batche({
    required this.id,
    required this.productId,
    required this.batchNumber,
    required this.expDate,
    required this.quantity,
    required this.purchasePrice,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['batch_number'] = Variable<String>(batchNumber);
    map['exp_date'] = Variable<DateTime>(expDate);
    map['quantity'] = Variable<double>(quantity);
    map['purchase_price'] = Variable<double>(purchasePrice);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BatchesCompanion toCompanion(bool nullToAbsent) {
    return BatchesCompanion(
      id: Value(id),
      productId: Value(productId),
      batchNumber: Value(batchNumber),
      expDate: Value(expDate),
      quantity: Value(quantity),
      purchasePrice: Value(purchasePrice),
      createdAt: Value(createdAt),
    );
  }

  factory Batche.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Batche(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      batchNumber: serializer.fromJson<String>(json['batchNumber']),
      expDate: serializer.fromJson<DateTime>(json['expDate']),
      quantity: serializer.fromJson<double>(json['quantity']),
      purchasePrice: serializer.fromJson<double>(json['purchasePrice']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'batchNumber': serializer.toJson<String>(batchNumber),
      'expDate': serializer.toJson<DateTime>(expDate),
      'quantity': serializer.toJson<double>(quantity),
      'purchasePrice': serializer.toJson<double>(purchasePrice),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Batche copyWith({
    int? id,
    int? productId,
    String? batchNumber,
    DateTime? expDate,
    double? quantity,
    double? purchasePrice,
    DateTime? createdAt,
  }) => Batche(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    batchNumber: batchNumber ?? this.batchNumber,
    expDate: expDate ?? this.expDate,
    quantity: quantity ?? this.quantity,
    purchasePrice: purchasePrice ?? this.purchasePrice,
    createdAt: createdAt ?? this.createdAt,
  );
  Batche copyWithCompanion(BatchesCompanion data) {
    return Batche(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      batchNumber: data.batchNumber.present
          ? data.batchNumber.value
          : this.batchNumber,
      expDate: data.expDate.present ? data.expDate.value : this.expDate,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Batche(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('expDate: $expDate, ')
          ..write('quantity: $quantity, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    batchNumber,
    expDate,
    quantity,
    purchasePrice,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Batche &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.batchNumber == this.batchNumber &&
          other.expDate == this.expDate &&
          other.quantity == this.quantity &&
          other.purchasePrice == this.purchasePrice &&
          other.createdAt == this.createdAt);
}

class BatchesCompanion extends UpdateCompanion<Batche> {
  final Value<int> id;
  final Value<int> productId;
  final Value<String> batchNumber;
  final Value<DateTime> expDate;
  final Value<double> quantity;
  final Value<double> purchasePrice;
  final Value<DateTime> createdAt;
  const BatchesCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.batchNumber = const Value.absent(),
    this.expDate = const Value.absent(),
    this.quantity = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BatchesCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required String batchNumber,
    required DateTime expDate,
    required double quantity,
    required double purchasePrice,
    this.createdAt = const Value.absent(),
  }) : productId = Value(productId),
       batchNumber = Value(batchNumber),
       expDate = Value(expDate),
       quantity = Value(quantity),
       purchasePrice = Value(purchasePrice);
  static Insertable<Batche> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<String>? batchNumber,
    Expression<DateTime>? expDate,
    Expression<double>? quantity,
    Expression<double>? purchasePrice,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (batchNumber != null) 'batch_number': batchNumber,
      if (expDate != null) 'exp_date': expDate,
      if (quantity != null) 'quantity': quantity,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BatchesCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<String>? batchNumber,
    Value<DateTime>? expDate,
    Value<double>? quantity,
    Value<double>? purchasePrice,
    Value<DateTime>? createdAt,
  }) {
    return BatchesCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      batchNumber: batchNumber ?? this.batchNumber,
      expDate: expDate ?? this.expDate,
      quantity: quantity ?? this.quantity,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (batchNumber.present) {
      map['batch_number'] = Variable<String>(batchNumber.value);
    }
    if (expDate.present) {
      map['exp_date'] = Variable<DateTime>(expDate.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BatchesCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('expDate: $expDate, ')
          ..write('quantity: $quantity, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $InventoryAdjustmentsTable extends InventoryAdjustments
    with TableInfo<$InventoryAdjustmentsTable, InventoryAdjustment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryAdjustmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _batchIdMeta = const VerificationMeta(
    'batchId',
  );
  @override
  late final GeneratedColumn<int> batchId = GeneratedColumn<int>(
    'batch_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES batches (id)',
    ),
  );
  static const VerificationMeta _deltaQtyMeta = const VerificationMeta(
    'deltaQty',
  );
  @override
  late final GeneratedColumn<double> deltaQty = GeneratedColumn<double>(
    'delta_qty',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _performedByMeta = const VerificationMeta(
    'performedBy',
  );
  @override
  late final GeneratedColumn<String> performedBy = GeneratedColumn<String>(
    'performed_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    batchId,
    deltaQty,
    reason,
    performedBy,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_adjustments';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryAdjustment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('batch_id')) {
      context.handle(
        _batchIdMeta,
        batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_batchIdMeta);
    }
    if (data.containsKey('delta_qty')) {
      context.handle(
        _deltaQtyMeta,
        deltaQty.isAcceptableOrUnknown(data['delta_qty']!, _deltaQtyMeta),
      );
    } else if (isInserting) {
      context.missing(_deltaQtyMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('performed_by')) {
      context.handle(
        _performedByMeta,
        performedBy.isAcceptableOrUnknown(
          data['performed_by']!,
          _performedByMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_performedByMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryAdjustment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryAdjustment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      batchId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}batch_id'],
      )!,
      deltaQty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}delta_qty'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      performedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}performed_by'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InventoryAdjustmentsTable createAlias(String alias) {
    return $InventoryAdjustmentsTable(attachedDatabase, alias);
  }
}

class InventoryAdjustment extends DataClass
    implements Insertable<InventoryAdjustment> {
  final int id;
  final int productId;
  final int batchId;
  final double deltaQty;
  final String reason;
  final String performedBy;
  final DateTime createdAt;
  const InventoryAdjustment({
    required this.id,
    required this.productId,
    required this.batchId,
    required this.deltaQty,
    required this.reason,
    required this.performedBy,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['batch_id'] = Variable<int>(batchId);
    map['delta_qty'] = Variable<double>(deltaQty);
    map['reason'] = Variable<String>(reason);
    map['performed_by'] = Variable<String>(performedBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InventoryAdjustmentsCompanion toCompanion(bool nullToAbsent) {
    return InventoryAdjustmentsCompanion(
      id: Value(id),
      productId: Value(productId),
      batchId: Value(batchId),
      deltaQty: Value(deltaQty),
      reason: Value(reason),
      performedBy: Value(performedBy),
      createdAt: Value(createdAt),
    );
  }

  factory InventoryAdjustment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryAdjustment(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      batchId: serializer.fromJson<int>(json['batchId']),
      deltaQty: serializer.fromJson<double>(json['deltaQty']),
      reason: serializer.fromJson<String>(json['reason']),
      performedBy: serializer.fromJson<String>(json['performedBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'batchId': serializer.toJson<int>(batchId),
      'deltaQty': serializer.toJson<double>(deltaQty),
      'reason': serializer.toJson<String>(reason),
      'performedBy': serializer.toJson<String>(performedBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InventoryAdjustment copyWith({
    int? id,
    int? productId,
    int? batchId,
    double? deltaQty,
    String? reason,
    String? performedBy,
    DateTime? createdAt,
  }) => InventoryAdjustment(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    batchId: batchId ?? this.batchId,
    deltaQty: deltaQty ?? this.deltaQty,
    reason: reason ?? this.reason,
    performedBy: performedBy ?? this.performedBy,
    createdAt: createdAt ?? this.createdAt,
  );
  InventoryAdjustment copyWithCompanion(InventoryAdjustmentsCompanion data) {
    return InventoryAdjustment(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      deltaQty: data.deltaQty.present ? data.deltaQty.value : this.deltaQty,
      reason: data.reason.present ? data.reason.value : this.reason,
      performedBy: data.performedBy.present
          ? data.performedBy.value
          : this.performedBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryAdjustment(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('batchId: $batchId, ')
          ..write('deltaQty: $deltaQty, ')
          ..write('reason: $reason, ')
          ..write('performedBy: $performedBy, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    batchId,
    deltaQty,
    reason,
    performedBy,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryAdjustment &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.batchId == this.batchId &&
          other.deltaQty == this.deltaQty &&
          other.reason == this.reason &&
          other.performedBy == this.performedBy &&
          other.createdAt == this.createdAt);
}

class InventoryAdjustmentsCompanion
    extends UpdateCompanion<InventoryAdjustment> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int> batchId;
  final Value<double> deltaQty;
  final Value<String> reason;
  final Value<String> performedBy;
  final Value<DateTime> createdAt;
  const InventoryAdjustmentsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.batchId = const Value.absent(),
    this.deltaQty = const Value.absent(),
    this.reason = const Value.absent(),
    this.performedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  InventoryAdjustmentsCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required int batchId,
    required double deltaQty,
    required String reason,
    required String performedBy,
    this.createdAt = const Value.absent(),
  }) : productId = Value(productId),
       batchId = Value(batchId),
       deltaQty = Value(deltaQty),
       reason = Value(reason),
       performedBy = Value(performedBy);
  static Insertable<InventoryAdjustment> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? batchId,
    Expression<double>? deltaQty,
    Expression<String>? reason,
    Expression<String>? performedBy,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (batchId != null) 'batch_id': batchId,
      if (deltaQty != null) 'delta_qty': deltaQty,
      if (reason != null) 'reason': reason,
      if (performedBy != null) 'performed_by': performedBy,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  InventoryAdjustmentsCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<int>? batchId,
    Value<double>? deltaQty,
    Value<String>? reason,
    Value<String>? performedBy,
    Value<DateTime>? createdAt,
  }) {
    return InventoryAdjustmentsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      batchId: batchId ?? this.batchId,
      deltaQty: deltaQty ?? this.deltaQty,
      reason: reason ?? this.reason,
      performedBy: performedBy ?? this.performedBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<int>(batchId.value);
    }
    if (deltaQty.present) {
      map['delta_qty'] = Variable<double>(deltaQty.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (performedBy.present) {
      map['performed_by'] = Variable<String>(performedBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryAdjustmentsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('batchId: $batchId, ')
          ..write('deltaQty: $deltaQty, ')
          ..write('reason: $reason, ')
          ..write('performedBy: $performedBy, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsTable extends AuditLogs
    with TableInfo<$AuditLogsTable, AuditLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entityMeta = const VerificationMeta('entity');
  @override
  late final GeneratedColumn<String> entity = GeneratedColumn<String>(
    'entity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actorMeta = const VerificationMeta('actor');
  @override
  late final GeneratedColumn<String> actor = GeneratedColumn<String>(
    'actor',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entity,
    action,
    actor,
    payload,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity')) {
      context.handle(
        _entityMeta,
        entity.isAcceptableOrUnknown(data['entity']!, _entityMeta),
      );
    } else if (isInserting) {
      context.missing(_entityMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('actor')) {
      context.handle(
        _actorMeta,
        actor.isAcceptableOrUnknown(data['actor']!, _actorMeta),
      );
    } else if (isInserting) {
      context.missing(_actorMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      actor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actor'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AuditLogsTable createAlias(String alias) {
    return $AuditLogsTable(attachedDatabase, alias);
  }
}

class AuditLog extends DataClass implements Insertable<AuditLog> {
  final int id;
  final String entity;
  final String action;
  final String actor;
  final String payload;
  final DateTime createdAt;
  const AuditLog({
    required this.id,
    required this.entity,
    required this.action,
    required this.actor,
    required this.payload,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity'] = Variable<String>(entity);
    map['action'] = Variable<String>(action);
    map['actor'] = Variable<String>(actor);
    map['payload'] = Variable<String>(payload);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AuditLogsCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsCompanion(
      id: Value(id),
      entity: Value(entity),
      action: Value(action),
      actor: Value(actor),
      payload: Value(payload),
      createdAt: Value(createdAt),
    );
  }

  factory AuditLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLog(
      id: serializer.fromJson<int>(json['id']),
      entity: serializer.fromJson<String>(json['entity']),
      action: serializer.fromJson<String>(json['action']),
      actor: serializer.fromJson<String>(json['actor']),
      payload: serializer.fromJson<String>(json['payload']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entity': serializer.toJson<String>(entity),
      'action': serializer.toJson<String>(action),
      'actor': serializer.toJson<String>(actor),
      'payload': serializer.toJson<String>(payload),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AuditLog copyWith({
    int? id,
    String? entity,
    String? action,
    String? actor,
    String? payload,
    DateTime? createdAt,
  }) => AuditLog(
    id: id ?? this.id,
    entity: entity ?? this.entity,
    action: action ?? this.action,
    actor: actor ?? this.actor,
    payload: payload ?? this.payload,
    createdAt: createdAt ?? this.createdAt,
  );
  AuditLog copyWithCompanion(AuditLogsCompanion data) {
    return AuditLog(
      id: data.id.present ? data.id.value : this.id,
      entity: data.entity.present ? data.entity.value : this.entity,
      action: data.action.present ? data.action.value : this.action,
      actor: data.actor.present ? data.actor.value : this.actor,
      payload: data.payload.present ? data.payload.value : this.payload,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLog(')
          ..write('id: $id, ')
          ..write('entity: $entity, ')
          ..write('action: $action, ')
          ..write('actor: $actor, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, entity, action, actor, payload, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLog &&
          other.id == this.id &&
          other.entity == this.entity &&
          other.action == this.action &&
          other.actor == this.actor &&
          other.payload == this.payload &&
          other.createdAt == this.createdAt);
}

class AuditLogsCompanion extends UpdateCompanion<AuditLog> {
  final Value<int> id;
  final Value<String> entity;
  final Value<String> action;
  final Value<String> actor;
  final Value<String> payload;
  final Value<DateTime> createdAt;
  const AuditLogsCompanion({
    this.id = const Value.absent(),
    this.entity = const Value.absent(),
    this.action = const Value.absent(),
    this.actor = const Value.absent(),
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AuditLogsCompanion.insert({
    this.id = const Value.absent(),
    required String entity,
    required String action,
    required String actor,
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : entity = Value(entity),
       action = Value(action),
       actor = Value(actor);
  static Insertable<AuditLog> custom({
    Expression<int>? id,
    Expression<String>? entity,
    Expression<String>? action,
    Expression<String>? actor,
    Expression<String>? payload,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entity != null) 'entity': entity,
      if (action != null) 'action': action,
      if (actor != null) 'actor': actor,
      if (payload != null) 'payload': payload,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AuditLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? entity,
    Value<String>? action,
    Value<String>? actor,
    Value<String>? payload,
    Value<DateTime>? createdAt,
  }) {
    return AuditLogsCompanion(
      id: id ?? this.id,
      entity: entity ?? this.entity,
      action: action ?? this.action,
      actor: actor ?? this.actor,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entity.present) {
      map['entity'] = Variable<String>(entity.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (actor.present) {
      map['actor'] = Variable<String>(actor.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsCompanion(')
          ..write('id: $id, ')
          ..write('entity: $entity, ')
          ..write('action: $action, ')
          ..write('actor: $actor, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices with TableInfo<$InvoicesTable, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _invoiceNoMeta = const VerificationMeta(
    'invoiceNo',
  );
  @override
  late final GeneratedColumn<String> invoiceNo = GeneratedColumn<String>(
    'invoice_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, invoiceNo, totalAmount, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Invoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_no')) {
      context.handle(
        _invoiceNoMeta,
        invoiceNo.isAcceptableOrUnknown(data['invoice_no']!, _invoiceNoMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceNoMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_no'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final int id;
  final String invoiceNo;
  final double totalAmount;
  final DateTime createdAt;
  const Invoice({
    required this.id,
    required this.invoiceNo,
    required this.totalAmount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_no'] = Variable<String>(invoiceNo);
    map['total_amount'] = Variable<double>(totalAmount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      invoiceNo: Value(invoiceNo),
      totalAmount: Value(totalAmount),
      createdAt: Value(createdAt),
    );
  }

  factory Invoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<int>(json['id']),
      invoiceNo: serializer.fromJson<String>(json['invoiceNo']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceNo': serializer.toJson<String>(invoiceNo),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Invoice copyWith({
    int? id,
    String? invoiceNo,
    double? totalAmount,
    DateTime? createdAt,
  }) => Invoice(
    id: id ?? this.id,
    invoiceNo: invoiceNo ?? this.invoiceNo,
    totalAmount: totalAmount ?? this.totalAmount,
    createdAt: createdAt ?? this.createdAt,
  );
  Invoice copyWithCompanion(InvoicesCompanion data) {
    return Invoice(
      id: data.id.present ? data.id.value : this.id,
      invoiceNo: data.invoiceNo.present ? data.invoiceNo.value : this.invoiceNo,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('invoiceNo: $invoiceNo, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, invoiceNo, totalAmount, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.invoiceNo == this.invoiceNo &&
          other.totalAmount == this.totalAmount &&
          other.createdAt == this.createdAt);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<int> id;
  final Value<String> invoiceNo;
  final Value<double> totalAmount;
  final Value<DateTime> createdAt;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.invoiceNo = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.id = const Value.absent(),
    required String invoiceNo,
    required double totalAmount,
    this.createdAt = const Value.absent(),
  }) : invoiceNo = Value(invoiceNo),
       totalAmount = Value(totalAmount);
  static Insertable<Invoice> custom({
    Expression<int>? id,
    Expression<String>? invoiceNo,
    Expression<double>? totalAmount,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceNo != null) 'invoice_no': invoiceNo,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  InvoicesCompanion copyWith({
    Value<int>? id,
    Value<String>? invoiceNo,
    Value<double>? totalAmount,
    Value<DateTime>? createdAt,
  }) {
    return InvoicesCompanion(
      id: id ?? this.id,
      invoiceNo: invoiceNo ?? this.invoiceNo,
      totalAmount: totalAmount ?? this.totalAmount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceNo.present) {
      map['invoice_no'] = Variable<String>(invoiceNo.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('invoiceNo: $invoiceNo, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Regular'),
  );
  static const VerificationMeta _totalPurchasesMeta = const VerificationMeta(
    'totalPurchases',
  );
  @override
  late final GeneratedColumn<double> totalPurchases = GeneratedColumn<double>(
    'total_purchases',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastPurchaseAtMeta = const VerificationMeta(
    'lastPurchaseAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastPurchaseAt =
      GeneratedColumn<DateTime>(
        'last_purchase_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    phone,
    email,
    address,
    category,
    totalPurchases,
    lastPurchaseAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('total_purchases')) {
      context.handle(
        _totalPurchasesMeta,
        totalPurchases.isAcceptableOrUnknown(
          data['total_purchases']!,
          _totalPurchasesMeta,
        ),
      );
    }
    if (data.containsKey('last_purchase_at')) {
      context.handle(
        _lastPurchaseAtMeta,
        lastPurchaseAt.isAcceptableOrUnknown(
          data['last_purchase_at']!,
          _lastPurchaseAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      totalPurchases: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_purchases'],
      )!,
      lastPurchaseAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_purchase_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String name;
  final String phone;
  final String? email;
  final String? address;
  final String category;
  final double totalPurchases;
  final DateTime? lastPurchaseAt;
  final DateTime createdAt;
  const Customer({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.address,
    required this.category,
    required this.totalPurchases,
    this.lastPurchaseAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['category'] = Variable<String>(category);
    map['total_purchases'] = Variable<double>(totalPurchases);
    if (!nullToAbsent || lastPurchaseAt != null) {
      map['last_purchase_at'] = Variable<DateTime>(lastPurchaseAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      phone: Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      category: Value(category),
      totalPurchases: Value(totalPurchases),
      lastPurchaseAt: lastPurchaseAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPurchaseAt),
      createdAt: Value(createdAt),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      category: serializer.fromJson<String>(json['category']),
      totalPurchases: serializer.fromJson<double>(json['totalPurchases']),
      lastPurchaseAt: serializer.fromJson<DateTime?>(json['lastPurchaseAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'category': serializer.toJson<String>(category),
      'totalPurchases': serializer.toJson<double>(totalPurchases),
      'lastPurchaseAt': serializer.toJson<DateTime?>(lastPurchaseAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Customer copyWith({
    int? id,
    String? name,
    String? phone,
    Value<String?> email = const Value.absent(),
    Value<String?> address = const Value.absent(),
    String? category,
    double? totalPurchases,
    Value<DateTime?> lastPurchaseAt = const Value.absent(),
    DateTime? createdAt,
  }) => Customer(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    email: email.present ? email.value : this.email,
    address: address.present ? address.value : this.address,
    category: category ?? this.category,
    totalPurchases: totalPurchases ?? this.totalPurchases,
    lastPurchaseAt: lastPurchaseAt.present
        ? lastPurchaseAt.value
        : this.lastPurchaseAt,
    createdAt: createdAt ?? this.createdAt,
  );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      category: data.category.present ? data.category.value : this.category,
      totalPurchases: data.totalPurchases.present
          ? data.totalPurchases.value
          : this.totalPurchases,
      lastPurchaseAt: data.lastPurchaseAt.present
          ? data.lastPurchaseAt.value
          : this.lastPurchaseAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('category: $category, ')
          ..write('totalPurchases: $totalPurchases, ')
          ..write('lastPurchaseAt: $lastPurchaseAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    phone,
    email,
    address,
    category,
    totalPurchases,
    lastPurchaseAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.address == this.address &&
          other.category == this.category &&
          other.totalPurchases == this.totalPurchases &&
          other.lastPurchaseAt == this.lastPurchaseAt &&
          other.createdAt == this.createdAt);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> phone;
  final Value<String?> email;
  final Value<String?> address;
  final Value<String> category;
  final Value<double> totalPurchases;
  final Value<DateTime?> lastPurchaseAt;
  final Value<DateTime> createdAt;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.category = const Value.absent(),
    this.totalPurchases = const Value.absent(),
    this.lastPurchaseAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String phone,
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.category = const Value.absent(),
    this.totalPurchases = const Value.absent(),
    this.lastPurchaseAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       phone = Value(phone);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? address,
    Expression<String>? category,
    Expression<double>? totalPurchases,
    Expression<DateTime>? lastPurchaseAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (category != null) 'category': category,
      if (totalPurchases != null) 'total_purchases': totalPurchases,
      if (lastPurchaseAt != null) 'last_purchase_at': lastPurchaseAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CustomersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? phone,
    Value<String?>? email,
    Value<String?>? address,
    Value<String>? category,
    Value<double>? totalPurchases,
    Value<DateTime?>? lastPurchaseAt,
    Value<DateTime>? createdAt,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      category: category ?? this.category,
      totalPurchases: totalPurchases ?? this.totalPurchases,
      lastPurchaseAt: lastPurchaseAt ?? this.lastPurchaseAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (totalPurchases.present) {
      map['total_purchases'] = Variable<double>(totalPurchases.value);
    }
    if (lastPurchaseAt.present) {
      map['last_purchase_at'] = Variable<DateTime>(lastPurchaseAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('category: $category, ')
          ..write('totalPurchases: $totalPurchases, ')
          ..write('lastPurchaseAt: $lastPurchaseAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts with TableInfo<$ContactsTable, Contact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gstinMeta = const VerificationMeta('gstin');
  @override
  late final GeneratedColumn<String> gstin = GeneratedColumn<String>(
    'gstin',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bankDetailsMeta = const VerificationMeta(
    'bankDetails',
  );
  @override
  late final GeneratedColumn<String> bankDetails = GeneratedColumn<String>(
    'bank_details',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doctorRegistrationNumberMeta =
      const VerificationMeta('doctorRegistrationNumber');
  @override
  late final GeneratedColumn<String> doctorRegistrationNumber =
      GeneratedColumn<String>(
        'doctor_registration_number',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    name,
    phone,
    email,
    gstin,
    bankDetails,
    doctorRegistrationNumber,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Contact> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('gstin')) {
      context.handle(
        _gstinMeta,
        gstin.isAcceptableOrUnknown(data['gstin']!, _gstinMeta),
      );
    }
    if (data.containsKey('bank_details')) {
      context.handle(
        _bankDetailsMeta,
        bankDetails.isAcceptableOrUnknown(
          data['bank_details']!,
          _bankDetailsMeta,
        ),
      );
    }
    if (data.containsKey('doctor_registration_number')) {
      context.handle(
        _doctorRegistrationNumberMeta,
        doctorRegistrationNumber.isAcceptableOrUnknown(
          data['doctor_registration_number']!,
          _doctorRegistrationNumberMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contact(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      gstin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gstin'],
      ),
      bankDetails: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_details'],
      ),
      doctorRegistrationNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doctor_registration_number'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }
}

class Contact extends DataClass implements Insertable<Contact> {
  final int id;
  final String type;
  final String name;
  final String phone;
  final String? email;
  final String? gstin;
  final String? bankDetails;
  final String? doctorRegistrationNumber;
  final DateTime createdAt;
  const Contact({
    required this.id,
    required this.type,
    required this.name,
    required this.phone,
    this.email,
    this.gstin,
    this.bankDetails,
    this.doctorRegistrationNumber,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || gstin != null) {
      map['gstin'] = Variable<String>(gstin);
    }
    if (!nullToAbsent || bankDetails != null) {
      map['bank_details'] = Variable<String>(bankDetails);
    }
    if (!nullToAbsent || doctorRegistrationNumber != null) {
      map['doctor_registration_number'] = Variable<String>(
        doctorRegistrationNumber,
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      id: Value(id),
      type: Value(type),
      name: Value(name),
      phone: Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      gstin: gstin == null && nullToAbsent
          ? const Value.absent()
          : Value(gstin),
      bankDetails: bankDetails == null && nullToAbsent
          ? const Value.absent()
          : Value(bankDetails),
      doctorRegistrationNumber: doctorRegistrationNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(doctorRegistrationNumber),
      createdAt: Value(createdAt),
    );
  }

  factory Contact.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contact(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      gstin: serializer.fromJson<String?>(json['gstin']),
      bankDetails: serializer.fromJson<String?>(json['bankDetails']),
      doctorRegistrationNumber: serializer.fromJson<String?>(
        json['doctorRegistrationNumber'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'email': serializer.toJson<String?>(email),
      'gstin': serializer.toJson<String?>(gstin),
      'bankDetails': serializer.toJson<String?>(bankDetails),
      'doctorRegistrationNumber': serializer.toJson<String?>(
        doctorRegistrationNumber,
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Contact copyWith({
    int? id,
    String? type,
    String? name,
    String? phone,
    Value<String?> email = const Value.absent(),
    Value<String?> gstin = const Value.absent(),
    Value<String?> bankDetails = const Value.absent(),
    Value<String?> doctorRegistrationNumber = const Value.absent(),
    DateTime? createdAt,
  }) => Contact(
    id: id ?? this.id,
    type: type ?? this.type,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    email: email.present ? email.value : this.email,
    gstin: gstin.present ? gstin.value : this.gstin,
    bankDetails: bankDetails.present ? bankDetails.value : this.bankDetails,
    doctorRegistrationNumber: doctorRegistrationNumber.present
        ? doctorRegistrationNumber.value
        : this.doctorRegistrationNumber,
    createdAt: createdAt ?? this.createdAt,
  );
  Contact copyWithCompanion(ContactsCompanion data) {
    return Contact(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      gstin: data.gstin.present ? data.gstin.value : this.gstin,
      bankDetails: data.bankDetails.present
          ? data.bankDetails.value
          : this.bankDetails,
      doctorRegistrationNumber: data.doctorRegistrationNumber.present
          ? data.doctorRegistrationNumber.value
          : this.doctorRegistrationNumber,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contact(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('gstin: $gstin, ')
          ..write('bankDetails: $bankDetails, ')
          ..write('doctorRegistrationNumber: $doctorRegistrationNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    name,
    phone,
    email,
    gstin,
    bankDetails,
    doctorRegistrationNumber,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contact &&
          other.id == this.id &&
          other.type == this.type &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.gstin == this.gstin &&
          other.bankDetails == this.bankDetails &&
          other.doctorRegistrationNumber == this.doctorRegistrationNumber &&
          other.createdAt == this.createdAt);
}

class ContactsCompanion extends UpdateCompanion<Contact> {
  final Value<int> id;
  final Value<String> type;
  final Value<String> name;
  final Value<String> phone;
  final Value<String?> email;
  final Value<String?> gstin;
  final Value<String?> bankDetails;
  final Value<String?> doctorRegistrationNumber;
  final Value<DateTime> createdAt;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.gstin = const Value.absent(),
    this.bankDetails = const Value.absent(),
    this.doctorRegistrationNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ContactsCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required String name,
    required String phone,
    this.email = const Value.absent(),
    this.gstin = const Value.absent(),
    this.bankDetails = const Value.absent(),
    this.doctorRegistrationNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : type = Value(type),
       name = Value(name),
       phone = Value(phone);
  static Insertable<Contact> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? gstin,
    Expression<String>? bankDetails,
    Expression<String>? doctorRegistrationNumber,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (gstin != null) 'gstin': gstin,
      if (bankDetails != null) 'bank_details': bankDetails,
      if (doctorRegistrationNumber != null)
        'doctor_registration_number': doctorRegistrationNumber,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ContactsCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<String>? name,
    Value<String>? phone,
    Value<String?>? email,
    Value<String?>? gstin,
    Value<String?>? bankDetails,
    Value<String?>? doctorRegistrationNumber,
    Value<DateTime>? createdAt,
  }) {
    return ContactsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      gstin: gstin ?? this.gstin,
      bankDetails: bankDetails ?? this.bankDetails,
      doctorRegistrationNumber:
          doctorRegistrationNumber ?? this.doctorRegistrationNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (gstin.present) {
      map['gstin'] = Variable<String>(gstin.value);
    }
    if (bankDetails.present) {
      map['bank_details'] = Variable<String>(bankDetails.value);
    }
    if (doctorRegistrationNumber.present) {
      map['doctor_registration_number'] = Variable<String>(
        doctorRegistrationNumber.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('gstin: $gstin, ')
          ..write('bankDetails: $bankDetails, ')
          ..write('doctorRegistrationNumber: $doctorRegistrationNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PurchaseInvoicesTable extends PurchaseInvoices
    with TableInfo<$PurchaseInvoicesTable, PurchaseInvoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseInvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _supplierNameMeta = const VerificationMeta(
    'supplierName',
  );
  @override
  late final GeneratedColumn<String> supplierName = GeneratedColumn<String>(
    'supplier_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierGstinMeta = const VerificationMeta(
    'supplierGstin',
  );
  @override
  late final GeneratedColumn<String> supplierGstin = GeneratedColumn<String>(
    'supplier_gstin',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _taxableAmountMeta = const VerificationMeta(
    'taxableAmount',
  );
  @override
  late final GeneratedColumn<double> taxableAmount = GeneratedColumn<double>(
    'taxable_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gstAmountMeta = const VerificationMeta(
    'gstAmount',
  );
  @override
  late final GeneratedColumn<double> gstAmount = GeneratedColumn<double>(
    'gst_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    supplierName,
    supplierGstin,
    taxableAmount,
    gstAmount,
    totalAmount,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseInvoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('supplier_name')) {
      context.handle(
        _supplierNameMeta,
        supplierName.isAcceptableOrUnknown(
          data['supplier_name']!,
          _supplierNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_supplierNameMeta);
    }
    if (data.containsKey('supplier_gstin')) {
      context.handle(
        _supplierGstinMeta,
        supplierGstin.isAcceptableOrUnknown(
          data['supplier_gstin']!,
          _supplierGstinMeta,
        ),
      );
    }
    if (data.containsKey('taxable_amount')) {
      context.handle(
        _taxableAmountMeta,
        taxableAmount.isAcceptableOrUnknown(
          data['taxable_amount']!,
          _taxableAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_taxableAmountMeta);
    }
    if (data.containsKey('gst_amount')) {
      context.handle(
        _gstAmountMeta,
        gstAmount.isAcceptableOrUnknown(data['gst_amount']!, _gstAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_gstAmountMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseInvoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseInvoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      supplierName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_name'],
      )!,
      supplierGstin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_gstin'],
      ),
      taxableAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}taxable_amount'],
      )!,
      gstAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gst_amount'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PurchaseInvoicesTable createAlias(String alias) {
    return $PurchaseInvoicesTable(attachedDatabase, alias);
  }
}

class PurchaseInvoice extends DataClass implements Insertable<PurchaseInvoice> {
  final int id;
  final String supplierName;
  final String? supplierGstin;
  final double taxableAmount;
  final double gstAmount;
  final double totalAmount;
  final DateTime createdAt;
  const PurchaseInvoice({
    required this.id,
    required this.supplierName,
    this.supplierGstin,
    required this.taxableAmount,
    required this.gstAmount,
    required this.totalAmount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['supplier_name'] = Variable<String>(supplierName);
    if (!nullToAbsent || supplierGstin != null) {
      map['supplier_gstin'] = Variable<String>(supplierGstin);
    }
    map['taxable_amount'] = Variable<double>(taxableAmount);
    map['gst_amount'] = Variable<double>(gstAmount);
    map['total_amount'] = Variable<double>(totalAmount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PurchaseInvoicesCompanion toCompanion(bool nullToAbsent) {
    return PurchaseInvoicesCompanion(
      id: Value(id),
      supplierName: Value(supplierName),
      supplierGstin: supplierGstin == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierGstin),
      taxableAmount: Value(taxableAmount),
      gstAmount: Value(gstAmount),
      totalAmount: Value(totalAmount),
      createdAt: Value(createdAt),
    );
  }

  factory PurchaseInvoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseInvoice(
      id: serializer.fromJson<int>(json['id']),
      supplierName: serializer.fromJson<String>(json['supplierName']),
      supplierGstin: serializer.fromJson<String?>(json['supplierGstin']),
      taxableAmount: serializer.fromJson<double>(json['taxableAmount']),
      gstAmount: serializer.fromJson<double>(json['gstAmount']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'supplierName': serializer.toJson<String>(supplierName),
      'supplierGstin': serializer.toJson<String?>(supplierGstin),
      'taxableAmount': serializer.toJson<double>(taxableAmount),
      'gstAmount': serializer.toJson<double>(gstAmount),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PurchaseInvoice copyWith({
    int? id,
    String? supplierName,
    Value<String?> supplierGstin = const Value.absent(),
    double? taxableAmount,
    double? gstAmount,
    double? totalAmount,
    DateTime? createdAt,
  }) => PurchaseInvoice(
    id: id ?? this.id,
    supplierName: supplierName ?? this.supplierName,
    supplierGstin: supplierGstin.present
        ? supplierGstin.value
        : this.supplierGstin,
    taxableAmount: taxableAmount ?? this.taxableAmount,
    gstAmount: gstAmount ?? this.gstAmount,
    totalAmount: totalAmount ?? this.totalAmount,
    createdAt: createdAt ?? this.createdAt,
  );
  PurchaseInvoice copyWithCompanion(PurchaseInvoicesCompanion data) {
    return PurchaseInvoice(
      id: data.id.present ? data.id.value : this.id,
      supplierName: data.supplierName.present
          ? data.supplierName.value
          : this.supplierName,
      supplierGstin: data.supplierGstin.present
          ? data.supplierGstin.value
          : this.supplierGstin,
      taxableAmount: data.taxableAmount.present
          ? data.taxableAmount.value
          : this.taxableAmount,
      gstAmount: data.gstAmount.present ? data.gstAmount.value : this.gstAmount,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseInvoice(')
          ..write('id: $id, ')
          ..write('supplierName: $supplierName, ')
          ..write('supplierGstin: $supplierGstin, ')
          ..write('taxableAmount: $taxableAmount, ')
          ..write('gstAmount: $gstAmount, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    supplierName,
    supplierGstin,
    taxableAmount,
    gstAmount,
    totalAmount,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseInvoice &&
          other.id == this.id &&
          other.supplierName == this.supplierName &&
          other.supplierGstin == this.supplierGstin &&
          other.taxableAmount == this.taxableAmount &&
          other.gstAmount == this.gstAmount &&
          other.totalAmount == this.totalAmount &&
          other.createdAt == this.createdAt);
}

class PurchaseInvoicesCompanion extends UpdateCompanion<PurchaseInvoice> {
  final Value<int> id;
  final Value<String> supplierName;
  final Value<String?> supplierGstin;
  final Value<double> taxableAmount;
  final Value<double> gstAmount;
  final Value<double> totalAmount;
  final Value<DateTime> createdAt;
  const PurchaseInvoicesCompanion({
    this.id = const Value.absent(),
    this.supplierName = const Value.absent(),
    this.supplierGstin = const Value.absent(),
    this.taxableAmount = const Value.absent(),
    this.gstAmount = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PurchaseInvoicesCompanion.insert({
    this.id = const Value.absent(),
    required String supplierName,
    this.supplierGstin = const Value.absent(),
    required double taxableAmount,
    required double gstAmount,
    required double totalAmount,
    this.createdAt = const Value.absent(),
  }) : supplierName = Value(supplierName),
       taxableAmount = Value(taxableAmount),
       gstAmount = Value(gstAmount),
       totalAmount = Value(totalAmount);
  static Insertable<PurchaseInvoice> custom({
    Expression<int>? id,
    Expression<String>? supplierName,
    Expression<String>? supplierGstin,
    Expression<double>? taxableAmount,
    Expression<double>? gstAmount,
    Expression<double>? totalAmount,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (supplierName != null) 'supplier_name': supplierName,
      if (supplierGstin != null) 'supplier_gstin': supplierGstin,
      if (taxableAmount != null) 'taxable_amount': taxableAmount,
      if (gstAmount != null) 'gst_amount': gstAmount,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PurchaseInvoicesCompanion copyWith({
    Value<int>? id,
    Value<String>? supplierName,
    Value<String?>? supplierGstin,
    Value<double>? taxableAmount,
    Value<double>? gstAmount,
    Value<double>? totalAmount,
    Value<DateTime>? createdAt,
  }) {
    return PurchaseInvoicesCompanion(
      id: id ?? this.id,
      supplierName: supplierName ?? this.supplierName,
      supplierGstin: supplierGstin ?? this.supplierGstin,
      taxableAmount: taxableAmount ?? this.taxableAmount,
      gstAmount: gstAmount ?? this.gstAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (supplierName.present) {
      map['supplier_name'] = Variable<String>(supplierName.value);
    }
    if (supplierGstin.present) {
      map['supplier_gstin'] = Variable<String>(supplierGstin.value);
    }
    if (taxableAmount.present) {
      map['taxable_amount'] = Variable<double>(taxableAmount.value);
    }
    if (gstAmount.present) {
      map['gst_amount'] = Variable<double>(gstAmount.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseInvoicesCompanion(')
          ..write('id: $id, ')
          ..write('supplierName: $supplierName, ')
          ..write('supplierGstin: $supplierGstin, ')
          ..write('taxableAmount: $taxableAmount, ')
          ..write('gstAmount: $gstAmount, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PurchaseInvoiceItemsTable extends PurchaseInvoiceItems
    with TableInfo<$PurchaseInvoiceItemsTable, PurchaseInvoiceItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseInvoiceItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _purchaseInvoiceIdMeta = const VerificationMeta(
    'purchaseInvoiceId',
  );
  @override
  late final GeneratedColumn<int> purchaseInvoiceId = GeneratedColumn<int>(
    'purchase_invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES purchase_invoices (id)',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batchNumberMeta = const VerificationMeta(
    'batchNumber',
  );
  @override
  late final GeneratedColumn<String> batchNumber = GeneratedColumn<String>(
    'batch_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gstRateMeta = const VerificationMeta(
    'gstRate',
  );
  @override
  late final GeneratedColumn<double> gstRate = GeneratedColumn<double>(
    'gst_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expDateMeta = const VerificationMeta(
    'expDate',
  );
  @override
  late final GeneratedColumn<DateTime> expDate = GeneratedColumn<DateTime>(
    'exp_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    purchaseInvoiceId,
    productId,
    productName,
    batchNumber,
    quantity,
    purchasePrice,
    gstRate,
    expDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_invoice_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseInvoiceItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('purchase_invoice_id')) {
      context.handle(
        _purchaseInvoiceIdMeta,
        purchaseInvoiceId.isAcceptableOrUnknown(
          data['purchase_invoice_id']!,
          _purchaseInvoiceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchaseInvoiceIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('batch_number')) {
      context.handle(
        _batchNumberMeta,
        batchNumber.isAcceptableOrUnknown(
          data['batch_number']!,
          _batchNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_batchNumberMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasePriceMeta);
    }
    if (data.containsKey('gst_rate')) {
      context.handle(
        _gstRateMeta,
        gstRate.isAcceptableOrUnknown(data['gst_rate']!, _gstRateMeta),
      );
    } else if (isInserting) {
      context.missing(_gstRateMeta);
    }
    if (data.containsKey('exp_date')) {
      context.handle(
        _expDateMeta,
        expDate.isAcceptableOrUnknown(data['exp_date']!, _expDateMeta),
      );
    } else if (isInserting) {
      context.missing(_expDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseInvoiceItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseInvoiceItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      purchaseInvoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchase_invoice_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      ),
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      batchNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_number'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price'],
      )!,
      gstRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gst_rate'],
      )!,
      expDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}exp_date'],
      )!,
    );
  }

  @override
  $PurchaseInvoiceItemsTable createAlias(String alias) {
    return $PurchaseInvoiceItemsTable(attachedDatabase, alias);
  }
}

class PurchaseInvoiceItem extends DataClass
    implements Insertable<PurchaseInvoiceItem> {
  final int id;
  final int purchaseInvoiceId;
  final int? productId;
  final String productName;
  final String batchNumber;
  final double quantity;
  final double purchasePrice;
  final double gstRate;
  final DateTime expDate;
  const PurchaseInvoiceItem({
    required this.id,
    required this.purchaseInvoiceId,
    this.productId,
    required this.productName,
    required this.batchNumber,
    required this.quantity,
    required this.purchasePrice,
    required this.gstRate,
    required this.expDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['purchase_invoice_id'] = Variable<int>(purchaseInvoiceId);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
    }
    map['product_name'] = Variable<String>(productName);
    map['batch_number'] = Variable<String>(batchNumber);
    map['quantity'] = Variable<double>(quantity);
    map['purchase_price'] = Variable<double>(purchasePrice);
    map['gst_rate'] = Variable<double>(gstRate);
    map['exp_date'] = Variable<DateTime>(expDate);
    return map;
  }

  PurchaseInvoiceItemsCompanion toCompanion(bool nullToAbsent) {
    return PurchaseInvoiceItemsCompanion(
      id: Value(id),
      purchaseInvoiceId: Value(purchaseInvoiceId),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      productName: Value(productName),
      batchNumber: Value(batchNumber),
      quantity: Value(quantity),
      purchasePrice: Value(purchasePrice),
      gstRate: Value(gstRate),
      expDate: Value(expDate),
    );
  }

  factory PurchaseInvoiceItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseInvoiceItem(
      id: serializer.fromJson<int>(json['id']),
      purchaseInvoiceId: serializer.fromJson<int>(json['purchaseInvoiceId']),
      productId: serializer.fromJson<int?>(json['productId']),
      productName: serializer.fromJson<String>(json['productName']),
      batchNumber: serializer.fromJson<String>(json['batchNumber']),
      quantity: serializer.fromJson<double>(json['quantity']),
      purchasePrice: serializer.fromJson<double>(json['purchasePrice']),
      gstRate: serializer.fromJson<double>(json['gstRate']),
      expDate: serializer.fromJson<DateTime>(json['expDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'purchaseInvoiceId': serializer.toJson<int>(purchaseInvoiceId),
      'productId': serializer.toJson<int?>(productId),
      'productName': serializer.toJson<String>(productName),
      'batchNumber': serializer.toJson<String>(batchNumber),
      'quantity': serializer.toJson<double>(quantity),
      'purchasePrice': serializer.toJson<double>(purchasePrice),
      'gstRate': serializer.toJson<double>(gstRate),
      'expDate': serializer.toJson<DateTime>(expDate),
    };
  }

  PurchaseInvoiceItem copyWith({
    int? id,
    int? purchaseInvoiceId,
    Value<int?> productId = const Value.absent(),
    String? productName,
    String? batchNumber,
    double? quantity,
    double? purchasePrice,
    double? gstRate,
    DateTime? expDate,
  }) => PurchaseInvoiceItem(
    id: id ?? this.id,
    purchaseInvoiceId: purchaseInvoiceId ?? this.purchaseInvoiceId,
    productId: productId.present ? productId.value : this.productId,
    productName: productName ?? this.productName,
    batchNumber: batchNumber ?? this.batchNumber,
    quantity: quantity ?? this.quantity,
    purchasePrice: purchasePrice ?? this.purchasePrice,
    gstRate: gstRate ?? this.gstRate,
    expDate: expDate ?? this.expDate,
  );
  PurchaseInvoiceItem copyWithCompanion(PurchaseInvoiceItemsCompanion data) {
    return PurchaseInvoiceItem(
      id: data.id.present ? data.id.value : this.id,
      purchaseInvoiceId: data.purchaseInvoiceId.present
          ? data.purchaseInvoiceId.value
          : this.purchaseInvoiceId,
      productId: data.productId.present ? data.productId.value : this.productId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      batchNumber: data.batchNumber.present
          ? data.batchNumber.value
          : this.batchNumber,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      gstRate: data.gstRate.present ? data.gstRate.value : this.gstRate,
      expDate: data.expDate.present ? data.expDate.value : this.expDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseInvoiceItem(')
          ..write('id: $id, ')
          ..write('purchaseInvoiceId: $purchaseInvoiceId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('quantity: $quantity, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('gstRate: $gstRate, ')
          ..write('expDate: $expDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    purchaseInvoiceId,
    productId,
    productName,
    batchNumber,
    quantity,
    purchasePrice,
    gstRate,
    expDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseInvoiceItem &&
          other.id == this.id &&
          other.purchaseInvoiceId == this.purchaseInvoiceId &&
          other.productId == this.productId &&
          other.productName == this.productName &&
          other.batchNumber == this.batchNumber &&
          other.quantity == this.quantity &&
          other.purchasePrice == this.purchasePrice &&
          other.gstRate == this.gstRate &&
          other.expDate == this.expDate);
}

class PurchaseInvoiceItemsCompanion
    extends UpdateCompanion<PurchaseInvoiceItem> {
  final Value<int> id;
  final Value<int> purchaseInvoiceId;
  final Value<int?> productId;
  final Value<String> productName;
  final Value<String> batchNumber;
  final Value<double> quantity;
  final Value<double> purchasePrice;
  final Value<double> gstRate;
  final Value<DateTime> expDate;
  const PurchaseInvoiceItemsCompanion({
    this.id = const Value.absent(),
    this.purchaseInvoiceId = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.batchNumber = const Value.absent(),
    this.quantity = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.gstRate = const Value.absent(),
    this.expDate = const Value.absent(),
  });
  PurchaseInvoiceItemsCompanion.insert({
    this.id = const Value.absent(),
    required int purchaseInvoiceId,
    this.productId = const Value.absent(),
    required String productName,
    required String batchNumber,
    required double quantity,
    required double purchasePrice,
    required double gstRate,
    required DateTime expDate,
  }) : purchaseInvoiceId = Value(purchaseInvoiceId),
       productName = Value(productName),
       batchNumber = Value(batchNumber),
       quantity = Value(quantity),
       purchasePrice = Value(purchasePrice),
       gstRate = Value(gstRate),
       expDate = Value(expDate);
  static Insertable<PurchaseInvoiceItem> custom({
    Expression<int>? id,
    Expression<int>? purchaseInvoiceId,
    Expression<int>? productId,
    Expression<String>? productName,
    Expression<String>? batchNumber,
    Expression<double>? quantity,
    Expression<double>? purchasePrice,
    Expression<double>? gstRate,
    Expression<DateTime>? expDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (purchaseInvoiceId != null) 'purchase_invoice_id': purchaseInvoiceId,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (batchNumber != null) 'batch_number': batchNumber,
      if (quantity != null) 'quantity': quantity,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (gstRate != null) 'gst_rate': gstRate,
      if (expDate != null) 'exp_date': expDate,
    });
  }

  PurchaseInvoiceItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? purchaseInvoiceId,
    Value<int?>? productId,
    Value<String>? productName,
    Value<String>? batchNumber,
    Value<double>? quantity,
    Value<double>? purchasePrice,
    Value<double>? gstRate,
    Value<DateTime>? expDate,
  }) {
    return PurchaseInvoiceItemsCompanion(
      id: id ?? this.id,
      purchaseInvoiceId: purchaseInvoiceId ?? this.purchaseInvoiceId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      batchNumber: batchNumber ?? this.batchNumber,
      quantity: quantity ?? this.quantity,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      gstRate: gstRate ?? this.gstRate,
      expDate: expDate ?? this.expDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (purchaseInvoiceId.present) {
      map['purchase_invoice_id'] = Variable<int>(purchaseInvoiceId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (batchNumber.present) {
      map['batch_number'] = Variable<String>(batchNumber.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (gstRate.present) {
      map['gst_rate'] = Variable<double>(gstRate.value);
    }
    if (expDate.present) {
      map['exp_date'] = Variable<DateTime>(expDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseInvoiceItemsCompanion(')
          ..write('id: $id, ')
          ..write('purchaseInvoiceId: $purchaseInvoiceId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('quantity: $quantity, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('gstRate: $gstRate, ')
          ..write('expDate: $expDate')
          ..write(')'))
        .toString();
  }
}

class $CreditNotesTable extends CreditNotes
    with TableInfo<$CreditNotesTable, CreditNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _originalInvoiceNoMeta = const VerificationMeta(
    'originalInvoiceNo',
  );
  @override
  late final GeneratedColumn<String> originalInvoiceNo =
      GeneratedColumn<String>(
        'original_invoice_no',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _originalInvoiceDateMeta =
      const VerificationMeta('originalInvoiceDate');
  @override
  late final GeneratedColumn<DateTime> originalInvoiceDate =
      GeneratedColumn<DateTime>(
        'original_invoice_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _returnDateMeta = const VerificationMeta(
    'returnDate',
  );
  @override
  late final GeneratedColumn<DateTime> returnDate = GeneratedColumn<DateTime>(
    'return_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxableAmountMeta = const VerificationMeta(
    'taxableAmount',
  );
  @override
  late final GeneratedColumn<double> taxableAmount = GeneratedColumn<double>(
    'taxable_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _gstAmountMeta = const VerificationMeta(
    'gstAmount',
  );
  @override
  late final GeneratedColumn<double> gstAmount = GeneratedColumn<double>(
    'gst_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    originalInvoiceNo,
    originalInvoiceDate,
    returnDate,
    taxableAmount,
    gstAmount,
    totalAmount,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<CreditNote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('original_invoice_no')) {
      context.handle(
        _originalInvoiceNoMeta,
        originalInvoiceNo.isAcceptableOrUnknown(
          data['original_invoice_no']!,
          _originalInvoiceNoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalInvoiceNoMeta);
    }
    if (data.containsKey('original_invoice_date')) {
      context.handle(
        _originalInvoiceDateMeta,
        originalInvoiceDate.isAcceptableOrUnknown(
          data['original_invoice_date']!,
          _originalInvoiceDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalInvoiceDateMeta);
    }
    if (data.containsKey('return_date')) {
      context.handle(
        _returnDateMeta,
        returnDate.isAcceptableOrUnknown(data['return_date']!, _returnDateMeta),
      );
    } else if (isInserting) {
      context.missing(_returnDateMeta);
    }
    if (data.containsKey('taxable_amount')) {
      context.handle(
        _taxableAmountMeta,
        taxableAmount.isAcceptableOrUnknown(
          data['taxable_amount']!,
          _taxableAmountMeta,
        ),
      );
    }
    if (data.containsKey('gst_amount')) {
      context.handle(
        _gstAmountMeta,
        gstAmount.isAcceptableOrUnknown(data['gst_amount']!, _gstAmountMeta),
      );
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CreditNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditNote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      originalInvoiceNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_invoice_no'],
      )!,
      originalInvoiceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}original_invoice_date'],
      )!,
      returnDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}return_date'],
      )!,
      taxableAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}taxable_amount'],
      )!,
      gstAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gst_amount'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CreditNotesTable createAlias(String alias) {
    return $CreditNotesTable(attachedDatabase, alias);
  }
}

class CreditNote extends DataClass implements Insertable<CreditNote> {
  final int id;
  final String originalInvoiceNo;
  final DateTime originalInvoiceDate;
  final DateTime returnDate;
  final double taxableAmount;
  final double gstAmount;
  final double totalAmount;
  final DateTime createdAt;
  const CreditNote({
    required this.id,
    required this.originalInvoiceNo,
    required this.originalInvoiceDate,
    required this.returnDate,
    required this.taxableAmount,
    required this.gstAmount,
    required this.totalAmount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['original_invoice_no'] = Variable<String>(originalInvoiceNo);
    map['original_invoice_date'] = Variable<DateTime>(originalInvoiceDate);
    map['return_date'] = Variable<DateTime>(returnDate);
    map['taxable_amount'] = Variable<double>(taxableAmount);
    map['gst_amount'] = Variable<double>(gstAmount);
    map['total_amount'] = Variable<double>(totalAmount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CreditNotesCompanion toCompanion(bool nullToAbsent) {
    return CreditNotesCompanion(
      id: Value(id),
      originalInvoiceNo: Value(originalInvoiceNo),
      originalInvoiceDate: Value(originalInvoiceDate),
      returnDate: Value(returnDate),
      taxableAmount: Value(taxableAmount),
      gstAmount: Value(gstAmount),
      totalAmount: Value(totalAmount),
      createdAt: Value(createdAt),
    );
  }

  factory CreditNote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditNote(
      id: serializer.fromJson<int>(json['id']),
      originalInvoiceNo: serializer.fromJson<String>(json['originalInvoiceNo']),
      originalInvoiceDate: serializer.fromJson<DateTime>(
        json['originalInvoiceDate'],
      ),
      returnDate: serializer.fromJson<DateTime>(json['returnDate']),
      taxableAmount: serializer.fromJson<double>(json['taxableAmount']),
      gstAmount: serializer.fromJson<double>(json['gstAmount']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'originalInvoiceNo': serializer.toJson<String>(originalInvoiceNo),
      'originalInvoiceDate': serializer.toJson<DateTime>(originalInvoiceDate),
      'returnDate': serializer.toJson<DateTime>(returnDate),
      'taxableAmount': serializer.toJson<double>(taxableAmount),
      'gstAmount': serializer.toJson<double>(gstAmount),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CreditNote copyWith({
    int? id,
    String? originalInvoiceNo,
    DateTime? originalInvoiceDate,
    DateTime? returnDate,
    double? taxableAmount,
    double? gstAmount,
    double? totalAmount,
    DateTime? createdAt,
  }) => CreditNote(
    id: id ?? this.id,
    originalInvoiceNo: originalInvoiceNo ?? this.originalInvoiceNo,
    originalInvoiceDate: originalInvoiceDate ?? this.originalInvoiceDate,
    returnDate: returnDate ?? this.returnDate,
    taxableAmount: taxableAmount ?? this.taxableAmount,
    gstAmount: gstAmount ?? this.gstAmount,
    totalAmount: totalAmount ?? this.totalAmount,
    createdAt: createdAt ?? this.createdAt,
  );
  CreditNote copyWithCompanion(CreditNotesCompanion data) {
    return CreditNote(
      id: data.id.present ? data.id.value : this.id,
      originalInvoiceNo: data.originalInvoiceNo.present
          ? data.originalInvoiceNo.value
          : this.originalInvoiceNo,
      originalInvoiceDate: data.originalInvoiceDate.present
          ? data.originalInvoiceDate.value
          : this.originalInvoiceDate,
      returnDate: data.returnDate.present
          ? data.returnDate.value
          : this.returnDate,
      taxableAmount: data.taxableAmount.present
          ? data.taxableAmount.value
          : this.taxableAmount,
      gstAmount: data.gstAmount.present ? data.gstAmount.value : this.gstAmount,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditNote(')
          ..write('id: $id, ')
          ..write('originalInvoiceNo: $originalInvoiceNo, ')
          ..write('originalInvoiceDate: $originalInvoiceDate, ')
          ..write('returnDate: $returnDate, ')
          ..write('taxableAmount: $taxableAmount, ')
          ..write('gstAmount: $gstAmount, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    originalInvoiceNo,
    originalInvoiceDate,
    returnDate,
    taxableAmount,
    gstAmount,
    totalAmount,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditNote &&
          other.id == this.id &&
          other.originalInvoiceNo == this.originalInvoiceNo &&
          other.originalInvoiceDate == this.originalInvoiceDate &&
          other.returnDate == this.returnDate &&
          other.taxableAmount == this.taxableAmount &&
          other.gstAmount == this.gstAmount &&
          other.totalAmount == this.totalAmount &&
          other.createdAt == this.createdAt);
}

class CreditNotesCompanion extends UpdateCompanion<CreditNote> {
  final Value<int> id;
  final Value<String> originalInvoiceNo;
  final Value<DateTime> originalInvoiceDate;
  final Value<DateTime> returnDate;
  final Value<double> taxableAmount;
  final Value<double> gstAmount;
  final Value<double> totalAmount;
  final Value<DateTime> createdAt;
  const CreditNotesCompanion({
    this.id = const Value.absent(),
    this.originalInvoiceNo = const Value.absent(),
    this.originalInvoiceDate = const Value.absent(),
    this.returnDate = const Value.absent(),
    this.taxableAmount = const Value.absent(),
    this.gstAmount = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CreditNotesCompanion.insert({
    this.id = const Value.absent(),
    required String originalInvoiceNo,
    required DateTime originalInvoiceDate,
    required DateTime returnDate,
    this.taxableAmount = const Value.absent(),
    this.gstAmount = const Value.absent(),
    required double totalAmount,
    this.createdAt = const Value.absent(),
  }) : originalInvoiceNo = Value(originalInvoiceNo),
       originalInvoiceDate = Value(originalInvoiceDate),
       returnDate = Value(returnDate),
       totalAmount = Value(totalAmount);
  static Insertable<CreditNote> custom({
    Expression<int>? id,
    Expression<String>? originalInvoiceNo,
    Expression<DateTime>? originalInvoiceDate,
    Expression<DateTime>? returnDate,
    Expression<double>? taxableAmount,
    Expression<double>? gstAmount,
    Expression<double>? totalAmount,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (originalInvoiceNo != null) 'original_invoice_no': originalInvoiceNo,
      if (originalInvoiceDate != null)
        'original_invoice_date': originalInvoiceDate,
      if (returnDate != null) 'return_date': returnDate,
      if (taxableAmount != null) 'taxable_amount': taxableAmount,
      if (gstAmount != null) 'gst_amount': gstAmount,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CreditNotesCompanion copyWith({
    Value<int>? id,
    Value<String>? originalInvoiceNo,
    Value<DateTime>? originalInvoiceDate,
    Value<DateTime>? returnDate,
    Value<double>? taxableAmount,
    Value<double>? gstAmount,
    Value<double>? totalAmount,
    Value<DateTime>? createdAt,
  }) {
    return CreditNotesCompanion(
      id: id ?? this.id,
      originalInvoiceNo: originalInvoiceNo ?? this.originalInvoiceNo,
      originalInvoiceDate: originalInvoiceDate ?? this.originalInvoiceDate,
      returnDate: returnDate ?? this.returnDate,
      taxableAmount: taxableAmount ?? this.taxableAmount,
      gstAmount: gstAmount ?? this.gstAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (originalInvoiceNo.present) {
      map['original_invoice_no'] = Variable<String>(originalInvoiceNo.value);
    }
    if (originalInvoiceDate.present) {
      map['original_invoice_date'] = Variable<DateTime>(
        originalInvoiceDate.value,
      );
    }
    if (returnDate.present) {
      map['return_date'] = Variable<DateTime>(returnDate.value);
    }
    if (taxableAmount.present) {
      map['taxable_amount'] = Variable<double>(taxableAmount.value);
    }
    if (gstAmount.present) {
      map['gst_amount'] = Variable<double>(gstAmount.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditNotesCompanion(')
          ..write('id: $id, ')
          ..write('originalInvoiceNo: $originalInvoiceNo, ')
          ..write('originalInvoiceDate: $originalInvoiceDate, ')
          ..write('returnDate: $returnDate, ')
          ..write('taxableAmount: $taxableAmount, ')
          ..write('gstAmount: $gstAmount, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CreditNoteItemsTable extends CreditNoteItems
    with TableInfo<$CreditNoteItemsTable, CreditNoteItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditNoteItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _creditNoteIdMeta = const VerificationMeta(
    'creditNoteId',
  );
  @override
  late final GeneratedColumn<int> creditNoteId = GeneratedColumn<int>(
    'credit_note_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES credit_notes (id)',
    ),
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batchNumberMeta = const VerificationMeta(
    'batchNumber',
  );
  @override
  late final GeneratedColumn<String> batchNumber = GeneratedColumn<String>(
    'batch_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxRateMeta = const VerificationMeta(
    'taxRate',
  );
  @override
  late final GeneratedColumn<double> taxRate = GeneratedColumn<double>(
    'tax_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    creditNoteId,
    productName,
    batchNumber,
    quantity,
    unitPrice,
    taxRate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_note_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<CreditNoteItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('credit_note_id')) {
      context.handle(
        _creditNoteIdMeta,
        creditNoteId.isAcceptableOrUnknown(
          data['credit_note_id']!,
          _creditNoteIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creditNoteIdMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('batch_number')) {
      context.handle(
        _batchNumberMeta,
        batchNumber.isAcceptableOrUnknown(
          data['batch_number']!,
          _batchNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_batchNumberMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('tax_rate')) {
      context.handle(
        _taxRateMeta,
        taxRate.isAcceptableOrUnknown(data['tax_rate']!, _taxRateMeta),
      );
    } else if (isInserting) {
      context.missing(_taxRateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CreditNoteItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditNoteItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      creditNoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}credit_note_id'],
      )!,
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      batchNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_number'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      taxRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_rate'],
      )!,
    );
  }

  @override
  $CreditNoteItemsTable createAlias(String alias) {
    return $CreditNoteItemsTable(attachedDatabase, alias);
  }
}

class CreditNoteItem extends DataClass implements Insertable<CreditNoteItem> {
  final int id;
  final int creditNoteId;
  final String productName;
  final String batchNumber;
  final double quantity;
  final double unitPrice;
  final double taxRate;
  const CreditNoteItem({
    required this.id,
    required this.creditNoteId,
    required this.productName,
    required this.batchNumber,
    required this.quantity,
    required this.unitPrice,
    required this.taxRate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['credit_note_id'] = Variable<int>(creditNoteId);
    map['product_name'] = Variable<String>(productName);
    map['batch_number'] = Variable<String>(batchNumber);
    map['quantity'] = Variable<double>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    map['tax_rate'] = Variable<double>(taxRate);
    return map;
  }

  CreditNoteItemsCompanion toCompanion(bool nullToAbsent) {
    return CreditNoteItemsCompanion(
      id: Value(id),
      creditNoteId: Value(creditNoteId),
      productName: Value(productName),
      batchNumber: Value(batchNumber),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      taxRate: Value(taxRate),
    );
  }

  factory CreditNoteItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditNoteItem(
      id: serializer.fromJson<int>(json['id']),
      creditNoteId: serializer.fromJson<int>(json['creditNoteId']),
      productName: serializer.fromJson<String>(json['productName']),
      batchNumber: serializer.fromJson<String>(json['batchNumber']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      taxRate: serializer.fromJson<double>(json['taxRate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'creditNoteId': serializer.toJson<int>(creditNoteId),
      'productName': serializer.toJson<String>(productName),
      'batchNumber': serializer.toJson<String>(batchNumber),
      'quantity': serializer.toJson<double>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'taxRate': serializer.toJson<double>(taxRate),
    };
  }

  CreditNoteItem copyWith({
    int? id,
    int? creditNoteId,
    String? productName,
    String? batchNumber,
    double? quantity,
    double? unitPrice,
    double? taxRate,
  }) => CreditNoteItem(
    id: id ?? this.id,
    creditNoteId: creditNoteId ?? this.creditNoteId,
    productName: productName ?? this.productName,
    batchNumber: batchNumber ?? this.batchNumber,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    taxRate: taxRate ?? this.taxRate,
  );
  CreditNoteItem copyWithCompanion(CreditNoteItemsCompanion data) {
    return CreditNoteItem(
      id: data.id.present ? data.id.value : this.id,
      creditNoteId: data.creditNoteId.present
          ? data.creditNoteId.value
          : this.creditNoteId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      batchNumber: data.batchNumber.present
          ? data.batchNumber.value
          : this.batchNumber,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      taxRate: data.taxRate.present ? data.taxRate.value : this.taxRate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditNoteItem(')
          ..write('id: $id, ')
          ..write('creditNoteId: $creditNoteId, ')
          ..write('productName: $productName, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('taxRate: $taxRate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    creditNoteId,
    productName,
    batchNumber,
    quantity,
    unitPrice,
    taxRate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditNoteItem &&
          other.id == this.id &&
          other.creditNoteId == this.creditNoteId &&
          other.productName == this.productName &&
          other.batchNumber == this.batchNumber &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.taxRate == this.taxRate);
}

class CreditNoteItemsCompanion extends UpdateCompanion<CreditNoteItem> {
  final Value<int> id;
  final Value<int> creditNoteId;
  final Value<String> productName;
  final Value<String> batchNumber;
  final Value<double> quantity;
  final Value<double> unitPrice;
  final Value<double> taxRate;
  const CreditNoteItemsCompanion({
    this.id = const Value.absent(),
    this.creditNoteId = const Value.absent(),
    this.productName = const Value.absent(),
    this.batchNumber = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.taxRate = const Value.absent(),
  });
  CreditNoteItemsCompanion.insert({
    this.id = const Value.absent(),
    required int creditNoteId,
    required String productName,
    required String batchNumber,
    required double quantity,
    required double unitPrice,
    required double taxRate,
  }) : creditNoteId = Value(creditNoteId),
       productName = Value(productName),
       batchNumber = Value(batchNumber),
       quantity = Value(quantity),
       unitPrice = Value(unitPrice),
       taxRate = Value(taxRate);
  static Insertable<CreditNoteItem> custom({
    Expression<int>? id,
    Expression<int>? creditNoteId,
    Expression<String>? productName,
    Expression<String>? batchNumber,
    Expression<double>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? taxRate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (creditNoteId != null) 'credit_note_id': creditNoteId,
      if (productName != null) 'product_name': productName,
      if (batchNumber != null) 'batch_number': batchNumber,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (taxRate != null) 'tax_rate': taxRate,
    });
  }

  CreditNoteItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? creditNoteId,
    Value<String>? productName,
    Value<String>? batchNumber,
    Value<double>? quantity,
    Value<double>? unitPrice,
    Value<double>? taxRate,
  }) {
    return CreditNoteItemsCompanion(
      id: id ?? this.id,
      creditNoteId: creditNoteId ?? this.creditNoteId,
      productName: productName ?? this.productName,
      batchNumber: batchNumber ?? this.batchNumber,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      taxRate: taxRate ?? this.taxRate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (creditNoteId.present) {
      map['credit_note_id'] = Variable<int>(creditNoteId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (batchNumber.present) {
      map['batch_number'] = Variable<String>(batchNumber.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (taxRate.present) {
      map['tax_rate'] = Variable<double>(taxRate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditNoteItemsCompanion(')
          ..write('id: $id, ')
          ..write('creditNoteId: $creditNoteId, ')
          ..write('productName: $productName, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('taxRate: $taxRate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $BatchesTable batches = $BatchesTable(this);
  late final $InventoryAdjustmentsTable inventoryAdjustments =
      $InventoryAdjustmentsTable(this);
  late final $AuditLogsTable auditLogs = $AuditLogsTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $PurchaseInvoicesTable purchaseInvoices = $PurchaseInvoicesTable(
    this,
  );
  late final $PurchaseInvoiceItemsTable purchaseInvoiceItems =
      $PurchaseInvoiceItemsTable(this);
  late final $CreditNotesTable creditNotes = $CreditNotesTable(this);
  late final $CreditNoteItemsTable creditNoteItems = $CreditNoteItemsTable(
    this,
  );
  late final UserDao userDao = UserDao(this as AppDatabase);
  late final ProductDao productDao = ProductDao(this as AppDatabase);
  late final BatchDao batchDao = BatchDao(this as AppDatabase);
  late final AuditLogDao auditLogDao = AuditLogDao(this as AppDatabase);
  late final DashboardDao dashboardDao = DashboardDao(this as AppDatabase);
  late final CustomerDao customerDao = CustomerDao(this as AppDatabase);
  late final ContactDao contactDao = ContactDao(this as AppDatabase);
  late final PurchaseDao purchaseDao = PurchaseDao(this as AppDatabase);
  late final ReturnDao returnDao = ReturnDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    products,
    batches,
    inventoryAdjustments,
    auditLogs,
    invoices,
    customers,
    contacts,
    purchaseInvoices,
    purchaseInvoiceItems,
    creditNotes,
    creditNoteItems,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String username,
      required String passwordHash,
      required String role,
      Value<DateTime> createdAt,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> username,
      Value<String> passwordHash,
      Value<String> role,
      Value<DateTime> createdAt,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                username: username,
                passwordHash: passwordHash,
                role: role,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String username,
                required String passwordHash,
                required String role,
                Value<DateTime> createdAt = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                username: username,
                passwordHash: passwordHash,
                role: role,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> barcode,
      required String hsnCode,
      required double gstRate,
      required double mrp,
      Value<double> lowStockThreshold,
      Value<bool> isH1,
      Value<DateTime> createdAt,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> barcode,
      Value<String> hsnCode,
      Value<double> gstRate,
      Value<double> mrp,
      Value<double> lowStockThreshold,
      Value<bool> isH1,
      Value<DateTime> createdAt,
    });

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BatchesTable, List<Batche>> _batchesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.batches,
    aliasName: $_aliasNameGenerator(db.products.id, db.batches.productId),
  );

  $$BatchesTableProcessedTableManager get batchesRefs {
    final manager = $$BatchesTableTableManager(
      $_db,
      $_db.batches,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_batchesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InventoryAdjustmentsTable,
    List<InventoryAdjustment>
  >
  _inventoryAdjustmentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.inventoryAdjustments,
        aliasName: $_aliasNameGenerator(
          db.products.id,
          db.inventoryAdjustments.productId,
        ),
      );

  $$InventoryAdjustmentsTableProcessedTableManager
  get inventoryAdjustmentsRefs {
    final manager = $$InventoryAdjustmentsTableTableManager(
      $_db,
      $_db.inventoryAdjustments,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inventoryAdjustmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PurchaseInvoiceItemsTable,
    List<PurchaseInvoiceItem>
  >
  _purchaseInvoiceItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.purchaseInvoiceItems,
        aliasName: $_aliasNameGenerator(
          db.products.id,
          db.purchaseInvoiceItems.productId,
        ),
      );

  $$PurchaseInvoiceItemsTableProcessedTableManager
  get purchaseInvoiceItemsRefs {
    final manager = $$PurchaseInvoiceItemsTableTableManager(
      $_db,
      $_db.purchaseInvoiceItems,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _purchaseInvoiceItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hsnCode => $composableBuilder(
    column: $table.hsnCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gstRate => $composableBuilder(
    column: $table.gstRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mrp => $composableBuilder(
    column: $table.mrp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lowStockThreshold => $composableBuilder(
    column: $table.lowStockThreshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isH1 => $composableBuilder(
    column: $table.isH1,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> batchesRefs(
    Expression<bool> Function($$BatchesTableFilterComposer f) f,
  ) {
    final $$BatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableFilterComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> inventoryAdjustmentsRefs(
    Expression<bool> Function($$InventoryAdjustmentsTableFilterComposer f) f,
  ) {
    final $$InventoryAdjustmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventoryAdjustments,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryAdjustmentsTableFilterComposer(
            $db: $db,
            $table: $db.inventoryAdjustments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> purchaseInvoiceItemsRefs(
    Expression<bool> Function($$PurchaseInvoiceItemsTableFilterComposer f) f,
  ) {
    final $$PurchaseInvoiceItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseInvoiceItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseInvoiceItemsTableFilterComposer(
            $db: $db,
            $table: $db.purchaseInvoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hsnCode => $composableBuilder(
    column: $table.hsnCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gstRate => $composableBuilder(
    column: $table.gstRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mrp => $composableBuilder(
    column: $table.mrp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lowStockThreshold => $composableBuilder(
    column: $table.lowStockThreshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isH1 => $composableBuilder(
    column: $table.isH1,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get hsnCode =>
      $composableBuilder(column: $table.hsnCode, builder: (column) => column);

  GeneratedColumn<double> get gstRate =>
      $composableBuilder(column: $table.gstRate, builder: (column) => column);

  GeneratedColumn<double> get mrp =>
      $composableBuilder(column: $table.mrp, builder: (column) => column);

  GeneratedColumn<double> get lowStockThreshold => $composableBuilder(
    column: $table.lowStockThreshold,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isH1 =>
      $composableBuilder(column: $table.isH1, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> batchesRefs<T extends Object>(
    Expression<T> Function($$BatchesTableAnnotationComposer a) f,
  ) {
    final $$BatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> inventoryAdjustmentsRefs<T extends Object>(
    Expression<T> Function($$InventoryAdjustmentsTableAnnotationComposer a) f,
  ) {
    final $$InventoryAdjustmentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryAdjustments,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryAdjustmentsTableAnnotationComposer(
                $db: $db,
                $table: $db.inventoryAdjustments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> purchaseInvoiceItemsRefs<T extends Object>(
    Expression<T> Function($$PurchaseInvoiceItemsTableAnnotationComposer a) f,
  ) {
    final $$PurchaseInvoiceItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.purchaseInvoiceItems,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PurchaseInvoiceItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.purchaseInvoiceItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, $$ProductsTableReferences),
          Product,
          PrefetchHooks Function({
            bool batchesRefs,
            bool inventoryAdjustmentsRefs,
            bool purchaseInvoiceItemsRefs,
          })
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<String> hsnCode = const Value.absent(),
                Value<double> gstRate = const Value.absent(),
                Value<double> mrp = const Value.absent(),
                Value<double> lowStockThreshold = const Value.absent(),
                Value<bool> isH1 = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                name: name,
                barcode: barcode,
                hsnCode: hsnCode,
                gstRate: gstRate,
                mrp: mrp,
                lowStockThreshold: lowStockThreshold,
                isH1: isH1,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> barcode = const Value.absent(),
                required String hsnCode,
                required double gstRate,
                required double mrp,
                Value<double> lowStockThreshold = const Value.absent(),
                Value<bool> isH1 = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                name: name,
                barcode: barcode,
                hsnCode: hsnCode,
                gstRate: gstRate,
                mrp: mrp,
                lowStockThreshold: lowStockThreshold,
                isH1: isH1,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                batchesRefs = false,
                inventoryAdjustmentsRefs = false,
                purchaseInvoiceItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (batchesRefs) db.batches,
                    if (inventoryAdjustmentsRefs) db.inventoryAdjustments,
                    if (purchaseInvoiceItemsRefs) db.purchaseInvoiceItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (batchesRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          Batche
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._batchesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).batchesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (inventoryAdjustmentsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          InventoryAdjustment
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._inventoryAdjustmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).inventoryAdjustmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (purchaseInvoiceItemsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          PurchaseInvoiceItem
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._purchaseInvoiceItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseInvoiceItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, $$ProductsTableReferences),
      Product,
      PrefetchHooks Function({
        bool batchesRefs,
        bool inventoryAdjustmentsRefs,
        bool purchaseInvoiceItemsRefs,
      })
    >;
typedef $$BatchesTableCreateCompanionBuilder =
    BatchesCompanion Function({
      Value<int> id,
      required int productId,
      required String batchNumber,
      required DateTime expDate,
      required double quantity,
      required double purchasePrice,
      Value<DateTime> createdAt,
    });
typedef $$BatchesTableUpdateCompanionBuilder =
    BatchesCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<String> batchNumber,
      Value<DateTime> expDate,
      Value<double> quantity,
      Value<double> purchasePrice,
      Value<DateTime> createdAt,
    });

final class $$BatchesTableReferences
    extends BaseReferences<_$AppDatabase, $BatchesTable, Batche> {
  $$BatchesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$AppDatabase db) => db.products
      .createAlias($_aliasNameGenerator(db.batches.productId, db.products.id));

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $InventoryAdjustmentsTable,
    List<InventoryAdjustment>
  >
  _inventoryAdjustmentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.inventoryAdjustments,
        aliasName: $_aliasNameGenerator(
          db.batches.id,
          db.inventoryAdjustments.batchId,
        ),
      );

  $$InventoryAdjustmentsTableProcessedTableManager
  get inventoryAdjustmentsRefs {
    final manager = $$InventoryAdjustmentsTableTableManager(
      $_db,
      $_db.inventoryAdjustments,
    ).filter((f) => f.batchId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inventoryAdjustmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BatchesTableFilterComposer
    extends Composer<_$AppDatabase, $BatchesTable> {
  $$BatchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expDate => $composableBuilder(
    column: $table.expDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> inventoryAdjustmentsRefs(
    Expression<bool> Function($$InventoryAdjustmentsTableFilterComposer f) f,
  ) {
    final $$InventoryAdjustmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventoryAdjustments,
      getReferencedColumn: (t) => t.batchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryAdjustmentsTableFilterComposer(
            $db: $db,
            $table: $db.inventoryAdjustments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BatchesTableOrderingComposer
    extends Composer<_$AppDatabase, $BatchesTable> {
  $$BatchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expDate => $composableBuilder(
    column: $table.expDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BatchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BatchesTable> {
  $$BatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expDate =>
      $composableBuilder(column: $table.expDate, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> inventoryAdjustmentsRefs<T extends Object>(
    Expression<T> Function($$InventoryAdjustmentsTableAnnotationComposer a) f,
  ) {
    final $$InventoryAdjustmentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryAdjustments,
          getReferencedColumn: (t) => t.batchId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryAdjustmentsTableAnnotationComposer(
                $db: $db,
                $table: $db.inventoryAdjustments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$BatchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BatchesTable,
          Batche,
          $$BatchesTableFilterComposer,
          $$BatchesTableOrderingComposer,
          $$BatchesTableAnnotationComposer,
          $$BatchesTableCreateCompanionBuilder,
          $$BatchesTableUpdateCompanionBuilder,
          (Batche, $$BatchesTableReferences),
          Batche,
          PrefetchHooks Function({
            bool productId,
            bool inventoryAdjustmentsRefs,
          })
        > {
  $$BatchesTableTableManager(_$AppDatabase db, $BatchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<String> batchNumber = const Value.absent(),
                Value<DateTime> expDate = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> purchasePrice = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BatchesCompanion(
                id: id,
                productId: productId,
                batchNumber: batchNumber,
                expDate: expDate,
                quantity: quantity,
                purchasePrice: purchasePrice,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required String batchNumber,
                required DateTime expDate,
                required double quantity,
                required double purchasePrice,
                Value<DateTime> createdAt = const Value.absent(),
              }) => BatchesCompanion.insert(
                id: id,
                productId: productId,
                batchNumber: batchNumber,
                expDate: expDate,
                quantity: quantity,
                purchasePrice: purchasePrice,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BatchesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({productId = false, inventoryAdjustmentsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (inventoryAdjustmentsRefs) db.inventoryAdjustments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (productId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.productId,
                                    referencedTable: $$BatchesTableReferences
                                        ._productIdTable(db),
                                    referencedColumn: $$BatchesTableReferences
                                        ._productIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (inventoryAdjustmentsRefs)
                        await $_getPrefetchedData<
                          Batche,
                          $BatchesTable,
                          InventoryAdjustment
                        >(
                          currentTable: table,
                          referencedTable: $$BatchesTableReferences
                              ._inventoryAdjustmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BatchesTableReferences(
                                db,
                                table,
                                p0,
                              ).inventoryAdjustmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.batchId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BatchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BatchesTable,
      Batche,
      $$BatchesTableFilterComposer,
      $$BatchesTableOrderingComposer,
      $$BatchesTableAnnotationComposer,
      $$BatchesTableCreateCompanionBuilder,
      $$BatchesTableUpdateCompanionBuilder,
      (Batche, $$BatchesTableReferences),
      Batche,
      PrefetchHooks Function({bool productId, bool inventoryAdjustmentsRefs})
    >;
typedef $$InventoryAdjustmentsTableCreateCompanionBuilder =
    InventoryAdjustmentsCompanion Function({
      Value<int> id,
      required int productId,
      required int batchId,
      required double deltaQty,
      required String reason,
      required String performedBy,
      Value<DateTime> createdAt,
    });
typedef $$InventoryAdjustmentsTableUpdateCompanionBuilder =
    InventoryAdjustmentsCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<int> batchId,
      Value<double> deltaQty,
      Value<String> reason,
      Value<String> performedBy,
      Value<DateTime> createdAt,
    });

final class $$InventoryAdjustmentsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $InventoryAdjustmentsTable,
          InventoryAdjustment
        > {
  $$InventoryAdjustmentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.inventoryAdjustments.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BatchesTable _batchIdTable(_$AppDatabase db) =>
      db.batches.createAlias(
        $_aliasNameGenerator(db.inventoryAdjustments.batchId, db.batches.id),
      );

  $$BatchesTableProcessedTableManager get batchId {
    final $_column = $_itemColumn<int>('batch_id')!;

    final manager = $$BatchesTableTableManager(
      $_db,
      $_db.batches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_batchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InventoryAdjustmentsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryAdjustmentsTable> {
  $$InventoryAdjustmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get deltaQty => $composableBuilder(
    column: $table.deltaQty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get performedBy => $composableBuilder(
    column: $table.performedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BatchesTableFilterComposer get batchId {
    final $$BatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableFilterComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryAdjustmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryAdjustmentsTable> {
  $$InventoryAdjustmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get deltaQty => $composableBuilder(
    column: $table.deltaQty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get performedBy => $composableBuilder(
    column: $table.performedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BatchesTableOrderingComposer get batchId {
    final $$BatchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableOrderingComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryAdjustmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryAdjustmentsTable> {
  $$InventoryAdjustmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get deltaQty =>
      $composableBuilder(column: $table.deltaQty, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get performedBy => $composableBuilder(
    column: $table.performedBy,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BatchesTableAnnotationComposer get batchId {
    final $$BatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryAdjustmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryAdjustmentsTable,
          InventoryAdjustment,
          $$InventoryAdjustmentsTableFilterComposer,
          $$InventoryAdjustmentsTableOrderingComposer,
          $$InventoryAdjustmentsTableAnnotationComposer,
          $$InventoryAdjustmentsTableCreateCompanionBuilder,
          $$InventoryAdjustmentsTableUpdateCompanionBuilder,
          (InventoryAdjustment, $$InventoryAdjustmentsTableReferences),
          InventoryAdjustment,
          PrefetchHooks Function({bool productId, bool batchId})
        > {
  $$InventoryAdjustmentsTableTableManager(
    _$AppDatabase db,
    $InventoryAdjustmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryAdjustmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryAdjustmentsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InventoryAdjustmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> batchId = const Value.absent(),
                Value<double> deltaQty = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> performedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InventoryAdjustmentsCompanion(
                id: id,
                productId: productId,
                batchId: batchId,
                deltaQty: deltaQty,
                reason: reason,
                performedBy: performedBy,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required int batchId,
                required double deltaQty,
                required String reason,
                required String performedBy,
                Value<DateTime> createdAt = const Value.absent(),
              }) => InventoryAdjustmentsCompanion.insert(
                id: id,
                productId: productId,
                batchId: batchId,
                deltaQty: deltaQty,
                reason: reason,
                performedBy: performedBy,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InventoryAdjustmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false, batchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable:
                                    $$InventoryAdjustmentsTableReferences
                                        ._productIdTable(db),
                                referencedColumn:
                                    $$InventoryAdjustmentsTableReferences
                                        ._productIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (batchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.batchId,
                                referencedTable:
                                    $$InventoryAdjustmentsTableReferences
                                        ._batchIdTable(db),
                                referencedColumn:
                                    $$InventoryAdjustmentsTableReferences
                                        ._batchIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InventoryAdjustmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryAdjustmentsTable,
      InventoryAdjustment,
      $$InventoryAdjustmentsTableFilterComposer,
      $$InventoryAdjustmentsTableOrderingComposer,
      $$InventoryAdjustmentsTableAnnotationComposer,
      $$InventoryAdjustmentsTableCreateCompanionBuilder,
      $$InventoryAdjustmentsTableUpdateCompanionBuilder,
      (InventoryAdjustment, $$InventoryAdjustmentsTableReferences),
      InventoryAdjustment,
      PrefetchHooks Function({bool productId, bool batchId})
    >;
typedef $$AuditLogsTableCreateCompanionBuilder =
    AuditLogsCompanion Function({
      Value<int> id,
      required String entity,
      required String action,
      required String actor,
      Value<String> payload,
      Value<DateTime> createdAt,
    });
typedef $$AuditLogsTableUpdateCompanionBuilder =
    AuditLogsCompanion Function({
      Value<int> id,
      Value<String> entity,
      Value<String> action,
      Value<String> actor,
      Value<String> payload,
      Value<DateTime> createdAt,
    });

class $$AuditLogsTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actor => $composableBuilder(
    column: $table.actor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actor => $composableBuilder(
    column: $table.actor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entity =>
      $composableBuilder(column: $table.entity, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get actor =>
      $composableBuilder(column: $table.actor, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AuditLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditLogsTable,
          AuditLog,
          $$AuditLogsTableFilterComposer,
          $$AuditLogsTableOrderingComposer,
          $$AuditLogsTableAnnotationComposer,
          $$AuditLogsTableCreateCompanionBuilder,
          $$AuditLogsTableUpdateCompanionBuilder,
          (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
          AuditLog,
          PrefetchHooks Function()
        > {
  $$AuditLogsTableTableManager(_$AppDatabase db, $AuditLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entity = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String> actor = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AuditLogsCompanion(
                id: id,
                entity: entity,
                action: action,
                actor: actor,
                payload: payload,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entity,
                required String action,
                required String actor,
                Value<String> payload = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AuditLogsCompanion.insert(
                id: id,
                entity: entity,
                action: action,
                actor: actor,
                payload: payload,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditLogsTable,
      AuditLog,
      $$AuditLogsTableFilterComposer,
      $$AuditLogsTableOrderingComposer,
      $$AuditLogsTableAnnotationComposer,
      $$AuditLogsTableCreateCompanionBuilder,
      $$AuditLogsTableUpdateCompanionBuilder,
      (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
      AuditLog,
      PrefetchHooks Function()
    >;
typedef $$InvoicesTableCreateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> id,
      required String invoiceNo,
      required double totalAmount,
      Value<DateTime> createdAt,
    });
typedef $$InvoicesTableUpdateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> id,
      Value<String> invoiceNo,
      Value<double> totalAmount,
      Value<DateTime> createdAt,
    });

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceNo => $composableBuilder(
    column: $table.invoiceNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceNo => $composableBuilder(
    column: $table.invoiceNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceNo =>
      $composableBuilder(column: $table.invoiceNo, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$InvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesTable,
          Invoice,
          $$InvoicesTableFilterComposer,
          $$InvoicesTableOrderingComposer,
          $$InvoicesTableAnnotationComposer,
          $$InvoicesTableCreateCompanionBuilder,
          $$InvoicesTableUpdateCompanionBuilder,
          (Invoice, BaseReferences<_$AppDatabase, $InvoicesTable, Invoice>),
          Invoice,
          PrefetchHooks Function()
        > {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> invoiceNo = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InvoicesCompanion(
                id: id,
                invoiceNo: invoiceNo,
                totalAmount: totalAmount,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String invoiceNo,
                required double totalAmount,
                Value<DateTime> createdAt = const Value.absent(),
              }) => InvoicesCompanion.insert(
                id: id,
                invoiceNo: invoiceNo,
                totalAmount: totalAmount,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesTable,
      Invoice,
      $$InvoicesTableFilterComposer,
      $$InvoicesTableOrderingComposer,
      $$InvoicesTableAnnotationComposer,
      $$InvoicesTableCreateCompanionBuilder,
      $$InvoicesTableUpdateCompanionBuilder,
      (Invoice, BaseReferences<_$AppDatabase, $InvoicesTable, Invoice>),
      Invoice,
      PrefetchHooks Function()
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      required String name,
      required String phone,
      Value<String?> email,
      Value<String?> address,
      Value<String> category,
      Value<double> totalPurchases,
      Value<DateTime?> lastPurchaseAt,
      Value<DateTime> createdAt,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> phone,
      Value<String?> email,
      Value<String?> address,
      Value<String> category,
      Value<double> totalPurchases,
      Value<DateTime?> lastPurchaseAt,
      Value<DateTime> createdAt,
    });

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPurchases => $composableBuilder(
    column: $table.totalPurchases,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastPurchaseAt => $composableBuilder(
    column: $table.lastPurchaseAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPurchases => $composableBuilder(
    column: $table.totalPurchases,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastPurchaseAt => $composableBuilder(
    column: $table.lastPurchaseAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get totalPurchases => $composableBuilder(
    column: $table.totalPurchases,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastPurchaseAt => $composableBuilder(
    column: $table.lastPurchaseAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, BaseReferences<_$AppDatabase, $CustomersTable, Customer>),
          Customer,
          PrefetchHooks Function()
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double> totalPurchases = const Value.absent(),
                Value<DateTime?> lastPurchaseAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                name: name,
                phone: phone,
                email: email,
                address: address,
                category: category,
                totalPurchases: totalPurchases,
                lastPurchaseAt: lastPurchaseAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String phone,
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double> totalPurchases = const Value.absent(),
                Value<DateTime?> lastPurchaseAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                email: email,
                address: address,
                category: category,
                totalPurchases: totalPurchases,
                lastPurchaseAt: lastPurchaseAt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, BaseReferences<_$AppDatabase, $CustomersTable, Customer>),
      Customer,
      PrefetchHooks Function()
    >;
typedef $$ContactsTableCreateCompanionBuilder =
    ContactsCompanion Function({
      Value<int> id,
      required String type,
      required String name,
      required String phone,
      Value<String?> email,
      Value<String?> gstin,
      Value<String?> bankDetails,
      Value<String?> doctorRegistrationNumber,
      Value<DateTime> createdAt,
    });
typedef $$ContactsTableUpdateCompanionBuilder =
    ContactsCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<String> name,
      Value<String> phone,
      Value<String?> email,
      Value<String?> gstin,
      Value<String?> bankDetails,
      Value<String?> doctorRegistrationNumber,
      Value<DateTime> createdAt,
    });

class $$ContactsTableFilterComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gstin => $composableBuilder(
    column: $table.gstin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankDetails => $composableBuilder(
    column: $table.bankDetails,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doctorRegistrationNumber => $composableBuilder(
    column: $table.doctorRegistrationNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gstin => $composableBuilder(
    column: $table.gstin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankDetails => $composableBuilder(
    column: $table.bankDetails,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doctorRegistrationNumber => $composableBuilder(
    column: $table.doctorRegistrationNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get gstin =>
      $composableBuilder(column: $table.gstin, builder: (column) => column);

  GeneratedColumn<String> get bankDetails => $composableBuilder(
    column: $table.bankDetails,
    builder: (column) => column,
  );

  GeneratedColumn<String> get doctorRegistrationNumber => $composableBuilder(
    column: $table.doctorRegistrationNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ContactsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContactsTable,
          Contact,
          $$ContactsTableFilterComposer,
          $$ContactsTableOrderingComposer,
          $$ContactsTableAnnotationComposer,
          $$ContactsTableCreateCompanionBuilder,
          $$ContactsTableUpdateCompanionBuilder,
          (Contact, BaseReferences<_$AppDatabase, $ContactsTable, Contact>),
          Contact,
          PrefetchHooks Function()
        > {
  $$ContactsTableTableManager(_$AppDatabase db, $ContactsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> gstin = const Value.absent(),
                Value<String?> bankDetails = const Value.absent(),
                Value<String?> doctorRegistrationNumber = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ContactsCompanion(
                id: id,
                type: type,
                name: name,
                phone: phone,
                email: email,
                gstin: gstin,
                bankDetails: bankDetails,
                doctorRegistrationNumber: doctorRegistrationNumber,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                required String name,
                required String phone,
                Value<String?> email = const Value.absent(),
                Value<String?> gstin = const Value.absent(),
                Value<String?> bankDetails = const Value.absent(),
                Value<String?> doctorRegistrationNumber = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ContactsCompanion.insert(
                id: id,
                type: type,
                name: name,
                phone: phone,
                email: email,
                gstin: gstin,
                bankDetails: bankDetails,
                doctorRegistrationNumber: doctorRegistrationNumber,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ContactsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContactsTable,
      Contact,
      $$ContactsTableFilterComposer,
      $$ContactsTableOrderingComposer,
      $$ContactsTableAnnotationComposer,
      $$ContactsTableCreateCompanionBuilder,
      $$ContactsTableUpdateCompanionBuilder,
      (Contact, BaseReferences<_$AppDatabase, $ContactsTable, Contact>),
      Contact,
      PrefetchHooks Function()
    >;
typedef $$PurchaseInvoicesTableCreateCompanionBuilder =
    PurchaseInvoicesCompanion Function({
      Value<int> id,
      required String supplierName,
      Value<String?> supplierGstin,
      required double taxableAmount,
      required double gstAmount,
      required double totalAmount,
      Value<DateTime> createdAt,
    });
typedef $$PurchaseInvoicesTableUpdateCompanionBuilder =
    PurchaseInvoicesCompanion Function({
      Value<int> id,
      Value<String> supplierName,
      Value<String?> supplierGstin,
      Value<double> taxableAmount,
      Value<double> gstAmount,
      Value<double> totalAmount,
      Value<DateTime> createdAt,
    });

final class $$PurchaseInvoicesTableReferences
    extends
        BaseReferences<_$AppDatabase, $PurchaseInvoicesTable, PurchaseInvoice> {
  $$PurchaseInvoicesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $PurchaseInvoiceItemsTable,
    List<PurchaseInvoiceItem>
  >
  _purchaseInvoiceItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.purchaseInvoiceItems,
        aliasName: $_aliasNameGenerator(
          db.purchaseInvoices.id,
          db.purchaseInvoiceItems.purchaseInvoiceId,
        ),
      );

  $$PurchaseInvoiceItemsTableProcessedTableManager
  get purchaseInvoiceItemsRefs {
    final manager = $$PurchaseInvoiceItemsTableTableManager(
      $_db,
      $_db.purchaseInvoiceItems,
    ).filter((f) => f.purchaseInvoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _purchaseInvoiceItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PurchaseInvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseInvoicesTable> {
  $$PurchaseInvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierGstin => $composableBuilder(
    column: $table.supplierGstin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxableAmount => $composableBuilder(
    column: $table.taxableAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gstAmount => $composableBuilder(
    column: $table.gstAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> purchaseInvoiceItemsRefs(
    Expression<bool> Function($$PurchaseInvoiceItemsTableFilterComposer f) f,
  ) {
    final $$PurchaseInvoiceItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseInvoiceItems,
      getReferencedColumn: (t) => t.purchaseInvoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseInvoiceItemsTableFilterComposer(
            $db: $db,
            $table: $db.purchaseInvoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchaseInvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseInvoicesTable> {
  $$PurchaseInvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierGstin => $composableBuilder(
    column: $table.supplierGstin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxableAmount => $composableBuilder(
    column: $table.taxableAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gstAmount => $composableBuilder(
    column: $table.gstAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchaseInvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseInvoicesTable> {
  $$PurchaseInvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get supplierGstin => $composableBuilder(
    column: $table.supplierGstin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get taxableAmount => $composableBuilder(
    column: $table.taxableAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get gstAmount =>
      $composableBuilder(column: $table.gstAmount, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> purchaseInvoiceItemsRefs<T extends Object>(
    Expression<T> Function($$PurchaseInvoiceItemsTableAnnotationComposer a) f,
  ) {
    final $$PurchaseInvoiceItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.purchaseInvoiceItems,
          getReferencedColumn: (t) => t.purchaseInvoiceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PurchaseInvoiceItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.purchaseInvoiceItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PurchaseInvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseInvoicesTable,
          PurchaseInvoice,
          $$PurchaseInvoicesTableFilterComposer,
          $$PurchaseInvoicesTableOrderingComposer,
          $$PurchaseInvoicesTableAnnotationComposer,
          $$PurchaseInvoicesTableCreateCompanionBuilder,
          $$PurchaseInvoicesTableUpdateCompanionBuilder,
          (PurchaseInvoice, $$PurchaseInvoicesTableReferences),
          PurchaseInvoice,
          PrefetchHooks Function({bool purchaseInvoiceItemsRefs})
        > {
  $$PurchaseInvoicesTableTableManager(
    _$AppDatabase db,
    $PurchaseInvoicesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseInvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseInvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseInvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> supplierName = const Value.absent(),
                Value<String?> supplierGstin = const Value.absent(),
                Value<double> taxableAmount = const Value.absent(),
                Value<double> gstAmount = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PurchaseInvoicesCompanion(
                id: id,
                supplierName: supplierName,
                supplierGstin: supplierGstin,
                taxableAmount: taxableAmount,
                gstAmount: gstAmount,
                totalAmount: totalAmount,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String supplierName,
                Value<String?> supplierGstin = const Value.absent(),
                required double taxableAmount,
                required double gstAmount,
                required double totalAmount,
                Value<DateTime> createdAt = const Value.absent(),
              }) => PurchaseInvoicesCompanion.insert(
                id: id,
                supplierName: supplierName,
                supplierGstin: supplierGstin,
                taxableAmount: taxableAmount,
                gstAmount: gstAmount,
                totalAmount: totalAmount,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchaseInvoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({purchaseInvoiceItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (purchaseInvoiceItemsRefs) db.purchaseInvoiceItems,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (purchaseInvoiceItemsRefs)
                    await $_getPrefetchedData<
                      PurchaseInvoice,
                      $PurchaseInvoicesTable,
                      PurchaseInvoiceItem
                    >(
                      currentTable: table,
                      referencedTable: $$PurchaseInvoicesTableReferences
                          ._purchaseInvoiceItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PurchaseInvoicesTableReferences(
                            db,
                            table,
                            p0,
                          ).purchaseInvoiceItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.purchaseInvoiceId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PurchaseInvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseInvoicesTable,
      PurchaseInvoice,
      $$PurchaseInvoicesTableFilterComposer,
      $$PurchaseInvoicesTableOrderingComposer,
      $$PurchaseInvoicesTableAnnotationComposer,
      $$PurchaseInvoicesTableCreateCompanionBuilder,
      $$PurchaseInvoicesTableUpdateCompanionBuilder,
      (PurchaseInvoice, $$PurchaseInvoicesTableReferences),
      PurchaseInvoice,
      PrefetchHooks Function({bool purchaseInvoiceItemsRefs})
    >;
typedef $$PurchaseInvoiceItemsTableCreateCompanionBuilder =
    PurchaseInvoiceItemsCompanion Function({
      Value<int> id,
      required int purchaseInvoiceId,
      Value<int?> productId,
      required String productName,
      required String batchNumber,
      required double quantity,
      required double purchasePrice,
      required double gstRate,
      required DateTime expDate,
    });
typedef $$PurchaseInvoiceItemsTableUpdateCompanionBuilder =
    PurchaseInvoiceItemsCompanion Function({
      Value<int> id,
      Value<int> purchaseInvoiceId,
      Value<int?> productId,
      Value<String> productName,
      Value<String> batchNumber,
      Value<double> quantity,
      Value<double> purchasePrice,
      Value<double> gstRate,
      Value<DateTime> expDate,
    });

final class $$PurchaseInvoiceItemsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PurchaseInvoiceItemsTable,
          PurchaseInvoiceItem
        > {
  $$PurchaseInvoiceItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PurchaseInvoicesTable _purchaseInvoiceIdTable(_$AppDatabase db) =>
      db.purchaseInvoices.createAlias(
        $_aliasNameGenerator(
          db.purchaseInvoiceItems.purchaseInvoiceId,
          db.purchaseInvoices.id,
        ),
      );

  $$PurchaseInvoicesTableProcessedTableManager get purchaseInvoiceId {
    final $_column = $_itemColumn<int>('purchase_invoice_id')!;

    final manager = $$PurchaseInvoicesTableTableManager(
      $_db,
      $_db.purchaseInvoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_purchaseInvoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.purchaseInvoiceItems.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager? get productId {
    final $_column = $_itemColumn<int>('product_id');
    if ($_column == null) return null;
    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PurchaseInvoiceItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseInvoiceItemsTable> {
  $$PurchaseInvoiceItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gstRate => $composableBuilder(
    column: $table.gstRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expDate => $composableBuilder(
    column: $table.expDate,
    builder: (column) => ColumnFilters(column),
  );

  $$PurchaseInvoicesTableFilterComposer get purchaseInvoiceId {
    final $$PurchaseInvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseInvoiceId,
      referencedTable: $db.purchaseInvoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseInvoicesTableFilterComposer(
            $db: $db,
            $table: $db.purchaseInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseInvoiceItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseInvoiceItemsTable> {
  $$PurchaseInvoiceItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gstRate => $composableBuilder(
    column: $table.gstRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expDate => $composableBuilder(
    column: $table.expDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$PurchaseInvoicesTableOrderingComposer get purchaseInvoiceId {
    final $$PurchaseInvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseInvoiceId,
      referencedTable: $db.purchaseInvoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseInvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.purchaseInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseInvoiceItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseInvoiceItemsTable> {
  $$PurchaseInvoiceItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get gstRate =>
      $composableBuilder(column: $table.gstRate, builder: (column) => column);

  GeneratedColumn<DateTime> get expDate =>
      $composableBuilder(column: $table.expDate, builder: (column) => column);

  $$PurchaseInvoicesTableAnnotationComposer get purchaseInvoiceId {
    final $$PurchaseInvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseInvoiceId,
      referencedTable: $db.purchaseInvoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseInvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseInvoiceItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseInvoiceItemsTable,
          PurchaseInvoiceItem,
          $$PurchaseInvoiceItemsTableFilterComposer,
          $$PurchaseInvoiceItemsTableOrderingComposer,
          $$PurchaseInvoiceItemsTableAnnotationComposer,
          $$PurchaseInvoiceItemsTableCreateCompanionBuilder,
          $$PurchaseInvoiceItemsTableUpdateCompanionBuilder,
          (PurchaseInvoiceItem, $$PurchaseInvoiceItemsTableReferences),
          PurchaseInvoiceItem,
          PrefetchHooks Function({bool purchaseInvoiceId, bool productId})
        > {
  $$PurchaseInvoiceItemsTableTableManager(
    _$AppDatabase db,
    $PurchaseInvoiceItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseInvoiceItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseInvoiceItemsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PurchaseInvoiceItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> purchaseInvoiceId = const Value.absent(),
                Value<int?> productId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<String> batchNumber = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> purchasePrice = const Value.absent(),
                Value<double> gstRate = const Value.absent(),
                Value<DateTime> expDate = const Value.absent(),
              }) => PurchaseInvoiceItemsCompanion(
                id: id,
                purchaseInvoiceId: purchaseInvoiceId,
                productId: productId,
                productName: productName,
                batchNumber: batchNumber,
                quantity: quantity,
                purchasePrice: purchasePrice,
                gstRate: gstRate,
                expDate: expDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int purchaseInvoiceId,
                Value<int?> productId = const Value.absent(),
                required String productName,
                required String batchNumber,
                required double quantity,
                required double purchasePrice,
                required double gstRate,
                required DateTime expDate,
              }) => PurchaseInvoiceItemsCompanion.insert(
                id: id,
                purchaseInvoiceId: purchaseInvoiceId,
                productId: productId,
                productName: productName,
                batchNumber: batchNumber,
                quantity: quantity,
                purchasePrice: purchasePrice,
                gstRate: gstRate,
                expDate: expDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchaseInvoiceItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({purchaseInvoiceId = false, productId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (purchaseInvoiceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.purchaseInvoiceId,
                                    referencedTable:
                                        $$PurchaseInvoiceItemsTableReferences
                                            ._purchaseInvoiceIdTable(db),
                                    referencedColumn:
                                        $$PurchaseInvoiceItemsTableReferences
                                            ._purchaseInvoiceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (productId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.productId,
                                    referencedTable:
                                        $$PurchaseInvoiceItemsTableReferences
                                            ._productIdTable(db),
                                    referencedColumn:
                                        $$PurchaseInvoiceItemsTableReferences
                                            ._productIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$PurchaseInvoiceItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseInvoiceItemsTable,
      PurchaseInvoiceItem,
      $$PurchaseInvoiceItemsTableFilterComposer,
      $$PurchaseInvoiceItemsTableOrderingComposer,
      $$PurchaseInvoiceItemsTableAnnotationComposer,
      $$PurchaseInvoiceItemsTableCreateCompanionBuilder,
      $$PurchaseInvoiceItemsTableUpdateCompanionBuilder,
      (PurchaseInvoiceItem, $$PurchaseInvoiceItemsTableReferences),
      PurchaseInvoiceItem,
      PrefetchHooks Function({bool purchaseInvoiceId, bool productId})
    >;
typedef $$CreditNotesTableCreateCompanionBuilder =
    CreditNotesCompanion Function({
      Value<int> id,
      required String originalInvoiceNo,
      required DateTime originalInvoiceDate,
      required DateTime returnDate,
      Value<double> taxableAmount,
      Value<double> gstAmount,
      required double totalAmount,
      Value<DateTime> createdAt,
    });
typedef $$CreditNotesTableUpdateCompanionBuilder =
    CreditNotesCompanion Function({
      Value<int> id,
      Value<String> originalInvoiceNo,
      Value<DateTime> originalInvoiceDate,
      Value<DateTime> returnDate,
      Value<double> taxableAmount,
      Value<double> gstAmount,
      Value<double> totalAmount,
      Value<DateTime> createdAt,
    });

final class $$CreditNotesTableReferences
    extends BaseReferences<_$AppDatabase, $CreditNotesTable, CreditNote> {
  $$CreditNotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CreditNoteItemsTable, List<CreditNoteItem>>
  _creditNoteItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.creditNoteItems,
    aliasName: $_aliasNameGenerator(
      db.creditNotes.id,
      db.creditNoteItems.creditNoteId,
    ),
  );

  $$CreditNoteItemsTableProcessedTableManager get creditNoteItemsRefs {
    final manager = $$CreditNoteItemsTableTableManager(
      $_db,
      $_db.creditNoteItems,
    ).filter((f) => f.creditNoteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _creditNoteItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CreditNotesTableFilterComposer
    extends Composer<_$AppDatabase, $CreditNotesTable> {
  $$CreditNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalInvoiceNo => $composableBuilder(
    column: $table.originalInvoiceNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get originalInvoiceDate => $composableBuilder(
    column: $table.originalInvoiceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get returnDate => $composableBuilder(
    column: $table.returnDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxableAmount => $composableBuilder(
    column: $table.taxableAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gstAmount => $composableBuilder(
    column: $table.gstAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> creditNoteItemsRefs(
    Expression<bool> Function($$CreditNoteItemsTableFilterComposer f) f,
  ) {
    final $$CreditNoteItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.creditNoteItems,
      getReferencedColumn: (t) => t.creditNoteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditNoteItemsTableFilterComposer(
            $db: $db,
            $table: $db.creditNoteItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CreditNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditNotesTable> {
  $$CreditNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalInvoiceNo => $composableBuilder(
    column: $table.originalInvoiceNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get originalInvoiceDate => $composableBuilder(
    column: $table.originalInvoiceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get returnDate => $composableBuilder(
    column: $table.returnDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxableAmount => $composableBuilder(
    column: $table.taxableAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gstAmount => $composableBuilder(
    column: $table.gstAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CreditNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditNotesTable> {
  $$CreditNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get originalInvoiceNo => $composableBuilder(
    column: $table.originalInvoiceNo,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get originalInvoiceDate => $composableBuilder(
    column: $table.originalInvoiceDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get returnDate => $composableBuilder(
    column: $table.returnDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get taxableAmount => $composableBuilder(
    column: $table.taxableAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get gstAmount =>
      $composableBuilder(column: $table.gstAmount, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> creditNoteItemsRefs<T extends Object>(
    Expression<T> Function($$CreditNoteItemsTableAnnotationComposer a) f,
  ) {
    final $$CreditNoteItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.creditNoteItems,
      getReferencedColumn: (t) => t.creditNoteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditNoteItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.creditNoteItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CreditNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CreditNotesTable,
          CreditNote,
          $$CreditNotesTableFilterComposer,
          $$CreditNotesTableOrderingComposer,
          $$CreditNotesTableAnnotationComposer,
          $$CreditNotesTableCreateCompanionBuilder,
          $$CreditNotesTableUpdateCompanionBuilder,
          (CreditNote, $$CreditNotesTableReferences),
          CreditNote,
          PrefetchHooks Function({bool creditNoteItemsRefs})
        > {
  $$CreditNotesTableTableManager(_$AppDatabase db, $CreditNotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CreditNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CreditNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> originalInvoiceNo = const Value.absent(),
                Value<DateTime> originalInvoiceDate = const Value.absent(),
                Value<DateTime> returnDate = const Value.absent(),
                Value<double> taxableAmount = const Value.absent(),
                Value<double> gstAmount = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CreditNotesCompanion(
                id: id,
                originalInvoiceNo: originalInvoiceNo,
                originalInvoiceDate: originalInvoiceDate,
                returnDate: returnDate,
                taxableAmount: taxableAmount,
                gstAmount: gstAmount,
                totalAmount: totalAmount,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String originalInvoiceNo,
                required DateTime originalInvoiceDate,
                required DateTime returnDate,
                Value<double> taxableAmount = const Value.absent(),
                Value<double> gstAmount = const Value.absent(),
                required double totalAmount,
                Value<DateTime> createdAt = const Value.absent(),
              }) => CreditNotesCompanion.insert(
                id: id,
                originalInvoiceNo: originalInvoiceNo,
                originalInvoiceDate: originalInvoiceDate,
                returnDate: returnDate,
                taxableAmount: taxableAmount,
                gstAmount: gstAmount,
                totalAmount: totalAmount,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CreditNotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({creditNoteItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (creditNoteItemsRefs) db.creditNoteItems,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (creditNoteItemsRefs)
                    await $_getPrefetchedData<
                      CreditNote,
                      $CreditNotesTable,
                      CreditNoteItem
                    >(
                      currentTable: table,
                      referencedTable: $$CreditNotesTableReferences
                          ._creditNoteItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CreditNotesTableReferences(
                            db,
                            table,
                            p0,
                          ).creditNoteItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.creditNoteId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CreditNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CreditNotesTable,
      CreditNote,
      $$CreditNotesTableFilterComposer,
      $$CreditNotesTableOrderingComposer,
      $$CreditNotesTableAnnotationComposer,
      $$CreditNotesTableCreateCompanionBuilder,
      $$CreditNotesTableUpdateCompanionBuilder,
      (CreditNote, $$CreditNotesTableReferences),
      CreditNote,
      PrefetchHooks Function({bool creditNoteItemsRefs})
    >;
typedef $$CreditNoteItemsTableCreateCompanionBuilder =
    CreditNoteItemsCompanion Function({
      Value<int> id,
      required int creditNoteId,
      required String productName,
      required String batchNumber,
      required double quantity,
      required double unitPrice,
      required double taxRate,
    });
typedef $$CreditNoteItemsTableUpdateCompanionBuilder =
    CreditNoteItemsCompanion Function({
      Value<int> id,
      Value<int> creditNoteId,
      Value<String> productName,
      Value<String> batchNumber,
      Value<double> quantity,
      Value<double> unitPrice,
      Value<double> taxRate,
    });

final class $$CreditNoteItemsTableReferences
    extends
        BaseReferences<_$AppDatabase, $CreditNoteItemsTable, CreditNoteItem> {
  $$CreditNoteItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CreditNotesTable _creditNoteIdTable(_$AppDatabase db) =>
      db.creditNotes.createAlias(
        $_aliasNameGenerator(
          db.creditNoteItems.creditNoteId,
          db.creditNotes.id,
        ),
      );

  $$CreditNotesTableProcessedTableManager get creditNoteId {
    final $_column = $_itemColumn<int>('credit_note_id')!;

    final manager = $$CreditNotesTableTableManager(
      $_db,
      $_db.creditNotes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_creditNoteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CreditNoteItemsTableFilterComposer
    extends Composer<_$AppDatabase, $CreditNoteItemsTable> {
  $$CreditNoteItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxRate => $composableBuilder(
    column: $table.taxRate,
    builder: (column) => ColumnFilters(column),
  );

  $$CreditNotesTableFilterComposer get creditNoteId {
    final $$CreditNotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.creditNoteId,
      referencedTable: $db.creditNotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditNotesTableFilterComposer(
            $db: $db,
            $table: $db.creditNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CreditNoteItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditNoteItemsTable> {
  $$CreditNoteItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxRate => $composableBuilder(
    column: $table.taxRate,
    builder: (column) => ColumnOrderings(column),
  );

  $$CreditNotesTableOrderingComposer get creditNoteId {
    final $$CreditNotesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.creditNoteId,
      referencedTable: $db.creditNotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditNotesTableOrderingComposer(
            $db: $db,
            $table: $db.creditNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CreditNoteItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditNoteItemsTable> {
  $$CreditNoteItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get taxRate =>
      $composableBuilder(column: $table.taxRate, builder: (column) => column);

  $$CreditNotesTableAnnotationComposer get creditNoteId {
    final $$CreditNotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.creditNoteId,
      referencedTable: $db.creditNotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditNotesTableAnnotationComposer(
            $db: $db,
            $table: $db.creditNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CreditNoteItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CreditNoteItemsTable,
          CreditNoteItem,
          $$CreditNoteItemsTableFilterComposer,
          $$CreditNoteItemsTableOrderingComposer,
          $$CreditNoteItemsTableAnnotationComposer,
          $$CreditNoteItemsTableCreateCompanionBuilder,
          $$CreditNoteItemsTableUpdateCompanionBuilder,
          (CreditNoteItem, $$CreditNoteItemsTableReferences),
          CreditNoteItem,
          PrefetchHooks Function({bool creditNoteId})
        > {
  $$CreditNoteItemsTableTableManager(
    _$AppDatabase db,
    $CreditNoteItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditNoteItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CreditNoteItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CreditNoteItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> creditNoteId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<String> batchNumber = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> taxRate = const Value.absent(),
              }) => CreditNoteItemsCompanion(
                id: id,
                creditNoteId: creditNoteId,
                productName: productName,
                batchNumber: batchNumber,
                quantity: quantity,
                unitPrice: unitPrice,
                taxRate: taxRate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int creditNoteId,
                required String productName,
                required String batchNumber,
                required double quantity,
                required double unitPrice,
                required double taxRate,
              }) => CreditNoteItemsCompanion.insert(
                id: id,
                creditNoteId: creditNoteId,
                productName: productName,
                batchNumber: batchNumber,
                quantity: quantity,
                unitPrice: unitPrice,
                taxRate: taxRate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CreditNoteItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({creditNoteId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (creditNoteId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.creditNoteId,
                                referencedTable:
                                    $$CreditNoteItemsTableReferences
                                        ._creditNoteIdTable(db),
                                referencedColumn:
                                    $$CreditNoteItemsTableReferences
                                        ._creditNoteIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CreditNoteItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CreditNoteItemsTable,
      CreditNoteItem,
      $$CreditNoteItemsTableFilterComposer,
      $$CreditNoteItemsTableOrderingComposer,
      $$CreditNoteItemsTableAnnotationComposer,
      $$CreditNoteItemsTableCreateCompanionBuilder,
      $$CreditNoteItemsTableUpdateCompanionBuilder,
      (CreditNoteItem, $$CreditNoteItemsTableReferences),
      CreditNoteItem,
      PrefetchHooks Function({bool creditNoteId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$BatchesTableTableManager get batches =>
      $$BatchesTableTableManager(_db, _db.batches);
  $$InventoryAdjustmentsTableTableManager get inventoryAdjustments =>
      $$InventoryAdjustmentsTableTableManager(_db, _db.inventoryAdjustments);
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db, _db.auditLogs);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$ContactsTableTableManager get contacts =>
      $$ContactsTableTableManager(_db, _db.contacts);
  $$PurchaseInvoicesTableTableManager get purchaseInvoices =>
      $$PurchaseInvoicesTableTableManager(_db, _db.purchaseInvoices);
  $$PurchaseInvoiceItemsTableTableManager get purchaseInvoiceItems =>
      $$PurchaseInvoiceItemsTableTableManager(_db, _db.purchaseInvoiceItems);
  $$CreditNotesTableTableManager get creditNotes =>
      $$CreditNotesTableTableManager(_db, _db.creditNotes);
  $$CreditNoteItemsTableTableManager get creditNoteItems =>
      $$CreditNoteItemsTableTableManager(_db, _db.creditNoteItems);
}

mixin _$UserDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  UserDaoManager get managers => UserDaoManager(this);
}

class UserDaoManager {
  final _$UserDaoMixin _db;
  UserDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
}

mixin _$ProductDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProductsTable get products => attachedDatabase.products;
  $BatchesTable get batches => attachedDatabase.batches;
  $InventoryAdjustmentsTable get inventoryAdjustments =>
      attachedDatabase.inventoryAdjustments;
  ProductDaoManager get managers => ProductDaoManager(this);
}

class ProductDaoManager {
  final _$ProductDaoMixin _db;
  ProductDaoManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db.attachedDatabase, _db.products);
  $$BatchesTableTableManager get batches =>
      $$BatchesTableTableManager(_db.attachedDatabase, _db.batches);
  $$InventoryAdjustmentsTableTableManager get inventoryAdjustments =>
      $$InventoryAdjustmentsTableTableManager(
        _db.attachedDatabase,
        _db.inventoryAdjustments,
      );
}

mixin _$BatchDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProductsTable get products => attachedDatabase.products;
  $BatchesTable get batches => attachedDatabase.batches;
  BatchDaoManager get managers => BatchDaoManager(this);
}

class BatchDaoManager {
  final _$BatchDaoMixin _db;
  BatchDaoManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db.attachedDatabase, _db.products);
  $$BatchesTableTableManager get batches =>
      $$BatchesTableTableManager(_db.attachedDatabase, _db.batches);
}

mixin _$AuditLogDaoMixin on DatabaseAccessor<AppDatabase> {
  $AuditLogsTable get auditLogs => attachedDatabase.auditLogs;
  AuditLogDaoManager get managers => AuditLogDaoManager(this);
}

class AuditLogDaoManager {
  final _$AuditLogDaoMixin _db;
  AuditLogDaoManager(this._db);
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db.attachedDatabase, _db.auditLogs);
}

mixin _$DashboardDaoMixin on DatabaseAccessor<AppDatabase> {
  $InvoicesTable get invoices => attachedDatabase.invoices;
  $ProductsTable get products => attachedDatabase.products;
  $BatchesTable get batches => attachedDatabase.batches;
  DashboardDaoManager get managers => DashboardDaoManager(this);
}

class DashboardDaoManager {
  final _$DashboardDaoMixin _db;
  DashboardDaoManager(this._db);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db.attachedDatabase, _db.invoices);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db.attachedDatabase, _db.products);
  $$BatchesTableTableManager get batches =>
      $$BatchesTableTableManager(_db.attachedDatabase, _db.batches);
}

mixin _$CustomerDaoMixin on DatabaseAccessor<AppDatabase> {
  $CustomersTable get customers => attachedDatabase.customers;
  CustomerDaoManager get managers => CustomerDaoManager(this);
}

class CustomerDaoManager {
  final _$CustomerDaoMixin _db;
  CustomerDaoManager(this._db);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db.attachedDatabase, _db.customers);
}

mixin _$ContactDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContactsTable get contacts => attachedDatabase.contacts;
  ContactDaoManager get managers => ContactDaoManager(this);
}

class ContactDaoManager {
  final _$ContactDaoMixin _db;
  ContactDaoManager(this._db);
  $$ContactsTableTableManager get contacts =>
      $$ContactsTableTableManager(_db.attachedDatabase, _db.contacts);
}

mixin _$PurchaseDaoMixin on DatabaseAccessor<AppDatabase> {
  $PurchaseInvoicesTable get purchaseInvoices =>
      attachedDatabase.purchaseInvoices;
  $ProductsTable get products => attachedDatabase.products;
  $PurchaseInvoiceItemsTable get purchaseInvoiceItems =>
      attachedDatabase.purchaseInvoiceItems;
  $BatchesTable get batches => attachedDatabase.batches;
  PurchaseDaoManager get managers => PurchaseDaoManager(this);
}

class PurchaseDaoManager {
  final _$PurchaseDaoMixin _db;
  PurchaseDaoManager(this._db);
  $$PurchaseInvoicesTableTableManager get purchaseInvoices =>
      $$PurchaseInvoicesTableTableManager(
        _db.attachedDatabase,
        _db.purchaseInvoices,
      );
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db.attachedDatabase, _db.products);
  $$PurchaseInvoiceItemsTableTableManager get purchaseInvoiceItems =>
      $$PurchaseInvoiceItemsTableTableManager(
        _db.attachedDatabase,
        _db.purchaseInvoiceItems,
      );
  $$BatchesTableTableManager get batches =>
      $$BatchesTableTableManager(_db.attachedDatabase, _db.batches);
}

mixin _$ReturnDaoMixin on DatabaseAccessor<AppDatabase> {
  $CreditNotesTable get creditNotes => attachedDatabase.creditNotes;
  $CreditNoteItemsTable get creditNoteItems => attachedDatabase.creditNoteItems;
  $ProductsTable get products => attachedDatabase.products;
  $BatchesTable get batches => attachedDatabase.batches;
  ReturnDaoManager get managers => ReturnDaoManager(this);
}

class ReturnDaoManager {
  final _$ReturnDaoMixin _db;
  ReturnDaoManager(this._db);
  $$CreditNotesTableTableManager get creditNotes =>
      $$CreditNotesTableTableManager(_db.attachedDatabase, _db.creditNotes);
  $$CreditNoteItemsTableTableManager get creditNoteItems =>
      $$CreditNoteItemsTableTableManager(
        _db.attachedDatabase,
        _db.creditNoteItems,
      );
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db.attachedDatabase, _db.products);
  $$BatchesTableTableManager get batches =>
      $$BatchesTableTableManager(_db.attachedDatabase, _db.batches);
}
