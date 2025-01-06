// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_global_settings_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserGlobalSettingsEntityCollection on Isar {
  IsarCollection<UserGlobalSettingsEntity> get userGlobalSettingsEntitys =>
      this.collection();
}

const UserGlobalSettingsEntitySchema = CollectionSchema(
  name: r'UserGlobalSettingsEntity',
  id: -3740738450067599367,
  properties: {
    r'appOpenedCount': PropertySchema(
      id: 0,
      name: r'appOpenedCount',
      type: IsarType.long,
    ),
    r'canalplusSettings': PropertySchema(
      id: 1,
      name: r'canalplusSettings',
      type: IsarType.object,
      target: r'CanalplusConfigEntity',
    ),
    r'classificationTree': PropertySchema(
      id: 2,
      name: r'classificationTree',
      type: IsarType.objectList,
      target: r'ProductCategoryEntity',
    ),
    r'countryConfiguration': PropertySchema(
      id: 3,
      name: r'countryConfiguration',
      type: IsarType.object,
      target: r'CountryConfigurationEntity',
    ),
    r'dontDisplaySwipeProductsListHelp': PropertySchema(
      id: 4,
      name: r'dontDisplaySwipeProductsListHelp',
      type: IsarType.bool,
    ),
    r'hasSuccessfullySentCanalPlusUserInfo': PropertySchema(
      id: 5,
      name: r'hasSuccessfullySentCanalPlusUserInfo',
      type: IsarType.bool,
    ),
    r'isCanalplusUser': PropertySchema(
      id: 6,
      name: r'isCanalplusUser',
      type: IsarType.bool,
    ),
    r'lastInactiveSessionUserReadTriggerDate': PropertySchema(
      id: 7,
      name: r'lastInactiveSessionUserReadTriggerDate',
      type: IsarType.dateTime,
    ),
    r'lastTimeConnectedToInternet': PropertySchema(
      id: 8,
      name: r'lastTimeConnectedToInternet',
      type: IsarType.dateTime,
    ),
    r'preferredCountryCode': PropertySchema(
      id: 9,
      name: r'preferredCountryCode',
      type: IsarType.string,
    ),
    r'preferredLanguageCode': PropertySchema(
      id: 10,
      name: r'preferredLanguageCode',
      type: IsarType.string,
    ),
    r'theme': PropertySchema(
      id: 11,
      name: r'theme',
      type: IsarType.byte,
      enumMap: _UserGlobalSettingsEntitythemeEnumValueMap,
    )
  },
  estimateSize: _userGlobalSettingsEntityEstimateSize,
  serialize: _userGlobalSettingsEntitySerialize,
  deserialize: _userGlobalSettingsEntityDeserialize,
  deserializeProp: _userGlobalSettingsEntityDeserializeProp,
  idName: r'localId',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'CountryConfigurationEntity': CountryConfigurationEntitySchema,
    r'CountryConfigPopupEntity': CountryConfigPopupEntitySchema,
    r'CountryConfigRegisterPopupButtonEntity':
        CountryConfigRegisterPopupButtonEntitySchema,
    r'CanalplusConfigEntity': CanalplusConfigEntitySchema,
    r'CanalPlusConfigTextItemEntity': CanalPlusConfigTextItemEntitySchema,
    r'ProductCategoryEntity': ProductCategoryEntitySchema
  },
  getId: _userGlobalSettingsEntityGetId,
  getLinks: _userGlobalSettingsEntityGetLinks,
  attach: _userGlobalSettingsEntityAttach,
  version: '3.1.0+1',
);

int _userGlobalSettingsEntityEstimateSize(
  UserGlobalSettingsEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.canalplusSettings;
    if (value != null) {
      bytesCount += 3 +
          CanalplusConfigEntitySchema.estimateSize(
              value, allOffsets[CanalplusConfigEntity]!, allOffsets);
    }
  }
  {
    final list = object.classificationTree;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[ProductCategoryEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += ProductCategoryEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.countryConfiguration;
    if (value != null) {
      bytesCount += 3 +
          CountryConfigurationEntitySchema.estimateSize(
              value, allOffsets[CountryConfigurationEntity]!, allOffsets);
    }
  }
  bytesCount += 3 + object.preferredCountryCode.length * 3;
  bytesCount += 3 + object.preferredLanguageCode.length * 3;
  return bytesCount;
}

