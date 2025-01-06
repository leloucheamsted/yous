// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_search_output_item_entity.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CollectionSearchOutputItemEntitySchema = Schema(
  name: r'CollectionSearchOutputItemEntity',
  id: -545916256547928028,
  properties: {
    r'id': PropertySchema(
      id: 0,
      name: r'id',
      type: IsarType.long,
    ),
    r'isAdultContent': PropertySchema(
      id: 1,
      name: r'isAdultContent',
      type: IsarType.bool,
    ),
    r'isVisible': PropertySchema(
      id: 2,
      name: r'isVisible',
      type: IsarType.bool,
    ),
    r'pertinenceWeight': PropertySchema(
      id: 3,
      name: r'pertinenceWeight',
      type: IsarType.double,
    ),
    r'thumbnailUrlL': PropertySchema(
      id: 4,
      name: r'thumbnailUrlL',
      type: IsarType.string,
    ),
    r'thumbnailUrlM': PropertySchema(
      id: 5,
      name: r'thumbnailUrlM',
      type: IsarType.string,
    ),
    r'thumbnailUrlS': PropertySchema(
      id: 6,
      name: r'thumbnailUrlS',
      type: IsarType.string,
    ),
    r'thumbnailurllWebp': PropertySchema(
      id: 7,
      name: r'thumbnailurllWebp',
      type: IsarType.string,
    ),
    r'thumbnailurlmWebp': PropertySchema(
      id: 8,
      name: r'thumbnailurlmWebp',
      type: IsarType.string,
    ),
    r'thumbnailurlsWebp': PropertySchema(
      id: 9,
      name: r'thumbnailurlsWebp',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 10,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _collectionSearchOutputItemEntityEstimateSize,
  serialize: _collectionSearchOutputItemEntitySerialize,
  deserialize: _collectionSearchOutputItemEntityDeserialize,
  deserializeProp: _collectionSearchOutputItemEntityDeserializeProp,
);

int _collectionSearchOutputItemEntityEstimateSize(
  CollectionSearchOutputItemEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.thumbnailUrlL;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.thumbnailUrlM;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.thumbnailUrlS;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.thumbnailurllWebp;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.thumbnailurlmWebp;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.thumbnailurlsWebp;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _collectionSearchOutputItemEntitySerialize(
  CollectionSearchOutputItemEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.id);
  writer.writeBool(offsets[1], object.isAdultContent);
  writer.writeBool(offsets[2], object.isVisible);
  writer.writeDouble(offsets[3], object.pertinenceWeight);
  writer.writeString(offsets[4], object.thumbnailUrlL);
  writer.writeString(offsets[5], object.thumbnailUrlM);
  writer.writeString(offsets[6], object.thumbnailUrlS);
  writer.writeString(offsets[7], object.thumbnailurllWebp);
  writer.writeString(offsets[8], object.thumbnailurlmWebp);
  writer.writeString(offsets[9], object.thumbnailurlsWebp);
  writer.writeString(offsets[10], object.title);
}

CollectionSearchOutputItemEntity _collectionSearchOutputItemEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CollectionSearchOutputItemEntity();
  object.id = reader.readLongOrNull(offsets[0]);
  object.isAdultContent = reader.readBoolOrNull(offsets[1]);
  object.isVisible = reader.readBoolOrNull(offsets[2]);
  object.pertinenceWeight = reader.readDoubleOrNull(offsets[3]);
  object.thumbnailUrlL = reader.readStringOrNull(offsets[4]);
  object.thumbnailUrlM = reader.readStringOrNull(offsets[5]);
  object.thumbnailUrlS = reader.readStringOrNull(offsets[6]);
  object.thumbnailurllWebp = reader.readStringOrNull(offsets[7]);
  object.thumbnailurlmWebp = reader.readStringOrNull(offsets[8]);
  object.thumbnailurlsWebp = reader.readStringOrNull(offsets[9]);
  object.title = reader.readStringOrNull(offsets[10]);
  return object;
}

