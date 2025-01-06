// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_account_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCurrentUserAccountEntityCollection on Isar {
  IsarCollection<CurrentUserAccountEntity> get currentUserAccountEntitys =>
      this.collection();
}

const CurrentUserAccountEntitySchema = CollectionSchema(
  name: r'CurrentUserAccountEntity',
  id: 3404588011237769627,
  properties: {
    r'additionalRightExpiration': PropertySchema(
      id: 0,
      name: r'additionalRightExpiration',
      type: IsarType.dateTime,
    ),
    r'additionalRightRequired': PropertySchema(
      id: 1,
      name: r'additionalRightRequired',
      type: IsarType.bool,
    ),
    r'classificationTreeId': PropertySchema(
      id: 2,
      name: r'classificationTreeId',
      type: IsarType.long,
    ),
    r'cobranding': PropertySchema(
      id: 3,
      name: r'cobranding',
      type: IsarType.string,
    ),
    r'email': PropertySchema(
      id: 4,
      name: r'email',
      type: IsarType.string,
    ),
    r'firebaseToken': PropertySchema(
      id: 5,
      name: r'firebaseToken',
      type: IsarType.string,
    ),
    r'firstName': PropertySchema(
      id: 6,
      name: r'firstName',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 7,
      name: r'id',
      type: IsarType.long,
    ),
    r'imageUrl': PropertySchema(
      id: 8,
      name: r'imageUrl',
      type: IsarType.string,
    ),
    r'isSubscriber': PropertySchema(
      id: 9,
      name: r'isSubscriber',
      type: IsarType.bool,
    ),
    r'isYSClassificationSettings': PropertySchema(
      id: 10,
      name: r'isYSClassificationSettings',
      type: IsarType.bool,
    ),
    r'lastName': PropertySchema(
      id: 11,
      name: r'lastName',
      type: IsarType.string,
    ),
    r'premiumIsAllowed': PropertySchema(
      id: 12,
      name: r'premiumIsAllowed',
      type: IsarType.bool,
    ),
    r'profileImageUrls': PropertySchema(
      id: 13,
      name: r'profileImageUrls',
      type: IsarType.stringList,
    ),
    r'profilePic': PropertySchema(
      id: 14,
      name: r'profilePic',
      type: IsarType.string,
    ),
    r'token': PropertySchema(
      id: 15,
      name: r'token',
      type: IsarType.string,
    ),
    r'trackingId': PropertySchema(
      id: 16,
      name: r'trackingId',
      type: IsarType.string,
    ),
    r'userName': PropertySchema(
      id: 17,
      name: r'userName',
      type: IsarType.string,
    ),
    r'userSelections': PropertySchema(
      id: 18,
      name: r'userSelections',
      type: IsarType.objectList,
      target: r'SimpleLibraryEntity',
    )
  },
  estimateSize: _currentUserAccountEntityEstimateSize,
  serialize: _currentUserAccountEntitySerialize,
  deserialize: _currentUserAccountEntityDeserialize,
  deserializeProp: _currentUserAccountEntityDeserializeProp,
  idName: r'localId',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'SimpleLibraryEntity': SimpleLibraryEntitySchema,
    r'LibraryProductEntity': LibraryProductEntitySchema
  },
  getId: _currentUserAccountEntityGetId,
  getLinks: _currentUserAccountEntityGetLinks,
  attach: _currentUserAccountEntityAttach,
  version: '3.1.0+1',
);

