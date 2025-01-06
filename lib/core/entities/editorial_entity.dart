import 'package:isar/isar.dart';
import 'package:youscribe/core/models/responses/edito_v3_model.dart';

part 'editorial_entity.g.dart';

@embedded
class EditorialEntity {
  EditorialEntity({this.imageUrl, this.typeId, this.link});
  EditorialEntity.fromEditorialV3Model(bool shouldGetLargeImages,
      String editorialBaseImageUrl, EditoV3Model v3Model) {
    // ignore: unused_local_variable
    String imageUrl = '';
    final String? mImage = v3Model.imageKeyM?.isEmpty ?? true
        ? v3Model.imageKeyOriginalM
        : v3Model.imageKeyM;
    final String? sImage = v3Model.imageKeyS?.isEmpty ?? true
        ? v3Model.imageKeyOriginalS
        : v3Model.imageKeyS;

    imageUrl = shouldGetLargeImages
        ? '$editorialBaseImageUrl/$mImage'
        : '$editorialBaseImageUrl/$sImage';

    // imageUrl = imageUrl;
    link = v3Model.ctaUrl;
    typeId = v3Model.brandId;
  }
  String? imageUrl;
  int? typeId;
  String? link;
}
