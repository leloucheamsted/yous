// ignore_for_file: annotate_overrides

import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/models/responses/bookmark_model.dart';

part 'bookmark_entity.g.dart';

@Collection()
class BookmarkEntity extends BaseEntity {
  BookmarkEntity({
    required this.userId,
    required this.productId,
    required this.pageNumber,
    required this.progress,
    this.idRef = '',
    this.rowId = 0,
    this.bookmarkId = 0,
    this.contentCFI = '',
    this.note = '',
    this.deleted = false,
    DateTime? dateUpdate,
    this.dateSynchronized,
    this.synchronized,
    this.type = AccountBookmarkType.auto,
    super.localId,
  }) : dateUpdate = dateUpdate ?? DateTime.now();

  BookmarkEntity copyFromBookmarkModel(BookmarkModel bookmark) {
    return BookmarkEntity(
        userId: 0,
        productId: bookmark.productId,
        bookmarkId: bookmark.id,
        idRef: bookmark.idRef!,
        contentCFI: bookmark.contentCFI!,
        note: bookmark.note!,
        dateUpdate: DateTime.now(),
        dateSynchronized: DateTime.now(),
        pageNumber: bookmark.pageNumber,
        progress: bookmark.progress.toInt(),
        type: AccountBookmarkType.user);
  }

  late int rowId;
  late int userId;
  late int productId;
  late int bookmarkId;
  late String idRef;
  late String contentCFI;
  late String note;
  late bool deleted;
  late DateTime? dateUpdate;
  late DateTime? dateSynchronized;
  late bool? synchronized;
  late int pageNumber;
  late int progress;
  @ignore
  Duration get progressDuration => Duration(seconds: progress);
  @enumerated
  late final AccountBookmarkType type;

  BookmarkEntity copyWith({
    int? rowId,
    int? userId,
    int? productId,
    int? bookmarkId,
    String? idRef,
    String? contentCFI,
    String? note,
    bool? deleted,
    DateTime? dateUpdate,
    DateTime? dateSynchronized,
    bool? synchronized,
    int? pageNumber,
    int? progress,
    AccountBookmarkType? type,
    int? localId,
  }) {
    return BookmarkEntity(
      localId: localId ?? this.localId,
      rowId: rowId ?? this.rowId,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      bookmarkId: bookmarkId ?? this.bookmarkId,
      idRef: idRef ?? this.idRef,
      contentCFI: contentCFI ?? this.contentCFI,
      note: note ?? this.note,
      deleted: deleted ?? this.deleted,
      dateUpdate: dateUpdate ?? this.dateUpdate,
      dateSynchronized: dateSynchronized ?? this.dateSynchronized,
      synchronized: synchronized ?? this.synchronized,
      pageNumber: pageNumber ?? this.pageNumber,
      progress: progress ?? this.progress,
      type: type ?? this.type,
    );
  }
}