int _currentUserAccountEntityEstimateSize(
  CurrentUserAccountEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.cobranding;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.email;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.firebaseToken;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.firstName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.imageUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.profileImageUrls;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.profilePic;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.token;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.trackingId.length * 3;
  {
    final value = object.userName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.userSelections;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[SimpleLibraryEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += SimpleLibraryEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _currentUserAccountEntitySerialize(
  CurrentUserAccountEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.additionalRightExpiration);
  writer.writeBool(offsets[1], object.additionalRightRequired);
  writer.writeLong(offsets[2], object.classificationTreeId);
  writer.writeString(offsets[3], object.cobranding);
  writer.writeString(offsets[4], object.email);
  writer.writeString(offsets[5], object.firebaseToken);
  writer.writeString(offsets[6], object.firstName);
  writer.writeLong(offsets[7], object.id);
  writer.writeString(offsets[8], object.imageUrl);
  writer.writeBool(offsets[9], object.isSubscriber);
  writer.writeBool(offsets[10], object.isYSClassificationSettings);
  writer.writeString(offsets[11], object.lastName);
  writer.writeBool(offsets[12], object.premiumIsAllowed);
  writer.writeStringList(offsets[13], object.profileImageUrls);
  writer.writeString(offsets[14], object.profilePic);
  writer.writeString(offsets[15], object.token);
  writer.writeString(offsets[16], object.trackingId);
  writer.writeString(offsets[17], object.userName);
  writer.writeObjectList<SimpleLibraryEntity>(
    offsets[18],
    allOffsets,
    SimpleLibraryEntitySchema.serialize,
    object.userSelections,
  );
}

CurrentUserAccountEntity _currentUserAccountEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CurrentUserAccountEntity();
  object.additionalRightExpiration = reader.readDateTimeOrNull(offsets[0]);
  object.additionalRightRequired = reader.readBoolOrNull(offsets[1]);
  object.classificationTreeId = reader.readLongOrNull(offsets[2]);
  object.cobranding = reader.readStringOrNull(offsets[3]);
  object.email = reader.readStringOrNull(offsets[4]);
  object.firebaseToken = reader.readStringOrNull(offsets[5]);
  object.firstName = reader.readStringOrNull(offsets[6]);
  object.id = reader.readLongOrNull(offsets[7]);
  object.imageUrl = reader.readStringOrNull(offsets[8]);
  object.isSubscriber = reader.readBoolOrNull(offsets[9]);
  object.lastName = reader.readStringOrNull(offsets[11]);
  object.localId = id;
  object.premiumIsAllowed = reader.readBoolOrNull(offsets[12]);
  object.profileImageUrls = reader.readStringList(offsets[13]);
  object.profilePic = reader.readStringOrNull(offsets[14]);
  object.token = reader.readStringOrNull(offsets[15]);
  object.trackingId = reader.readString(offsets[16]);
  object.userName = reader.readStringOrNull(offsets[17]);
  object.userSelections = reader.readObjectList<SimpleLibraryEntity>(
    offsets[18],
    SimpleLibraryEntitySchema.deserialize,
    allOffsets,
    SimpleLibraryEntity(),
  );
  return object;
}

P _currentUserAccountEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readBoolOrNull(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readBoolOrNull(offset)) as P;
    case 13:
      return (reader.readStringList(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readObjectList<SimpleLibraryEntity>(
        offset,
        SimpleLibraryEntitySchema.deserialize,
        allOffsets,
        SimpleLibraryEntity(),
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _currentUserAccountEntityGetId(CurrentUserAccountEntity object) {
  return object.localId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _currentUserAccountEntityGetLinks(
    CurrentUserAccountEntity object) {
  return [];
}

void _currentUserAccountEntityAttach(
    IsarCollection<dynamic> col, Id id, CurrentUserAccountEntity object) {
  object.localId = id;
}

extension CurrentUserAccountEntityQueryWhereSort on QueryBuilder<
    CurrentUserAccountEntity, CurrentUserAccountEntity, QWhere> {
  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterWhere>
      anyLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CurrentUserAccountEntityQueryWhere on QueryBuilder<
    CurrentUserAccountEntity, CurrentUserAccountEntity, QWhereClause> {
  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterWhereClause> localIdEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: localId,
        upper: localId,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
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

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterWhereClause>
      localIdGreaterThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localId, includeLower: include),
      );
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterWhereClause> localIdLessThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
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

extension CurrentUserAccountEntityQueryFilter on QueryBuilder<
    CurrentUserAccountEntity, CurrentUserAccountEntity, QFilterCondition> {
  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> additionalRightExpirationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'additionalRightExpiration',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> additionalRightExpirationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'additionalRightExpiration',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> additionalRightExpirationEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'additionalRightExpiration',
        value: value,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> additionalRightExpirationGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'additionalRightExpiration',
        value: value,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> additionalRightExpirationLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'additionalRightExpiration',
        value: value,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> additionalRightExpirationBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'additionalRightExpiration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> additionalRightRequiredIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'additionalRightRequired',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> additionalRightRequiredIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'additionalRightRequired',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> additionalRightRequiredEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'additionalRightRequired',
        value: value,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> classificationTreeIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'classificationTreeId',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> classificationTreeIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'classificationTreeId',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> classificationTreeIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'classificationTreeId',
        value: value,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> classificationTreeIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'classificationTreeId',
        value: value,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> classificationTreeIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'classificationTreeId',
        value: value,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> classificationTreeIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'classificationTreeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> cobrandingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cobranding',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> cobrandingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cobranding',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> cobrandingEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cobranding',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> cobrandingGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cobranding',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> cobrandingLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cobranding',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> cobrandingBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cobranding',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> cobrandingStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cobranding',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> cobrandingEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cobranding',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      cobrandingContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cobranding',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      cobrandingMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cobranding',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> cobrandingIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cobranding',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> cobrandingIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cobranding',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> emailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> emailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> emailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> emailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'email',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      emailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      emailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firebaseTokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firebaseToken',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firebaseTokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firebaseToken',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firebaseTokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firebaseTokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firebaseToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firebaseTokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firebaseToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firebaseTokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firebaseToken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firebaseTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firebaseToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firebaseTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firebaseToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      firebaseTokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firebaseToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      firebaseTokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firebaseToken',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firebaseTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseToken',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firebaseTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firebaseToken',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firstNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firstName',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firstNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firstName',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firstNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firstNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firstNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firstNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firstName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firstNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firstNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      firstNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      firstNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firstName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firstNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstName',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> firstNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firstName',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> idEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> idGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> idLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> idBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> imageUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> imageUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> imageUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> imageUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> imageUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> imageUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> imageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> imageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      imageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      imageUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> imageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> imageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> isSubscriberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isSubscriber',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> isSubscriberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isSubscriber',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> isSubscriberEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSubscriber',
        value: value,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> isYSClassificationSettingsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isYSClassificationSettings',
        value: value,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> lastNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastName',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> lastNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastName',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> lastNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> lastNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> lastNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> lastNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> lastNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> lastNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      lastNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      lastNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> lastNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastName',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> lastNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastName',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> localIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> localIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> localIdEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
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

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
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

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
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

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> premiumIsAllowedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'premiumIsAllowed',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> premiumIsAllowedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'premiumIsAllowed',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> premiumIsAllowedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'premiumIsAllowed',
        value: value,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profileImageUrlsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'profileImageUrls',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profileImageUrlsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'profileImageUrls',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profileImageUrlsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileImageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profileImageUrlsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'profileImageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profileImageUrlsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'profileImageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profileImageUrlsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'profileImageUrls',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profileImageUrlsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'profileImageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profileImageUrlsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'profileImageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      profileImageUrlsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'profileImageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      profileImageUrlsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'profileImageUrls',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profileImageUrlsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileImageUrls',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profileImageUrlsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'profileImageUrls',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profileImageUrlsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'profileImageUrls',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profileImageUrlsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'profileImageUrls',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profileImageUrlsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'profileImageUrls',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profileImageUrlsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'profileImageUrls',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profileImageUrlsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'profileImageUrls',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profileImageUrlsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'profileImageUrls',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profilePicIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'profilePic',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profilePicIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'profilePic',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profilePicEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profilePic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profilePicGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'profilePic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profilePicLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'profilePic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profilePicBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'profilePic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profilePicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'profilePic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profilePicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'profilePic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      profilePicContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'profilePic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      profilePicMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'profilePic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profilePicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profilePic',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> profilePicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'profilePic',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> tokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'token',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> tokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'token',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> tokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> tokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> tokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> tokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'token',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> tokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> tokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      tokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      tokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'token',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> tokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'token',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> tokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'token',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> trackingIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackingId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> trackingIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trackingId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> trackingIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trackingId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> trackingIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trackingId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> trackingIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'trackingId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> trackingIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'trackingId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      trackingIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'trackingId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      trackingIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'trackingId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> trackingIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackingId',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> trackingIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trackingId',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> userNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userName',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> userNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userName',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> userNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> userNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> userNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> userNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> userNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> userNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      userNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      userNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> userNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userName',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> userNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userName',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> userSelectionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userSelections',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> userSelectionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userSelections',
      ));
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> userSelectionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userSelections',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> userSelectionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userSelections',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> userSelectionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userSelections',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> userSelectionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userSelections',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> userSelectionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userSelections',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
      QAfterFilterCondition> userSelectionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userSelections',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension CurrentUserAccountEntityQueryObject on QueryBuilder<
    CurrentUserAccountEntity, CurrentUserAccountEntity, QFilterCondition> {
  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity,
          QAfterFilterCondition>
      userSelectionsElement(FilterQuery<SimpleLibraryEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'userSelections');
    });
  }
}

extension CurrentUserAccountEntityQueryLinks on QueryBuilder<
    CurrentUserAccountEntity, CurrentUserAccountEntity, QFilterCondition> {}

extension CurrentUserAccountEntityQuerySortBy on QueryBuilder<
    CurrentUserAccountEntity, CurrentUserAccountEntity, QSortBy> {
  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByAdditionalRightExpiration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalRightExpiration', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByAdditionalRightExpirationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalRightExpiration', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByAdditionalRightRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalRightRequired', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByAdditionalRightRequiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalRightRequired', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByClassificationTreeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'classificationTreeId', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByClassificationTreeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'classificationTreeId', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByCobranding() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cobranding', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByCobrandingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cobranding', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByFirebaseToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseToken', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByFirebaseTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseToken', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByFirstName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByFirstNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByIsSubscriber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSubscriber', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByIsSubscriberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSubscriber', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByIsYSClassificationSettings() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isYSClassificationSettings', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByIsYSClassificationSettingsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isYSClassificationSettings', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByLastName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByLastNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByPremiumIsAllowed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'premiumIsAllowed', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByPremiumIsAllowedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'premiumIsAllowed', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByProfilePic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profilePic', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByProfilePicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profilePic', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByTrackingId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingId', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByTrackingIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingId', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      sortByUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.desc);
    });
  }
}

