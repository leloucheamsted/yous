class PageTurnedEntity {
  PageTurnedEntity({
    required this.percent,
    required this.pageSize,
    required this.pagePosition,
    required this.currentPage,
    this.idRef = '',
    this.contentCFI = '',
    DateTime? eventDate,
  }) : eventDate = eventDate ?? DateTime.now();

  double percent;
  double pageSize;
  double pagePosition;
  String contentCFI;
  String idRef;
  int currentPage;
  DateTime eventDate;
}
