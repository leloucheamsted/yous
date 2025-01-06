// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_configuration_entity.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CountryConfigurationEntitySchema = Schema(
  name: r'CountryConfigurationEntity',
  id: -2433813836898433900,
  properties: {
    r'countryCode': PropertySchema(
      id: 0,
      name: r'countryCode',
      type: IsarType.string,
    ),
    r'defaultCobranding': PropertySchema(
      id: 1,
      name: r'defaultCobranding',
      type: IsarType.string,
    ),
    r'facebookAllowed': PropertySchema(
      id: 2,
      name: r'facebookAllowed',
      type: IsarType.bool,
    ),
    r'garAuthRedirectUrl': PropertySchema(
      id: 3,
      name: r'garAuthRedirectUrl',
      type: IsarType.string,
    ),
    r'garEnabled': PropertySchema(
      id: 4,
      name: r'garEnabled',
      type: IsarType.bool,
    ),
    r'garLogoutUrl': PropertySchema(
      id: 5,
      name: r'garLogoutUrl',
      type: IsarType.string,
    ),
    r'inAppPurchaseAllowed': PropertySchema(
      id: 6,
      name: r'inAppPurchaseAllowed',
      type: IsarType.bool,
    ),
    r'registerAllowed': PropertySchema(
      id: 7,
      name: r'registerAllowed',
      type: IsarType.bool,
    ),
    r'registerPopup': PropertySchema(
      id: 8,
      name: r'registerPopup',
      type: IsarType.object,
      target: r'CountryConfigPopupEntity',
    )
  },
  estimateSize: _countryConfigurationEntityEstimateSize,
  serialize: _countryConfigurationEntitySerialize,
  deserialize: _countryConfigurationEntityDeserialize,
  deserializeProp: _countryConfigurationEntityDeserializeProp,
);

int _countryConfigurationEntityEstimateSize(
  CountryConfigurationEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.countryCode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.defaultCobranding;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.garAuthRedirectUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.garLogoutUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.registerPopup;
    if (value != null) {
      bytesCount += 3 +
          CountryConfigPopupEntitySchema.estimateSize(
              value, allOffsets[CountryConfigPopupEntity]!, allOffsets);
    }
  }
  return bytesCount;
}

void _countryConfigurationEntitySerialize(
  CountryConfigurationEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.countryCode);
  writer.writeString(offsets[1], object.defaultCobranding);
  writer.writeBool(offsets[2], object.facebookAllowed);
  writer.writeString(offsets[3], object.garAuthRedirectUrl);
  writer.writeBool(offsets[4], object.garEnabled);
  writer.writeString(offsets[5], object.garLogoutUrl);
  writer.writeBool(offsets[6], object.inAppPurchaseAllowed);
  writer.writeBool(offsets[7], object.registerAllowed);
  writer.writeObject<CountryConfigPopupEntity>(
    offsets[8],
    allOffsets,
    CountryConfigPopupEntitySchema.serialize,
    object.registerPopup,
  );
}

CountryConfigurationEntity _countryConfigurationEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CountryConfigurationEntity();
  object.countryCode = reader.readStringOrNull(offsets[0]);
  object.defaultCobranding = reader.readStringOrNull(offsets[1]);
  object.facebookAllowed = reader.readBoolOrNull(offsets[2]);
  object.garAuthRedirectUrl = reader.readStringOrNull(offsets[3]);
  object.garEnabled = reader.readBoolOrNull(offsets[4]);
  object.garLogoutUrl = reader.readStringOrNull(offsets[5]);
  object.inAppPurchaseAllowed = reader.readBoolOrNull(offsets[6]);
  object.registerAllowed = reader.readBoolOrNull(offsets[7]);
  object.registerPopup = reader.readObjectOrNull<CountryConfigPopupEntity>(
    offsets[8],
    CountryConfigPopupEntitySchema.deserialize,
    allOffsets,
  );
  return object;
}

