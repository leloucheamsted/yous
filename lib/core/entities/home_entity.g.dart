// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHomeEntityCollection on Isar {
  IsarCollection<HomeEntity> get homeEntitys => this.collection();
}

const HomeEntitySchema = CollectionSchema(
  name: r'HomeEntity',
  id: 796260444144022460,
  properties: {
    r'collections': PropertySchema(
      id: 0,
      name: r'collections',
      type: IsarType.objectList,
      target: r'CollectionSearchOutputItemEntity',
    ),
    r'editorials': PropertySchema(
      id: 1,
      name: r'editorials',
      type: IsarType.objectList,
      target: r'EditorialEntity',
    ),
    r'selections': PropertySchema(
      id: 2,
      name: r'selections',
      type: IsarType.objectList,
      target: r'SelectionEntity',
    )
  },
  estimateSize: _homeEntityEstimateSize,
  serialize: _homeEntitySerialize,
  deserialize: _homeEntityDeserialize,
  deserializeProp: _homeEntityDeserializeProp,
  idName: r'localId',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'EditorialEntity': EditorialEntitySchema,
    r'SelectionEntity': SelectionEntitySchema,
    r'CollectionSearchOutputItemEntity': CollectionSearchOutputItemEntitySchema
  },
  getId: _homeEntityGetId,
  getLinks: _homeEntityGetLinks,
  attach: _homeEntityAttach,
  version: '3.1.0+1',
);

int _homeEntityEstimateSize(
  HomeEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.collections.length * 3;
  {
    final offsets = allOffsets[CollectionSearchOutputItemEntity]!;
    for (var i = 0; i < object.collections.length; i++) {
      final value = object.collections[i];
      bytesCount += CollectionSearchOutputItemEntitySchema.estimateSize(
          value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.editorials.length * 3;
  {
    final offsets = allOffsets[EditorialEntity]!;
    for (var i = 0; i < object.editorials.length; i++) {
      final value = object.editorials[i];
      bytesCount +=
          EditorialEntitySchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.selections.length * 3;
  {
    final offsets = allOffsets[SelectionEntity]!;
    for (var i = 0; i < object.selections.length; i++) {
      final value = object.selections[i];
      bytesCount +=
          SelectionEntitySchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _homeEntitySerialize(
  HomeEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<CollectionSearchOutputItemEntity>(
    offsets[0],
    allOffsets,
    CollectionSearchOutputItemEntitySchema.serialize,
    object.collections,
  );
  writer.writeObjectList<EditorialEntity>(
    offsets[1],
    allOffsets,
    EditorialEntitySchema.serialize,
    object.editorials,
  );
  writer.writeObjectList<SelectionEntity>(
    offsets[2],
    allOffsets,
    SelectionEntitySchema.serialize,
    object.selections,
  );
}

HomeEntity _homeEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HomeEntity(
    collections: reader.readObjectList<CollectionSearchOutputItemEntity>(
          offsets[0],
          CollectionSearchOutputItemEntitySchema.deserialize,
          allOffsets,
          CollectionSearchOutputItemEntity(),
        ) ??
        [],
    editorials: reader.readObjectList<EditorialEntity>(
          offsets[1],
          EditorialEntitySchema.deserialize,
          allOffsets,
          EditorialEntity(),
        ) ??
        [],
    localId: id,
    selections: reader.readObjectList<SelectionEntity>(
          offsets[2],
          SelectionEntitySchema.deserialize,
          allOffsets,
          SelectionEntity(),
        ) ??
        [],
  );
  return object;
}

P _homeEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<CollectionSearchOutputItemEntity>(
            offset,
            CollectionSearchOutputItemEntitySchema.deserialize,
            allOffsets,
            CollectionSearchOutputItemEntity(),
          ) ??
          []) as P;
    case 1:
      return (reader.readObjectList<EditorialEntity>(
            offset,
            EditorialEntitySchema.deserialize,
            allOffsets,
            EditorialEntity(),
          ) ??
          []) as P;
    case 2:
      return (reader.readObjectList<SelectionEntity>(
            offset,
            SelectionEntitySchema.deserialize,
            allOffsets,
            SelectionEntity(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _homeEntityGetId(HomeEntity object) {
  return object.localId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _homeEntityGetLinks(HomeEntity object) {
  return [];
}

void _homeEntityAttach(IsarCollection<dynamic> col, Id id, HomeEntity object) {
  object.localId = id;
}

extension HomeEntityQueryWhereSort
    on QueryBuilder<HomeEntity, HomeEntity, QWhere> {
  QueryBuilder<HomeEntity, HomeEntity, QAfterWhere> anyLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HomeEntityQueryWhere
    on QueryBuilder<HomeEntity, HomeEntity, QWhereClause> {
  QueryBuilder<HomeEntity, HomeEntity, QAfterWhereClause> localIdEqualTo(
      Id localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: localId,
        upper: localId,
      ));
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterWhereClause> localIdNotEqualTo(
      Id localId) {
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

  QueryBuilder<HomeEntity, HomeEntity, QAfterWhereClause> localIdGreaterThan(
      Id localId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localId, includeLower: include),
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterWhereClause> localIdLessThan(
      Id localId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localId, includeUpper: include),
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterWhereClause> localIdBetween(
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

extension HomeEntityQueryFilter
    on QueryBuilder<HomeEntity, HomeEntity, QFilterCondition> {
  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      collectionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'collections',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      collectionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'collections',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      collectionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'collections',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      collectionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'collections',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      collectionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'collections',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      collectionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'collections',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      editorialsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'editorials',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      editorialsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'editorials',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      editorialsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'editorials',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      editorialsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'editorials',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      editorialsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'editorials',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      editorialsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'editorials',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition> localIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      localIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition> localIdEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
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

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition> localIdLessThan(
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

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition> localIdBetween(
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

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      selectionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selections',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      selectionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selections',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      selectionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selections',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      selectionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selections',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      selectionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selections',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      selectionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selections',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension HomeEntityQueryObject
    on QueryBuilder<HomeEntity, HomeEntity, QFilterCondition> {
  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition>
      collectionsElement(FilterQuery<CollectionSearchOutputItemEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'collections');
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition> editorialsElement(
      FilterQuery<EditorialEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'editorials');
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterFilterCondition> selectionsElement(
      FilterQuery<SelectionEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'selections');
    });
  }
}

extension HomeEntityQueryLinks
    on QueryBuilder<HomeEntity, HomeEntity, QFilterCondition> {}

extension HomeEntityQuerySortBy
    on QueryBuilder<HomeEntity, HomeEntity, QSortBy> {}

extension HomeEntityQuerySortThenBy
    on QueryBuilder<HomeEntity, HomeEntity, QSortThenBy> {
  QueryBuilder<HomeEntity, HomeEntity, QAfterSortBy> thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<HomeEntity, HomeEntity, QAfterSortBy> thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }
}

extension HomeEntityQueryWhereDistinct
    on QueryBuilder<HomeEntity, HomeEntity, QDistinct> {}

extension HomeEntityQueryProperty
    on QueryBuilder<HomeEntity, HomeEntity, QQueryProperty> {
  QueryBuilder<HomeEntity, int, QQueryOperations> localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<HomeEntity, List<CollectionSearchOutputItemEntity>,
      QQueryOperations> collectionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'collections');
    });
  }

  QueryBuilder<HomeEntity, List<EditorialEntity>, QQueryOperations>
      editorialsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'editorials');
    });
  }

  QueryBuilder<HomeEntity, List<SelectionEntity>, QQueryOperations>
      selectionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selections');
    });
  }
}