extension CurrentUserAccountEntityQuerySortThenBy on QueryBuilder<
    CurrentUserAccountEntity, CurrentUserAccountEntity, QSortThenBy> {
  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByAdditionalRightExpiration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalRightExpiration', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByAdditionalRightExpirationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalRightExpiration', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByAdditionalRightRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalRightRequired', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByAdditionalRightRequiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalRightRequired', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByClassificationTreeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'classificationTreeId', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByClassificationTreeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'classificationTreeId', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByCobranding() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cobranding', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByCobrandingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cobranding', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByFirebaseToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseToken', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByFirebaseTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseToken', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByFirstName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByFirstNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByIsSubscriber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSubscriber', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByIsSubscriberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSubscriber', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByIsYSClassificationSettings() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isYSClassificationSettings', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByIsYSClassificationSettingsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isYSClassificationSettings', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByLastName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByLastNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByPremiumIsAllowed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'premiumIsAllowed', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByPremiumIsAllowedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'premiumIsAllowed', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByProfilePic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profilePic', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByProfilePicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profilePic', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByTrackingId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingId', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByTrackingIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingId', Sort.desc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.asc);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QAfterSortBy>
      thenByUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.desc);
    });
  }
}

extension CurrentUserAccountEntityQueryWhereDistinct on QueryBuilder<
    CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct> {
  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct>
      distinctByAdditionalRightExpiration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'additionalRightExpiration');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct>
      distinctByAdditionalRightRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'additionalRightRequired');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct>
      distinctByClassificationTreeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'classificationTreeId');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct>
      distinctByCobranding({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cobranding', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct>
      distinctByEmail({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct>
      distinctByFirebaseToken({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firebaseToken',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct>
      distinctByFirstName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firstName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct>
      distinctById() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct>
      distinctByImageUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct>
      distinctByIsSubscriber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSubscriber');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct>
      distinctByIsYSClassificationSettings() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isYSClassificationSettings');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct>
      distinctByLastName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct>
      distinctByPremiumIsAllowed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'premiumIsAllowed');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct>
      distinctByProfileImageUrls() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profileImageUrls');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct>
      distinctByProfilePic({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profilePic', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct>
      distinctByToken({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'token', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct>
      distinctByTrackingId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackingId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CurrentUserAccountEntity, CurrentUserAccountEntity, QDistinct>
      distinctByUserName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userName', caseSensitive: caseSensitive);
    });
  }
}

extension CurrentUserAccountEntityQueryProperty on QueryBuilder<
    CurrentUserAccountEntity, CurrentUserAccountEntity, QQueryProperty> {
  QueryBuilder<CurrentUserAccountEntity, int, QQueryOperations>
      localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, DateTime?, QQueryOperations>
      additionalRightExpirationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'additionalRightExpiration');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, bool?, QQueryOperations>
      additionalRightRequiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'additionalRightRequired');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, int?, QQueryOperations>
      classificationTreeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'classificationTreeId');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, String?, QQueryOperations>
      cobrandingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cobranding');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, String?, QQueryOperations>
      emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, String?, QQueryOperations>
      firebaseTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firebaseToken');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, String?, QQueryOperations>
      firstNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firstName');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, int?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, String?, QQueryOperations>
      imageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageUrl');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, bool?, QQueryOperations>
      isSubscriberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSubscriber');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, bool, QQueryOperations>
      isYSClassificationSettingsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isYSClassificationSettings');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, String?, QQueryOperations>
      lastNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastName');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, bool?, QQueryOperations>
      premiumIsAllowedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'premiumIsAllowed');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, List<String>?, QQueryOperations>
      profileImageUrlsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profileImageUrls');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, String?, QQueryOperations>
      profilePicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profilePic');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, String?, QQueryOperations>
      tokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'token');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, String, QQueryOperations>
      trackingIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackingId');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, String?, QQueryOperations>
      userNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userName');
    });
  }

  QueryBuilder<CurrentUserAccountEntity, List<SimpleLibraryEntity>?,
      QQueryOperations> userSelectionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userSelections');
    });
  }
}
