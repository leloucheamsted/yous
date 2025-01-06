import 'package:youscribe/core/entities/product_entity.dart';

extension ProductExtensions on ProductEntity {
  bool hasMp3() {
    return _hasMp3(extensions);
  }

  bool _hasMp3(List<String> extensions) {
    return extensions.contains("mp3") || extensions.contains("zip");
  }

  bool canFollowTheme() {
    if (isPress() || isDocument()) {
      return false;
    }

    return true;
  }

  bool isPress() {
    return _isPressCategory(categoryId);
  }

  bool _isPressCategory(int? categoryId) {
    if (categoryId == null) {
      return false;
    }

    if (categoryId != 67) {
      return categoryId == 68;
    }

    return true;
  }

  bool isDocumentCategory(int? categoryId) {
    final source = [62, 63, 64, 65, 66, 75, 76];
    if (categoryId != null) {
      return source.any((id) => id == categoryId);
    }

    return false;
  }

  bool isDocument() {
    return isDocumentCategory(categoryId);
  }
}
