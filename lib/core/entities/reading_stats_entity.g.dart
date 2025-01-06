// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_stats_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetReadingStatsEntityCollection on Isar {
  IsarCollection<ReadingStatsEntity> get readingStatsEntitys =>
      this.collection();
}

const ReadingStatsEntitySchema = CollectionSchema(
  name: r'ReadingStatsEntity',
  id: 5948119768336713567,
  properties: {
    r'count': PropertySchema(
      id: 0,
      name: r'count',
      type: IsarType.long,
    ),
    r'eventDate': PropertySchema(
      id: 1,
      name: r'eventDate',
      type: IsarType.dateTime,
    ),
    r'fromPart': PropertySchema(
      id: 2,
      name: r'fromPart',
      type: IsarType.long,
    ),
    r'productId': PropertySchema(
      id: 3,
      name: r'productId',
      type: IsarType.long,
    ),
    r'second': PropertySchema(
      id: 4,
      name: r'second',
      type: IsarType.long,
    ),
    r'toPart': PropertySchema(
      id: 5,
      name: r'toPart',
      type: IsarType.long,
    ),
    r'trackingId': PropertySchema(
      id: 6,
      name: r'trackingId',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(
      id: 7,
      name: r'userId',
      type: IsarType.long,
    )
  },
  estimateSize: _readingStatsEntityEstimateSize,
  serialize: _readingStatsEntitySerialize,
  deserialize: _readingStatsEntityDeserialize,
  deserializeProp: _readingStatsEntityDeserializeProp,
  idName: r'localId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _readingStatsEntityGetId,
  getLinks: _readingStatsEntityGetLinks,
  attach: _readingStatsEntityAttach,
  version: '3.1.0+1',
);

int _readingStatsEntityEstimateSize(
  ReadingStatsEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.trackingId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _readingStatsEntitySerialize(
  ReadingStatsEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.count);
  writer.writeDateTime(offsets[1], object.eventDate);
  writer.writeLong(offsets[2], object.fromPart);
  writer.writeLong(offsets[3], object.productId);
  writer.writeLong(offsets[4], object.second);
  writer.writeLong(offsets[5], object.toPart);
  writer.writeString(offsets[6], object.trackingId);
  writer.writeLong(offsets[7], object.userId);
}

ReadingStatsEntity _readingStatsEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ReadingStatsEntity();
  object.count = reader.readLongOrNull(offsets[0]);
  object.eventDate = reader.readDateTimeOrNull(offsets[1]);
  object.fromPart = reader.readLongOrNull(offsets[2]);
  object.localId = id;
  object.productId = reader.readLongOrNull(offsets[3]);
  object.second = reader.readLongOrNull(offsets[4]);
  object.toPart = reader.readLongOrNull(offsets[5]);
  object.trackingId = reader.readStringOrNull(offsets[6]);
  object.userId = reader.readLongOrNull(offsets[7]);
  return object;
}