void _userGlobalSettingsEntitySerialize(
  UserGlobalSettingsEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.appOpenedCount);
  writer.writeObject<CanalplusConfigEntity>(
    offsets[1],
    allOffsets,
    CanalplusConfigEntitySchema.serialize,
    object.canalplusSettings,
  );
  writer.writeObjectList<ProductCategoryEntity>(
    offsets[2],
    allOffsets,
    ProductCategoryEntitySchema.serialize,
    object.classificationTree,
  );
  writer.writeObject<CountryConfigurationEntity>(
    offsets[3],
    allOffsets,
    CountryConfigurationEntitySchema.serialize,
    object.countryConfiguration,
  );
  writer.writeBool(offsets[4], object.dontDisplaySwipeProductsListHelp);
  writer.writeBool(offsets[5], object.hasSuccessfullySentCanalPlusUserInfo);
  writer.writeBool(offsets[6], object.isCanalplusUser);
  writer.writeDateTime(
      offsets[7], object.lastInactiveSessionUserReadTriggerDate);
  writer.writeDateTime(offsets[8], object.lastTimeConnectedToInternet);
  writer.writeString(offsets[9], object.preferredCountryCode);
  writer.writeString(offsets[10], object.preferredLanguageCode);
  writer.writeByte(offsets[11], object.theme.index);
}

UserGlobalSettingsEntity _userGlobalSettingsEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserGlobalSettingsEntity(
    appOpenedCount: reader.readLong(offsets[0]),
    canalplusSettings: reader.readObjectOrNull<CanalplusConfigEntity>(
      offsets[1],
      CanalplusConfigEntitySchema.deserialize,
      allOffsets,
    ),
    classificationTree: reader.readObjectList<ProductCategoryEntity>(
      offsets[2],
      ProductCategoryEntitySchema.deserialize,
      allOffsets,
      ProductCategoryEntity(),
    ),
    countryConfiguration: reader.readObjectOrNull<CountryConfigurationEntity>(
      offsets[3],
      CountryConfigurationEntitySchema.deserialize,
      allOffsets,
    ),
    dontDisplaySwipeProductsListHelp: reader.readBoolOrNull(offsets[4]),
    hasSuccessfullySentCanalPlusUserInfo: reader.readBoolOrNull(offsets[5]),
    isCanalplusUser: reader.readBoolOrNull(offsets[6]),
    lastInactiveSessionUserReadTriggerDate:
        reader.readDateTimeOrNull(offsets[7]),
    lastTimeConnectedToInternet: reader.readDateTimeOrNull(offsets[8]),
    localId: id,
    preferredCountryCode: reader.readStringOrNull(offsets[9]) ?? '',
    preferredLanguageCode: reader.readStringOrNull(offsets[10]) ?? '',
    theme: _UserGlobalSettingsEntitythemeValueEnumMap[
            reader.readByteOrNull(offsets[11])] ??
        ThemeType.system,
  );
  return object;
}

P _userGlobalSettingsEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<CanalplusConfigEntity>(
        offset,
        CanalplusConfigEntitySchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readObjectList<ProductCategoryEntity>(
        offset,
        ProductCategoryEntitySchema.deserialize,
        allOffsets,
        ProductCategoryEntity(),
      )) as P;
    case 3:
      return (reader.readObjectOrNull<CountryConfigurationEntity>(
        offset,
        CountryConfigurationEntitySchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset)) as P;
    case 6:
      return (reader.readBoolOrNull(offset)) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 10:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 11:
      return (_UserGlobalSettingsEntitythemeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ThemeType.system) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _UserGlobalSettingsEntitythemeEnumValueMap = {
  'system': 0,
  'darkTheme': 1,
  'lightTheme': 2,
};
const _UserGlobalSettingsEntitythemeValueEnumMap = {
  0: ThemeType.system,
  1: ThemeType.darkTheme,
  2: ThemeType.lightTheme,
};

