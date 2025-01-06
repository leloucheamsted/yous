import 'package:youscribe/core/entities/editorial_entity.dart';
import 'package:youscribe/core/entities/selection_model.dart';

// ignore: one_member_abstracts
abstract class HomeRemoteDataSource {
  Future<(List<EditorialEntity> editorials, List<SelectionEntity> selections)>
      getHome(String language, bool shouldGetLargeImages);
}
