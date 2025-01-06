import 'package:youscribe/core/entities/notification_constants.dart';

class YsNotification {
  YsNotification(this.title, this.body, Map<String, String> data) {
    if (data.containsKey(NotificationConstants.notificationTypeDataName)) {
      if (data[NotificationConstants.notificationTypeDataName] == "OpenUrl") {
        type = YsNotificationType.openUrl;
        if (data.containsKey(NotificationConstants.urlDataName)) {
          urlToOpen = data[NotificationConstants.urlDataName];
        }
      } else if (data[NotificationConstants.notificationTypeDataName] ==
          NotificationConstants.notificationActionDataName) {
        final action = data[NotificationConstants.notificationActionDataName];
        if (action == NotificationConstants.openProductPageAction) {
          type = YsNotificationType.openProductPage;
          final parsedInt =
              int.parse(data[NotificationConstants.productIdDataName] ?? "0");
          productId = parsedInt == 0 ? null : parsedInt;
        } else if (action == NotificationConstants.openAuthorPageAction) {
          type = YsNotificationType.openAuthorPage;
          final parsedInt =
              int.parse(data[NotificationConstants.authorIdDataName] ?? "0");
          authorId = parsedInt == 0 ? null : parsedInt;
        } else if (action == NotificationConstants.openEditorPageAction) {
          type = YsNotificationType.openEditorPage;
          final parsedInt =
              int.parse(data[NotificationConstants.editorIdDataName] ?? "0");
          editorId = parsedInt == 0 ? null : parsedInt;
        } else if (action == NotificationConstants.openSelectionPageAction) {
          type = YsNotificationType.openSelection;
          selectionId = data[NotificationConstants.selectionIdDataName];
        } else if (action == NotificationConstants.openProductListAction) {
          type = YsNotificationType.openProductList;
          //TODO: Handle this later.
        }

        type ??= YsNotificationType.empty;
      }
    }
    if (data.containsKey(NotificationConstants.imageURLDataName)) {
      image = data[NotificationConstants.imageURLDataName];
    }
  }

  late final YsNotificationType? type;
  int? productId;
  int? authorId;
  int? editorId;
  String? selectionId;
  String? image;
  String? urlToOpen;
  final String title;
  final String? body;
}

enum YsNotificationType {
  openUrl,
  openProductPage,
  openProductList,
  openSelection,
  openEditorPage,
  openAuthorPage,
  empty
}
