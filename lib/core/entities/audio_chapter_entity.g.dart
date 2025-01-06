// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_chapter_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAudioChapterEntityCollection on Isar {
  IsarCollection<AudioChapterEntity> get audioChapterEntitys =>
      this.collection();
}

const AudioChapterEntitySchema = CollectionSchema(
  name: r'AudioChapterEntity',
  id: 8206735665650728681,
  properties: {
    r'chapterDuration': PropertySchema(
      id: 0,
      name: r'chapterDuration',
      type: IsarType.double,
    ),
    r'chapterFileName': PropertySchema(
      id: 1,
      name: r'chapterFileName',
      type: IsarType.string,
    ),
    r'chapterRealDuration': PropertySchema(
      id: 2,
      name: r'chapterRealDuration',
      type: IsarType.double,
    ),
    r'documentId': PropertySchema(
      id: 3,
      name: r'documentId',
      type: IsarType.long,
    ),
    r'isExtract': PropertySchema(
      id: 4,
      name: r'isExtract',
      type: IsarType.bool,
    ),
    r'mediaRealPath': PropertySchema(
      id: 5,
      name: r'mediaRealPath',
      type: IsarType.string,
    ),
    r'mediaUrl': PropertySchema(
      id: 6,
      name: r'mediaUrl',
      type: IsarType.string,
    ),
    r'orderId': PropertySchema(
      id: 7,
      name: r'orderId',
      type: IsarType.long,
    ),
    r'productId': PropertySchema(
      id: 8,
      name: r'productId',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 9,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _audioChapterEntityEstimateSize,
  serialize: _audioChapterEntitySerialize,
  deserialize: _audioChapterEntityDeserialize,
  deserializeProp: _audioChapterEntityDeserializeProp,
  idName: r'localId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _audioChapterEntityGetId,
  getLinks: _audioChapterEntityGetLinks,
  attach: _audioChapterEntityAttach,
  version: '3.1.0+1',
);

int _audioChapterEntityEstimateSize(
  AudioChapterEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.chapterFileName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.mediaRealPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.mediaUrl.length * 3;
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _audioChapterEntitySerialize(
  AudioChapterEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.chapterDuration);
  writer.writeString(offsets[1], object.chapterFileName);
  writer.writeDouble(offsets[2], object.chapterRealDuration);
  writer.writeLong(offsets[3], object.documentId);
  writer.writeBool(offsets[4], object.isExtract);
  writer.writeString(offsets[5], object.mediaRealPath);
  writer.writeString(offsets[6], object.mediaUrl);
  writer.writeLong(offsets[7], object.orderId);
  writer.writeLong(offsets[8], object.productId);
  writer.writeString(offsets[9], object.title);
}

AudioChapterEntity _audioChapterEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AudioChapterEntity(
    chapterDuration: reader.readDoubleOrNull(offsets[0]),
    chapterFileName: reader.readStringOrNull(offsets[1]),
    chapterRealDuration: reader.readDoubleOrNull(offsets[2]),
    documentId: reader.readLong(offsets[3]),
    isExtract: reader.readBoolOrNull(offsets[4]),
    mediaRealPath: reader.readStringOrNull(offsets[5]),
    mediaUrl: reader.readString(offsets[6]),
    orderId: reader.readLong(offsets[7]),
    productId: reader.readLong(offsets[8]),
    title: reader.readStringOrNull(offsets[9]),
  );
  object.localId = id;
  return object;
}

P _audioChapterEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _audioChapterEntityGetId(AudioChapterEntity object) {
  return object.localId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _audioChapterEntityGetLinks(
    AudioChapterEntity object) {
  return [];
}

void _audioChapterEntityAttach(
    IsarCollection<dynamic> col, Id id, AudioChapterEntity object) {
  object.localId = id;
}

extension AudioChapterEntityQueryWhereSort
    on QueryBuilder<AudioChapterEntity, AudioChapterEntity, QWhere> {
  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterWhere>
      anyLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AudioChapterEntityQueryWhere
    on QueryBuilder<AudioChapterEntity, AudioChapterEntity, QWhereClause> {
  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterWhereClause>
      localIdEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: localId,
        upper: localId,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterWhereClause>
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

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterWhereClause>
      localIdGreaterThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localId, includeLower: include),
      );
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterWhereClause>
      localIdLessThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localId, includeUpper: include),
      );
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterWhereClause>
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