P _collectionSearchOutputItemEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CollectionSearchOutputItemEntityQueryFilter on QueryBuilder<
    CollectionSearchOutputItemEntity,
    CollectionSearchOutputItemEntity,
    QFilterCondition> {
  QueryBuilder<CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> idEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity, QAfterFilterCondition> idBetween(
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

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> isAdultContentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isAdultContent',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> isAdultContentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isAdultContent',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> isAdultContentEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isAdultContent',
        value: value,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> isVisibleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isVisible',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> isVisibleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isVisible',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> isVisibleEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isVisible',
        value: value,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> pertinenceWeightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pertinenceWeight',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> pertinenceWeightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pertinenceWeight',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> pertinenceWeightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pertinenceWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> pertinenceWeightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pertinenceWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> pertinenceWeightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pertinenceWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> pertinenceWeightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pertinenceWeight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlLIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'thumbnailUrlL',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlLIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'thumbnailUrlL',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlLEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailUrlL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlLGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'thumbnailUrlL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlLLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'thumbnailUrlL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlLBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'thumbnailUrlL',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlLStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'thumbnailUrlL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlLEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'thumbnailUrlL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
          CollectionSearchOutputItemEntity, QAfterFilterCondition>
      thumbnailUrlLContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'thumbnailUrlL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
          CollectionSearchOutputItemEntity, QAfterFilterCondition>
      thumbnailUrlLMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'thumbnailUrlL',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlLIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailUrlL',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlLIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'thumbnailUrlL',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlMIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'thumbnailUrlM',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlMIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'thumbnailUrlM',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlMEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailUrlM',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlMGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'thumbnailUrlM',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlMLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'thumbnailUrlM',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlMBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'thumbnailUrlM',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlMStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'thumbnailUrlM',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlMEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'thumbnailUrlM',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
          CollectionSearchOutputItemEntity, QAfterFilterCondition>
      thumbnailUrlMContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'thumbnailUrlM',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
          CollectionSearchOutputItemEntity, QAfterFilterCondition>
      thumbnailUrlMMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'thumbnailUrlM',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlMIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailUrlM',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlMIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'thumbnailUrlM',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlSIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'thumbnailUrlS',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlSIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'thumbnailUrlS',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlSEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailUrlS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlSGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'thumbnailUrlS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlSLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'thumbnailUrlS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlSBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'thumbnailUrlS',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlSStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'thumbnailUrlS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlSEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'thumbnailUrlS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
          CollectionSearchOutputItemEntity, QAfterFilterCondition>
      thumbnailUrlSContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'thumbnailUrlS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
          CollectionSearchOutputItemEntity, QAfterFilterCondition>
      thumbnailUrlSMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'thumbnailUrlS',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlSIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailUrlS',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailUrlSIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'thumbnailUrlS',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurllWebpIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'thumbnailurllWebp',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurllWebpIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'thumbnailurllWebp',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurllWebpEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailurllWebp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurllWebpGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'thumbnailurllWebp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurllWebpLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'thumbnailurllWebp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurllWebpBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'thumbnailurllWebp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurllWebpStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'thumbnailurllWebp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurllWebpEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'thumbnailurllWebp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
          CollectionSearchOutputItemEntity, QAfterFilterCondition>
      thumbnailurllWebpContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'thumbnailurllWebp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
          CollectionSearchOutputItemEntity, QAfterFilterCondition>
      thumbnailurllWebpMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'thumbnailurllWebp',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurllWebpIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailurllWebp',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurllWebpIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'thumbnailurllWebp',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlmWebpIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'thumbnailurlmWebp',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlmWebpIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'thumbnailurlmWebp',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlmWebpEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailurlmWebp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlmWebpGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'thumbnailurlmWebp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlmWebpLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'thumbnailurlmWebp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlmWebpBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'thumbnailurlmWebp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlmWebpStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'thumbnailurlmWebp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlmWebpEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'thumbnailurlmWebp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
          CollectionSearchOutputItemEntity, QAfterFilterCondition>
      thumbnailurlmWebpContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'thumbnailurlmWebp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
          CollectionSearchOutputItemEntity, QAfterFilterCondition>
      thumbnailurlmWebpMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'thumbnailurlmWebp',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlmWebpIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailurlmWebp',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlmWebpIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'thumbnailurlmWebp',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlsWebpIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'thumbnailurlsWebp',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlsWebpIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'thumbnailurlsWebp',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlsWebpEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailurlsWebp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlsWebpGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'thumbnailurlsWebp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlsWebpLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'thumbnailurlsWebp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlsWebpBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'thumbnailurlsWebp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlsWebpStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'thumbnailurlsWebp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlsWebpEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'thumbnailurlsWebp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
          CollectionSearchOutputItemEntity, QAfterFilterCondition>
      thumbnailurlsWebpContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'thumbnailurlsWebp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
          CollectionSearchOutputItemEntity, QAfterFilterCondition>
      thumbnailurlsWebpMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'thumbnailurlsWebp',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlsWebpIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailurlsWebp',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> thumbnailurlsWebpIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'thumbnailurlsWebp',
        value: '',
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity, QAfterFilterCondition> titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity, QAfterFilterCondition> titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity, QAfterFilterCondition> titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity, QAfterFilterCondition> titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity, QAfterFilterCondition> titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
          CollectionSearchOutputItemEntity, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
          CollectionSearchOutputItemEntity, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CollectionSearchOutputItemEntity,
      CollectionSearchOutputItemEntity,
      QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension CollectionSearchOutputItemEntityQueryObject on QueryBuilder<
    CollectionSearchOutputItemEntity,
    CollectionSearchOutputItemEntity,
    QFilterCondition> {}