P _countryConfigurationEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readBoolOrNull(offset)) as P;
    case 7:
      return (reader.readBoolOrNull(offset)) as P;
    case 8:
      return (reader.readObjectOrNull<CountryConfigPopupEntity>(
        offset,
        CountryConfigPopupEntitySchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CountryConfigurationEntityQueryFilter on QueryBuilder<
    CountryConfigurationEntity, CountryConfigurationEntity, QFilterCondition> {
  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> countryCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'countryCode',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> countryCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'countryCode',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> countryCodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'countryCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> countryCodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'countryCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> countryCodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'countryCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> countryCodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'countryCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> countryCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'countryCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> countryCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'countryCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
          QAfterFilterCondition>
      countryCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'countryCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
          QAfterFilterCondition>
      countryCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'countryCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> countryCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'countryCode',
        value: '',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> countryCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'countryCode',
        value: '',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> defaultCobrandingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'defaultCobranding',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> defaultCobrandingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'defaultCobranding',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> defaultCobrandingEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultCobranding',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> defaultCobrandingGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultCobranding',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> defaultCobrandingLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultCobranding',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> defaultCobrandingBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultCobranding',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> defaultCobrandingStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'defaultCobranding',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> defaultCobrandingEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'defaultCobranding',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
          QAfterFilterCondition>
      defaultCobrandingContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'defaultCobranding',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
          QAfterFilterCondition>
      defaultCobrandingMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'defaultCobranding',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> defaultCobrandingIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultCobranding',
        value: '',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> defaultCobrandingIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'defaultCobranding',
        value: '',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> facebookAllowedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'facebookAllowed',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> facebookAllowedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'facebookAllowed',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> facebookAllowedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'facebookAllowed',
        value: value,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garAuthRedirectUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'garAuthRedirectUrl',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garAuthRedirectUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'garAuthRedirectUrl',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garAuthRedirectUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'garAuthRedirectUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garAuthRedirectUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'garAuthRedirectUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garAuthRedirectUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'garAuthRedirectUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garAuthRedirectUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'garAuthRedirectUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garAuthRedirectUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'garAuthRedirectUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garAuthRedirectUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'garAuthRedirectUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
          QAfterFilterCondition>
      garAuthRedirectUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'garAuthRedirectUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
          QAfterFilterCondition>
      garAuthRedirectUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'garAuthRedirectUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garAuthRedirectUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'garAuthRedirectUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garAuthRedirectUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'garAuthRedirectUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garEnabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'garEnabled',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garEnabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'garEnabled',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garEnabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'garEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garLogoutUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'garLogoutUrl',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garLogoutUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'garLogoutUrl',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garLogoutUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'garLogoutUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garLogoutUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'garLogoutUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garLogoutUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'garLogoutUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garLogoutUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'garLogoutUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garLogoutUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'garLogoutUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garLogoutUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'garLogoutUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
          QAfterFilterCondition>
      garLogoutUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'garLogoutUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
          QAfterFilterCondition>
      garLogoutUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'garLogoutUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garLogoutUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'garLogoutUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> garLogoutUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'garLogoutUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> inAppPurchaseAllowedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'inAppPurchaseAllowed',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> inAppPurchaseAllowedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'inAppPurchaseAllowed',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> inAppPurchaseAllowedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inAppPurchaseAllowed',
        value: value,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> registerAllowedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'registerAllowed',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> registerAllowedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'registerAllowed',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> registerAllowedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'registerAllowed',
        value: value,
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> registerPopupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'registerPopup',
      ));
    });
  }

  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
      QAfterFilterCondition> registerPopupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'registerPopup',
      ));
    });
  }
}

