// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_search_output_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionSearchOutputItemModel _$CollectionSearchOutputItemModelFromJson(
        Map<String, dynamic> json) =>
    CollectionSearchOutputItemModel(
      id: json['Id'] as int?,
      title: json['Title'] as String?,
      products: (json['Products'] as List<dynamic>?)
          ?.map((e) => CollectionSearchProductOutputItemModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      productsOrder: (json['ProductsOrder'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(int.parse(k), e as int),
      ),
      thumbnailUrlS: json['ThumbnailUrlS'] as String?,
      thumbnailUrlM: json['ThumbnailUrlM'] as String?,
      thumbnailUrlL: json['ThumbnailUrlL'] as String?,
      thumbnailurlsWebp: json['ThumbnailurlS_webp'] as String?,
      thumbnailurlmWebp: json['ThumbnailurlM_webp'] as String?,
      thumbnailurllWebp: json['ThumbnailurlL_webp'] as String?,
      isAdultContent: json['IsAdultContent'] as bool?,
      isVisible: json['IsVisible'] as bool?,
      pertinenceWeight: (json['PertinenceWeight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CollectionSearchOutputItemModelToJson(
        CollectionSearchOutputItemModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Title': instance.title,
      'Products': instance.products,
      'ProductsOrder':
          instance.productsOrder?.map((k, e) => MapEntry(k.toString(), e)),
      'ThumbnailUrlS': instance.thumbnailUrlS,
      'ThumbnailUrlM': instance.thumbnailUrlM,
      'ThumbnailUrlL': instance.thumbnailUrlL,
      'ThumbnailurlS_webp': instance.thumbnailurlsWebp,
      'ThumbnailurlM_webp': instance.thumbnailurlmWebp,
      'ThumbnailurlL_webp': instance.thumbnailurllWebp,
      'IsAdultContent': instance.isAdultContent,
      'IsVisible': instance.isVisible,
      'PertinenceWeight': instance.pertinenceWeight,
    };
