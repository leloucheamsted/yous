// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canalplus_config_entity.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CanalplusConfigEntitySchema = Schema(
  name: r'CanalplusConfigEntity',
  id: -3573221490863355487,
  properties: {
    r'allowed': PropertySchema(
      id: 0,
      name: r'allowed',
      type: IsarType.bool,
    ),
    r'notSubscriberMessage': PropertySchema(
      id: 1,
      name: r'notSubscriberMessage',
      type: IsarType.objectList,
      target: r'CanalPlusConfigTextItemEntity',
    )
  },
  estimateSize: _canalplusConfigEntityEstimateSize,
  serialize: _canalplusConfigEntitySerialize,
  deserialize: _canalplusConfigEntityDeserialize,
  deserializeProp: _canalplusConfigEntityDeserializeProp,
);

int _canalplusConfigEntityEstimateSize(
  CanalplusConfigEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.notSubscriberMessage;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CanalPlusConfigTextItemEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CanalPlusConfigTextItemEntitySchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _canalplusConfigEntitySerialize(
  CanalplusConfigEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.allowed);
  writer.writeObjectList<CanalPlusConfigTextItemEntity>(
    offsets[1],
    allOffsets,
    CanalPlusConfigTextItemEntitySchema.serialize,
    object.notSubscriberMessage,
  );
}

CanalplusConfigEntity _canalplusConfigEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CanalplusConfigEntity(
    allowed: reader.readBoolOrNull(offsets[0]),
    notSubscriberMessage: reader.readObjectList<CanalPlusConfigTextItemEntity>(
      offsets[1],
      CanalPlusConfigTextItemEntitySchema.deserialize,
      allOffsets,
      CanalPlusConfigTextItemEntity(),
    ),
  );
  return object;
}

P _canalplusConfigEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readObjectList<CanalPlusConfigTextItemEntity>(
        offset,
        CanalPlusConfigTextItemEntitySchema.deserialize,
        allOffsets,
        CanalPlusConfigTextItemEntity(),
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CanalplusConfigEntityQueryFilter on QueryBuilder<
    CanalplusConfigEntity, CanalplusConfigEntity, QFilterCondition> {
  QueryBuilder<CanalplusConfigEntity, CanalplusConfigEntity,
      QAfterFilterCondition> allowedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'allowed',
      ));
    });
  }

  QueryBuilder<CanalplusConfigEntity, CanalplusConfigEntity,
      QAfterFilterCondition> allowedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'allowed',
      ));
    });
  }

  QueryBuilder<CanalplusConfigEntity, CanalplusConfigEntity,
      QAfterFilterCondition> allowedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allowed',
        value: value,
      ));
    });
  }

  QueryBuilder<CanalplusConfigEntity, CanalplusConfigEntity,
      QAfterFilterCondition> notSubscriberMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notSubscriberMessage',
      ));
    });
  }

  QueryBuilder<CanalplusConfigEntity, CanalplusConfigEntity,
      QAfterFilterCondition> notSubscriberMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notSubscriberMessage',
      ));
    });
  }

  QueryBuilder<CanalplusConfigEntity, CanalplusConfigEntity,
      QAfterFilterCondition> notSubscriberMessageLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notSubscriberMessage',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CanalplusConfigEntity, CanalplusConfigEntity,
      QAfterFilterCondition> notSubscriberMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notSubscriberMessage',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CanalplusConfigEntity, CanalplusConfigEntity,
      QAfterFilterCondition> notSubscriberMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notSubscriberMessage',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CanalplusConfigEntity, CanalplusConfigEntity,
      QAfterFilterCondition> notSubscriberMessageLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notSubscriberMessage',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CanalplusConfigEntity, CanalplusConfigEntity,
      QAfterFilterCondition> notSubscriberMessageLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notSubscriberMessage',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CanalplusConfigEntity, CanalplusConfigEntity,
      QAfterFilterCondition> notSubscriberMessageLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notSubscriberMessage',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension CanalplusConfigEntityQueryObject on QueryBuilder<
    CanalplusConfigEntity, CanalplusConfigEntity, QFilterCondition> {
  QueryBuilder<CanalplusConfigEntity, CanalplusConfigEntity,
          QAfterFilterCondition>
      notSubscriberMessageElement(
          FilterQuery<CanalPlusConfigTextItemEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'notSubscriberMessage');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CanalPlusConfigTextItemEntitySchema = Schema(
  name: r'CanalPlusConfigTextItemEntity',
  id: -3237028030733820577,
  properties: {
    r'type': PropertySchema(
      id: 0,
      name: r'type',
      type: IsarType.byte,
      enumMap: _CanalPlusConfigTextItemEntitytypeEnumValueMap,
    ),
    r'value': PropertySchema(
      id: 1,
      name: r'value',
      type: IsarType.string,
    )
  },
  estimateSize: _canalPlusConfigTextItemEntityEstimateSize,
  serialize: _canalPlusConfigTextItemEntitySerialize,
  deserialize: _canalPlusConfigTextItemEntityDeserialize,
  deserializeProp: _canalPlusConfigTextItemEntityDeserializeProp,
);

int _canalPlusConfigTextItemEntityEstimateSize(
  CanalPlusConfigTextItemEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.value;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _canalPlusConfigTextItemEntitySerialize(
  CanalPlusConfigTextItemEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.type.index);
  writer.writeString(offsets[1], object.value);
}

CanalPlusConfigTextItemEntity _canalPlusConfigTextItemEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CanalPlusConfigTextItemEntity(
    type: _CanalPlusConfigTextItemEntitytypeValueEnumMap[
            reader.readByteOrNull(offsets[0])] ??
        CanalPlusConfigTextItemType.text,
    value: reader.readStringOrNull(offsets[1]),
  );
  return object;
}

P _canalPlusConfigTextItemEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_CanalPlusConfigTextItemEntitytypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          CanalPlusConfigTextItemType.text) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CanalPlusConfigTextItemEntitytypeEnumValueMap = {
  'text': 0,
  'link': 1,
};
const _CanalPlusConfigTextItemEntitytypeValueEnumMap = {
  0: CanalPlusConfigTextItemType.text,
  1: CanalPlusConfigTextItemType.link,
};

extension CanalPlusConfigTextItemEntityQueryFilter on QueryBuilder<
    CanalPlusConfigTextItemEntity,
    CanalPlusConfigTextItemEntity,
    QFilterCondition> {
  QueryBuilder<CanalPlusConfigTextItemEntity, CanalPlusConfigTextItemEntity,
      QAfterFilterCondition> typeEqualTo(CanalPlusConfigTextItemType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<CanalPlusConfigTextItemEntity, CanalPlusConfigTextItemEntity,
      QAfterFilterCondition> typeGreaterThan(
    CanalPlusConfigTextItemType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<CanalPlusConfigTextItemEntity, CanalPlusConfigTextItemEntity,
      QAfterFilterCondition> typeLessThan(
    CanalPlusConfigTextItemType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<CanalPlusConfigTextItemEntity, CanalPlusConfigTextItemEntity,
      QAfterFilterCondition> typeBetween(
    CanalPlusConfigTextItemType lower,
    CanalPlusConfigTextItemType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CanalPlusConfigTextItemEntity, CanalPlusConfigTextItemEntity,
      QAfterFilterCondition> valueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'value',
      ));
    });
  }

  QueryBuilder<CanalPlusConfigTextItemEntity, CanalPlusConfigTextItemEntity,
      QAfterFilterCondition> valueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'value',
      ));
    });
  }

  QueryBuilder<CanalPlusConfigTextItemEntity, CanalPlusConfigTextItemEntity,
      QAfterFilterCondition> valueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CanalPlusConfigTextItemEntity, CanalPlusConfigTextItemEntity,
      QAfterFilterCondition> valueGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CanalPlusConfigTextItemEntity, CanalPlusConfigTextItemEntity,
      QAfterFilterCondition> valueLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CanalPlusConfigTextItemEntity, CanalPlusConfigTextItemEntity,
      QAfterFilterCondition> valueBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CanalPlusConfigTextItemEntity, CanalPlusConfigTextItemEntity,
      QAfterFilterCondition> valueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CanalPlusConfigTextItemEntity, CanalPlusConfigTextItemEntity,
      QAfterFilterCondition> valueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CanalPlusConfigTextItemEntity, CanalPlusConfigTextItemEntity,
          QAfterFilterCondition>
      valueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CanalPlusConfigTextItemEntity, CanalPlusConfigTextItemEntity,
          QAfterFilterCondition>
      valueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'value',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CanalPlusConfigTextItemEntity, CanalPlusConfigTextItemEntity,
      QAfterFilterCondition> valueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: '',
      ));
    });
  }

  QueryBuilder<CanalPlusConfigTextItemEntity, CanalPlusConfigTextItemEntity,
      QAfterFilterCondition> valueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'value',
        value: '',
      ));
    });
  }
}

extension CanalPlusConfigTextItemEntityQueryObject on QueryBuilder<
    CanalPlusConfigTextItemEntity,
    CanalPlusConfigTextItemEntity,
    QFilterCondition> {}
