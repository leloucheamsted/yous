// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_document_password_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProductDocumentPasswordEntityCollection on Isar {
  IsarCollection<ProductDocumentPasswordEntity>
      get productDocumentPasswordEntitys => this.collection();
}

const ProductDocumentPasswordEntitySchema = CollectionSchema(
  name: r'ProductDocumentPasswordEntity',
  id: 5470747457444087283,
  properties: {
    r'password': PropertySchema(
      id: 0,
      name: r'password',
      type: IsarType.string,
    ),
    r'productId': PropertySchema(
      id: 1,
      name: r'productId',
      type: IsarType.long,
    )
  },
  estimateSize: _productDocumentPasswordEntityEstimateSize,
  serialize: _productDocumentPasswordEntitySerialize,
  deserialize: _productDocumentPasswordEntityDeserialize,
  deserializeProp: _productDocumentPasswordEntityDeserializeProp,
  idName: r'localId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _productDocumentPasswordEntityGetId,
  getLinks: _productDocumentPasswordEntityGetLinks,
  attach: _productDocumentPasswordEntityAttach,
  version: '3.1.0+1',
);

int _productDocumentPasswordEntityEstimateSize(
  ProductDocumentPasswordEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.password.length * 3;
  return bytesCount;
}

void _productDocumentPasswordEntitySerialize(
  ProductDocumentPasswordEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.password);
  writer.writeLong(offsets[1], object.productId);
}

ProductDocumentPasswordEntity _productDocumentPasswordEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProductDocumentPasswordEntity(
    password: reader.readString(offsets[0]),
    productId: reader.readLong(offsets[1]),
  );
  object.localId = id;
  return object;
}

P _productDocumentPasswordEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _productDocumentPasswordEntityGetId(ProductDocumentPasswordEntity object) {
  return object.localId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _productDocumentPasswordEntityGetLinks(
    ProductDocumentPasswordEntity object) {
  return [];
}

void _productDocumentPasswordEntityAttach(
    IsarCollection<dynamic> col, Id id, ProductDocumentPasswordEntity object) {
  object.localId = id;
}

extension ProductDocumentPasswordEntityQueryWhereSort on QueryBuilder<
    ProductDocumentPasswordEntity, ProductDocumentPasswordEntity, QWhere> {
  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterWhere> anyLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ProductDocumentPasswordEntityQueryWhere on QueryBuilder<
    ProductDocumentPasswordEntity,
    ProductDocumentPasswordEntity,
    QWhereClause> {
  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterWhereClause> localIdEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: localId,
        upper: localId,
      ));
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
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

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
          QAfterWhereClause>
      localIdGreaterThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localId, includeLower: include),
      );
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterWhereClause> localIdLessThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localId, includeUpper: include),
      );
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
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

extension ProductDocumentPasswordEntityQueryFilter on QueryBuilder<
    ProductDocumentPasswordEntity,
    ProductDocumentPasswordEntity,
    QFilterCondition> {
  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterFilterCondition> localIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterFilterCondition> localIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterFilterCondition> localIdEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
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

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
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

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
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

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterFilterCondition> passwordEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterFilterCondition> passwordGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterFilterCondition> passwordLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterFilterCondition> passwordBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'password',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterFilterCondition> passwordStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterFilterCondition> passwordEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
          QAfterFilterCondition>
      passwordContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
          QAfterFilterCondition>
      passwordMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'password',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterFilterCondition> passwordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'password',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterFilterCondition> passwordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'password',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterFilterCondition> productIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productId',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterFilterCondition> productIdGreaterThan(
    int value, {
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

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterFilterCondition> productIdLessThan(
    int value, {
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

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterFilterCondition> productIdBetween(
    int lower,
    int upper, {
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
}

extension ProductDocumentPasswordEntityQueryObject on QueryBuilder<
    ProductDocumentPasswordEntity,
    ProductDocumentPasswordEntity,
    QFilterCondition> {}

extension ProductDocumentPasswordEntityQueryLinks on QueryBuilder<
    ProductDocumentPasswordEntity,
    ProductDocumentPasswordEntity,
    QFilterCondition> {}

extension ProductDocumentPasswordEntityQuerySortBy on QueryBuilder<
    ProductDocumentPasswordEntity, ProductDocumentPasswordEntity, QSortBy> {
  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterSortBy> sortByPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.asc);
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterSortBy> sortByPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.desc);
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterSortBy> sortByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.asc);
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterSortBy> sortByProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.desc);
    });
  }
}

extension ProductDocumentPasswordEntityQuerySortThenBy on QueryBuilder<
    ProductDocumentPasswordEntity, ProductDocumentPasswordEntity, QSortThenBy> {
  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterSortBy> thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterSortBy> thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterSortBy> thenByPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.asc);
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterSortBy> thenByPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.desc);
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterSortBy> thenByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.asc);
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QAfterSortBy> thenByProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.desc);
    });
  }
}

extension ProductDocumentPasswordEntityQueryWhereDistinct on QueryBuilder<
    ProductDocumentPasswordEntity, ProductDocumentPasswordEntity, QDistinct> {
  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QDistinct> distinctByPassword({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'password', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, ProductDocumentPasswordEntity,
      QDistinct> distinctByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'productId');
    });
  }
}

extension ProductDocumentPasswordEntityQueryProperty on QueryBuilder<
    ProductDocumentPasswordEntity,
    ProductDocumentPasswordEntity,
    QQueryProperty> {
  QueryBuilder<ProductDocumentPasswordEntity, int, QQueryOperations>
      localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, String, QQueryOperations>
      passwordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'password');
    });
  }

  QueryBuilder<ProductDocumentPasswordEntity, int, QQueryOperations>
      productIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'productId');
    });
  }
}