Id _userGlobalSettingsEntityGetId(UserGlobalSettingsEntity object) {
  return object.localId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _userGlobalSettingsEntityGetLinks(
    UserGlobalSettingsEntity object) {
  return [];
}

void _userGlobalSettingsEntityAttach(
    IsarCollection<dynamic> col, Id id, UserGlobalSettingsEntity object) {
  object.localId = id;
}

extension UserGlobalSettingsEntityQueryWhereSort on QueryBuilder<
    UserGlobalSettingsEntity, UserGlobalSettingsEntity, QWhere> {
  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterWhere>
      anyLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserGlobalSettingsEntityQueryWhere on QueryBuilder<
    UserGlobalSettingsEntity, UserGlobalSettingsEntity, QWhereClause> {
  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterWhereClause> localIdEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: localId,
        upper: localId,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterWhereClause> localIdNotEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: localId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: localId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: localId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: localId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
          QAfterWhereClause>
      localIdGreaterThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localId, includeLower: include),
      );
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterWhereClause> localIdLessThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localId, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterWhereClause> localIdBetween(
    Id lowerLocalId,
    Id upperLocalId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerLocalId,
        includeLower: includeLower,
        upper: upperLocalId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserGlobalSettingsEntityQueryFilter on QueryBuilder<
    UserGlobalSettingsEntity, UserGlobalSettingsEntity, QFilterCondition> {
  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> appOpenedCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appOpenedCount',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> appOpenedCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'appOpenedCount',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> appOpenedCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'appOpenedCount',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> appOpenedCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'appOpenedCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> canalplusSettingsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'canalplusSettings',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> canalplusSettingsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'canalplusSettings',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> classificationTreeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'classificationTree',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> classificationTreeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'classificationTree',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> classificationTreeLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'classificationTree',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> classificationTreeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'classificationTree',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> classificationTreeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'classificationTree',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> classificationTreeLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'classificationTree',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> classificationTreeLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'classificationTree',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> classificationTreeLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'classificationTree',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> countryConfigurationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'countryConfiguration',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> countryConfigurationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'countryConfiguration',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> dontDisplaySwipeProductsListHelpIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dontDisplaySwipeProductsListHelp',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> dontDisplaySwipeProductsListHelpIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dontDisplaySwipeProductsListHelp',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
          QAfterFilterCondition>
      dontDisplaySwipeProductsListHelpEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dontDisplaySwipeProductsListHelp',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> hasSuccessfullySentCanalPlusUserInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hasSuccessfullySentCanalPlusUserInfo',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> hasSuccessfullySentCanalPlusUserInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hasSuccessfullySentCanalPlusUserInfo',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
          QAfterFilterCondition>
      hasSuccessfullySentCanalPlusUserInfoEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasSuccessfullySentCanalPlusUserInfo',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> isCanalplusUserIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isCanalplusUser',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> isCanalplusUserIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isCanalplusUser',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> isCanalplusUserEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCanalplusUser',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> lastInactiveSessionUserReadTriggerDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastInactiveSessionUserReadTriggerDate',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> lastInactiveSessionUserReadTriggerDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastInactiveSessionUserReadTriggerDate',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
          QAfterFilterCondition>
      lastInactiveSessionUserReadTriggerDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastInactiveSessionUserReadTriggerDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> lastInactiveSessionUserReadTriggerDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastInactiveSessionUserReadTriggerDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> lastInactiveSessionUserReadTriggerDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastInactiveSessionUserReadTriggerDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> lastInactiveSessionUserReadTriggerDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastInactiveSessionUserReadTriggerDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> lastTimeConnectedToInternetIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastTimeConnectedToInternet',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> lastTimeConnectedToInternetIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastTimeConnectedToInternet',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
          QAfterFilterCondition>
      lastTimeConnectedToInternetEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTimeConnectedToInternet',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> lastTimeConnectedToInternetGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastTimeConnectedToInternet',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> lastTimeConnectedToInternetLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastTimeConnectedToInternet',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> lastTimeConnectedToInternetBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastTimeConnectedToInternet',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> localIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> localIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> localIdEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> localIdGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> localIdLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> localIdBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> preferredCountryCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preferredCountryCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> preferredCountryCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'preferredCountryCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> preferredCountryCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'preferredCountryCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> preferredCountryCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'preferredCountryCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> preferredCountryCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'preferredCountryCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> preferredCountryCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'preferredCountryCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
          QAfterFilterCondition>
      preferredCountryCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'preferredCountryCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
          QAfterFilterCondition>
      preferredCountryCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'preferredCountryCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> preferredCountryCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preferredCountryCode',
        value: '',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> preferredCountryCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'preferredCountryCode',
        value: '',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> preferredLanguageCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preferredLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> preferredLanguageCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'preferredLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> preferredLanguageCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'preferredLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> preferredLanguageCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'preferredLanguageCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> preferredLanguageCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'preferredLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> preferredLanguageCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'preferredLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
          QAfterFilterCondition>
      preferredLanguageCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'preferredLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
          QAfterFilterCondition>
      preferredLanguageCodeMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'preferredLanguageCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> preferredLanguageCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preferredLanguageCode',
        value: '',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> preferredLanguageCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'preferredLanguageCode',
        value: '',
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> themeEqualTo(ThemeType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'theme',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> themeGreaterThan(
    ThemeType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'theme',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> themeLessThan(
    ThemeType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'theme',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
      QAfterFilterCondition> themeBetween(
    ThemeType lower,
    ThemeType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'theme',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserGlobalSettingsEntityQueryObject on QueryBuilder<
    UserGlobalSettingsEntity, UserGlobalSettingsEntity, QFilterCondition> {
  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
          QAfterFilterCondition>
      canalplusSettings(FilterQuery<CanalplusConfigEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'canalplusSettings');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
          QAfterFilterCondition>
      classificationTreeElement(FilterQuery<ProductCategoryEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'classificationTree');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity,
          QAfterFilterCondition>
      countryConfiguration(FilterQuery<CountryConfigurationEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'countryConfiguration');
    });
  }
}

extension UserGlobalSettingsEntityQueryLinks on QueryBuilder<
    UserGlobalSettingsEntity, UserGlobalSettingsEntity, QFilterCondition> {}

extension UserGlobalSettingsEntityQuerySortBy on QueryBuilder<
    UserGlobalSettingsEntity, UserGlobalSettingsEntity, QSortBy> {
  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      sortByAppOpenedCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appOpenedCount', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      sortByAppOpenedCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appOpenedCount', Sort.desc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      sortByDontDisplaySwipeProductsListHelp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dontDisplaySwipeProductsListHelp', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      sortByDontDisplaySwipeProductsListHelpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dontDisplaySwipeProductsListHelp', Sort.desc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      sortByHasSuccessfullySentCanalPlusUserInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasSuccessfullySentCanalPlusUserInfo', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      sortByHasSuccessfullySentCanalPlusUserInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
          r'hasSuccessfullySentCanalPlusUserInfo', Sort.desc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      sortByIsCanalplusUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCanalplusUser', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      sortByIsCanalplusUserDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCanalplusUser', Sort.desc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      sortByLastInactiveSessionUserReadTriggerDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
          r'lastInactiveSessionUserReadTriggerDate', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      sortByLastInactiveSessionUserReadTriggerDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
          r'lastInactiveSessionUserReadTriggerDate', Sort.desc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      sortByLastTimeConnectedToInternet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeConnectedToInternet', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      sortByLastTimeConnectedToInternetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeConnectedToInternet', Sort.desc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      sortByPreferredCountryCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredCountryCode', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      sortByPreferredCountryCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredCountryCode', Sort.desc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      sortByPreferredLanguageCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredLanguageCode', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      sortByPreferredLanguageCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredLanguageCode', Sort.desc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      sortByTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      sortByThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.desc);
    });
  }
}