extension AudioChapterEntityQueryFilter
    on QueryBuilder<AudioChapterEntity, AudioChapterEntity, QFilterCondition> {
  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterDurationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chapterDuration',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterDurationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chapterDuration',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterDurationEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterDuration',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterDurationGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chapterDuration',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterDurationLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chapterDuration',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterDurationBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chapterDuration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterFileNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chapterFileName',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterFileNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chapterFileName',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterFileNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterFileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterFileNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chapterFileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterFileNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chapterFileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterFileNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chapterFileName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterFileNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chapterFileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterFileNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chapterFileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterFileNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chapterFileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterFileNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chapterFileName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterFileNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterFileName',
        value: '',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterFileNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chapterFileName',
        value: '',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterRealDurationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chapterRealDuration',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterRealDurationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chapterRealDuration',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterRealDurationEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterRealDuration',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterRealDurationGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chapterRealDuration',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterRealDurationLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chapterRealDuration',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      chapterRealDurationBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chapterRealDuration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      documentIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentId',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      documentIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'documentId',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      documentIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'documentId',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      documentIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'documentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      isExtractIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isExtract',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      isExtractIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isExtract',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      isExtractEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isExtract',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      localIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      localIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      localIdEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
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

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
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

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
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

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaRealPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mediaRealPath',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaRealPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mediaRealPath',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaRealPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaRealPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaRealPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mediaRealPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaRealPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mediaRealPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaRealPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mediaRealPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaRealPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mediaRealPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaRealPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mediaRealPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaRealPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mediaRealPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaRealPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mediaRealPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaRealPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaRealPath',
        value: '',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaRealPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mediaRealPath',
        value: '',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mediaUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mediaUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mediaUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mediaUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mediaUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mediaUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mediaUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      mediaUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mediaUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      orderIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderId',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      orderIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orderId',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      orderIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orderId',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      orderIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      productIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productId',
        value: value,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
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

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
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

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
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

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      titleEqualTo(
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

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      titleGreaterThan(
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

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      titleLessThan(
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

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      titleBetween(
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

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      titleStartsWith(
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

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      titleEndsWith(
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

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension AudioChapterEntityQueryObject
    on QueryBuilder<AudioChapterEntity, AudioChapterEntity, QFilterCondition> {}

extension AudioChapterEntityQueryLinks
    on QueryBuilder<AudioChapterEntity, AudioChapterEntity, QFilterCondition> {}

extension AudioChapterEntityQuerySortBy
    on QueryBuilder<AudioChapterEntity, AudioChapterEntity, QSortBy> {
  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByChapterDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterDuration', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByChapterDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterDuration', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByChapterFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterFileName', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByChapterFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterFileName', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByChapterRealDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterRealDuration', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByChapterRealDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterRealDuration', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByDocumentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentId', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByDocumentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentId', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByIsExtract() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExtract', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByIsExtractDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExtract', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByMediaRealPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaRealPath', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByMediaRealPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaRealPath', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByMediaUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaUrl', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByMediaUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaUrl', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension AudioChapterEntityQuerySortThenBy
    on QueryBuilder<AudioChapterEntity, AudioChapterEntity, QSortThenBy> {
  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByChapterDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterDuration', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByChapterDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterDuration', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByChapterFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterFileName', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByChapterFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterFileName', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByChapterRealDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterRealDuration', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByChapterRealDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterRealDuration', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByDocumentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentId', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByDocumentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentId', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByIsExtract() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExtract', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByIsExtractDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExtract', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByMediaRealPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaRealPath', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByMediaRealPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaRealPath', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByMediaUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaUrl', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByMediaUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaUrl', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.desc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension AudioChapterEntityQueryWhereDistinct
    on QueryBuilder<AudioChapterEntity, AudioChapterEntity, QDistinct> {
  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QDistinct>
      distinctByChapterDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapterDuration');
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QDistinct>
      distinctByChapterFileName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapterFileName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QDistinct>
      distinctByChapterRealDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapterRealDuration');
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QDistinct>
      distinctByDocumentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'documentId');
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QDistinct>
      distinctByIsExtract() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isExtract');
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QDistinct>
      distinctByMediaRealPath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaRealPath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QDistinct>
      distinctByMediaUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QDistinct>
      distinctByOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderId');
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QDistinct>
      distinctByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'productId');
    });
  }

  QueryBuilder<AudioChapterEntity, AudioChapterEntity, QDistinct>
      distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension AudioChapterEntityQueryProperty
    on QueryBuilder<AudioChapterEntity, AudioChapterEntity, QQueryProperty> {
  QueryBuilder<AudioChapterEntity, int, QQueryOperations> localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<AudioChapterEntity, double?, QQueryOperations>
      chapterDurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapterDuration');
    });
  }

  QueryBuilder<AudioChapterEntity, String?, QQueryOperations>
      chapterFileNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapterFileName');
    });
  }

  QueryBuilder<AudioChapterEntity, double?, QQueryOperations>
      chapterRealDurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapterRealDuration');
    });
  }

  QueryBuilder<AudioChapterEntity, int, QQueryOperations> documentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'documentId');
    });
  }

  QueryBuilder<AudioChapterEntity, bool?, QQueryOperations>
      isExtractProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isExtract');
    });
  }

  QueryBuilder<AudioChapterEntity, String?, QQueryOperations>
      mediaRealPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaRealPath');
    });
  }

  QueryBuilder<AudioChapterEntity, String, QQueryOperations>
      mediaUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaUrl');
    });
  }

  QueryBuilder<AudioChapterEntity, int, QQueryOperations> orderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderId');
    });
  }

  QueryBuilder<AudioChapterEntity, int, QQueryOperations> productIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'productId');
    });
  }

  QueryBuilder<AudioChapterEntity, String?, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