extension CountryConfigurationEntityQueryObject on QueryBuilder<
    CountryConfigurationEntity, CountryConfigurationEntity, QFilterCondition> {
  QueryBuilder<CountryConfigurationEntity, CountryConfigurationEntity,
          QAfterFilterCondition>
      registerPopup(FilterQuery<CountryConfigPopupEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'registerPopup');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CountryConfigPopupEntitySchema = Schema(
  name: r'CountryConfigPopupEntity',
  id: -3022561486430497314,
  properties: {
    r'bottomText': PropertySchema(
      id: 0,
      name: r'bottomText',
      type: IsarType.stringList,
    ),
    r'buttons': PropertySchema(
      id: 1,
      name: r'buttons',
      type: IsarType.objectList,
      target: r'CountryConfigRegisterPopupButtonEntity',
    ),
    r'title': PropertySchema(
      id: 2,
      name: r'title',
      type: IsarType.string,
    ),
    r'topText': PropertySchema(
      id: 3,
      name: r'topText',
      type: IsarType.stringList,
    )
  },
  estimateSize: _countryConfigPopupEntityEstimateSize,
  serialize: _countryConfigPopupEntitySerialize,
  deserialize: _countryConfigPopupEntityDeserialize,
  deserializeProp: _countryConfigPopupEntityDeserializeProp,
);

int _countryConfigPopupEntityEstimateSize(
  CountryConfigPopupEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.bottomText;
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
    final list = object.buttons;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CountryConfigRegisterPopupButtonEntity]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              CountryConfigRegisterPopupButtonEntitySchema.estimateSize(
                  value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.topText;
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
  return bytesCount;
}

void _countryConfigPopupEntitySerialize(
  CountryConfigPopupEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.bottomText);
  writer.writeObjectList<CountryConfigRegisterPopupButtonEntity>(
    offsets[1],
    allOffsets,
    CountryConfigRegisterPopupButtonEntitySchema.serialize,
    object.buttons,
  );
  writer.writeString(offsets[2], object.title);
  writer.writeStringList(offsets[3], object.topText);
}

CountryConfigPopupEntity _countryConfigPopupEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CountryConfigPopupEntity(
    bottomText: reader.readStringList(offsets[0]),
    buttons: reader.readObjectList<CountryConfigRegisterPopupButtonEntity>(
      offsets[1],
      CountryConfigRegisterPopupButtonEntitySchema.deserialize,
      allOffsets,
      CountryConfigRegisterPopupButtonEntity(),
    ),
    title: reader.readStringOrNull(offsets[2]),
    topText: reader.readStringList(offsets[3]),
  );
  return object;
}