extension UserGlobalSettingsEntityQuerySortThenBy on QueryBuilder<
    UserGlobalSettingsEntity, UserGlobalSettingsEntity, QSortThenBy> {
  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByAppOpenedCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appOpenedCount', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByAppOpenedCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appOpenedCount', Sort.desc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByDontDisplaySwipeProductsListHelp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dontDisplaySwipeProductsListHelp', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByDontDisplaySwipeProductsListHelpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dontDisplaySwipeProductsListHelp', Sort.desc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByHasSuccessfullySentCanalPlusUserInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasSuccessfullySentCanalPlusUserInfo', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByHasSuccessfullySentCanalPlusUserInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
          r'hasSuccessfullySentCanalPlusUserInfo', Sort.desc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByIsCanalplusUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCanalplusUser', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByIsCanalplusUserDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCanalplusUser', Sort.desc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByLastInactiveSessionUserReadTriggerDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
          r'lastInactiveSessionUserReadTriggerDate', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByLastInactiveSessionUserReadTriggerDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
          r'lastInactiveSessionUserReadTriggerDate', Sort.desc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByLastTimeConnectedToInternet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeConnectedToInternet', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByLastTimeConnectedToInternetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTimeConnectedToInternet', Sort.desc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByPreferredCountryCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredCountryCode', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByPreferredCountryCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredCountryCode', Sort.desc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByPreferredLanguageCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredLanguageCode', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByPreferredLanguageCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredLanguageCode', Sort.desc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.asc);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QAfterSortBy>
      thenByThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.desc);
    });
  }
}

