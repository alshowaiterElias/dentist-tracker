// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $ProfilesTableTable extends ProfilesTable
    with TableInfo<$ProfilesTableTable, ProfilesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dentistIdMeta = const VerificationMeta(
    'dentistId',
  );
  @override
  late final GeneratedColumn<String> dentistId = GeneratedColumn<String>(
    'dentist_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
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
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revenuePercentageMeta = const VerificationMeta(
    'revenuePercentage',
  );
  @override
  late final GeneratedColumn<double> revenuePercentage =
      GeneratedColumn<double>(
        'revenue_percentage',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(100.0),
      );
  static const VerificationMeta _preferredLanguageMeta = const VerificationMeta(
    'preferredLanguage',
  );
  @override
  late final GeneratedColumn<String> preferredLanguage =
      GeneratedColumn<String>(
        'preferred_language',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('en'),
      );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<String> cachedAt = GeneratedColumn<String>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dentistId,
    fullName,
    email,
    phone,
    revenuePercentage,
    preferredLanguage,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfilesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('dentist_id')) {
      context.handle(
        _dentistIdMeta,
        dentistId.isAcceptableOrUnknown(data['dentist_id']!, _dentistIdMeta),
      );
    } else if (isInserting) {
      context.missing(_dentistIdMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('revenue_percentage')) {
      context.handle(
        _revenuePercentageMeta,
        revenuePercentage.isAcceptableOrUnknown(
          data['revenue_percentage']!,
          _revenuePercentageMeta,
        ),
      );
    }
    if (data.containsKey('preferred_language')) {
      context.handle(
        _preferredLanguageMeta,
        preferredLanguage.isAcceptableOrUnknown(
          data['preferred_language']!,
          _preferredLanguageMeta,
        ),
      );
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfilesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfilesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      dentistId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dentist_id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      revenuePercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}revenue_percentage'],
      )!,
      preferredLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_language'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $ProfilesTableTable createAlias(String alias) {
    return $ProfilesTableTable(attachedDatabase, alias);
  }
}