P _readingStatsEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _readingStatsEntityGetId(ReadingStatsEntity object) {
  return object.localId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _readingStatsEntityGetLinks(
    ReadingStatsEntity object) {
  return [];
}

void _readingStatsEntityAttach(
    IsarCollection<dynamic> col, Id id, ReadingStatsEntity object) {
  object.localId = id;
}

extension ReadingStatsEntityQueryWhereSort
    on QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QWhere> {
  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterWhere>
      anyLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ReadingStatsEntityQueryWhere
    on QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QWhereClause> {
  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterWhereClause>
      localIdEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: localId,
        upper: localId,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterWhereClause>
      localIdNotEqualTo(Id localId) {
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

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterWhereClause>
      localIdGreaterThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localId, includeLower: include),
      );
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterWhereClause>
      localIdLessThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localId, includeUpper: include),
      );
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterWhereClause>
      localIdBetween(
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

extension ReadingStatsEntityQueryFilter
    on QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QFilterCondition> {
  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      countIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'count',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      countIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'count',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      countEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'count',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      countGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'count',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      countLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'count',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      countBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'count',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      eventDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'eventDate',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      eventDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'eventDate',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      eventDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      eventDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'eventDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      eventDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'eventDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      eventDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'eventDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      fromPartIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fromPart',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      fromPartIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fromPart',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      fromPartEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromPart',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      fromPartGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fromPart',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      fromPartLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fromPart',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      fromPartBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fromPart',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      localIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      localIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      localIdEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      localIdGreaterThan(
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

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      localIdLessThan(
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

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      localIdBetween(
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

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      productIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'productId',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      productIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'productId',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      productIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productId',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      productIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productId',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      productIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productId',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      productIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      secondIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'second',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      secondIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'second',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      secondEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'second',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      secondGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'second',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      secondLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'second',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      secondBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'second',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      toPartIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'toPart',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      toPartIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'toPart',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      toPartEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toPart',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      toPartGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toPart',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      toPartLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toPart',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      toPartBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toPart',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      trackingIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trackingId',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      trackingIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trackingId',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      trackingIdEqualTo(
    String? value, {
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

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      trackingIdGreaterThan(
    String? value, {
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

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      trackingIdLessThan(
    String? value, {
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

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      trackingIdBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      trackingIdStartsWith(
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

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      trackingIdEndsWith(
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

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      trackingIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'trackingId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      trackingIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'trackingId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      trackingIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackingId',
        value: '',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      trackingIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trackingId',
        value: '',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      userIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      userIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      userIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterFilterCondition>
      userIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ReadingStatsEntityQueryObject
    on QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QFilterCondition> {}

extension ReadingStatsEntityQueryLinks
    on QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QFilterCondition> {}

extension ReadingStatsEntityQuerySortBy
    on QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QSortBy> {
  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      sortByCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.asc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      sortByCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.desc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      sortByEventDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventDate', Sort.asc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      sortByEventDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventDate', Sort.desc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      sortByFromPart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromPart', Sort.asc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      sortByFromPartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromPart', Sort.desc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      sortByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.asc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      sortByProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.desc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      sortBySecond() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'second', Sort.asc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      sortBySecondDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'second', Sort.desc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      sortByToPart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toPart', Sort.asc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      sortByToPartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toPart', Sort.desc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      sortByTrackingId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingId', Sort.asc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      sortByTrackingIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingId', Sort.desc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension ReadingStatsEntityQuerySortThenBy
    on QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QSortThenBy> {
  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      thenByCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.asc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      thenByCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.desc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      thenByEventDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventDate', Sort.asc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      thenByEventDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventDate', Sort.desc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      thenByFromPart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromPart', Sort.asc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      thenByFromPartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromPart', Sort.desc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      thenByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.asc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      thenByProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.desc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      thenBySecond() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'second', Sort.asc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      thenBySecondDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'second', Sort.desc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      thenByToPart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toPart', Sort.asc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      thenByToPartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toPart', Sort.desc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      thenByTrackingId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingId', Sort.asc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      thenByTrackingIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingId', Sort.desc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension ReadingStatsEntityQueryWhereDistinct
    on QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QDistinct> {
  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QDistinct>
      distinctByCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'count');
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QDistinct>
      distinctByEventDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eventDate');
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QDistinct>
      distinctByFromPart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fromPart');
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QDistinct>
      distinctByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'productId');
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QDistinct>
      distinctBySecond() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'second');
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QDistinct>
      distinctByToPart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toPart');
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QDistinct>
      distinctByTrackingId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackingId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QDistinct>
      distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId');
    });
  }
}

extension ReadingStatsEntityQueryProperty
    on QueryBuilder<ReadingStatsEntity, ReadingStatsEntity, QQueryProperty> {
  QueryBuilder<ReadingStatsEntity, int, QQueryOperations> localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<ReadingStatsEntity, int?, QQueryOperations> countProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'count');
    });
  }

  QueryBuilder<ReadingStatsEntity, DateTime?, QQueryOperations>
      eventDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eventDate');
    });
  }

  QueryBuilder<ReadingStatsEntity, int?, QQueryOperations> fromPartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fromPart');
    });
  }

  QueryBuilder<ReadingStatsEntity, int?, QQueryOperations> productIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'productId');
    });
  }

  QueryBuilder<ReadingStatsEntity, int?, QQueryOperations> secondProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'second');
    });
  }

  QueryBuilder<ReadingStatsEntity, int?, QQueryOperations> toPartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toPart');
    });
  }

  QueryBuilder<ReadingStatsEntity, String?, QQueryOperations>
      trackingIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackingId');
    });
  }

  QueryBuilder<ReadingStatsEntity, int?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