extension UserGlobalSettingsEntityQueryWhereDistinct on QueryBuilder<
    UserGlobalSettingsEntity, UserGlobalSettingsEntity, QDistinct> {
  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QDistinct>
      distinctByAppOpenedCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appOpenedCount');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QDistinct>
      distinctByDontDisplaySwipeProductsListHelp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dontDisplaySwipeProductsListHelp');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QDistinct>
      distinctByHasSuccessfullySentCanalPlusUserInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasSuccessfullySentCanalPlusUserInfo');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QDistinct>
      distinctByIsCanalplusUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCanalplusUser');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QDistinct>
      distinctByLastInactiveSessionUserReadTriggerDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastInactiveSessionUserReadTriggerDate');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QDistinct>
      distinctByLastTimeConnectedToInternet() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastTimeConnectedToInternet');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QDistinct>
      distinctByPreferredCountryCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'preferredCountryCode',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QDistinct>
      distinctByPreferredLanguageCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'preferredLanguageCode',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, UserGlobalSettingsEntity, QDistinct>
      distinctByTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'theme');
    });
  }
}

extension UserGlobalSettingsEntityQueryProperty on QueryBuilder<
    UserGlobalSettingsEntity, UserGlobalSettingsEntity, QQueryProperty> {
  QueryBuilder<UserGlobalSettingsEntity, int, QQueryOperations>
      localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, int, QQueryOperations>
      appOpenedCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appOpenedCount');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, CanalplusConfigEntity?,
      QQueryOperations> canalplusSettingsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canalplusSettings');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, List<ProductCategoryEntity>?,
      QQueryOperations> classificationTreeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'classificationTree');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, CountryConfigurationEntity?,
      QQueryOperations> countryConfigurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'countryConfiguration');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, bool?, QQueryOperations>
      dontDisplaySwipeProductsListHelpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dontDisplaySwipeProductsListHelp');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, bool?, QQueryOperations>
      hasSuccessfullySentCanalPlusUserInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasSuccessfullySentCanalPlusUserInfo');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, bool?, QQueryOperations>
      isCanalplusUserProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCanalplusUser');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, DateTime?, QQueryOperations>
      lastInactiveSessionUserReadTriggerDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastInactiveSessionUserReadTriggerDate');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, DateTime?, QQueryOperations>
      lastTimeConnectedToInternetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastTimeConnectedToInternet');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, String, QQueryOperations>
      preferredCountryCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'preferredCountryCode');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, String, QQueryOperations>
      preferredLanguageCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'preferredLanguageCode');
    });
  }

  QueryBuilder<UserGlobalSettingsEntity, ThemeType, QQueryOperations>
      themeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'theme');
    });
  }
}
