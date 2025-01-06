// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteModel _$FavoriteModelFromJson(Map<String, dynamic> json) =>
    FavoriteModel(
      favoritedDate: json['FavoritedDate'] == null
          ? null
          : DateTime.parse(json['FavoritedDate'] as String),
      product: json['Product'] == null
          ? null
          : ProductModel.fromJson(json['Product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoriteModelToJson(FavoriteModel instance) =>
    <String, dynamic>{
      'FavoritedDate': instance.favoritedDate?.toIso8601String(),
      'Product': instance.product,
    };
