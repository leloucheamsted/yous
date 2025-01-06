// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBookmarkEntityCollection on Isar {
  IsarCollection<BookmarkEntity> get bookmarkEntitys => this.collection();
}

const BookmarkEntitySchema = CollectionSchema(
  name: r'BookmarkEntity',
  id: -7369956597930324689,
  properties: {
    r'bookmarkId': PropertySchema(
      id: 0,
      name: r'bookmarkId',
      type: IsarType.long,
    ),
    r'contentCFI': PropertySchema(
      id: 1,
      name: r'contentCFI',
      type: IsarType.string,
    ),
    r'dateSynchronized': PropertySchema(
      id: 2,
      name: r'dateSynchronized',
      type: IsarType.dateTime,
    ),
    r'dateUpdate': PropertySchema(
      id: 3,
      name: r'dateUpdate',
      type: IsarType.dateTime,
    ),
    r'deleted': PropertySchema(
      id: 4,
      name: r'deleted',
      type: IsarType.bool,
    ),
    r'idRef': PropertySchema(
      id: 5,
      name: r'idRef',
      type: IsarType.string,
    ),
    r'note': PropertySchema(
      id: 6,
      name: r'note',
      type: IsarType.string,
    ),
    r'pageNumber': PropertySchema(
      id: 7,
      name: r'pageNumber',
      type: IsarType.long,
    ),
    r'productId': PropertySchema(
      id: 8,
      name: r'productId',
      type: IsarType.long,
    ),
    r'progress': PropertySchema(
      id: 9,
      name: r'progress',
      type: IsarType.long,
    ),
    r'rowId': PropertySchema(
      id: 10,
      name: r'rowId',
      type: IsarType.long,
    ),
    r'synchronized': PropertySchema(
      id: 11,
      name: r'synchronized',
      type: IsarType.bool,
    ),
    r'type': PropertySchema(
      id: 12,
      name: r'type',
      type: IsarType.byte,
      enumMap: _BookmarkEntitytypeEnumValueMap,
    ),
    r'userId': PropertySchema(
      id: 13,
      name: r'userId',
      type: IsarType.long,
    )
  },
  estimateSize: _bookmarkEntityEstimateSize,
  serialize: _bookmarkEntitySerialize,
  deserialize: _bookmarkEntityDeserialize,
  deserializeProp: _bookmarkEntityDeserializeProp,
  idName: r'localId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _bookmarkEntityGetId,
  getLinks: _bookmarkEntityGetLinks,
  attach: _bookmarkEntityAttach,
  version: '3.1.0+1',
);

int _bookmarkEntityEstimateSize(
  BookmarkEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.contentCFI.length * 3;
  bytesCount += 3 + object.idRef.length * 3;
  bytesCount += 3 + object.note.length * 3;
  return bytesCount;
}

void _bookmarkEntitySerialize(
  BookmarkEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.bookmarkId);
  writer.writeString(offsets[1], object.contentCFI);
  writer.writeDateTime(offsets[2], object.dateSynchronized);
  writer.writeDateTime(offsets[3], object.dateUpdate);
  writer.writeBool(offsets[4], object.deleted);
  writer.writeString(offsets[5], object.idRef);
  writer.writeString(offsets[6], object.note);
  writer.writeLong(offsets[7], object.pageNumber);
  writer.writeLong(offsets[8], object.productId);
  writer.writeLong(offsets[9], object.progress);
  writer.writeLong(offsets[10], object.rowId);
  writer.writeBool(offsets[11], object.synchronized);
  writer.writeByte(offsets[12], object.type.index);
  writer.writeLong(offsets[13], object.userId);
}

BookmarkEntity _bookmarkEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BookmarkEntity(
    bookmarkId: reader.readLongOrNull(offsets[0]) ?? 0,
    contentCFI: reader.readStringOrNull(offsets[1]) ?? '',
    dateSynchronized: reader.readDateTimeOrNull(offsets[2]),
    dateUpdate: reader.readDateTimeOrNull(offsets[3]),
    deleted: reader.readBoolOrNull(offsets[4]) ?? false,
    idRef: reader.readStringOrNull(offsets[5]) ?? '',
    localId: id,
    note: reader.readStringOrNull(offsets[6]) ?? '',
    pageNumber: reader.readLong(offsets[7]),
    productId: reader.readLong(offsets[8]),
    progress: reader.readLong(offsets[9]),
    rowId: reader.readLongOrNull(offsets[10]) ?? 0,
    synchronized: reader.readBoolOrNull(offsets[11]),
    type: _BookmarkEntitytypeValueEnumMap[reader.readByteOrNull(offsets[12])] ??
        AccountBookmarkType.auto,
    userId: reader.readLong(offsets[13]),
  );
  return object;
}