class ProfilesTableData extends DataClass
    implements Insertable<ProfilesTableData> {
  final String id;
  final String dentistId;
  final String fullName;
  final String? email;
  final String? phone;
  final double revenuePercentage;
  final String preferredLanguage;
  final String cachedAt;
  const ProfilesTableData({
    required this.id,
    required this.dentistId,
    required this.fullName,
    this.email,
    this.phone,
    required this.revenuePercentage,
    required this.preferredLanguage,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['dentist_id'] = Variable<String>(dentistId);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['revenue_percentage'] = Variable<double>(revenuePercentage);
    map['preferred_language'] = Variable<String>(preferredLanguage);
    map['cached_at'] = Variable<String>(cachedAt);
    return map;
  }

  ProfilesTableCompanion toCompanion(bool nullToAbsent) {
    return ProfilesTableCompanion(
      id: Value(id),
      dentistId: Value(dentistId),
      fullName: Value(fullName),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      revenuePercentage: Value(revenuePercentage),
      preferredLanguage: Value(preferredLanguage),
      cachedAt: Value(cachedAt),
    );
  }

  factory ProfilesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfilesTableData(
      id: serializer.fromJson<String>(json['id']),
      dentistId: serializer.fromJson<String>(json['dentistId']),
      fullName: serializer.fromJson<String>(json['fullName']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      revenuePercentage: serializer.fromJson<double>(json['revenuePercentage']),
      preferredLanguage: serializer.fromJson<String>(json['preferredLanguage']),
      cachedAt: serializer.fromJson<String>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'dentistId': serializer.toJson<String>(dentistId),
      'fullName': serializer.toJson<String>(fullName),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'revenuePercentage': serializer.toJson<double>(revenuePercentage),
      'preferredLanguage': serializer.toJson<String>(preferredLanguage),
      'cachedAt': serializer.toJson<String>(cachedAt),
    };
  }

  ProfilesTableData copyWith({
    String? id,
    String? dentistId,
    String? fullName,
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    double? revenuePercentage,
    String? preferredLanguage,
    String? cachedAt,
  }) => ProfilesTableData(
    id: id ?? this.id,
    dentistId: dentistId ?? this.dentistId,
    fullName: fullName ?? this.fullName,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    revenuePercentage: revenuePercentage ?? this.revenuePercentage,
    preferredLanguage: preferredLanguage ?? this.preferredLanguage,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  ProfilesTableData copyWithCompanion(ProfilesTableCompanion data) {
    return ProfilesTableData(
      id: data.id.present ? data.id.value : this.id,
      dentistId: data.dentistId.present ? data.dentistId.value : this.dentistId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      revenuePercentage: data.revenuePercentage.present
          ? data.revenuePercentage.value
          : this.revenuePercentage,
      preferredLanguage: data.preferredLanguage.present
          ? data.preferredLanguage.value
          : this.preferredLanguage,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesTableData(')
          ..write('id: $id, ')
          ..write('dentistId: $dentistId, ')
          ..write('fullName: $fullName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('revenuePercentage: $revenuePercentage, ')
          ..write('preferredLanguage: $preferredLanguage, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    dentistId,
    fullName,
    email,
    phone,
    revenuePercentage,
    preferredLanguage,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfilesTableData &&
          other.id == this.id &&
          other.dentistId == this.dentistId &&
          other.fullName == this.fullName &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.revenuePercentage == this.revenuePercentage &&
          other.preferredLanguage == this.preferredLanguage &&
          other.cachedAt == this.cachedAt);
}

class ProfilesTableCompanion extends UpdateCompanion<ProfilesTableData> {
  final Value<String> id;
  final Value<String> dentistId;
  final Value<String> fullName;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<double> revenuePercentage;
  final Value<String> preferredLanguage;
  final Value<String> cachedAt;
  final Value<int> rowid;
  const ProfilesTableCompanion({
    this.id = const Value.absent(),
    this.dentistId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.revenuePercentage = const Value.absent(),
    this.preferredLanguage = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfilesTableCompanion.insert({
    required String id,
    required String dentistId,
    required String fullName,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.revenuePercentage = const Value.absent(),
    this.preferredLanguage = const Value.absent(),
    required String cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       dentistId = Value(dentistId),
       fullName = Value(fullName),
       cachedAt = Value(cachedAt);
  static Insertable<ProfilesTableData> custom({
    Expression<String>? id,
    Expression<String>? dentistId,
    Expression<String>? fullName,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<double>? revenuePercentage,
    Expression<String>? preferredLanguage,
    Expression<String>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dentistId != null) 'dentist_id': dentistId,
      if (fullName != null) 'full_name': fullName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (revenuePercentage != null) 'revenue_percentage': revenuePercentage,
      if (preferredLanguage != null) 'preferred_language': preferredLanguage,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfilesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? dentistId,
    Value<String>? fullName,
    Value<String?>? email,
    Value<String?>? phone,
    Value<double>? revenuePercentage,
    Value<String>? preferredLanguage,
    Value<String>? cachedAt,
    Value<int>? rowid,
  }) {
    return ProfilesTableCompanion(
      id: id ?? this.id,
      dentistId: dentistId ?? this.dentistId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      revenuePercentage: revenuePercentage ?? this.revenuePercentage,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (dentistId.present) {
      map['dentist_id'] = Variable<String>(dentistId.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (revenuePercentage.present) {
      map['revenue_percentage'] = Variable<double>(revenuePercentage.value);
    }
    if (preferredLanguage.present) {
      map['preferred_language'] = Variable<String>(preferredLanguage.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<String>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesTableCompanion(')
          ..write('id: $id, ')
          ..write('dentistId: $dentistId, ')
          ..write('fullName: $fullName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('revenuePercentage: $revenuePercentage, ')
          ..write('preferredLanguage: $preferredLanguage, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PatientsTableTable extends PatientsTable
    with TableInfo<$PatientsTableTable, PatientsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatientsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dentistIdMeta = const VerificationMeta(
    'dentistId',
  );
  @override
  late final GeneratedColumn<String> dentistId = GeneratedColumn<String>(
    'dentist_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
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
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _medicalStatusMeta = const VerificationMeta(
    'medicalStatus',
  );
  @override
  late final GeneratedColumn<String> medicalStatus = GeneratedColumn<String>(
    'medical_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _conditionMeta = const VerificationMeta(
    'condition',
  );
  @override
  late final GeneratedColumn<String> condition = GeneratedColumn<String>(
    'condition',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<String> cachedAt = GeneratedColumn<String>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dentistId,
    fullName,
    phone,
    age,
    medicalStatus,
    condition,
    notes,
    isDeleted,
    createdAt,
    updatedAt,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'patients_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PatientsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('dentist_id')) {
      context.handle(
        _dentistIdMeta,
        dentistId.isAcceptableOrUnknown(data['dentist_id']!, _dentistIdMeta),
      );
    } else if (isInserting) {
      context.missing(_dentistIdMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    }
    if (data.containsKey('medical_status')) {
      context.handle(
        _medicalStatusMeta,
        medicalStatus.isAcceptableOrUnknown(
          data['medical_status']!,
          _medicalStatusMeta,
        ),
      );
    }
    if (data.containsKey('condition')) {
      context.handle(
        _conditionMeta,
        condition.isAcceptableOrUnknown(data['condition']!, _conditionMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PatientsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PatientsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      dentistId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dentist_id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      ),
      medicalStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medical_status'],
      ),
      condition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}condition'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $PatientsTableTable createAlias(String alias) {
    return $PatientsTableTable(attachedDatabase, alias);
  }
}

class PatientsTableData extends DataClass
    implements Insertable<PatientsTableData> {
  final String id;
  final String dentistId;
  final String fullName;
  final String phone;
  final int? age;
  final String? medicalStatus;
  final String? condition;
  final String? notes;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;
  final String cachedAt;
  const PatientsTableData({
    required this.id,
    required this.dentistId,
    required this.fullName,
    required this.phone,
    this.age,
    this.medicalStatus,
    this.condition,
    this.notes,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['dentist_id'] = Variable<String>(dentistId);
    map['full_name'] = Variable<String>(fullName);
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    if (!nullToAbsent || medicalStatus != null) {
      map['medical_status'] = Variable<String>(medicalStatus);
    }
    if (!nullToAbsent || condition != null) {
      map['condition'] = Variable<String>(condition);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['cached_at'] = Variable<String>(cachedAt);
    return map;
  }

  PatientsTableCompanion toCompanion(bool nullToAbsent) {
    return PatientsTableCompanion(
      id: Value(id),
      dentistId: Value(dentistId),
      fullName: Value(fullName),
      phone: Value(phone),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      medicalStatus: medicalStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(medicalStatus),
      condition: condition == null && nullToAbsent
          ? const Value.absent()
          : Value(condition),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      cachedAt: Value(cachedAt),
    );
  }

  factory PatientsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PatientsTableData(
      id: serializer.fromJson<String>(json['id']),
      dentistId: serializer.fromJson<String>(json['dentistId']),
      fullName: serializer.fromJson<String>(json['fullName']),
      phone: serializer.fromJson<String>(json['phone']),
      age: serializer.fromJson<int?>(json['age']),
      medicalStatus: serializer.fromJson<String?>(json['medicalStatus']),
      condition: serializer.fromJson<String?>(json['condition']),
      notes: serializer.fromJson<String?>(json['notes']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      cachedAt: serializer.fromJson<String>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'dentistId': serializer.toJson<String>(dentistId),
      'fullName': serializer.toJson<String>(fullName),
      'phone': serializer.toJson<String>(phone),
      'age': serializer.toJson<int?>(age),
      'medicalStatus': serializer.toJson<String?>(medicalStatus),
      'condition': serializer.toJson<String?>(condition),
      'notes': serializer.toJson<String?>(notes),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'cachedAt': serializer.toJson<String>(cachedAt),
    };
  }

  PatientsTableData copyWith({
    String? id,
    String? dentistId,
    String? fullName,
    String? phone,
    Value<int?> age = const Value.absent(),
    Value<String?> medicalStatus = const Value.absent(),
    Value<String?> condition = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
    String? cachedAt,
  }) => PatientsTableData(
    id: id ?? this.id,
    dentistId: dentistId ?? this.dentistId,
    fullName: fullName ?? this.fullName,
    phone: phone ?? this.phone,
    age: age.present ? age.value : this.age,
    medicalStatus: medicalStatus.present
        ? medicalStatus.value
        : this.medicalStatus,
    condition: condition.present ? condition.value : this.condition,
    notes: notes.present ? notes.value : this.notes,
    isDeleted: isDeleted ?? this.isDeleted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  PatientsTableData copyWithCompanion(PatientsTableCompanion data) {
    return PatientsTableData(
      id: data.id.present ? data.id.value : this.id,
      dentistId: data.dentistId.present ? data.dentistId.value : this.dentistId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      phone: data.phone.present ? data.phone.value : this.phone,
      age: data.age.present ? data.age.value : this.age,
      medicalStatus: data.medicalStatus.present
          ? data.medicalStatus.value
          : this.medicalStatus,
      condition: data.condition.present ? data.condition.value : this.condition,
      notes: data.notes.present ? data.notes.value : this.notes,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PatientsTableData(')
          ..write('id: $id, ')
          ..write('dentistId: $dentistId, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('age: $age, ')
          ..write('medicalStatus: $medicalStatus, ')
          ..write('condition: $condition, ')
          ..write('notes: $notes, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    dentistId,
    fullName,
    phone,
    age,
    medicalStatus,
    condition,
    notes,
    isDeleted,
    createdAt,
    updatedAt,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PatientsTableData &&
          other.id == this.id &&
          other.dentistId == this.dentistId &&
          other.fullName == this.fullName &&
          other.phone == this.phone &&
          other.age == this.age &&
          other.medicalStatus == this.medicalStatus &&
          other.condition == this.condition &&
          other.notes == this.notes &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.cachedAt == this.cachedAt);
}

class PatientsTableCompanion extends UpdateCompanion<PatientsTableData> {
  final Value<String> id;
  final Value<String> dentistId;
  final Value<String> fullName;
  final Value<String> phone;
  final Value<int?> age;
  final Value<String?> medicalStatus;
  final Value<String?> condition;
  final Value<String?> notes;
  final Value<bool> isDeleted;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> cachedAt;
  final Value<int> rowid;
  const PatientsTableCompanion({
    this.id = const Value.absent(),
    this.dentistId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.phone = const Value.absent(),
    this.age = const Value.absent(),
    this.medicalStatus = const Value.absent(),
    this.condition = const Value.absent(),
    this.notes = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PatientsTableCompanion.insert({
    required String id,
    required String dentistId,
    required String fullName,
    required String phone,
    this.age = const Value.absent(),
    this.medicalStatus = const Value.absent(),
    this.condition = const Value.absent(),
    this.notes = const Value.absent(),
    this.isDeleted = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    required String cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       dentistId = Value(dentistId),
       fullName = Value(fullName),
       phone = Value(phone),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       cachedAt = Value(cachedAt);
  static Insertable<PatientsTableData> custom({
    Expression<String>? id,
    Expression<String>? dentistId,
    Expression<String>? fullName,
    Expression<String>? phone,
    Expression<int>? age,
    Expression<String>? medicalStatus,
    Expression<String>? condition,
    Expression<String>? notes,
    Expression<bool>? isDeleted,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dentistId != null) 'dentist_id': dentistId,
      if (fullName != null) 'full_name': fullName,
      if (phone != null) 'phone': phone,
      if (age != null) 'age': age,
      if (medicalStatus != null) 'medical_status': medicalStatus,
      if (condition != null) 'condition': condition,
      if (notes != null) 'notes': notes,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PatientsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? dentistId,
    Value<String>? fullName,
    Value<String>? phone,
    Value<int?>? age,
    Value<String?>? medicalStatus,
    Value<String?>? condition,
    Value<String?>? notes,
    Value<bool>? isDeleted,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String>? cachedAt,
    Value<int>? rowid,
  }) {
    return PatientsTableCompanion(
      id: id ?? this.id,
      dentistId: dentistId ?? this.dentistId,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      age: age ?? this.age,
      medicalStatus: medicalStatus ?? this.medicalStatus,
      condition: condition ?? this.condition,
      notes: notes ?? this.notes,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (dentistId.present) {
      map['dentist_id'] = Variable<String>(dentistId.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (medicalStatus.present) {
      map['medical_status'] = Variable<String>(medicalStatus.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String>(condition.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<String>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientsTableCompanion(')
          ..write('id: $id, ')
          ..write('dentistId: $dentistId, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('age: $age, ')
          ..write('medicalStatus: $medicalStatus, ')
          ..write('condition: $condition, ')
          ..write('notes: $notes, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TreatmentsTableTable extends TreatmentsTable
    with TableInfo<$TreatmentsTableTable, TreatmentsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TreatmentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dentistIdMeta = const VerificationMeta(
    'dentistId',
  );
  @override
  late final GeneratedColumn<String> dentistId = GeneratedColumn<String>(
    'dentist_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _procedureTypeMeta = const VerificationMeta(
    'procedureType',
  );
  @override
  late final GeneratedColumn<String> procedureType = GeneratedColumn<String>(
    'procedure_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toothNumbersMeta = const VerificationMeta(
    'toothNumbers',
  );
  @override
  late final GeneratedColumn<String> toothNumbers = GeneratedColumn<String>(
    'tooth_numbers',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _treatmentNotesMeta = const VerificationMeta(
    'treatmentNotes',
  );
  @override
  late final GeneratedColumn<String> treatmentNotes = GeneratedColumn<String>(
    'treatment_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalCostMeta = const VerificationMeta(
    'totalCost',
  );
  @override
  late final GeneratedColumn<double> totalCost = GeneratedColumn<double>(
    'total_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _technicianCostMeta = const VerificationMeta(
    'technicianCost',
  );
  @override
  late final GeneratedColumn<double> technicianCost = GeneratedColumn<double>(
    'technician_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _amountPaidMeta = const VerificationMeta(
    'amountPaid',
  );
  @override
  late final GeneratedColumn<double> amountPaid = GeneratedColumn<double>(
    'amount_paid',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('in_progress'),
  );
  static const VerificationMeta _treatmentDateMeta = const VerificationMeta(
    'treatmentDate',
  );
  @override
  late final GeneratedColumn<String> treatmentDate = GeneratedColumn<String>(
    'treatment_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientNameMeta = const VerificationMeta(
    'patientName',
  );
  @override
  late final GeneratedColumn<String> patientName = GeneratedColumn<String>(
    'patient_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<String> cachedAt = GeneratedColumn<String>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    dentistId,
    procedureType,
    toothNumbers,
    description,
    treatmentNotes,
    totalCost,
    technicianCost,
    amountPaid,
    status,
    treatmentDate,
    createdAt,
    patientName,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'treatments_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TreatmentsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('dentist_id')) {
      context.handle(
        _dentistIdMeta,
        dentistId.isAcceptableOrUnknown(data['dentist_id']!, _dentistIdMeta),
      );
    } else if (isInserting) {
      context.missing(_dentistIdMeta);
    }
    if (data.containsKey('procedure_type')) {
      context.handle(
        _procedureTypeMeta,
        procedureType.isAcceptableOrUnknown(
          data['procedure_type']!,
          _procedureTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_procedureTypeMeta);
    }
    if (data.containsKey('tooth_numbers')) {
      context.handle(
        _toothNumbersMeta,
        toothNumbers.isAcceptableOrUnknown(
          data['tooth_numbers']!,
          _toothNumbersMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('treatment_notes')) {
      context.handle(
        _treatmentNotesMeta,
        treatmentNotes.isAcceptableOrUnknown(
          data['treatment_notes']!,
          _treatmentNotesMeta,
        ),
      );
    }
    if (data.containsKey('total_cost')) {
      context.handle(
        _totalCostMeta,
        totalCost.isAcceptableOrUnknown(data['total_cost']!, _totalCostMeta),
      );
    }
    if (data.containsKey('technician_cost')) {
      context.handle(
        _technicianCostMeta,
        technicianCost.isAcceptableOrUnknown(
          data['technician_cost']!,
          _technicianCostMeta,
        ),
      );
    }
    if (data.containsKey('amount_paid')) {
      context.handle(
        _amountPaidMeta,
        amountPaid.isAcceptableOrUnknown(data['amount_paid']!, _amountPaidMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('treatment_date')) {
      context.handle(
        _treatmentDateMeta,
        treatmentDate.isAcceptableOrUnknown(
          data['treatment_date']!,
          _treatmentDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_treatmentDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('patient_name')) {
      context.handle(
        _patientNameMeta,
        patientName.isAcceptableOrUnknown(
          data['patient_name']!,
          _patientNameMeta,
        ),
      );
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TreatmentsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TreatmentsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      dentistId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dentist_id'],
      )!,
      procedureType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}procedure_type'],
      )!,
      toothNumbers: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tooth_numbers'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      treatmentNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}treatment_notes'],
      ),
      totalCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_cost'],
      )!,
      technicianCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}technician_cost'],
      )!,
      amountPaid: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount_paid'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      treatmentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}treatment_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      patientName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_name'],
      ),
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $TreatmentsTableTable createAlias(String alias) {
    return $TreatmentsTableTable(attachedDatabase, alias);
  }
}

class TreatmentsTableData extends DataClass
    implements Insertable<TreatmentsTableData> {
  final String id;
  final String patientId;
  final String dentistId;
  final String procedureType;
  final String toothNumbers;
  final String? description;
  final String? treatmentNotes;
  final double totalCost;
  final double technicianCost;
  final double amountPaid;
  final String status;
  final String treatmentDate;
  final String createdAt;
  final String? patientName;
  final String cachedAt;
  const TreatmentsTableData({
    required this.id,
    required this.patientId,
    required this.dentistId,
    required this.procedureType,
    required this.toothNumbers,
    this.description,
    this.treatmentNotes,
    required this.totalCost,
    required this.technicianCost,
    required this.amountPaid,
    required this.status,
    required this.treatmentDate,
    required this.createdAt,
    this.patientName,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['dentist_id'] = Variable<String>(dentistId);
    map['procedure_type'] = Variable<String>(procedureType);
    map['tooth_numbers'] = Variable<String>(toothNumbers);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || treatmentNotes != null) {
      map['treatment_notes'] = Variable<String>(treatmentNotes);
    }
    map['total_cost'] = Variable<double>(totalCost);
    map['technician_cost'] = Variable<double>(technicianCost);
    map['amount_paid'] = Variable<double>(amountPaid);
    map['status'] = Variable<String>(status);
    map['treatment_date'] = Variable<String>(treatmentDate);
    map['created_at'] = Variable<String>(createdAt);
    if (!nullToAbsent || patientName != null) {
      map['patient_name'] = Variable<String>(patientName);
    }
    map['cached_at'] = Variable<String>(cachedAt);
    return map;
  }

  TreatmentsTableCompanion toCompanion(bool nullToAbsent) {
    return TreatmentsTableCompanion(
      id: Value(id),
      patientId: Value(patientId),
      dentistId: Value(dentistId),
      procedureType: Value(procedureType),
      toothNumbers: Value(toothNumbers),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      treatmentNotes: treatmentNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(treatmentNotes),
      totalCost: Value(totalCost),
      technicianCost: Value(technicianCost),
      amountPaid: Value(amountPaid),
      status: Value(status),
      treatmentDate: Value(treatmentDate),
      createdAt: Value(createdAt),
      patientName: patientName == null && nullToAbsent
          ? const Value.absent()
          : Value(patientName),
      cachedAt: Value(cachedAt),
    );
  }

  factory TreatmentsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TreatmentsTableData(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      dentistId: serializer.fromJson<String>(json['dentistId']),
      procedureType: serializer.fromJson<String>(json['procedureType']),
      toothNumbers: serializer.fromJson<String>(json['toothNumbers']),
      description: serializer.fromJson<String?>(json['description']),
      treatmentNotes: serializer.fromJson<String?>(json['treatmentNotes']),
      totalCost: serializer.fromJson<double>(json['totalCost']),
      technicianCost: serializer.fromJson<double>(json['technicianCost']),
      amountPaid: serializer.fromJson<double>(json['amountPaid']),
      status: serializer.fromJson<String>(json['status']),
      treatmentDate: serializer.fromJson<String>(json['treatmentDate']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      patientName: serializer.fromJson<String?>(json['patientName']),
      cachedAt: serializer.fromJson<String>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'dentistId': serializer.toJson<String>(dentistId),
      'procedureType': serializer.toJson<String>(procedureType),
      'toothNumbers': serializer.toJson<String>(toothNumbers),
      'description': serializer.toJson<String?>(description),
      'treatmentNotes': serializer.toJson<String?>(treatmentNotes),
      'totalCost': serializer.toJson<double>(totalCost),
      'technicianCost': serializer.toJson<double>(technicianCost),
      'amountPaid': serializer.toJson<double>(amountPaid),
      'status': serializer.toJson<String>(status),
      'treatmentDate': serializer.toJson<String>(treatmentDate),
      'createdAt': serializer.toJson<String>(createdAt),
      'patientName': serializer.toJson<String?>(patientName),
      'cachedAt': serializer.toJson<String>(cachedAt),
    };
  }

  TreatmentsTableData copyWith({
    String? id,
    String? patientId,
    String? dentistId,
    String? procedureType,
    String? toothNumbers,
    Value<String?> description = const Value.absent(),
    Value<String?> treatmentNotes = const Value.absent(),
    double? totalCost,
    double? technicianCost,
    double? amountPaid,
    String? status,
    String? treatmentDate,
    String? createdAt,
    Value<String?> patientName = const Value.absent(),
    String? cachedAt,
  }) => TreatmentsTableData(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    dentistId: dentistId ?? this.dentistId,
    procedureType: procedureType ?? this.procedureType,
    toothNumbers: toothNumbers ?? this.toothNumbers,
    description: description.present ? description.value : this.description,
    treatmentNotes: treatmentNotes.present
        ? treatmentNotes.value
        : this.treatmentNotes,
    totalCost: totalCost ?? this.totalCost,
    technicianCost: technicianCost ?? this.technicianCost,
    amountPaid: amountPaid ?? this.amountPaid,
    status: status ?? this.status,
    treatmentDate: treatmentDate ?? this.treatmentDate,
    createdAt: createdAt ?? this.createdAt,
    patientName: patientName.present ? patientName.value : this.patientName,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  TreatmentsTableData copyWithCompanion(TreatmentsTableCompanion data) {
    return TreatmentsTableData(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      dentistId: data.dentistId.present ? data.dentistId.value : this.dentistId,
      procedureType: data.procedureType.present
          ? data.procedureType.value
          : this.procedureType,
      toothNumbers: data.toothNumbers.present
          ? data.toothNumbers.value
          : this.toothNumbers,
      description: data.description.present
          ? data.description.value
          : this.description,
      treatmentNotes: data.treatmentNotes.present
          ? data.treatmentNotes.value
          : this.treatmentNotes,
      totalCost: data.totalCost.present ? data.totalCost.value : this.totalCost,
      technicianCost: data.technicianCost.present
          ? data.technicianCost.value
          : this.technicianCost,
      amountPaid: data.amountPaid.present
          ? data.amountPaid.value
          : this.amountPaid,
      status: data.status.present ? data.status.value : this.status,
      treatmentDate: data.treatmentDate.present
          ? data.treatmentDate.value
          : this.treatmentDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      patientName: data.patientName.present
          ? data.patientName.value
          : this.patientName,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TreatmentsTableData(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('dentistId: $dentistId, ')
          ..write('procedureType: $procedureType, ')
          ..write('toothNumbers: $toothNumbers, ')
          ..write('description: $description, ')
          ..write('treatmentNotes: $treatmentNotes, ')
          ..write('totalCost: $totalCost, ')
          ..write('technicianCost: $technicianCost, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('status: $status, ')
          ..write('treatmentDate: $treatmentDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('patientName: $patientName, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    dentistId,
    procedureType,
    toothNumbers,
    description,
    treatmentNotes,
    totalCost,
    technicianCost,
    amountPaid,
    status,
    treatmentDate,
    createdAt,
    patientName,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TreatmentsTableData &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.dentistId == this.dentistId &&
          other.procedureType == this.procedureType &&
          other.toothNumbers == this.toothNumbers &&
          other.description == this.description &&
          other.treatmentNotes == this.treatmentNotes &&
          other.totalCost == this.totalCost &&
          other.technicianCost == this.technicianCost &&
          other.amountPaid == this.amountPaid &&
          other.status == this.status &&
          other.treatmentDate == this.treatmentDate &&
          other.createdAt == this.createdAt &&
          other.patientName == this.patientName &&
          other.cachedAt == this.cachedAt);
}

class TreatmentsTableCompanion extends UpdateCompanion<TreatmentsTableData> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> dentistId;
  final Value<String> procedureType;
  final Value<String> toothNumbers;
  final Value<String?> description;
  final Value<String?> treatmentNotes;
  final Value<double> totalCost;
  final Value<double> technicianCost;
  final Value<double> amountPaid;
  final Value<String> status;
  final Value<String> treatmentDate;
  final Value<String> createdAt;
  final Value<String?> patientName;
  final Value<String> cachedAt;
  final Value<int> rowid;
  const TreatmentsTableCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.dentistId = const Value.absent(),
    this.procedureType = const Value.absent(),
    this.toothNumbers = const Value.absent(),
    this.description = const Value.absent(),
    this.treatmentNotes = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.technicianCost = const Value.absent(),
    this.amountPaid = const Value.absent(),
    this.status = const Value.absent(),
    this.treatmentDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.patientName = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TreatmentsTableCompanion.insert({
    required String id,
    required String patientId,
    required String dentistId,
    required String procedureType,
    this.toothNumbers = const Value.absent(),
    this.description = const Value.absent(),
    this.treatmentNotes = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.technicianCost = const Value.absent(),
    this.amountPaid = const Value.absent(),
    this.status = const Value.absent(),
    required String treatmentDate,
    required String createdAt,
    this.patientName = const Value.absent(),
    required String cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId),
       dentistId = Value(dentistId),
       procedureType = Value(procedureType),
       treatmentDate = Value(treatmentDate),
       createdAt = Value(createdAt),
       cachedAt = Value(cachedAt);
  static Insertable<TreatmentsTableData> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? dentistId,
    Expression<String>? procedureType,
    Expression<String>? toothNumbers,
    Expression<String>? description,
    Expression<String>? treatmentNotes,
    Expression<double>? totalCost,
    Expression<double>? technicianCost,
    Expression<double>? amountPaid,
    Expression<String>? status,
    Expression<String>? treatmentDate,
    Expression<String>? createdAt,
    Expression<String>? patientName,
    Expression<String>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (dentistId != null) 'dentist_id': dentistId,
      if (procedureType != null) 'procedure_type': procedureType,
      if (toothNumbers != null) 'tooth_numbers': toothNumbers,
      if (description != null) 'description': description,
      if (treatmentNotes != null) 'treatment_notes': treatmentNotes,
      if (totalCost != null) 'total_cost': totalCost,
      if (technicianCost != null) 'technician_cost': technicianCost,
      if (amountPaid != null) 'amount_paid': amountPaid,
      if (status != null) 'status': status,
      if (treatmentDate != null) 'treatment_date': treatmentDate,
      if (createdAt != null) 'created_at': createdAt,
      if (patientName != null) 'patient_name': patientName,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TreatmentsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<String>? dentistId,
    Value<String>? procedureType,
    Value<String>? toothNumbers,
    Value<String?>? description,
    Value<String?>? treatmentNotes,
    Value<double>? totalCost,
    Value<double>? technicianCost,
    Value<double>? amountPaid,
    Value<String>? status,
    Value<String>? treatmentDate,
    Value<String>? createdAt,
    Value<String?>? patientName,
    Value<String>? cachedAt,
    Value<int>? rowid,
  }) {
    return TreatmentsTableCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      dentistId: dentistId ?? this.dentistId,
      procedureType: procedureType ?? this.procedureType,
      toothNumbers: toothNumbers ?? this.toothNumbers,
      description: description ?? this.description,
      treatmentNotes: treatmentNotes ?? this.treatmentNotes,
      totalCost: totalCost ?? this.totalCost,
      technicianCost: technicianCost ?? this.technicianCost,
      amountPaid: amountPaid ?? this.amountPaid,
      status: status ?? this.status,
      treatmentDate: treatmentDate ?? this.treatmentDate,
      createdAt: createdAt ?? this.createdAt,
      patientName: patientName ?? this.patientName,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (dentistId.present) {
      map['dentist_id'] = Variable<String>(dentistId.value);
    }
    if (procedureType.present) {
      map['procedure_type'] = Variable<String>(procedureType.value);
    }
    if (toothNumbers.present) {
      map['tooth_numbers'] = Variable<String>(toothNumbers.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (treatmentNotes.present) {
      map['treatment_notes'] = Variable<String>(treatmentNotes.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<double>(totalCost.value);
    }
    if (technicianCost.present) {
      map['technician_cost'] = Variable<double>(technicianCost.value);
    }
    if (amountPaid.present) {
      map['amount_paid'] = Variable<double>(amountPaid.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (treatmentDate.present) {
      map['treatment_date'] = Variable<String>(treatmentDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (patientName.present) {
      map['patient_name'] = Variable<String>(patientName.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<String>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TreatmentsTableCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('dentistId: $dentistId, ')
          ..write('procedureType: $procedureType, ')
          ..write('toothNumbers: $toothNumbers, ')
          ..write('description: $description, ')
          ..write('treatmentNotes: $treatmentNotes, ')
          ..write('totalCost: $totalCost, ')
          ..write('technicianCost: $technicianCost, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('status: $status, ')
          ..write('treatmentDate: $treatmentDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('patientName: $patientName, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTableTable extends PaymentsTable
    with TableInfo<$PaymentsTableTable, PaymentsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _treatmentIdMeta = const VerificationMeta(
    'treatmentId',
  );
  @override
  late final GeneratedColumn<String> treatmentId = GeneratedColumn<String>(
    'treatment_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dentistIdMeta = const VerificationMeta(
    'dentistId',
  );
  @override
  late final GeneratedColumn<String> dentistId = GeneratedColumn<String>(
    'dentist_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('cash'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentDateMeta = const VerificationMeta(
    'paymentDate',
  );
  @override
  late final GeneratedColumn<String> paymentDate = GeneratedColumn<String>(
    'payment_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<String> cachedAt = GeneratedColumn<String>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    treatmentId,
    dentistId,
    amount,
    paymentMethod,
    notes,
    paymentDate,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('treatment_id')) {
      context.handle(
        _treatmentIdMeta,
        treatmentId.isAcceptableOrUnknown(
          data['treatment_id']!,
          _treatmentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_treatmentIdMeta);
    }
    if (data.containsKey('dentist_id')) {
      context.handle(
        _dentistIdMeta,
        dentistId.isAcceptableOrUnknown(data['dentist_id']!, _dentistIdMeta),
      );
    } else if (isInserting) {
      context.missing(_dentistIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('payment_date')) {
      context.handle(
        _paymentDateMeta,
        paymentDate.isAcceptableOrUnknown(
          data['payment_date']!,
          _paymentDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentDateMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      treatmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}treatment_id'],
      )!,
      dentistId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dentist_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      paymentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_date'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $PaymentsTableTable createAlias(String alias) {
    return $PaymentsTableTable(attachedDatabase, alias);
  }
}

class PaymentsTableData extends DataClass
    implements Insertable<PaymentsTableData> {
  final String id;
  final String treatmentId;
  final String dentistId;
  final double amount;
  final String paymentMethod;
  final String? notes;
  final String paymentDate;
  final String cachedAt;
  const PaymentsTableData({
    required this.id,
    required this.treatmentId,
    required this.dentistId,
    required this.amount,
    required this.paymentMethod,
    this.notes,
    required this.paymentDate,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['treatment_id'] = Variable<String>(treatmentId);
    map['dentist_id'] = Variable<String>(dentistId);
    map['amount'] = Variable<double>(amount);
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['payment_date'] = Variable<String>(paymentDate);
    map['cached_at'] = Variable<String>(cachedAt);
    return map;
  }

  PaymentsTableCompanion toCompanion(bool nullToAbsent) {
    return PaymentsTableCompanion(
      id: Value(id),
      treatmentId: Value(treatmentId),
      dentistId: Value(dentistId),
      amount: Value(amount),
      paymentMethod: Value(paymentMethod),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      paymentDate: Value(paymentDate),
      cachedAt: Value(cachedAt),
    );
  }

  factory PaymentsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentsTableData(
      id: serializer.fromJson<String>(json['id']),
      treatmentId: serializer.fromJson<String>(json['treatmentId']),
      dentistId: serializer.fromJson<String>(json['dentistId']),
      amount: serializer.fromJson<double>(json['amount']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      notes: serializer.fromJson<String?>(json['notes']),
      paymentDate: serializer.fromJson<String>(json['paymentDate']),
      cachedAt: serializer.fromJson<String>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'treatmentId': serializer.toJson<String>(treatmentId),
      'dentistId': serializer.toJson<String>(dentistId),
      'amount': serializer.toJson<double>(amount),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'notes': serializer.toJson<String?>(notes),
      'paymentDate': serializer.toJson<String>(paymentDate),
      'cachedAt': serializer.toJson<String>(cachedAt),
    };
  }

  PaymentsTableData copyWith({
    String? id,
    String? treatmentId,
    String? dentistId,
    double? amount,
    String? paymentMethod,
    Value<String?> notes = const Value.absent(),
    String? paymentDate,
    String? cachedAt,
  }) => PaymentsTableData(
    id: id ?? this.id,
    treatmentId: treatmentId ?? this.treatmentId,
    dentistId: dentistId ?? this.dentistId,
    amount: amount ?? this.amount,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    notes: notes.present ? notes.value : this.notes,
    paymentDate: paymentDate ?? this.paymentDate,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  PaymentsTableData copyWithCompanion(PaymentsTableCompanion data) {
    return PaymentsTableData(
      id: data.id.present ? data.id.value : this.id,
      treatmentId: data.treatmentId.present
          ? data.treatmentId.value
          : this.treatmentId,
      dentistId: data.dentistId.present ? data.dentistId.value : this.dentistId,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      notes: data.notes.present ? data.notes.value : this.notes,
      paymentDate: data.paymentDate.present
          ? data.paymentDate.value
          : this.paymentDate,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsTableData(')
          ..write('id: $id, ')
          ..write('treatmentId: $treatmentId, ')
          ..write('dentistId: $dentistId, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('notes: $notes, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    treatmentId,
    dentistId,
    amount,
    paymentMethod,
    notes,
    paymentDate,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentsTableData &&
          other.id == this.id &&
          other.treatmentId == this.treatmentId &&
          other.dentistId == this.dentistId &&
          other.amount == this.amount &&
          other.paymentMethod == this.paymentMethod &&
          other.notes == this.notes &&
          other.paymentDate == this.paymentDate &&
          other.cachedAt == this.cachedAt);
}

class PaymentsTableCompanion extends UpdateCompanion<PaymentsTableData> {
  final Value<String> id;
  final Value<String> treatmentId;
  final Value<String> dentistId;
  final Value<double> amount;
  final Value<String> paymentMethod;
  final Value<String?> notes;
  final Value<String> paymentDate;
  final Value<String> cachedAt;
  final Value<int> rowid;
  const PaymentsTableCompanion({
    this.id = const Value.absent(),
    this.treatmentId = const Value.absent(),
    this.dentistId = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.notes = const Value.absent(),
    this.paymentDate = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentsTableCompanion.insert({
    required String id,
    required String treatmentId,
    required String dentistId,
    required double amount,
    this.paymentMethod = const Value.absent(),
    this.notes = const Value.absent(),
    required String paymentDate,
    required String cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       treatmentId = Value(treatmentId),
       dentistId = Value(dentistId),
       amount = Value(amount),
       paymentDate = Value(paymentDate),
       cachedAt = Value(cachedAt);
  static Insertable<PaymentsTableData> custom({
    Expression<String>? id,
    Expression<String>? treatmentId,
    Expression<String>? dentistId,
    Expression<double>? amount,
    Expression<String>? paymentMethod,
    Expression<String>? notes,
    Expression<String>? paymentDate,
    Expression<String>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (treatmentId != null) 'treatment_id': treatmentId,
      if (dentistId != null) 'dentist_id': dentistId,
      if (amount != null) 'amount': amount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (notes != null) 'notes': notes,
      if (paymentDate != null) 'payment_date': paymentDate,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? treatmentId,
    Value<String>? dentistId,
    Value<double>? amount,
    Value<String>? paymentMethod,
    Value<String?>? notes,
    Value<String>? paymentDate,
    Value<String>? cachedAt,
    Value<int>? rowid,
  }) {
    return PaymentsTableCompanion(
      id: id ?? this.id,
      treatmentId: treatmentId ?? this.treatmentId,
      dentistId: dentistId ?? this.dentistId,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      paymentDate: paymentDate ?? this.paymentDate,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (treatmentId.present) {
      map['treatment_id'] = Variable<String>(treatmentId.value);
    }
    if (dentistId.present) {
      map['dentist_id'] = Variable<String>(dentistId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (paymentDate.present) {
      map['payment_date'] = Variable<String>(paymentDate.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<String>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsTableCompanion(')
          ..write('id: $id, ')
          ..write('treatmentId: $treatmentId, ')
          ..write('dentistId: $dentistId, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('notes: $notes, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppointmentsTableTable extends AppointmentsTable
    with TableInfo<$AppointmentsTableTable, AppointmentsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppointmentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dentistIdMeta = const VerificationMeta(
    'dentistId',
  );
  @override
  late final GeneratedColumn<String> dentistId = GeneratedColumn<String>(
    'dentist_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _treatmentIdMeta = const VerificationMeta(
    'treatmentId',
  );
  @override
  late final GeneratedColumn<String> treatmentId = GeneratedColumn<String>(
    'treatment_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _appointmentDateMeta = const VerificationMeta(
    'appointmentDate',
  );
  @override
  late final GeneratedColumn<String> appointmentDate = GeneratedColumn<String>(
    'appointment_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('scheduled'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _patientNameMeta = const VerificationMeta(
    'patientName',
  );
  @override
  late final GeneratedColumn<String> patientName = GeneratedColumn<String>(
    'patient_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _patientPhoneMeta = const VerificationMeta(
    'patientPhone',
  );
  @override
  late final GeneratedColumn<String> patientPhone = GeneratedColumn<String>(
    'patient_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<String> cachedAt = GeneratedColumn<String>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    dentistId,
    treatmentId,
    appointmentDate,
    status,
    notes,
    patientName,
    patientPhone,
    createdAt,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'appointments_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppointmentsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('dentist_id')) {
      context.handle(
        _dentistIdMeta,
        dentistId.isAcceptableOrUnknown(data['dentist_id']!, _dentistIdMeta),
      );
    } else if (isInserting) {
      context.missing(_dentistIdMeta);
    }
    if (data.containsKey('treatment_id')) {
      context.handle(
        _treatmentIdMeta,
        treatmentId.isAcceptableOrUnknown(
          data['treatment_id']!,
          _treatmentIdMeta,
        ),
      );
    }
    if (data.containsKey('appointment_date')) {
      context.handle(
        _appointmentDateMeta,
        appointmentDate.isAcceptableOrUnknown(
          data['appointment_date']!,
          _appointmentDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_appointmentDateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('patient_name')) {
      context.handle(
        _patientNameMeta,
        patientName.isAcceptableOrUnknown(
          data['patient_name']!,
          _patientNameMeta,
        ),
      );
    }
    if (data.containsKey('patient_phone')) {
      context.handle(
        _patientPhoneMeta,
        patientPhone.isAcceptableOrUnknown(
          data['patient_phone']!,
          _patientPhoneMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppointmentsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppointmentsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      dentistId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dentist_id'],
      )!,
      treatmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}treatment_id'],
      ),
      appointmentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}appointment_date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      patientName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_name'],
      ),
      patientPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_phone'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $AppointmentsTableTable createAlias(String alias) {
    return $AppointmentsTableTable(attachedDatabase, alias);
  }
}

class AppointmentsTableData extends DataClass
    implements Insertable<AppointmentsTableData> {
  final String id;
  final String patientId;
  final String dentistId;
  final String? treatmentId;
  final String appointmentDate;
  final String status;
  final String? notes;
  final String? patientName;
  final String? patientPhone;
  final String createdAt;
  final String cachedAt;
  const AppointmentsTableData({
    required this.id,
    required this.patientId,
    required this.dentistId,
    this.treatmentId,
    required this.appointmentDate,
    required this.status,
    this.notes,
    this.patientName,
    this.patientPhone,
    required this.createdAt,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['dentist_id'] = Variable<String>(dentistId);
    if (!nullToAbsent || treatmentId != null) {
      map['treatment_id'] = Variable<String>(treatmentId);
    }
    map['appointment_date'] = Variable<String>(appointmentDate);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || patientName != null) {
      map['patient_name'] = Variable<String>(patientName);
    }
    if (!nullToAbsent || patientPhone != null) {
      map['patient_phone'] = Variable<String>(patientPhone);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['cached_at'] = Variable<String>(cachedAt);
    return map;
  }

  AppointmentsTableCompanion toCompanion(bool nullToAbsent) {
    return AppointmentsTableCompanion(
      id: Value(id),
      patientId: Value(patientId),
      dentistId: Value(dentistId),
      treatmentId: treatmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(treatmentId),
      appointmentDate: Value(appointmentDate),
      status: Value(status),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      patientName: patientName == null && nullToAbsent
          ? const Value.absent()
          : Value(patientName),
      patientPhone: patientPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(patientPhone),
      createdAt: Value(createdAt),
      cachedAt: Value(cachedAt),
    );
  }

  factory AppointmentsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppointmentsTableData(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      dentistId: serializer.fromJson<String>(json['dentistId']),
      treatmentId: serializer.fromJson<String?>(json['treatmentId']),
      appointmentDate: serializer.fromJson<String>(json['appointmentDate']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      patientName: serializer.fromJson<String?>(json['patientName']),
      patientPhone: serializer.fromJson<String?>(json['patientPhone']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      cachedAt: serializer.fromJson<String>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'dentistId': serializer.toJson<String>(dentistId),
      'treatmentId': serializer.toJson<String?>(treatmentId),
      'appointmentDate': serializer.toJson<String>(appointmentDate),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'patientName': serializer.toJson<String?>(patientName),
      'patientPhone': serializer.toJson<String?>(patientPhone),
      'createdAt': serializer.toJson<String>(createdAt),
      'cachedAt': serializer.toJson<String>(cachedAt),
    };
  }

  AppointmentsTableData copyWith({
    String? id,
    String? patientId,
    String? dentistId,
    Value<String?> treatmentId = const Value.absent(),
    String? appointmentDate,
    String? status,
    Value<String?> notes = const Value.absent(),
    Value<String?> patientName = const Value.absent(),
    Value<String?> patientPhone = const Value.absent(),
    String? createdAt,
    String? cachedAt,
  }) => AppointmentsTableData(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    dentistId: dentistId ?? this.dentistId,
    treatmentId: treatmentId.present ? treatmentId.value : this.treatmentId,
    appointmentDate: appointmentDate ?? this.appointmentDate,
    status: status ?? this.status,
    notes: notes.present ? notes.value : this.notes,
    patientName: patientName.present ? patientName.value : this.patientName,
    patientPhone: patientPhone.present ? patientPhone.value : this.patientPhone,
    createdAt: createdAt ?? this.createdAt,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  AppointmentsTableData copyWithCompanion(AppointmentsTableCompanion data) {
    return AppointmentsTableData(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      dentistId: data.dentistId.present ? data.dentistId.value : this.dentistId,
      treatmentId: data.treatmentId.present
          ? data.treatmentId.value
          : this.treatmentId,
      appointmentDate: data.appointmentDate.present
          ? data.appointmentDate.value
          : this.appointmentDate,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      patientName: data.patientName.present
          ? data.patientName.value
          : this.patientName,
      patientPhone: data.patientPhone.present
          ? data.patientPhone.value
          : this.patientPhone,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppointmentsTableData(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('dentistId: $dentistId, ')
          ..write('treatmentId: $treatmentId, ')
          ..write('appointmentDate: $appointmentDate, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('patientName: $patientName, ')
          ..write('patientPhone: $patientPhone, ')
          ..write('createdAt: $createdAt, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    dentistId,
    treatmentId,
    appointmentDate,
    status,
    notes,
    patientName,
    patientPhone,
    createdAt,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppointmentsTableData &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.dentistId == this.dentistId &&
          other.treatmentId == this.treatmentId &&
          other.appointmentDate == this.appointmentDate &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.patientName == this.patientName &&
          other.patientPhone == this.patientPhone &&
          other.createdAt == this.createdAt &&
          other.cachedAt == this.cachedAt);
}

class AppointmentsTableCompanion
    extends UpdateCompanion<AppointmentsTableData> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> dentistId;
  final Value<String?> treatmentId;
  final Value<String> appointmentDate;
  final Value<String> status;
  final Value<String?> notes;
  final Value<String?> patientName;
  final Value<String?> patientPhone;
  final Value<String> createdAt;
  final Value<String> cachedAt;
  final Value<int> rowid;
  const AppointmentsTableCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.dentistId = const Value.absent(),
    this.treatmentId = const Value.absent(),
    this.appointmentDate = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.patientName = const Value.absent(),
    this.patientPhone = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppointmentsTableCompanion.insert({
    required String id,
    required String patientId,
    required String dentistId,
    this.treatmentId = const Value.absent(),
    required String appointmentDate,
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.patientName = const Value.absent(),
    this.patientPhone = const Value.absent(),
    required String createdAt,
    required String cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId),
       dentistId = Value(dentistId),
       appointmentDate = Value(appointmentDate),
       createdAt = Value(createdAt),
       cachedAt = Value(cachedAt);
  static Insertable<AppointmentsTableData> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? dentistId,
    Expression<String>? treatmentId,
    Expression<String>? appointmentDate,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<String>? patientName,
    Expression<String>? patientPhone,
    Expression<String>? createdAt,
    Expression<String>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (dentistId != null) 'dentist_id': dentistId,
      if (treatmentId != null) 'treatment_id': treatmentId,
      if (appointmentDate != null) 'appointment_date': appointmentDate,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (patientName != null) 'patient_name': patientName,
      if (patientPhone != null) 'patient_phone': patientPhone,
      if (createdAt != null) 'created_at': createdAt,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppointmentsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<String>? dentistId,
    Value<String?>? treatmentId,
    Value<String>? appointmentDate,
    Value<String>? status,
    Value<String?>? notes,
    Value<String?>? patientName,
    Value<String?>? patientPhone,
    Value<String>? createdAt,
    Value<String>? cachedAt,
    Value<int>? rowid,
  }) {
    return AppointmentsTableCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      dentistId: dentistId ?? this.dentistId,
      treatmentId: treatmentId ?? this.treatmentId,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      patientName: patientName ?? this.patientName,
      patientPhone: patientPhone ?? this.patientPhone,
      createdAt: createdAt ?? this.createdAt,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (dentistId.present) {
      map['dentist_id'] = Variable<String>(dentistId.value);
    }
    if (treatmentId.present) {
      map['treatment_id'] = Variable<String>(treatmentId.value);
    }
    if (appointmentDate.present) {
      map['appointment_date'] = Variable<String>(appointmentDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (patientName.present) {
      map['patient_name'] = Variable<String>(patientName.value);
    }
    if (patientPhone.present) {
      map['patient_phone'] = Variable<String>(patientPhone.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<String>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppointmentsTableCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('dentistId: $dentistId, ')
          ..write('treatmentId: $treatmentId, ')
          ..write('appointmentDate: $appointmentDate, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('patientName: $patientName, ')
          ..write('patientPhone: $patientPhone, ')
          ..write('createdAt: $createdAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MedicationsTableTable extends MedicationsTable
    with TableInfo<$MedicationsTableTable, MedicationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _treatmentIdMeta = const VerificationMeta(
    'treatmentId',
  );
  @override
  late final GeneratedColumn<String> treatmentId = GeneratedColumn<String>(
    'treatment_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dentistIdMeta = const VerificationMeta(
    'dentistId',
  );
  @override
  late final GeneratedColumn<String> dentistId = GeneratedColumn<String>(
    'dentist_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _medicationNameMeta = const VerificationMeta(
    'medicationName',
  );
  @override
  late final GeneratedColumn<String> medicationName = GeneratedColumn<String>(
    'medication_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dosageMeta = const VerificationMeta('dosage');
  @override
  late final GeneratedColumn<String> dosage = GeneratedColumn<String>(
    'dosage',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
    'frequency',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<String> duration = GeneratedColumn<String>(
    'duration',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _prescribedDateMeta = const VerificationMeta(
    'prescribedDate',
  );
  @override
  late final GeneratedColumn<String> prescribedDate = GeneratedColumn<String>(
    'prescribed_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<String> cachedAt = GeneratedColumn<String>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    treatmentId,
    dentistId,
    medicationName,
    dosage,
    frequency,
    duration,
    notes,
    prescribedDate,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medications_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<MedicationsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('treatment_id')) {
      context.handle(
        _treatmentIdMeta,
        treatmentId.isAcceptableOrUnknown(
          data['treatment_id']!,
          _treatmentIdMeta,
        ),
      );
    }
    if (data.containsKey('dentist_id')) {
      context.handle(
        _dentistIdMeta,
        dentistId.isAcceptableOrUnknown(data['dentist_id']!, _dentistIdMeta),
      );
    } else if (isInserting) {
      context.missing(_dentistIdMeta);
    }
    if (data.containsKey('medication_name')) {
      context.handle(
        _medicationNameMeta,
        medicationName.isAcceptableOrUnknown(
          data['medication_name']!,
          _medicationNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_medicationNameMeta);
    }
    if (data.containsKey('dosage')) {
      context.handle(
        _dosageMeta,
        dosage.isAcceptableOrUnknown(data['dosage']!, _dosageMeta),
      );
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('prescribed_date')) {
      context.handle(
        _prescribedDateMeta,
        prescribedDate.isAcceptableOrUnknown(
          data['prescribed_date']!,
          _prescribedDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_prescribedDateMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicationsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicationsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      treatmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}treatment_id'],
      ),
      dentistId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dentist_id'],
      )!,
      medicationName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medication_name'],
      )!,
      dosage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dosage'],
      ),
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency'],
      ),
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}duration'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      prescribedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prescribed_date'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $MedicationsTableTable createAlias(String alias) {
    return $MedicationsTableTable(attachedDatabase, alias);
  }
}

class MedicationsTableData extends DataClass
    implements Insertable<MedicationsTableData> {
  final String id;
  final String patientId;
  final String? treatmentId;
  final String dentistId;
  final String medicationName;
  final String? dosage;
  final String? frequency;
  final String? duration;
  final String? notes;
  final String prescribedDate;
  final String cachedAt;
  const MedicationsTableData({
    required this.id,
    required this.patientId,
    this.treatmentId,
    required this.dentistId,
    required this.medicationName,
    this.dosage,
    this.frequency,
    this.duration,
    this.notes,
    required this.prescribedDate,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    if (!nullToAbsent || treatmentId != null) {
      map['treatment_id'] = Variable<String>(treatmentId);
    }
    map['dentist_id'] = Variable<String>(dentistId);
    map['medication_name'] = Variable<String>(medicationName);
    if (!nullToAbsent || dosage != null) {
      map['dosage'] = Variable<String>(dosage);
    }
    if (!nullToAbsent || frequency != null) {
      map['frequency'] = Variable<String>(frequency);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<String>(duration);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['prescribed_date'] = Variable<String>(prescribedDate);
    map['cached_at'] = Variable<String>(cachedAt);
    return map;
  }

  MedicationsTableCompanion toCompanion(bool nullToAbsent) {
    return MedicationsTableCompanion(
      id: Value(id),
      patientId: Value(patientId),
      treatmentId: treatmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(treatmentId),
      dentistId: Value(dentistId),
      medicationName: Value(medicationName),
      dosage: dosage == null && nullToAbsent
          ? const Value.absent()
          : Value(dosage),
      frequency: frequency == null && nullToAbsent
          ? const Value.absent()
          : Value(frequency),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      prescribedDate: Value(prescribedDate),
      cachedAt: Value(cachedAt),
    );
  }

  factory MedicationsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicationsTableData(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      treatmentId: serializer.fromJson<String?>(json['treatmentId']),
      dentistId: serializer.fromJson<String>(json['dentistId']),
      medicationName: serializer.fromJson<String>(json['medicationName']),
      dosage: serializer.fromJson<String?>(json['dosage']),
      frequency: serializer.fromJson<String?>(json['frequency']),
      duration: serializer.fromJson<String?>(json['duration']),
      notes: serializer.fromJson<String?>(json['notes']),
      prescribedDate: serializer.fromJson<String>(json['prescribedDate']),
      cachedAt: serializer.fromJson<String>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'treatmentId': serializer.toJson<String?>(treatmentId),
      'dentistId': serializer.toJson<String>(dentistId),
      'medicationName': serializer.toJson<String>(medicationName),
      'dosage': serializer.toJson<String?>(dosage),
      'frequency': serializer.toJson<String?>(frequency),
      'duration': serializer.toJson<String?>(duration),
      'notes': serializer.toJson<String?>(notes),
      'prescribedDate': serializer.toJson<String>(prescribedDate),
      'cachedAt': serializer.toJson<String>(cachedAt),
    };
  }

  MedicationsTableData copyWith({
    String? id,
    String? patientId,
    Value<String?> treatmentId = const Value.absent(),
    String? dentistId,
    String? medicationName,
    Value<String?> dosage = const Value.absent(),
    Value<String?> frequency = const Value.absent(),
    Value<String?> duration = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? prescribedDate,
    String? cachedAt,
  }) => MedicationsTableData(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    treatmentId: treatmentId.present ? treatmentId.value : this.treatmentId,
    dentistId: dentistId ?? this.dentistId,
    medicationName: medicationName ?? this.medicationName,
    dosage: dosage.present ? dosage.value : this.dosage,
    frequency: frequency.present ? frequency.value : this.frequency,
    duration: duration.present ? duration.value : this.duration,
    notes: notes.present ? notes.value : this.notes,
    prescribedDate: prescribedDate ?? this.prescribedDate,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  MedicationsTableData copyWithCompanion(MedicationsTableCompanion data) {
    return MedicationsTableData(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      treatmentId: data.treatmentId.present
          ? data.treatmentId.value
          : this.treatmentId,
      dentistId: data.dentistId.present ? data.dentistId.value : this.dentistId,
      medicationName: data.medicationName.present
          ? data.medicationName.value
          : this.medicationName,
      dosage: data.dosage.present ? data.dosage.value : this.dosage,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      duration: data.duration.present ? data.duration.value : this.duration,
      notes: data.notes.present ? data.notes.value : this.notes,
      prescribedDate: data.prescribedDate.present
          ? data.prescribedDate.value
          : this.prescribedDate,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicationsTableData(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('treatmentId: $treatmentId, ')
          ..write('dentistId: $dentistId, ')
          ..write('medicationName: $medicationName, ')
          ..write('dosage: $dosage, ')
          ..write('frequency: $frequency, ')
          ..write('duration: $duration, ')
          ..write('notes: $notes, ')
          ..write('prescribedDate: $prescribedDate, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    treatmentId,
    dentistId,
    medicationName,
    dosage,
    frequency,
    duration,
    notes,
    prescribedDate,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicationsTableData &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.treatmentId == this.treatmentId &&
          other.dentistId == this.dentistId &&
          other.medicationName == this.medicationName &&
          other.dosage == this.dosage &&
          other.frequency == this.frequency &&
          other.duration == this.duration &&
          other.notes == this.notes &&
          other.prescribedDate == this.prescribedDate &&
          other.cachedAt == this.cachedAt);
}

class MedicationsTableCompanion extends UpdateCompanion<MedicationsTableData> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String?> treatmentId;
  final Value<String> dentistId;
  final Value<String> medicationName;
  final Value<String?> dosage;
  final Value<String?> frequency;
  final Value<String?> duration;
  final Value<String?> notes;
  final Value<String> prescribedDate;
  final Value<String> cachedAt;
  final Value<int> rowid;
  const MedicationsTableCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.treatmentId = const Value.absent(),
    this.dentistId = const Value.absent(),
    this.medicationName = const Value.absent(),
    this.dosage = const Value.absent(),
    this.frequency = const Value.absent(),
    this.duration = const Value.absent(),
    this.notes = const Value.absent(),
    this.prescribedDate = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MedicationsTableCompanion.insert({
    required String id,
    required String patientId,
    this.treatmentId = const Value.absent(),
    required String dentistId,
    required String medicationName,
    this.dosage = const Value.absent(),
    this.frequency = const Value.absent(),
    this.duration = const Value.absent(),
    this.notes = const Value.absent(),
    required String prescribedDate,
    required String cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId),
       dentistId = Value(dentistId),
       medicationName = Value(medicationName),
       prescribedDate = Value(prescribedDate),
       cachedAt = Value(cachedAt);
  static Insertable<MedicationsTableData> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? treatmentId,
    Expression<String>? dentistId,
    Expression<String>? medicationName,
    Expression<String>? dosage,
    Expression<String>? frequency,
    Expression<String>? duration,
    Expression<String>? notes,
    Expression<String>? prescribedDate,
    Expression<String>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (treatmentId != null) 'treatment_id': treatmentId,
      if (dentistId != null) 'dentist_id': dentistId,
      if (medicationName != null) 'medication_name': medicationName,
      if (dosage != null) 'dosage': dosage,
      if (frequency != null) 'frequency': frequency,
      if (duration != null) 'duration': duration,
      if (notes != null) 'notes': notes,
      if (prescribedDate != null) 'prescribed_date': prescribedDate,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MedicationsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<String?>? treatmentId,
    Value<String>? dentistId,
    Value<String>? medicationName,
    Value<String?>? dosage,
    Value<String?>? frequency,
    Value<String?>? duration,
    Value<String?>? notes,
    Value<String>? prescribedDate,
    Value<String>? cachedAt,
    Value<int>? rowid,
  }) {
    return MedicationsTableCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      treatmentId: treatmentId ?? this.treatmentId,
      dentistId: dentistId ?? this.dentistId,
      medicationName: medicationName ?? this.medicationName,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      duration: duration ?? this.duration,
      notes: notes ?? this.notes,
      prescribedDate: prescribedDate ?? this.prescribedDate,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (treatmentId.present) {
      map['treatment_id'] = Variable<String>(treatmentId.value);
    }
    if (dentistId.present) {
      map['dentist_id'] = Variable<String>(dentistId.value);
    }
    if (medicationName.present) {
      map['medication_name'] = Variable<String>(medicationName.value);
    }
    if (dosage.present) {
      map['dosage'] = Variable<String>(dosage.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (duration.present) {
      map['duration'] = Variable<String>(duration.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (prescribedDate.present) {
      map['prescribed_date'] = Variable<String>(prescribedDate.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<String>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicationsTableCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('treatmentId: $treatmentId, ')
          ..write('dentistId: $dentistId, ')
          ..write('medicationName: $medicationName, ')
          ..write('dosage: $dosage, ')
          ..write('frequency: $frequency, ')
          ..write('duration: $duration, ')
          ..write('notes: $notes, ')
          ..write('prescribedDate: $prescribedDate, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FilesTableTable extends FilesTable
    with TableInfo<$FilesTableTable, FilesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FilesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _treatmentIdMeta = const VerificationMeta(
    'treatmentId',
  );
  @override
  late final GeneratedColumn<String> treatmentId = GeneratedColumn<String>(
    'treatment_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dentistIdMeta = const VerificationMeta(
    'dentistId',
  );
  @override
  late final GeneratedColumn<String> dentistId = GeneratedColumn<String>(
    'dentist_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileTypeMeta = const VerificationMeta(
    'fileType',
  );
  @override
  late final GeneratedColumn<String> fileType = GeneratedColumn<String>(
    'file_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileUrlMeta = const VerificationMeta(
    'fileUrl',
  );
  @override
  late final GeneratedColumn<String> fileUrl = GeneratedColumn<String>(
    'file_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _storagePathMeta = const VerificationMeta(
    'storagePath',
  );
  @override
  late final GeneratedColumn<String> storagePath = GeneratedColumn<String>(
    'storage_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileSizeMeta = const VerificationMeta(
    'fileSize',
  );
  @override
  late final GeneratedColumn<int> fileSize = GeneratedColumn<int>(
    'file_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    defaultValue: const Constant('other'),
  );
  static const VerificationMeta _uploadedAtMeta = const VerificationMeta(
    'uploadedAt',
  );
  @override
  late final GeneratedColumn<String> uploadedAt = GeneratedColumn<String>(
    'uploaded_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<String> cachedAt = GeneratedColumn<String>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    treatmentId,
    dentistId,
    fileName,
    fileType,
    fileUrl,
    storagePath,
    fileSize,
    category,
    uploadedAt,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'files_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<FilesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('treatment_id')) {
      context.handle(
        _treatmentIdMeta,
        treatmentId.isAcceptableOrUnknown(
          data['treatment_id']!,
          _treatmentIdMeta,
        ),
      );
    }
    if (data.containsKey('dentist_id')) {
      context.handle(
        _dentistIdMeta,
        dentistId.isAcceptableOrUnknown(data['dentist_id']!, _dentistIdMeta),
      );
    } else if (isInserting) {
      context.missing(_dentistIdMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('file_type')) {
      context.handle(
        _fileTypeMeta,
        fileType.isAcceptableOrUnknown(data['file_type']!, _fileTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_fileTypeMeta);
    }
    if (data.containsKey('file_url')) {
      context.handle(
        _fileUrlMeta,
        fileUrl.isAcceptableOrUnknown(data['file_url']!, _fileUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_fileUrlMeta);
    }
    if (data.containsKey('storage_path')) {
      context.handle(
        _storagePathMeta,
        storagePath.isAcceptableOrUnknown(
          data['storage_path']!,
          _storagePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_storagePathMeta);
    }
    if (data.containsKey('file_size')) {
      context.handle(
        _fileSizeMeta,
        fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('uploaded_at')) {
      context.handle(
        _uploadedAtMeta,
        uploadedAt.isAcceptableOrUnknown(data['uploaded_at']!, _uploadedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_uploadedAtMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FilesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FilesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      treatmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}treatment_id'],
      ),
      dentistId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dentist_id'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      fileType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_type'],
      )!,
      fileUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_url'],
      )!,
      storagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}storage_path'],
      )!,
      fileSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      uploadedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uploaded_at'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $FilesTableTable createAlias(String alias) {
    return $FilesTableTable(attachedDatabase, alias);
  }
}

class FilesTableData extends DataClass implements Insertable<FilesTableData> {
  final String id;
  final String patientId;
  final String? treatmentId;
  final String dentistId;
  final String fileName;
  final String fileType;
  final String fileUrl;
  final String storagePath;
  final int fileSize;
  final String category;
  final String uploadedAt;
  final String cachedAt;
  const FilesTableData({
    required this.id,
    required this.patientId,
    this.treatmentId,
    required this.dentistId,
    required this.fileName,
    required this.fileType,
    required this.fileUrl,
    required this.storagePath,
    required this.fileSize,
    required this.category,
    required this.uploadedAt,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    if (!nullToAbsent || treatmentId != null) {
      map['treatment_id'] = Variable<String>(treatmentId);
    }
    map['dentist_id'] = Variable<String>(dentistId);
    map['file_name'] = Variable<String>(fileName);
    map['file_type'] = Variable<String>(fileType);
    map['file_url'] = Variable<String>(fileUrl);
    map['storage_path'] = Variable<String>(storagePath);
    map['file_size'] = Variable<int>(fileSize);
    map['category'] = Variable<String>(category);
    map['uploaded_at'] = Variable<String>(uploadedAt);
    map['cached_at'] = Variable<String>(cachedAt);
    return map;
  }

  FilesTableCompanion toCompanion(bool nullToAbsent) {
    return FilesTableCompanion(
      id: Value(id),
      patientId: Value(patientId),
      treatmentId: treatmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(treatmentId),
      dentistId: Value(dentistId),
      fileName: Value(fileName),
      fileType: Value(fileType),
      fileUrl: Value(fileUrl),
      storagePath: Value(storagePath),
      fileSize: Value(fileSize),
      category: Value(category),
      uploadedAt: Value(uploadedAt),
      cachedAt: Value(cachedAt),
    );
  }

  factory FilesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FilesTableData(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      treatmentId: serializer.fromJson<String?>(json['treatmentId']),
      dentistId: serializer.fromJson<String>(json['dentistId']),
      fileName: serializer.fromJson<String>(json['fileName']),
      fileType: serializer.fromJson<String>(json['fileType']),
      fileUrl: serializer.fromJson<String>(json['fileUrl']),
      storagePath: serializer.fromJson<String>(json['storagePath']),
      fileSize: serializer.fromJson<int>(json['fileSize']),
      category: serializer.fromJson<String>(json['category']),
      uploadedAt: serializer.fromJson<String>(json['uploadedAt']),
      cachedAt: serializer.fromJson<String>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'treatmentId': serializer.toJson<String?>(treatmentId),
      'dentistId': serializer.toJson<String>(dentistId),
      'fileName': serializer.toJson<String>(fileName),
      'fileType': serializer.toJson<String>(fileType),
      'fileUrl': serializer.toJson<String>(fileUrl),
      'storagePath': serializer.toJson<String>(storagePath),
      'fileSize': serializer.toJson<int>(fileSize),
      'category': serializer.toJson<String>(category),
      'uploadedAt': serializer.toJson<String>(uploadedAt),
      'cachedAt': serializer.toJson<String>(cachedAt),
    };
  }

  FilesTableData copyWith({
    String? id,
    String? patientId,
    Value<String?> treatmentId = const Value.absent(),
    String? dentistId,
    String? fileName,
    String? fileType,
    String? fileUrl,
    String? storagePath,
    int? fileSize,
    String? category,
    String? uploadedAt,
    String? cachedAt,
  }) => FilesTableData(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    treatmentId: treatmentId.present ? treatmentId.value : this.treatmentId,
    dentistId: dentistId ?? this.dentistId,
    fileName: fileName ?? this.fileName,
    fileType: fileType ?? this.fileType,
    fileUrl: fileUrl ?? this.fileUrl,
    storagePath: storagePath ?? this.storagePath,
    fileSize: fileSize ?? this.fileSize,
    category: category ?? this.category,
    uploadedAt: uploadedAt ?? this.uploadedAt,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  FilesTableData copyWithCompanion(FilesTableCompanion data) {
    return FilesTableData(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      treatmentId: data.treatmentId.present
          ? data.treatmentId.value
          : this.treatmentId,
      dentistId: data.dentistId.present ? data.dentistId.value : this.dentistId,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      fileType: data.fileType.present ? data.fileType.value : this.fileType,
      fileUrl: data.fileUrl.present ? data.fileUrl.value : this.fileUrl,
      storagePath: data.storagePath.present
          ? data.storagePath.value
          : this.storagePath,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
      category: data.category.present ? data.category.value : this.category,
      uploadedAt: data.uploadedAt.present
          ? data.uploadedAt.value
          : this.uploadedAt,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FilesTableData(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('treatmentId: $treatmentId, ')
          ..write('dentistId: $dentistId, ')
          ..write('fileName: $fileName, ')
          ..write('fileType: $fileType, ')
          ..write('fileUrl: $fileUrl, ')
          ..write('storagePath: $storagePath, ')
          ..write('fileSize: $fileSize, ')
          ..write('category: $category, ')
          ..write('uploadedAt: $uploadedAt, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    treatmentId,
    dentistId,
    fileName,
    fileType,
    fileUrl,
    storagePath,
    fileSize,
    category,
    uploadedAt,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FilesTableData &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.treatmentId == this.treatmentId &&
          other.dentistId == this.dentistId &&
          other.fileName == this.fileName &&
          other.fileType == this.fileType &&
          other.fileUrl == this.fileUrl &&
          other.storagePath == this.storagePath &&
          other.fileSize == this.fileSize &&
          other.category == this.category &&
          other.uploadedAt == this.uploadedAt &&
          other.cachedAt == this.cachedAt);
}

class FilesTableCompanion extends UpdateCompanion<FilesTableData> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String?> treatmentId;
  final Value<String> dentistId;
  final Value<String> fileName;
  final Value<String> fileType;
  final Value<String> fileUrl;
  final Value<String> storagePath;
  final Value<int> fileSize;
  final Value<String> category;
  final Value<String> uploadedAt;
  final Value<String> cachedAt;
  final Value<int> rowid;
  const FilesTableCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.treatmentId = const Value.absent(),
    this.dentistId = const Value.absent(),
    this.fileName = const Value.absent(),
    this.fileType = const Value.absent(),
    this.fileUrl = const Value.absent(),
    this.storagePath = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.category = const Value.absent(),
    this.uploadedAt = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FilesTableCompanion.insert({
    required String id,
    required String patientId,
    this.treatmentId = const Value.absent(),
    required String dentistId,
    required String fileName,
    required String fileType,
    required String fileUrl,
    required String storagePath,
    this.fileSize = const Value.absent(),
    this.category = const Value.absent(),
    required String uploadedAt,
    required String cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId),
       dentistId = Value(dentistId),
       fileName = Value(fileName),
       fileType = Value(fileType),
       fileUrl = Value(fileUrl),
       storagePath = Value(storagePath),
       uploadedAt = Value(uploadedAt),
       cachedAt = Value(cachedAt);
  static Insertable<FilesTableData> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? treatmentId,
    Expression<String>? dentistId,
    Expression<String>? fileName,
    Expression<String>? fileType,
    Expression<String>? fileUrl,
    Expression<String>? storagePath,
    Expression<int>? fileSize,
    Expression<String>? category,
    Expression<String>? uploadedAt,
    Expression<String>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (treatmentId != null) 'treatment_id': treatmentId,
      if (dentistId != null) 'dentist_id': dentistId,
      if (fileName != null) 'file_name': fileName,
      if (fileType != null) 'file_type': fileType,
      if (fileUrl != null) 'file_url': fileUrl,
      if (storagePath != null) 'storage_path': storagePath,
      if (fileSize != null) 'file_size': fileSize,
      if (category != null) 'category': category,
      if (uploadedAt != null) 'uploaded_at': uploadedAt,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FilesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<String?>? treatmentId,
    Value<String>? dentistId,
    Value<String>? fileName,
    Value<String>? fileType,
    Value<String>? fileUrl,
    Value<String>? storagePath,
    Value<int>? fileSize,
    Value<String>? category,
    Value<String>? uploadedAt,
    Value<String>? cachedAt,
    Value<int>? rowid,
  }) {
    return FilesTableCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      treatmentId: treatmentId ?? this.treatmentId,
      dentistId: dentistId ?? this.dentistId,
      fileName: fileName ?? this.fileName,
      fileType: fileType ?? this.fileType,
      fileUrl: fileUrl ?? this.fileUrl,
      storagePath: storagePath ?? this.storagePath,
      fileSize: fileSize ?? this.fileSize,
      category: category ?? this.category,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (treatmentId.present) {
      map['treatment_id'] = Variable<String>(treatmentId.value);
    }
    if (dentistId.present) {
      map['dentist_id'] = Variable<String>(dentistId.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (fileType.present) {
      map['file_type'] = Variable<String>(fileType.value);
    }
    if (fileUrl.present) {
      map['file_url'] = Variable<String>(fileUrl.value);
    }
    if (storagePath.present) {
      map['storage_path'] = Variable<String>(storagePath.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (uploadedAt.present) {
      map['uploaded_at'] = Variable<String>(uploadedAt.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<String>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FilesTableCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('treatmentId: $treatmentId, ')
          ..write('dentistId: $dentistId, ')
          ..write('fileName: $fileName, ')
          ..write('fileType: $fileType, ')
          ..write('fileUrl: $fileUrl, ')
          ..write('storagePath: $storagePath, ')
          ..write('fileSize: $fileSize, ')
          ..write('category: $category, ')
          ..write('uploadedAt: $uploadedAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTableTable extends SyncQueueTable
    with TableInfo<$SyncQueueTableTable, SyncQueueTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _recordUuidMeta = const VerificationMeta(
    'recordUuid',
  );
  @override
  late final GeneratedColumn<String> recordUuid = GeneratedColumn<String>(
    'record_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetTableMeta = const VerificationMeta(
    'targetTable',
  );
  @override
  late final GeneratedColumn<String> targetTable = GeneratedColumn<String>(
    'target_table',
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
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recordUuid,
    targetTable,
    action,
    payload,
    createdAt,
    retryCount,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('record_uuid')) {
      context.handle(
        _recordUuidMeta,
        recordUuid.isAcceptableOrUnknown(data['record_uuid']!, _recordUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_recordUuidMeta);
    }
    if (data.containsKey('target_table')) {
      context.handle(
        _targetTableMeta,
        targetTable.isAcceptableOrUnknown(
          data['target_table']!,
          _targetTableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetTableMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recordUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_uuid'],
      )!,
      targetTable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_table'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $SyncQueueTableTable createAlias(String alias) {
    return $SyncQueueTableTable(attachedDatabase, alias);
  }
}

class SyncQueueTableData extends DataClass
    implements Insertable<SyncQueueTableData> {
  final int id;
  final String recordUuid;
  final String targetTable;
  final String action;
  final String payload;
  final String createdAt;
  final int retryCount;
  final String? lastError;
  const SyncQueueTableData({
    required this.id,
    required this.recordUuid,
    required this.targetTable,
    required this.action,
    required this.payload,
    required this.createdAt,
    required this.retryCount,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['record_uuid'] = Variable<String>(recordUuid);
    map['target_table'] = Variable<String>(targetTable);
    map['action'] = Variable<String>(action);
    map['payload'] = Variable<String>(payload);
    map['created_at'] = Variable<String>(createdAt);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  SyncQueueTableCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueTableCompanion(
      id: Value(id),
      recordUuid: Value(recordUuid),
      targetTable: Value(targetTable),
      action: Value(action),
      payload: Value(payload),
      createdAt: Value(createdAt),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory SyncQueueTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueTableData(
      id: serializer.fromJson<int>(json['id']),
      recordUuid: serializer.fromJson<String>(json['recordUuid']),
      targetTable: serializer.fromJson<String>(json['targetTable']),
      action: serializer.fromJson<String>(json['action']),
      payload: serializer.fromJson<String>(json['payload']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recordUuid': serializer.toJson<String>(recordUuid),
      'targetTable': serializer.toJson<String>(targetTable),
      'action': serializer.toJson<String>(action),
      'payload': serializer.toJson<String>(payload),
      'createdAt': serializer.toJson<String>(createdAt),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  SyncQueueTableData copyWith({
    int? id,
    String? recordUuid,
    String? targetTable,
    String? action,
    String? payload,
    String? createdAt,
    int? retryCount,
    Value<String?> lastError = const Value.absent(),
  }) => SyncQueueTableData(
    id: id ?? this.id,
    recordUuid: recordUuid ?? this.recordUuid,
    targetTable: targetTable ?? this.targetTable,
    action: action ?? this.action,
    payload: payload ?? this.payload,
    createdAt: createdAt ?? this.createdAt,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  SyncQueueTableData copyWithCompanion(SyncQueueTableCompanion data) {
    return SyncQueueTableData(
      id: data.id.present ? data.id.value : this.id,
      recordUuid: data.recordUuid.present
          ? data.recordUuid.value
          : this.recordUuid,
      targetTable: data.targetTable.present
          ? data.targetTable.value
          : this.targetTable,
      action: data.action.present ? data.action.value : this.action,
      payload: data.payload.present ? data.payload.value : this.payload,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableData(')
          ..write('id: $id, ')
          ..write('recordUuid: $recordUuid, ')
          ..write('targetTable: $targetTable, ')
          ..write('action: $action, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recordUuid,
    targetTable,
    action,
    payload,
    createdAt,
    retryCount,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueTableData &&
          other.id == this.id &&
          other.recordUuid == this.recordUuid &&
          other.targetTable == this.targetTable &&
          other.action == this.action &&
          other.payload == this.payload &&
          other.createdAt == this.createdAt &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError);
}

class SyncQueueTableCompanion extends UpdateCompanion<SyncQueueTableData> {
  final Value<int> id;
  final Value<String> recordUuid;
  final Value<String> targetTable;
  final Value<String> action;
  final Value<String> payload;
  final Value<String> createdAt;
  final Value<int> retryCount;
  final Value<String?> lastError;
  const SyncQueueTableCompanion({
    this.id = const Value.absent(),
    this.recordUuid = const Value.absent(),
    this.targetTable = const Value.absent(),
    this.action = const Value.absent(),
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
  });
  SyncQueueTableCompanion.insert({
    this.id = const Value.absent(),
    required String recordUuid,
    required String targetTable,
    required String action,
    required String payload,
    required String createdAt,
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
  }) : recordUuid = Value(recordUuid),
       targetTable = Value(targetTable),
       action = Value(action),
       payload = Value(payload),
       createdAt = Value(createdAt);
  static Insertable<SyncQueueTableData> custom({
    Expression<int>? id,
    Expression<String>? recordUuid,
    Expression<String>? targetTable,
    Expression<String>? action,
    Expression<String>? payload,
    Expression<String>? createdAt,
    Expression<int>? retryCount,
    Expression<String>? lastError,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recordUuid != null) 'record_uuid': recordUuid,
      if (targetTable != null) 'target_table': targetTable,
      if (action != null) 'action': action,
      if (payload != null) 'payload': payload,
      if (createdAt != null) 'created_at': createdAt,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
    });
  }

  SyncQueueTableCompanion copyWith({
    Value<int>? id,
    Value<String>? recordUuid,
    Value<String>? targetTable,
    Value<String>? action,
    Value<String>? payload,
    Value<String>? createdAt,
    Value<int>? retryCount,
    Value<String?>? lastError,
  }) {
    return SyncQueueTableCompanion(
      id: id ?? this.id,
      recordUuid: recordUuid ?? this.recordUuid,
      targetTable: targetTable ?? this.targetTable,
      action: action ?? this.action,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recordUuid.present) {
      map['record_uuid'] = Variable<String>(recordUuid.value);
    }
    if (targetTable.present) {
      map['target_table'] = Variable<String>(targetTable.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableCompanion(')
          ..write('id: $id, ')
          ..write('recordUuid: $recordUuid, ')
          ..write('targetTable: $targetTable, ')
          ..write('action: $action, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final $ProfilesTableTable profilesTable = $ProfilesTableTable(this);
  late final $PatientsTableTable patientsTable = $PatientsTableTable(this);
  late final $TreatmentsTableTable treatmentsTable = $TreatmentsTableTable(
    this,
  );
  late final $PaymentsTableTable paymentsTable = $PaymentsTableTable(this);
  late final $AppointmentsTableTable appointmentsTable =
      $AppointmentsTableTable(this);
  late final $MedicationsTableTable medicationsTable = $MedicationsTableTable(
    this,
  );
  late final $FilesTableTable filesTable = $FilesTableTable(this);
  late final $SyncQueueTableTable syncQueueTable = $SyncQueueTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profilesTable,
    patientsTable,
    treatmentsTable,
    paymentsTable,
    appointmentsTable,
    medicationsTable,
    filesTable,
    syncQueueTable,
  ];
}

typedef $$ProfilesTableTableCreateCompanionBuilder =
    ProfilesTableCompanion Function({
      required String id,
      required String dentistId,
      required String fullName,
      Value<String?> email,
      Value<String?> phone,
      Value<double> revenuePercentage,
      Value<String> preferredLanguage,
      required String cachedAt,
      Value<int> rowid,
    });
typedef $$ProfilesTableTableUpdateCompanionBuilder =
    ProfilesTableCompanion Function({
      Value<String> id,
      Value<String> dentistId,
      Value<String> fullName,
      Value<String?> email,
      Value<String?> phone,
      Value<double> revenuePercentage,
      Value<String> preferredLanguage,
      Value<String> cachedAt,
      Value<int> rowid,
    });

class $$ProfilesTableTableFilterComposer
    extends Composer<_$LocalDatabase, $ProfilesTableTable> {
  $$ProfilesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dentistId => $composableBuilder(
    column: $table.dentistId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get revenuePercentage => $composableBuilder(
    column: $table.revenuePercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferredLanguage => $composableBuilder(
    column: $table.preferredLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfilesTableTableOrderingComposer
    extends Composer<_$LocalDatabase, $ProfilesTableTable> {
  $$ProfilesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dentistId => $composableBuilder(
    column: $table.dentistId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get revenuePercentage => $composableBuilder(
    column: $table.revenuePercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredLanguage => $composableBuilder(
    column: $table.preferredLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfilesTableTableAnnotationComposer
    extends Composer<_$LocalDatabase, $ProfilesTableTable> {
  $$ProfilesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dentistId =>
      $composableBuilder(column: $table.dentistId, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<double> get revenuePercentage => $composableBuilder(
    column: $table.revenuePercentage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preferredLanguage => $composableBuilder(
    column: $table.preferredLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$ProfilesTableTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $ProfilesTableTable,
          ProfilesTableData,
          $$ProfilesTableTableFilterComposer,
          $$ProfilesTableTableOrderingComposer,
          $$ProfilesTableTableAnnotationComposer,
          $$ProfilesTableTableCreateCompanionBuilder,
          $$ProfilesTableTableUpdateCompanionBuilder,
          (
            ProfilesTableData,
            BaseReferences<
              _$LocalDatabase,
              $ProfilesTableTable,
              ProfilesTableData
            >,
          ),
          ProfilesTableData,
          PrefetchHooks Function()
        > {
  $$ProfilesTableTableTableManager(
    _$LocalDatabase db,
    $ProfilesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> dentistId = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<double> revenuePercentage = const Value.absent(),
                Value<String> preferredLanguage = const Value.absent(),
                Value<String> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesTableCompanion(
                id: id,
                dentistId: dentistId,
                fullName: fullName,
                email: email,
                phone: phone,
                revenuePercentage: revenuePercentage,
                preferredLanguage: preferredLanguage,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String dentistId,
                required String fullName,
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<double> revenuePercentage = const Value.absent(),
                Value<String> preferredLanguage = const Value.absent(),
                required String cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => ProfilesTableCompanion.insert(
                id: id,
                dentistId: dentistId,
                fullName: fullName,
                email: email,
                phone: phone,
                revenuePercentage: revenuePercentage,
                preferredLanguage: preferredLanguage,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfilesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $ProfilesTableTable,
      ProfilesTableData,
      $$ProfilesTableTableFilterComposer,
      $$ProfilesTableTableOrderingComposer,
      $$ProfilesTableTableAnnotationComposer,
      $$ProfilesTableTableCreateCompanionBuilder,
      $$ProfilesTableTableUpdateCompanionBuilder,
      (
        ProfilesTableData,
        BaseReferences<_$LocalDatabase, $ProfilesTableTable, ProfilesTableData>,
      ),
      ProfilesTableData,
      PrefetchHooks Function()
    >;
typedef $$PatientsTableTableCreateCompanionBuilder =
    PatientsTableCompanion Function({
      required String id,
      required String dentistId,
      required String fullName,
      required String phone,
      Value<int?> age,
      Value<String?> medicalStatus,
      Value<String?> condition,
      Value<String?> notes,
      Value<bool> isDeleted,
      required String createdAt,
      required String updatedAt,
      required String cachedAt,
      Value<int> rowid,
    });
typedef $$PatientsTableTableUpdateCompanionBuilder =
    PatientsTableCompanion Function({
      Value<String> id,
      Value<String> dentistId,
      Value<String> fullName,
      Value<String> phone,
      Value<int?> age,
      Value<String?> medicalStatus,
      Value<String?> condition,
      Value<String?> notes,
      Value<bool> isDeleted,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String> cachedAt,
      Value<int> rowid,
    });

class $$PatientsTableTableFilterComposer
    extends Composer<_$LocalDatabase, $PatientsTableTable> {
  $$PatientsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dentistId => $composableBuilder(
    column: $table.dentistId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get medicalStatus => $composableBuilder(
    column: $table.medicalStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PatientsTableTableOrderingComposer
    extends Composer<_$LocalDatabase, $PatientsTableTable> {
  $$PatientsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dentistId => $composableBuilder(
    column: $table.dentistId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get medicalStatus => $composableBuilder(
    column: $table.medicalStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PatientsTableTableAnnotationComposer
    extends Composer<_$LocalDatabase, $PatientsTableTable> {
  $$PatientsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dentistId =>
      $composableBuilder(column: $table.dentistId, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get medicalStatus => $composableBuilder(
    column: $table.medicalStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get condition =>
      $composableBuilder(column: $table.condition, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$PatientsTableTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $PatientsTableTable,
          PatientsTableData,
          $$PatientsTableTableFilterComposer,
          $$PatientsTableTableOrderingComposer,
          $$PatientsTableTableAnnotationComposer,
          $$PatientsTableTableCreateCompanionBuilder,
          $$PatientsTableTableUpdateCompanionBuilder,
          (
            PatientsTableData,
            BaseReferences<
              _$LocalDatabase,
              $PatientsTableTable,
              PatientsTableData
            >,
          ),
          PatientsTableData,
          PrefetchHooks Function()
        > {
  $$PatientsTableTableTableManager(
    _$LocalDatabase db,
    $PatientsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PatientsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PatientsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PatientsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> dentistId = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<int?> age = const Value.absent(),
                Value<String?> medicalStatus = const Value.absent(),
                Value<String?> condition = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PatientsTableCompanion(
                id: id,
                dentistId: dentistId,
                fullName: fullName,
                phone: phone,
                age: age,
                medicalStatus: medicalStatus,
                condition: condition,
                notes: notes,
                isDeleted: isDeleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String dentistId,
                required String fullName,
                required String phone,
                Value<int?> age = const Value.absent(),
                Value<String?> medicalStatus = const Value.absent(),
                Value<String?> condition = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                required String cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => PatientsTableCompanion.insert(
                id: id,
                dentistId: dentistId,
                fullName: fullName,
                phone: phone,
                age: age,
                medicalStatus: medicalStatus,
                condition: condition,
                notes: notes,
                isDeleted: isDeleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PatientsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $PatientsTableTable,
      PatientsTableData,
      $$PatientsTableTableFilterComposer,
      $$PatientsTableTableOrderingComposer,
      $$PatientsTableTableAnnotationComposer,
      $$PatientsTableTableCreateCompanionBuilder,
      $$PatientsTableTableUpdateCompanionBuilder,
      (
        PatientsTableData,
        BaseReferences<_$LocalDatabase, $PatientsTableTable, PatientsTableData>,
      ),
      PatientsTableData,
      PrefetchHooks Function()
    >;
typedef $$TreatmentsTableTableCreateCompanionBuilder =
    TreatmentsTableCompanion Function({
      required String id,
      required String patientId,
      required String dentistId,
      required String procedureType,
      Value<String> toothNumbers,
      Value<String?> description,
      Value<String?> treatmentNotes,
      Value<double> totalCost,
      Value<double> technicianCost,
      Value<double> amountPaid,
      Value<String> status,
      required String treatmentDate,
      required String createdAt,
      Value<String?> patientName,
      required String cachedAt,
      Value<int> rowid,
    });
typedef $$TreatmentsTableTableUpdateCompanionBuilder =
    TreatmentsTableCompanion Function({
      Value<String> id,
      Value<String> patientId,
      Value<String> dentistId,
      Value<String> procedureType,
      Value<String> toothNumbers,
      Value<String?> description,
      Value<String?> treatmentNotes,
      Value<double> totalCost,
      Value<double> technicianCost,
      Value<double> amountPaid,
      Value<String> status,
      Value<String> treatmentDate,
      Value<String> createdAt,
      Value<String?> patientName,
      Value<String> cachedAt,
      Value<int> rowid,
    });

class $$TreatmentsTableTableFilterComposer
    extends Composer<_$LocalDatabase, $TreatmentsTableTable> {
  $$TreatmentsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dentistId => $composableBuilder(
    column: $table.dentistId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get procedureType => $composableBuilder(
    column: $table.procedureType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toothNumbers => $composableBuilder(
    column: $table.toothNumbers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get treatmentNotes => $composableBuilder(
    column: $table.treatmentNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get technicianCost => $composableBuilder(
    column: $table.technicianCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get treatmentDate => $composableBuilder(
    column: $table.treatmentDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientName => $composableBuilder(
    column: $table.patientName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TreatmentsTableTableOrderingComposer
    extends Composer<_$LocalDatabase, $TreatmentsTableTable> {
  $$TreatmentsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dentistId => $composableBuilder(
    column: $table.dentistId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get procedureType => $composableBuilder(
    column: $table.procedureType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toothNumbers => $composableBuilder(
    column: $table.toothNumbers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get treatmentNotes => $composableBuilder(
    column: $table.treatmentNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get technicianCost => $composableBuilder(
    column: $table.technicianCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get treatmentDate => $composableBuilder(
    column: $table.treatmentDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientName => $composableBuilder(
    column: $table.patientName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TreatmentsTableTableAnnotationComposer
    extends Composer<_$LocalDatabase, $TreatmentsTableTable> {
  $$TreatmentsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get dentistId =>
      $composableBuilder(column: $table.dentistId, builder: (column) => column);

  GeneratedColumn<String> get procedureType => $composableBuilder(
    column: $table.procedureType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get toothNumbers => $composableBuilder(
    column: $table.toothNumbers,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get treatmentNotes => $composableBuilder(
    column: $table.treatmentNotes,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalCost =>
      $composableBuilder(column: $table.totalCost, builder: (column) => column);

  GeneratedColumn<double> get technicianCost => $composableBuilder(
    column: $table.technicianCost,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get treatmentDate => $composableBuilder(
    column: $table.treatmentDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get patientName => $composableBuilder(
    column: $table.patientName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$TreatmentsTableTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $TreatmentsTableTable,
          TreatmentsTableData,
          $$TreatmentsTableTableFilterComposer,
          $$TreatmentsTableTableOrderingComposer,
          $$TreatmentsTableTableAnnotationComposer,
          $$TreatmentsTableTableCreateCompanionBuilder,
          $$TreatmentsTableTableUpdateCompanionBuilder,
          (
            TreatmentsTableData,
            BaseReferences<
              _$LocalDatabase,
              $TreatmentsTableTable,
              TreatmentsTableData
            >,
          ),
          TreatmentsTableData,
          PrefetchHooks Function()
        > {
  $$TreatmentsTableTableTableManager(
    _$LocalDatabase db,
    $TreatmentsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TreatmentsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TreatmentsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TreatmentsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String> dentistId = const Value.absent(),
                Value<String> procedureType = const Value.absent(),
                Value<String> toothNumbers = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> treatmentNotes = const Value.absent(),
                Value<double> totalCost = const Value.absent(),
                Value<double> technicianCost = const Value.absent(),
                Value<double> amountPaid = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> treatmentDate = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String?> patientName = const Value.absent(),
                Value<String> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TreatmentsTableCompanion(
                id: id,
                patientId: patientId,
                dentistId: dentistId,
                procedureType: procedureType,
                toothNumbers: toothNumbers,
                description: description,
                treatmentNotes: treatmentNotes,
                totalCost: totalCost,
                technicianCost: technicianCost,
                amountPaid: amountPaid,
                status: status,
                treatmentDate: treatmentDate,
                createdAt: createdAt,
                patientName: patientName,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                required String dentistId,
                required String procedureType,
                Value<String> toothNumbers = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> treatmentNotes = const Value.absent(),
                Value<double> totalCost = const Value.absent(),
                Value<double> technicianCost = const Value.absent(),
                Value<double> amountPaid = const Value.absent(),
                Value<String> status = const Value.absent(),
                required String treatmentDate,
                required String createdAt,
                Value<String?> patientName = const Value.absent(),
                required String cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => TreatmentsTableCompanion.insert(
                id: id,
                patientId: patientId,
                dentistId: dentistId,
                procedureType: procedureType,
                toothNumbers: toothNumbers,
                description: description,
                treatmentNotes: treatmentNotes,
                totalCost: totalCost,
                technicianCost: technicianCost,
                amountPaid: amountPaid,
                status: status,
                treatmentDate: treatmentDate,
                createdAt: createdAt,
                patientName: patientName,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TreatmentsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $TreatmentsTableTable,
      TreatmentsTableData,
      $$TreatmentsTableTableFilterComposer,
      $$TreatmentsTableTableOrderingComposer,
      $$TreatmentsTableTableAnnotationComposer,
      $$TreatmentsTableTableCreateCompanionBuilder,
      $$TreatmentsTableTableUpdateCompanionBuilder,
      (
        TreatmentsTableData,
        BaseReferences<
          _$LocalDatabase,
          $TreatmentsTableTable,
          TreatmentsTableData
        >,
      ),
      TreatmentsTableData,
      PrefetchHooks Function()
    >;
typedef $$PaymentsTableTableCreateCompanionBuilder =
    PaymentsTableCompanion Function({
      required String id,
      required String treatmentId,
      required String dentistId,
      required double amount,
      Value<String> paymentMethod,
      Value<String?> notes,
      required String paymentDate,
      required String cachedAt,
      Value<int> rowid,
    });
typedef $$PaymentsTableTableUpdateCompanionBuilder =
    PaymentsTableCompanion Function({
      Value<String> id,
      Value<String> treatmentId,
      Value<String> dentistId,
      Value<double> amount,
      Value<String> paymentMethod,
      Value<String?> notes,
      Value<String> paymentDate,
      Value<String> cachedAt,
      Value<int> rowid,
    });

class $$PaymentsTableTableFilterComposer
    extends Composer<_$LocalDatabase, $PaymentsTableTable> {
  $$PaymentsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get treatmentId => $composableBuilder(
    column: $table.treatmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dentistId => $composableBuilder(
    column: $table.dentistId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PaymentsTableTableOrderingComposer
    extends Composer<_$LocalDatabase, $PaymentsTableTable> {
  $$PaymentsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get treatmentId => $composableBuilder(
    column: $table.treatmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dentistId => $composableBuilder(
    column: $table.dentistId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PaymentsTableTableAnnotationComposer
    extends Composer<_$LocalDatabase, $PaymentsTableTable> {
  $$PaymentsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get treatmentId => $composableBuilder(
    column: $table.treatmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dentistId =>
      $composableBuilder(column: $table.dentistId, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$PaymentsTableTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $PaymentsTableTable,
          PaymentsTableData,
          $$PaymentsTableTableFilterComposer,
          $$PaymentsTableTableOrderingComposer,
          $$PaymentsTableTableAnnotationComposer,
          $$PaymentsTableTableCreateCompanionBuilder,
          $$PaymentsTableTableUpdateCompanionBuilder,
          (
            PaymentsTableData,
            BaseReferences<
              _$LocalDatabase,
              $PaymentsTableTable,
              PaymentsTableData
            >,
          ),
          PaymentsTableData,
          PrefetchHooks Function()
        > {
  $$PaymentsTableTableTableManager(
    _$LocalDatabase db,
    $PaymentsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> treatmentId = const Value.absent(),
                Value<String> dentistId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> paymentDate = const Value.absent(),
                Value<String> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsTableCompanion(
                id: id,
                treatmentId: treatmentId,
                dentistId: dentistId,
                amount: amount,
                paymentMethod: paymentMethod,
                notes: notes,
                paymentDate: paymentDate,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String treatmentId,
                required String dentistId,
                required double amount,
                Value<String> paymentMethod = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required String paymentDate,
                required String cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => PaymentsTableCompanion.insert(
                id: id,
                treatmentId: treatmentId,
                dentistId: dentistId,
                amount: amount,
                paymentMethod: paymentMethod,
                notes: notes,
                paymentDate: paymentDate,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PaymentsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $PaymentsTableTable,
      PaymentsTableData,
      $$PaymentsTableTableFilterComposer,
      $$PaymentsTableTableOrderingComposer,
      $$PaymentsTableTableAnnotationComposer,
      $$PaymentsTableTableCreateCompanionBuilder,
      $$PaymentsTableTableUpdateCompanionBuilder,
      (
        PaymentsTableData,
        BaseReferences<_$LocalDatabase, $PaymentsTableTable, PaymentsTableData>,
      ),
      PaymentsTableData,
      PrefetchHooks Function()
    >;
typedef $$AppointmentsTableTableCreateCompanionBuilder =
    AppointmentsTableCompanion Function({
      required String id,
      required String patientId,
      required String dentistId,
      Value<String?> treatmentId,
      required String appointmentDate,
      Value<String> status,
      Value<String?> notes,
      Value<String?> patientName,
      Value<String?> patientPhone,
      required String createdAt,
      required String cachedAt,
      Value<int> rowid,
    });
typedef $$AppointmentsTableTableUpdateCompanionBuilder =
    AppointmentsTableCompanion Function({
      Value<String> id,
      Value<String> patientId,
      Value<String> dentistId,
      Value<String?> treatmentId,
      Value<String> appointmentDate,
      Value<String> status,
      Value<String?> notes,
      Value<String?> patientName,
      Value<String?> patientPhone,
      Value<String> createdAt,
      Value<String> cachedAt,
      Value<int> rowid,
    });

class $$AppointmentsTableTableFilterComposer
    extends Composer<_$LocalDatabase, $AppointmentsTableTable> {
  $$AppointmentsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dentistId => $composableBuilder(
    column: $table.dentistId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get treatmentId => $composableBuilder(
    column: $table.treatmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appointmentDate => $composableBuilder(
    column: $table.appointmentDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientName => $composableBuilder(
    column: $table.patientName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientPhone => $composableBuilder(
    column: $table.patientPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppointmentsTableTableOrderingComposer
    extends Composer<_$LocalDatabase, $AppointmentsTableTable> {
  $$AppointmentsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dentistId => $composableBuilder(
    column: $table.dentistId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get treatmentId => $composableBuilder(
    column: $table.treatmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appointmentDate => $composableBuilder(
    column: $table.appointmentDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientName => $composableBuilder(
    column: $table.patientName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientPhone => $composableBuilder(
    column: $table.patientPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppointmentsTableTableAnnotationComposer
    extends Composer<_$LocalDatabase, $AppointmentsTableTable> {
  $$AppointmentsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get dentistId =>
      $composableBuilder(column: $table.dentistId, builder: (column) => column);

  GeneratedColumn<String> get treatmentId => $composableBuilder(
    column: $table.treatmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get appointmentDate => $composableBuilder(
    column: $table.appointmentDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get patientName => $composableBuilder(
    column: $table.patientName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get patientPhone => $composableBuilder(
    column: $table.patientPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$AppointmentsTableTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $AppointmentsTableTable,
          AppointmentsTableData,
          $$AppointmentsTableTableFilterComposer,
          $$AppointmentsTableTableOrderingComposer,
          $$AppointmentsTableTableAnnotationComposer,
          $$AppointmentsTableTableCreateCompanionBuilder,
          $$AppointmentsTableTableUpdateCompanionBuilder,
          (
            AppointmentsTableData,
            BaseReferences<
              _$LocalDatabase,
              $AppointmentsTableTable,
              AppointmentsTableData
            >,
          ),
          AppointmentsTableData,
          PrefetchHooks Function()
        > {
  $$AppointmentsTableTableTableManager(
    _$LocalDatabase db,
    $AppointmentsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppointmentsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppointmentsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppointmentsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String> dentistId = const Value.absent(),
                Value<String?> treatmentId = const Value.absent(),
                Value<String> appointmentDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> patientName = const Value.absent(),
                Value<String?> patientPhone = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppointmentsTableCompanion(
                id: id,
                patientId: patientId,
                dentistId: dentistId,
                treatmentId: treatmentId,
                appointmentDate: appointmentDate,
                status: status,
                notes: notes,
                patientName: patientName,
                patientPhone: patientPhone,
                createdAt: createdAt,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                required String dentistId,
                Value<String?> treatmentId = const Value.absent(),
                required String appointmentDate,
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> patientName = const Value.absent(),
                Value<String?> patientPhone = const Value.absent(),
                required String createdAt,
                required String cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => AppointmentsTableCompanion.insert(
                id: id,
                patientId: patientId,
                dentistId: dentistId,
                treatmentId: treatmentId,
                appointmentDate: appointmentDate,
                status: status,
                notes: notes,
                patientName: patientName,
                patientPhone: patientPhone,
                createdAt: createdAt,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppointmentsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $AppointmentsTableTable,
      AppointmentsTableData,
      $$AppointmentsTableTableFilterComposer,
      $$AppointmentsTableTableOrderingComposer,
      $$AppointmentsTableTableAnnotationComposer,
      $$AppointmentsTableTableCreateCompanionBuilder,
      $$AppointmentsTableTableUpdateCompanionBuilder,
      (
        AppointmentsTableData,
        BaseReferences<
          _$LocalDatabase,
          $AppointmentsTableTable,
          AppointmentsTableData
        >,
      ),
      AppointmentsTableData,
      PrefetchHooks Function()
    >;
typedef $$MedicationsTableTableCreateCompanionBuilder =
    MedicationsTableCompanion Function({
      required String id,
      required String patientId,
      Value<String?> treatmentId,
      required String dentistId,
      required String medicationName,
      Value<String?> dosage,
      Value<String?> frequency,
      Value<String?> duration,
      Value<String?> notes,
      required String prescribedDate,
      required String cachedAt,
      Value<int> rowid,
    });
typedef $$MedicationsTableTableUpdateCompanionBuilder =
    MedicationsTableCompanion Function({
      Value<String> id,
      Value<String> patientId,
      Value<String?> treatmentId,
      Value<String> dentistId,
      Value<String> medicationName,
      Value<String?> dosage,
      Value<String?> frequency,
      Value<String?> duration,
      Value<String?> notes,
      Value<String> prescribedDate,
      Value<String> cachedAt,
      Value<int> rowid,
    });

class $$MedicationsTableTableFilterComposer
    extends Composer<_$LocalDatabase, $MedicationsTableTable> {
  $$MedicationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get treatmentId => $composableBuilder(
    column: $table.treatmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dentistId => $composableBuilder(
    column: $table.dentistId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get medicationName => $composableBuilder(
    column: $table.medicationName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dosage => $composableBuilder(
    column: $table.dosage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prescribedDate => $composableBuilder(
    column: $table.prescribedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MedicationsTableTableOrderingComposer
    extends Composer<_$LocalDatabase, $MedicationsTableTable> {
  $$MedicationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get treatmentId => $composableBuilder(
    column: $table.treatmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dentistId => $composableBuilder(
    column: $table.dentistId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get medicationName => $composableBuilder(
    column: $table.medicationName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dosage => $composableBuilder(
    column: $table.dosage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prescribedDate => $composableBuilder(
    column: $table.prescribedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MedicationsTableTableAnnotationComposer
    extends Composer<_$LocalDatabase, $MedicationsTableTable> {
  $$MedicationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get treatmentId => $composableBuilder(
    column: $table.treatmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dentistId =>
      $composableBuilder(column: $table.dentistId, builder: (column) => column);

  GeneratedColumn<String> get medicationName => $composableBuilder(
    column: $table.medicationName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dosage =>
      $composableBuilder(column: $table.dosage, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<String> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get prescribedDate => $composableBuilder(
    column: $table.prescribedDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$MedicationsTableTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $MedicationsTableTable,
          MedicationsTableData,
          $$MedicationsTableTableFilterComposer,
          $$MedicationsTableTableOrderingComposer,
          $$MedicationsTableTableAnnotationComposer,
          $$MedicationsTableTableCreateCompanionBuilder,
          $$MedicationsTableTableUpdateCompanionBuilder,
          (
            MedicationsTableData,
            BaseReferences<
              _$LocalDatabase,
              $MedicationsTableTable,
              MedicationsTableData
            >,
          ),
          MedicationsTableData,
          PrefetchHooks Function()
        > {
  $$MedicationsTableTableTableManager(
    _$LocalDatabase db,
    $MedicationsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicationsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicationsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicationsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String?> treatmentId = const Value.absent(),
                Value<String> dentistId = const Value.absent(),
                Value<String> medicationName = const Value.absent(),
                Value<String?> dosage = const Value.absent(),
                Value<String?> frequency = const Value.absent(),
                Value<String?> duration = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> prescribedDate = const Value.absent(),
                Value<String> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MedicationsTableCompanion(
                id: id,
                patientId: patientId,
                treatmentId: treatmentId,
                dentistId: dentistId,
                medicationName: medicationName,
                dosage: dosage,
                frequency: frequency,
                duration: duration,
                notes: notes,
                prescribedDate: prescribedDate,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                Value<String?> treatmentId = const Value.absent(),
                required String dentistId,
                required String medicationName,
                Value<String?> dosage = const Value.absent(),
                Value<String?> frequency = const Value.absent(),
                Value<String?> duration = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required String prescribedDate,
                required String cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => MedicationsTableCompanion.insert(
                id: id,
                patientId: patientId,
                treatmentId: treatmentId,
                dentistId: dentistId,
                medicationName: medicationName,
                dosage: dosage,
                frequency: frequency,
                duration: duration,
                notes: notes,
                prescribedDate: prescribedDate,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MedicationsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $MedicationsTableTable,
      MedicationsTableData,
      $$MedicationsTableTableFilterComposer,
      $$MedicationsTableTableOrderingComposer,
      $$MedicationsTableTableAnnotationComposer,
      $$MedicationsTableTableCreateCompanionBuilder,
      $$MedicationsTableTableUpdateCompanionBuilder,
      (
        MedicationsTableData,
        BaseReferences<
          _$LocalDatabase,
          $MedicationsTableTable,
          MedicationsTableData
        >,
      ),
      MedicationsTableData,
      PrefetchHooks Function()
    >;
typedef $$FilesTableTableCreateCompanionBuilder =
    FilesTableCompanion Function({
      required String id,
      required String patientId,
      Value<String?> treatmentId,
      required String dentistId,
      required String fileName,
      required String fileType,
      required String fileUrl,
      required String storagePath,
      Value<int> fileSize,
      Value<String> category,
      required String uploadedAt,
      required String cachedAt,
      Value<int> rowid,
    });
typedef $$FilesTableTableUpdateCompanionBuilder =
    FilesTableCompanion Function({
      Value<String> id,
      Value<String> patientId,
      Value<String?> treatmentId,
      Value<String> dentistId,
      Value<String> fileName,
      Value<String> fileType,
      Value<String> fileUrl,
      Value<String> storagePath,
      Value<int> fileSize,
      Value<String> category,
      Value<String> uploadedAt,
      Value<String> cachedAt,
      Value<int> rowid,
    });

class $$FilesTableTableFilterComposer
    extends Composer<_$LocalDatabase, $FilesTableTable> {
  $$FilesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get treatmentId => $composableBuilder(
    column: $table.treatmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dentistId => $composableBuilder(
    column: $table.dentistId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileType => $composableBuilder(
    column: $table.fileType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileUrl => $composableBuilder(
    column: $table.fileUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get storagePath => $composableBuilder(
    column: $table.storagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uploadedAt => $composableBuilder(
    column: $table.uploadedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FilesTableTableOrderingComposer
    extends Composer<_$LocalDatabase, $FilesTableTable> {
  $$FilesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get treatmentId => $composableBuilder(
    column: $table.treatmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dentistId => $composableBuilder(
    column: $table.dentistId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileType => $composableBuilder(
    column: $table.fileType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileUrl => $composableBuilder(
    column: $table.fileUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storagePath => $composableBuilder(
    column: $table.storagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uploadedAt => $composableBuilder(
    column: $table.uploadedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FilesTableTableAnnotationComposer
    extends Composer<_$LocalDatabase, $FilesTableTable> {
  $$FilesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get treatmentId => $composableBuilder(
    column: $table.treatmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dentistId =>
      $composableBuilder(column: $table.dentistId, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get fileType =>
      $composableBuilder(column: $table.fileType, builder: (column) => column);

  GeneratedColumn<String> get fileUrl =>
      $composableBuilder(column: $table.fileUrl, builder: (column) => column);

  GeneratedColumn<String> get storagePath => $composableBuilder(
    column: $table.storagePath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get uploadedAt => $composableBuilder(
    column: $table.uploadedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$FilesTableTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $FilesTableTable,
          FilesTableData,
          $$FilesTableTableFilterComposer,
          $$FilesTableTableOrderingComposer,
          $$FilesTableTableAnnotationComposer,
          $$FilesTableTableCreateCompanionBuilder,
          $$FilesTableTableUpdateCompanionBuilder,
          (
            FilesTableData,
            BaseReferences<_$LocalDatabase, $FilesTableTable, FilesTableData>,
          ),
          FilesTableData,
          PrefetchHooks Function()
        > {
  $$FilesTableTableTableManager(_$LocalDatabase db, $FilesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FilesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FilesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FilesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String?> treatmentId = const Value.absent(),
                Value<String> dentistId = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<String> fileType = const Value.absent(),
                Value<String> fileUrl = const Value.absent(),
                Value<String> storagePath = const Value.absent(),
                Value<int> fileSize = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> uploadedAt = const Value.absent(),
                Value<String> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FilesTableCompanion(
                id: id,
                patientId: patientId,
                treatmentId: treatmentId,
                dentistId: dentistId,
                fileName: fileName,
                fileType: fileType,
                fileUrl: fileUrl,
                storagePath: storagePath,
                fileSize: fileSize,
                category: category,
                uploadedAt: uploadedAt,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                Value<String?> treatmentId = const Value.absent(),
                required String dentistId,
                required String fileName,
                required String fileType,
                required String fileUrl,
                required String storagePath,
                Value<int> fileSize = const Value.absent(),
                Value<String> category = const Value.absent(),
                required String uploadedAt,
                required String cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => FilesTableCompanion.insert(
                id: id,
                patientId: patientId,
                treatmentId: treatmentId,
                dentistId: dentistId,
                fileName: fileName,
                fileType: fileType,
                fileUrl: fileUrl,
                storagePath: storagePath,
                fileSize: fileSize,
                category: category,
                uploadedAt: uploadedAt,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FilesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $FilesTableTable,
      FilesTableData,
      $$FilesTableTableFilterComposer,
      $$FilesTableTableOrderingComposer,
      $$FilesTableTableAnnotationComposer,
      $$FilesTableTableCreateCompanionBuilder,
      $$FilesTableTableUpdateCompanionBuilder,
      (
        FilesTableData,
        BaseReferences<_$LocalDatabase, $FilesTableTable, FilesTableData>,
      ),
      FilesTableData,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableTableCreateCompanionBuilder =
    SyncQueueTableCompanion Function({
      Value<int> id,
      required String recordUuid,
      required String targetTable,
      required String action,
      required String payload,
      required String createdAt,
      Value<int> retryCount,
      Value<String?> lastError,
    });
typedef $$SyncQueueTableTableUpdateCompanionBuilder =
    SyncQueueTableCompanion Function({
      Value<int> id,
      Value<String> recordUuid,
      Value<String> targetTable,
      Value<String> action,
      Value<String> payload,
      Value<String> createdAt,
      Value<int> retryCount,
      Value<String?> lastError,
    });

class $$SyncQueueTableTableFilterComposer
    extends Composer<_$LocalDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableFilterComposer({
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

  ColumnFilters<String> get recordUuid => $composableBuilder(
    column: $table.recordUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableTableOrderingComposer
    extends Composer<_$LocalDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableOrderingComposer({
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

  ColumnOrderings<String> get recordUuid => $composableBuilder(
    column: $table.recordUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableTableAnnotationComposer
    extends Composer<_$LocalDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get recordUuid => $composableBuilder(
    column: $table.recordUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$SyncQueueTableTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $SyncQueueTableTable,
          SyncQueueTableData,
          $$SyncQueueTableTableFilterComposer,
          $$SyncQueueTableTableOrderingComposer,
          $$SyncQueueTableTableAnnotationComposer,
          $$SyncQueueTableTableCreateCompanionBuilder,
          $$SyncQueueTableTableUpdateCompanionBuilder,
          (
            SyncQueueTableData,
            BaseReferences<
              _$LocalDatabase,
              $SyncQueueTableTable,
              SyncQueueTableData
            >,
          ),
          SyncQueueTableData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableTableManager(
    _$LocalDatabase db,
    $SyncQueueTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> recordUuid = const Value.absent(),
                Value<String> targetTable = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => SyncQueueTableCompanion(
                id: id,
                recordUuid: recordUuid,
                targetTable: targetTable,
                action: action,
                payload: payload,
                createdAt: createdAt,
                retryCount: retryCount,
                lastError: lastError,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String recordUuid,
                required String targetTable,
                required String action,
                required String payload,
                required String createdAt,
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => SyncQueueTableCompanion.insert(
                id: id,
                recordUuid: recordUuid,
                targetTable: targetTable,
                action: action,
                payload: payload,
                createdAt: createdAt,
                retryCount: retryCount,
                lastError: lastError,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $SyncQueueTableTable,
      SyncQueueTableData,
      $$SyncQueueTableTableFilterComposer,
      $$SyncQueueTableTableOrderingComposer,
      $$SyncQueueTableTableAnnotationComposer,
      $$SyncQueueTableTableCreateCompanionBuilder,
      $$SyncQueueTableTableUpdateCompanionBuilder,
      (
        SyncQueueTableData,
        BaseReferences<
          _$LocalDatabase,
          $SyncQueueTableTable,
          SyncQueueTableData
        >,
      ),
      SyncQueueTableData,
      PrefetchHooks Function()
    >;

class $LocalDatabaseManager {
  final _$LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  $$ProfilesTableTableTableManager get profilesTable =>
      $$ProfilesTableTableTableManager(_db, _db.profilesTable);
  $$PatientsTableTableTableManager get patientsTable =>
      $$PatientsTableTableTableManager(_db, _db.patientsTable);
  $$TreatmentsTableTableTableManager get treatmentsTable =>
      $$TreatmentsTableTableTableManager(_db, _db.treatmentsTable);
  $$PaymentsTableTableTableManager get paymentsTable =>
      $$PaymentsTableTableTableManager(_db, _db.paymentsTable);
  $$AppointmentsTableTableTableManager get appointmentsTable =>
      $$AppointmentsTableTableTableManager(_db, _db.appointmentsTable);
  $$MedicationsTableTableTableManager get medicationsTable =>
      $$MedicationsTableTableTableManager(_db, _db.medicationsTable);
  $$FilesTableTableTableManager get filesTable =>
      $$FilesTableTableTableManager(_db, _db.filesTable);
  $$SyncQueueTableTableTableManager get syncQueueTable =>
      $$SyncQueueTableTableTableManager(_db, _db.syncQueueTable);
}
