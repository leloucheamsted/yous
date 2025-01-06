import 'package:youscribe/core/entities/editorial_entity.dart';
import 'package:youscribe/core/entities/selection_model.dart';
import 'package:youscribe/core/models/responses/home_v3_content_model.dart';
import 'package:youscribe/data/data_sources/base_remote_data_source.dart';
import 'package:youscribe/data/data_sources/home_data_sources/home_remote_data_source.dart';

class HomeRemoteDataSourceImpl extends BaseRemoteDataSource
    implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({required super.dio, required super.appSettings});

  Future<(List<EditorialEntity>, List<SelectionEntity>)> getHomeV3(
      String language, bool shouldGetLargeImages) async {
    final response = await getWithType<Map<String, dynamic>>(
        '${appSettings.mobileAPIUrl}/v3/home?lng=$language');

    final home = HomeV3ContentModel.fromJson(response.data!);
    final List<EditorialEntity> edito = [];
    List<SelectionEntity> selections = [];

    for (final item in home.editorialItems!) {
      String imageUrl = '';
      String mImage = item.imageKeyOriginalM!;
      String sImage = item.imageKeyOriginalS!;

      if (item.imageKeyM != null && item.imageKeyM!.isNotEmpty) {
        mImage = item.imageKeyM!;
      }
      if (item.imageKeyS != null && item.imageKeyS!.isNotEmpty) {
        sImage = item.imageKeyS!;
      }

      imageUrl = shouldGetLargeImages
          ? '${appSettings.editorialBaseImageUrl}/$mImage'
          : '${appSettings.editorialBaseImageUrl}/$sImage';

      edito.add(EditorialEntity(
        imageUrl: imageUrl,
        link: item.ctaUrl,
        typeId: item.brandId,
      ));
    }

    selections =
        home.shelfPushs!.map(SelectionEntity.fromShelfPushContent).toList();

    return (edito, selections);
  }

  @override
  Future<(List<EditorialEntity>, List<SelectionEntity>)> getHome(
      String language, bool shouldGetLargeImages) {
    return getHomeV3(language, shouldGetLargeImages);
  }
}