P _bookmarkEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 11:
      return (reader.readBoolOrNull(offset)) as P;
    case 12:
      return (_BookmarkEntitytypeValueEnumMap[reader.readByteOrNull(offset)] ??
          AccountBookmarkType.auto) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _BookmarkEntitytypeEnumValueMap = {
  'auto': 0,
  'user': 1,
};
const _BookmarkEntitytypeValueEnumMap = {
  0: AccountBookmarkType.auto,
  1: AccountBookmarkType.user,
};

Id _bookmarkEntityGetId(BookmarkEntity object) {
  return object.localId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _bookmarkEntityGetLinks(BookmarkEntity object) {
  return [];
}

void _bookmarkEntityAttach(
    IsarCollection<dynamic> col, Id id, BookmarkEntity object) {
  object.localId = id;
}

extension BookmarkEntityQueryWhereSort
    on QueryBuilder<BookmarkEntity, BookmarkEntity, QWhere> {
  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterWhere> anyLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BookmarkEntityQueryWhere
    on QueryBuilder<BookmarkEntity, BookmarkEntity, QWhereClause> {
  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterWhereClause>
      localIdEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: localId,
        upper: localId,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterWhereClause>
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

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterWhereClause>
      localIdGreaterThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localId, includeLower: include),
      );
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterWhereClause>
      localIdLessThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localId, includeUpper: include),
      );
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterWhereClause>
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