P _countryConfigPopupEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset)) as P;
    case 1:
      return (reader.readObjectList<CountryConfigRegisterPopupButtonEntity>(
        offset,
        CountryConfigRegisterPopupButtonEntitySchema.deserialize,
        allOffsets,
        CountryConfigRegisterPopupButtonEntity(),
      )) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringList(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CountryConfigPopupEntityQueryFilter on QueryBuilder<
    CountryConfigPopupEntity, CountryConfigPopupEntity, QFilterCondition> {
  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> bottomTextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bottomText',
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> bottomTextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bottomText',
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> bottomTextElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bottomText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> bottomTextElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bottomText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> bottomTextElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bottomText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> bottomTextElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bottomText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> bottomTextElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bottomText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> bottomTextElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bottomText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
          QAfterFilterCondition>
      bottomTextElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bottomText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
          QAfterFilterCondition>
      bottomTextElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bottomText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> bottomTextElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bottomText',
        value: '',
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> bottomTextElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bottomText',
        value: '',
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> bottomTextLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bottomText',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> bottomTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bottomText',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> bottomTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bottomText',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> bottomTextLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bottomText',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> bottomTextLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bottomText',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> bottomTextLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bottomText',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> buttonsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'buttons',
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> buttonsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'buttons',
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> buttonsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'buttons',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> buttonsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'buttons',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> buttonsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'buttons',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> buttonsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'buttons',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> buttonsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'buttons',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> buttonsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'buttons',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> titleEqualTo(
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

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> titleGreaterThan(
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

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> titleLessThan(
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

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> titleBetween(
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

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> titleStartsWith(
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

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> titleEndsWith(
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

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
          QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
          QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> topTextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'topText',
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> topTextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'topText',
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> topTextElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> topTextElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'topText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> topTextElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'topText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> topTextElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'topText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> topTextElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'topText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> topTextElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'topText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
          QAfterFilterCondition>
      topTextElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'topText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
          QAfterFilterCondition>
      topTextElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'topText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> topTextElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topText',
        value: '',
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> topTextElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'topText',
        value: '',
      ));
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> topTextLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topText',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> topTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topText',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> topTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topText',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> topTextLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topText',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> topTextLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topText',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
      QAfterFilterCondition> topTextLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topText',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension CountryConfigPopupEntityQueryObject on QueryBuilder<
    CountryConfigPopupEntity, CountryConfigPopupEntity, QFilterCondition> {
  QueryBuilder<CountryConfigPopupEntity, CountryConfigPopupEntity,
          QAfterFilterCondition>
      buttonsElement(FilterQuery<CountryConfigRegisterPopupButtonEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'buttons');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CountryConfigRegisterPopupButtonEntitySchema = Schema(
  name: r'CountryConfigRegisterPopupButtonEntity',
  id: 5028260991806922626,
  properties: {
    r'smsCode': PropertySchema(
      id: 0,
      name: r'smsCode',
      type: IsarType.string,
    ),
    r'smsPhoneNumber': PropertySchema(
      id: 1,
      name: r'smsPhoneNumber',
      type: IsarType.string,
    ),
    r'text': PropertySchema(
      id: 2,
      name: r'text',
      type: IsarType.string,
    )
  },
  estimateSize: _countryConfigRegisterPopupButtonEntityEstimateSize,
  serialize: _countryConfigRegisterPopupButtonEntitySerialize,
  deserialize: _countryConfigRegisterPopupButtonEntityDeserialize,
  deserializeProp: _countryConfigRegisterPopupButtonEntityDeserializeProp,
);

int _countryConfigRegisterPopupButtonEntityEstimateSize(
  CountryConfigRegisterPopupButtonEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.smsCode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.smsPhoneNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.text;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _countryConfigRegisterPopupButtonEntitySerialize(
  CountryConfigRegisterPopupButtonEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.smsCode);
  writer.writeString(offsets[1], object.smsPhoneNumber);
  writer.writeString(offsets[2], object.text);
}

CountryConfigRegisterPopupButtonEntity
    _countryConfigRegisterPopupButtonEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CountryConfigRegisterPopupButtonEntity(
    smsCode: reader.readStringOrNull(offsets[0]),
    smsPhoneNumber: reader.readStringOrNull(offsets[1]),
    text: reader.readStringOrNull(offsets[2]),
  );
  return object;
}

P _countryConfigRegisterPopupButtonEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CountryConfigRegisterPopupButtonEntityQueryFilter on QueryBuilder<
    CountryConfigRegisterPopupButtonEntity,
    CountryConfigRegisterPopupButtonEntity,
    QFilterCondition> {
  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'smsCode',
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'smsCode',
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsCodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'smsCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsCodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'smsCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsCodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'smsCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsCodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'smsCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'smsCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'smsCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigRegisterPopupButtonEntity,
          CountryConfigRegisterPopupButtonEntity, QAfterFilterCondition>
      smsCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'smsCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigRegisterPopupButtonEntity,
          CountryConfigRegisterPopupButtonEntity, QAfterFilterCondition>
      smsCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'smsCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'smsCode',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'smsCode',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsPhoneNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'smsPhoneNumber',
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsPhoneNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'smsPhoneNumber',
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsPhoneNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'smsPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsPhoneNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'smsPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsPhoneNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'smsPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsPhoneNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'smsPhoneNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsPhoneNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'smsPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsPhoneNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'smsPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigRegisterPopupButtonEntity,
          CountryConfigRegisterPopupButtonEntity, QAfterFilterCondition>
      smsPhoneNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'smsPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigRegisterPopupButtonEntity,
          CountryConfigRegisterPopupButtonEntity, QAfterFilterCondition>
      smsPhoneNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'smsPhoneNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsPhoneNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'smsPhoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> smsPhoneNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'smsPhoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> textIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'text',
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> textIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'text',
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> textEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> textGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> textLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> textBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigRegisterPopupButtonEntity,
          CountryConfigRegisterPopupButtonEntity, QAfterFilterCondition>
      textContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CountryConfigRegisterPopupButtonEntity,
          CountryConfigRegisterPopupButtonEntity, QAfterFilterCondition>
      textMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CountryConfigRegisterPopupButtonEntity,
      CountryConfigRegisterPopupButtonEntity,
      QAfterFilterCondition> textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }
}

extension CountryConfigRegisterPopupButtonEntityQueryObject on QueryBuilder<
    CountryConfigRegisterPopupButtonEntity,
    CountryConfigRegisterPopupButtonEntity,
    QFilterCondition> {}