extension BookmarkEntityQueryFilter
    on QueryBuilder<BookmarkEntity, BookmarkEntity, QFilterCondition> {
  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      bookmarkIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookmarkId',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      bookmarkIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bookmarkId',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      bookmarkIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bookmarkId',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      bookmarkIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bookmarkId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      contentCFIEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentCFI',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      contentCFIGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentCFI',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      contentCFILessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentCFI',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      contentCFIBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentCFI',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      contentCFIStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentCFI',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      contentCFIEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentCFI',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      contentCFIContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentCFI',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      contentCFIMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentCFI',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      contentCFIIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentCFI',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      contentCFIIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentCFI',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      dateSynchronizedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateSynchronized',
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      dateSynchronizedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateSynchronized',
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      dateSynchronizedEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateSynchronized',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      dateSynchronizedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateSynchronized',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      dateSynchronizedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateSynchronized',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      dateSynchronizedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateSynchronized',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      dateUpdateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateUpdate',
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      dateUpdateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateUpdate',
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      dateUpdateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateUpdate',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      dateUpdateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateUpdate',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      dateUpdateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateUpdate',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      dateUpdateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateUpdate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      deletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deleted',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      idRefEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      idRefGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      idRefLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      idRefBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idRef',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      idRefStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'idRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      idRefEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'idRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      idRefContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'idRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      idRefMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'idRef',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      idRefIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idRef',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      idRefIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'idRef',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      localIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      localIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      localIdEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
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

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
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

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
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

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      noteEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      noteGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      noteLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      noteBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'note',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      noteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      noteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'note',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      pageNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pageNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      pageNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pageNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      pageNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pageNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      pageNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pageNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      productIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productId',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      productIdGreaterThan(
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

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      productIdLessThan(
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

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      productIdBetween(
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

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      progressEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'progress',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      progressGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'progress',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      progressLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'progress',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      progressBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'progress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      rowIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rowId',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      rowIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rowId',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      rowIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rowId',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      rowIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rowId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      synchronizedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'synchronized',
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      synchronizedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'synchronized',
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      synchronizedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'synchronized',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      typeEqualTo(AccountBookmarkType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      typeGreaterThan(
    AccountBookmarkType value, {
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

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      typeLessThan(
    AccountBookmarkType value, {
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

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      typeBetween(
    AccountBookmarkType lower,
    AccountBookmarkType upper, {
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

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      userIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      userIdGreaterThan(
    int value, {
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

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      userIdLessThan(
    int value, {
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

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterFilterCondition>
      userIdBetween(
    int lower,
    int upper, {
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

extension BookmarkEntityQueryObject
    on QueryBuilder<BookmarkEntity, BookmarkEntity, QFilterCondition> {}

extension BookmarkEntityQueryLinks
    on QueryBuilder<BookmarkEntity, BookmarkEntity, QFilterCondition> {}

extension BookmarkEntityQuerySortBy
    on QueryBuilder<BookmarkEntity, BookmarkEntity, QSortBy> {
  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      sortByBookmarkId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarkId', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      sortByBookmarkIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarkId', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      sortByContentCFI() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentCFI', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      sortByContentCFIDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentCFI', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      sortByDateSynchronized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSynchronized', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      sortByDateSynchronizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSynchronized', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      sortByDateUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateUpdate', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      sortByDateUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateUpdate', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> sortByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      sortByDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> sortByIdRef() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idRef', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> sortByIdRefDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idRef', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      sortByPageNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      sortByPageNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> sortByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      sortByProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> sortByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      sortByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> sortByRowId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowId', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> sortByRowIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowId', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      sortBySynchronized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synchronized', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      sortBySynchronizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synchronized', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension BookmarkEntityQuerySortThenBy
    on QueryBuilder<BookmarkEntity, BookmarkEntity, QSortThenBy> {
  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      thenByBookmarkId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarkId', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      thenByBookmarkIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarkId', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      thenByContentCFI() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentCFI', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      thenByContentCFIDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentCFI', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      thenByDateSynchronized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSynchronized', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      thenByDateSynchronizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSynchronized', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      thenByDateUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateUpdate', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      thenByDateUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateUpdate', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> thenByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      thenByDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> thenByIdRef() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idRef', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> thenByIdRefDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idRef', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      thenByPageNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      thenByPageNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> thenByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      thenByProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> thenByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      thenByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> thenByRowId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowId', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> thenByRowIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowId', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      thenBySynchronized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synchronized', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      thenBySynchronizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synchronized', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension BookmarkEntityQueryWhereDistinct
    on QueryBuilder<BookmarkEntity, BookmarkEntity, QDistinct> {
  QueryBuilder<BookmarkEntity, BookmarkEntity, QDistinct>
      distinctByBookmarkId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookmarkId');
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QDistinct> distinctByContentCFI(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentCFI', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QDistinct>
      distinctByDateSynchronized() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateSynchronized');
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QDistinct>
      distinctByDateUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateUpdate');
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QDistinct> distinctByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deleted');
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QDistinct> distinctByIdRef(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idRef', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QDistinct> distinctByNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QDistinct>
      distinctByPageNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pageNumber');
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QDistinct>
      distinctByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'productId');
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QDistinct> distinctByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'progress');
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QDistinct> distinctByRowId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rowId');
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QDistinct>
      distinctBySynchronized() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'synchronized');
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<BookmarkEntity, BookmarkEntity, QDistinct> distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId');
    });
  }
}

extension BookmarkEntityQueryProperty
    on QueryBuilder<BookmarkEntity, BookmarkEntity, QQueryProperty> {
  QueryBuilder<BookmarkEntity, int, QQueryOperations> localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<BookmarkEntity, int, QQueryOperations> bookmarkIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookmarkId');
    });
  }

  QueryBuilder<BookmarkEntity, String, QQueryOperations> contentCFIProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentCFI');
    });
  }

  QueryBuilder<BookmarkEntity, DateTime?, QQueryOperations>
      dateSynchronizedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateSynchronized');
    });
  }

  QueryBuilder<BookmarkEntity, DateTime?, QQueryOperations>
      dateUpdateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateUpdate');
    });
  }

  QueryBuilder<BookmarkEntity, bool, QQueryOperations> deletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deleted');
    });
  }

  QueryBuilder<BookmarkEntity, String, QQueryOperations> idRefProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idRef');
    });
  }

  QueryBuilder<BookmarkEntity, String, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<BookmarkEntity, int, QQueryOperations> pageNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pageNumber');
    });
  }

  QueryBuilder<BookmarkEntity, int, QQueryOperations> productIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'productId');
    });
  }

  QueryBuilder<BookmarkEntity, int, QQueryOperations> progressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'progress');
    });
  }

  QueryBuilder<BookmarkEntity, int, QQueryOperations> rowIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rowId');
    });
  }

  QueryBuilder<BookmarkEntity, bool?, QQueryOperations> synchronizedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'synchronized');
    });
  }

  QueryBuilder<BookmarkEntity, AccountBookmarkType, QQueryOperations>
      typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<BookmarkEntity, int, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
