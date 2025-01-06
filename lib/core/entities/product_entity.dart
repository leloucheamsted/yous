import 'package:isar/isar.dart';
import 'package:youscribe/core/entities/base/base_entity.dart';
import 'package:youscribe/core/entities/product_category_entity.dart';
import 'package:youscribe/core/entities/product_facet_entity.dart';
import 'package:youscribe/core/models/responses/favorite_model.dart';
import 'package:youscribe/core/models/responses/last_views_model.dart';
import 'package:youscribe/core/models/responses/offline_model.dart';
import 'package:youscribe/core/models/responses/product_commentary_model.dart';
import 'package:youscribe/core/models/responses/product_get_document.dart';
import 'package:youscribe/core/models/responses/product_get_document_format.dart';
import 'package:youscribe/core/models/responses/product_model.dart';
import 'package:youscribe/core/models/responses/product_offer_type.dart';
import 'package:youscribe/core/models/responses/product_search_item_output_model.dart';
import 'package:youscribe/core/models/utilities.dart';

part 'product_entity.g.dart';

@collection
class ProductEntity extends BaseEntity {
  ProductEntity({
    this.id,
    super.localId,
    this.isEditorFollowed = false,
    this.isAuthorFollowed = false,
    this.isRemovedFromOffline = false,
    this.isRemovedFromFavorites = false,
    this.numberOfPages = 0,
    this.collectionTitle = '',
    this.collectionId,
    this.productType = ProductType.book,
    this.title = '',
    this.firstProductDescriptionUrl = '',
    this.favoriteSynced = false,
    this.offlineSynced = false,
    this.lastReadSynced = false,
    this.favoriteAddedLocally = false,
    this.offlineAddedLocally = false,
    this.imageUrl = '',
    this.right = 0,
    this.author = '',
    this.progress = 0.0,
    this.narrator = '',
    this.languageCode = '',
    this.audioChaptersCount = 0,
    this.extensions = const [],
    this.subjects = const [],
    this.ownerDisplayableUserName = '',
    this.ownerUserName = '',
    this.ownerId,
    this.rentalPrice,
    this.categoryId,
    this.themeId,
    this.rootThemeId,
    this.documentProtectionTypeName = '',
    this.languagesIsoCode = const [],
    this.percentageDownloadProgress = 0.0,
    this.isLastRead = false,
    this.isFavorite = false,
    this.isOffline = false,
    this.isFileAvailable = false,
    this.isPremium = false,
    this.theme,
    DateTime? dateLastRead,
    DateTime? dateAddedToFavorites,
    DateTime? dateAddedToOfflines,
    DateTime? dateRemovedFromOfflines,
    DateTime? dateRemovedFromFavorites,
    DateTime? publishDate,
    Duration? estimatedReadTime,
    this.isPublished = false,
    this.origin = '',
    this.isFree = false,
    this.isHomeSuggestion = false,
    this.plainDescription = '',
    this.authorId = 0,
    this.size = 0,
    this.selectionId,
  }) : _description = "" {
    this.dateLastRead = dateLastRead ?? DateTime.now();
    this.dateAddedToFavorites = dateAddedToFavorites ?? DateTime.now();
    this.dateAddedToOfflines = dateAddedToOfflines ?? DateTime.now();
    this.dateRemovedFromOfflines = dateRemovedFromOfflines ?? DateTime.now();
    this.dateRemovedFromFavorites = dateRemovedFromFavorites ?? DateTime.now();
    this.publishDate = publishDate ?? DateTime.now();
    _estimatedReadSeconds = 0;
    _audioBookSeconds = 0;
    _audioBookDuration = Duration.zero;
    _estimatedReadTime = Duration.zero;
    this.estimatedReadTime = estimatedReadTime ?? Duration.zero;
  }

  ProductEntity copyWith({
    String? selectionId,
    int? localId,
    int? id,
    bool? isEditorFollowed,
    bool? isAuthorFollowed,
    bool? isRemovedFromOffline,
    bool? isRemovedFromFavorites,
    int? numberOfPages,
    String? collectionTitle,
    int? collectionId,
    ProductType? productType,
    String? title,
    String? firstProductDescriptionUrl,
    bool? favoriteSynced,
    bool? offlineSynced,
    bool? lastReadSynced,
    bool? favoriteAddedLocally,
    bool? offlineAddedLocally,
    String? imageUrl,
    int? right,
    String? author,
    double? progress,
    String? narrator,
    String? languageCode,
    int? audioChaptersCount,
    List<String>? extensions,
    List<String>? subjects,
    String? ownerDisplayableUserName,
    String? ownerUserName,
    int? ownerId,
    double? rentalPrice,
    int? categoryId,
    int? themeId,
    int? rootThemeId,
    String? documentProtectionTypeName,
    List<String>? languagesIsoCode,
    double? percentageDownloadProgress,
    bool? isLastRead,
    bool? isFavorite,
    bool? isOffline,
    bool? isFileAvailable,
    bool? isPremium,
    DateTime? dateLastRead,
    DateTime? dateAddedToFavorites,
    DateTime? dateAddedToOfflines,
    DateTime? dateRemovedFromOfflines,
    DateTime? dateRemovedFromFavorites,
    DateTime? publishDate,
    bool? isPublished,
    String? origin,
    bool? isFree,
    bool? isHomeSuggestion,
    String? plainDescription,
    int? authorId,
    int? size,
    Duration? estimatedReadTime,
  }) {
    return ProductEntity(
        localId: localId ?? this.localId,
        selectionId: selectionId,
        id: id ?? this.id,
        isEditorFollowed: isEditorFollowed ?? this.isEditorFollowed,
        isAuthorFollowed: isAuthorFollowed ?? this.isAuthorFollowed,
        isRemovedFromOffline: isRemovedFromOffline ?? this.isRemovedFromOffline,
        isRemovedFromFavorites:
            isRemovedFromFavorites ?? this.isRemovedFromFavorites,
        numberOfPages: numberOfPages ?? this.numberOfPages,
        collectionTitle: collectionTitle ?? this.collectionTitle,
        collectionId: collectionId ?? this.collectionId,
        productType: productType ?? this.productType,
        title: title ?? this.title,
        firstProductDescriptionUrl:
            firstProductDescriptionUrl ?? this.firstProductDescriptionUrl,
        favoriteSynced: favoriteSynced ?? this.favoriteSynced,
        offlineSynced: offlineSynced ?? this.offlineSynced,
        lastReadSynced: lastReadSynced ?? this.lastReadSynced,
        favoriteAddedLocally: favoriteAddedLocally ?? this.favoriteAddedLocally,
        offlineAddedLocally: offlineAddedLocally ?? this.offlineAddedLocally,
        imageUrl: imageUrl ?? this.imageUrl,
        right: right ?? this.right,
        author: author ?? this.author,
        progress: progress ?? this.progress,
        narrator: narrator ?? this.narrator,
        languageCode: languageCode ?? this.languageCode,
        audioChaptersCount: audioChaptersCount ?? this.audioChaptersCount,
        extensions: extensions ?? this.extensions,
        subjects: subjects ?? this.subjects,
        ownerDisplayableUserName:
            ownerDisplayableUserName ?? this.ownerDisplayableUserName,
        ownerUserName: ownerUserName ?? this.ownerUserName,
        ownerId: ownerId ?? this.ownerId,
        rentalPrice: rentalPrice ?? this.rentalPrice,
        categoryId: categoryId ?? this.categoryId,
        themeId: themeId ?? this.themeId,
        rootThemeId: rootThemeId ?? this.rootThemeId,
        documentProtectionTypeName:
            documentProtectionTypeName ?? this.documentProtectionTypeName,
        languagesIsoCode: languagesIsoCode ?? this.languagesIsoCode,
        percentageDownloadProgress:
            percentageDownloadProgress ?? this.percentageDownloadProgress,
        isLastRead: isLastRead ?? this.isLastRead,
        isFavorite: isFavorite ?? this.isFavorite,
        isOffline: isOffline ?? this.isOffline,
        isFileAvailable: isFileAvailable ?? this.isFileAvailable,
        isPremium: isPremium ?? this.isPremium,
        dateLastRead: dateLastRead ?? this.dateLastRead,
        dateAddedToFavorites: dateAddedToFavorites ?? this.dateAddedToFavorites,
        dateAddedToOfflines: dateAddedToOfflines ?? this.dateAddedToOfflines,
        dateRemovedFromOfflines:
            dateRemovedFromOfflines ?? this.dateRemovedFromOfflines,
        dateRemovedFromFavorites:
            dateRemovedFromFavorites ?? this.dateRemovedFromFavorites,
        publishDate: publishDate ?? this.publishDate,
        isPublished: isPublished ?? this.isPublished,
        origin: origin ?? this.origin,
        isFree: isFree ?? this.isFree,
        isHomeSuggestion: isHomeSuggestion ?? this.isHomeSuggestion,
        plainDescription: plainDescription ?? this.plainDescription,
        authorId: authorId ?? this.authorId,
        size: size ?? this.size,
        estimatedReadTime: estimatedReadTime);
  }

  static const String mp3Extension = "mp3";
  static const String epubExtension = "epub";
  static const String pdfExtension = "pdf";
  String? selectionId;
  bool? isEditorFollowed;
  bool? isAuthorFollowed;
  bool? isRemovedFromOffline;
  bool? isRemovedFromFavorites;

  int? id;

  int? numberOfPages;
  String? collectionTitle;
  int? collectionId;

  @enumerated
  ProductType productType;

  String? title;

  String? _description;
  String? get description => _description;
  set description(String? description) {
    if (_description != null) {
      plainDescription = parseHtmlToPlainString(description!);
    }
    _description = plainDescription;
  }

  String? firstProductDescriptionUrl;

  bool? favoriteSynced;
  bool? offlineSynced;
  bool? lastReadSynced;
  bool? favoriteAddedLocally;
  bool? offlineAddedLocally;

  String? imageUrl;
  int right;

  String? author;

  double? progress;

  String? narrator;

  String? languageCode;

  int? audioChaptersCount;

  List<String> extensions;
  List<String> subjects;

  late Duration _estimatedReadTime;
  @ignore
  Duration get estimatedReadTime => _estimatedReadTime;
  set estimatedReadTime(Duration value) {
    _estimatedReadTime = value;
    if (_estimatedReadSeconds == 0) {
      _estimatedReadSeconds = value.inSeconds;
    }
  }

  ///Convert the estimated read time to seconds, to save in the database.
  ///(It doesn't support the Duration type)
  late int _estimatedReadSeconds;
  int get estimatedReadSeconds => _estimatedReadSeconds;
  set estimatedReadSeconds(int value) {
    _estimatedReadSeconds = value;
    if (_estimatedReadTime == Duration.zero) {
      _estimatedReadTime = Duration(seconds: value);
    }
  }

  late Duration _audioBookDuration;
  @ignore
  Duration get audioBookDuration => _audioBookDuration;
  set audioBookDuration(Duration value) {
    _audioBookDuration = value;
    if (audioBookSeconds == 0) {
      audioBookSeconds = value.inSeconds;
    }
  }

  ///Convert the audiobook duration to seconds, to save in the database.
  ///(It doesn't support the Duration type)
  late int _audioBookSeconds;
  int get audioBookSeconds => _audioBookSeconds;
  set audioBookSeconds(int value) {
    _audioBookSeconds = value;
    if (_audioBookDuration == Duration.zero) {
      _audioBookDuration = Duration(seconds: value);
    }
  }

  String get humanizedDuration {
    //TODO: Later, add the locale for localization.
    // return printDuration(estimatedReadTime);
    return estimatedReadTime.toString().split('.').first.padLeft(8, "0");
  }

  String get humanizedAudioBookDuration {
    //TODO: Later, add the locale for localization.
    // return printDuration(audioBookDuration);
    return audioBookDuration.toString().split('.').first.padLeft(8, "0");
  }

  String? ownerDisplayableUserName;
  String? ownerUserName;
  int? ownerId;

  double? rentalPrice;

  int? categoryId;
  int? themeId;
  int? rootThemeId;

  String? documentProtectionTypeName;

  List<String> languagesIsoCode;

  double percentageDownloadProgress;

  bool? isLastRead;
  bool? isFavorite;
  bool? isOffline;
  bool? isPremium;
  //Tells if we have the product's file on the device
  bool? isFileAvailable;

  @ignore
  ProductFacetEntity? theme;
  late DateTime? dateLastRead;
  late DateTime? dateAddedToFavorites;
  late DateTime? dateAddedToOfflines;
  late DateTime? dateRemovedFromOfflines;
  late DateTime? dateRemovedFromFavorites;
  DateTime? get publishDate => _publishDate;
  set publishDate(DateTime? value) {
    _publishDate = value;
    if (_publishDate != null) {
      isPublished = _publishDate!.isBefore(DateTime.now());
    }
  }

  late DateTime? _publishDate;

  bool? isPublished;

  String? origin;
  bool? isFree;
  bool? isHomeSuggestion;

  String? plainDescription;
  String? comments;
  int? authorId;

  int? size;
  double get sizeInMb => size == null ? 0 : (size! / 1024) / 1024;

  ProductCategoryEntity? category;

  ProductCommentaryModel? _comment;
  @ignore
  ProductCommentaryModel? get comment => _comment;
  set comment(ProductCommentaryModel? comment) {
    _comment = comment;
    if (_comment != null && _comment?.comments != null) {
      comments = parseHtmlToPlainString(_comment!.comments);
    }
  }

  bool isProductFree(List<ProductOfferType?>? offers) {
    if (offers == null) {
      return false;
    }

    if (offers.length != 1) {
      return false;
    }

    return offers.single == ProductOfferType.free;
  }

  bool isProductPremium(List<ProductOfferType?>? offers) {
    if (offers != null) {
      return offers.any((offer) => offer == ProductOfferType.premium);
    }

    return false;
  }

  void fromProductSearchItemOutputModel(
    ProductSearchItemOutputModel product,
    bool isHomeSuggestion,
  ) {
    if (product.id == null) {
      throw Exception("Product Should NOT be null");
    }
    id = product.id;
    this.isHomeSuggestion = isHomeSuggestion;
    estimatedReadTime = product.estimatedReadTimeInDuration;
    author = product.authors != null
        ? concatenateStringList(product.authors, ", ")
        : "";
    description = product.description ?? "";
    title = product.title ?? "";
    imageUrl = product.thumbnailUrls != null
        ? product.thumbnailUrls!.isNotEmpty
            ? product.thumbnailUrls![0].url
            : (product.imageUrls != null
                ? product.imageUrls!.isNotEmpty
                    ? product.imageUrls![0].url
                    : ""
                : "")
        : "";
    origin = product.origin ?? "";
    extensions = product.extensions ?? [];
    categoryId = product.category?.id ?? product.categoryId;
    category = product.category != null
        ? ProductCategoryEntity.fromModel(product.category!)
        : null;
    productType = getProductType(categoryId);
    isPremium = isProductPremium(product.offerTypes?.toList());
    isFree = isProductFree(product.offerTypes?.toList());
    comment = product.comment;
    theme = product.theme != null
        ? ProductFacetEntity.fromModel(product.theme!)
        : null;
  }

  void fromLastViewsModel(LastViewsModel lastViewed) {
    isLastRead = true;
    dateLastRead = lastViewed.viewDate;
    fromProductModel(lastViewed.product!);
  }

  void fromOfflineModel(OfflineModel offline) {
    isOffline = true;
    dateAddedToOfflines = offline.offlinedDate;
    fromProductModel(offline.product!);
  }

  void fromFavoriteModel(FavoriteModel favorite) {
    isFavorite = true;
    dateAddedToFavorites = favorite.favoritedDate;
    fromProductModel(favorite.product!);
  }

  void fromProductModel(ProductModel model) {
    if (model.id == null) {
      throw Exception("Product Should NOT be null");
    }
    id = model.id;
    comment = model.comment;
    origin = model.origin ?? "";
    publishDate = model.publishDate ?? DateTime(0);
    subjects = model.tags
            ?.where((element) => element.value != null)
            .map((t) => t.value!)
            .toList() ??
        [];
    isPremium = isProductPremium(model.offers?.map((o) => o.type).toList());
    isFree = isProductFree(model.offers?.map((o) => o.type).toList());
    numberOfPages = model.numberOfPages;
    description = model.description ?? "";
    title = model.title ?? "";
    author = model.author ?? "";
    narrator = model.narrator ?? "";
    extensions = convertList(model.extensions);
    audioChaptersCount = model.playlistModel?.length ?? 0;
    audioBookDuration = model.estimatedReadTimeInDuration;
    estimatedReadTime = model.estimatedReadTimeInDuration;
    languagesIsoCode = model.languagesIsoCode ?? [];
    if (model.imageUrls?.isNotEmpty ?? false) {
      imageUrl = model.imageUrls![0].url;
    } else {
      imageUrl = null;
    }
    themeId = model.themeId;
    categoryId = model.categoryId;
    documentProtectionTypeName = model.documentProtectionTypeName ?? "";
    productType = getProductType(model.categoryId);
    right = model.right ?? 0;
    rentalPrice = model.rentalPriceByPages;
    isOffline = model.isOffline ?? false;
    isFavorite = model.isFavorite ?? false;
    ownerDisplayableUserName = model.ownerDisplayableUserName ?? "";
    ownerId = model.ownerId;
    authorId = model.authorId ?? 0;
    collectionId = model.collectionId;
    collectionTitle = model.collectionTitle;
    isEditorFollowed = model.isEditorFollowed ?? false;
    isAuthorFollowed = model.isAuthorFollowed ?? false;

    //NOTE: Since the size depends on the extension,
    //it is better to set it last.
    if (model.document != null) {
      size = getProductSize(model.document!);
    }
  }

  int getProductSize(ProductGetDocument document) {
    final String extension = getProductExtension();

    if (document.formats != null && document.formats!.isNotEmpty) {
      return document.formats!
              .firstWhere(
                (d) => d.extension?.toLowerCase() == extension,
                orElse: () => ProductGetDocumentFormat(size: 0),
              )
              .size ??
          0;
    }

    return 0;
  }

  String getProductExtension() {
    final hasEpub = extensions.map((e) => e.toLowerCase()).contains("epub");

    if (hasEpub) {
      return epubExtension;
    } else if (extensions.isNotEmpty &&
        extensions.first.toLowerCase().contains("docx")) {
      return pdfExtension;
    } else if (extensions.isNotEmpty &&
        extensions.first.toLowerCase().contains("zip")) {
      return mp3Extension;
    } else if (extensions.isNotEmpty) {
      return extensions.first.toLowerCase();
    }

    return "";
  }

  ProductType getProductType(int? categoryId) {
    switch (categoryId) {
      case 69:
      case 70:
        return ProductType.audioBook;
      case 67:
      case 68:
        return ProductType.news;
      case 60:
      case 1:
        return ProductType.comic;
      case 110:
      case 111:
        return ProductType.podcast;
      case 59:
      case 2:
      case 3:
      case 4:
      case 5:
      case 7:
      case 8:
      case 9:
      case 13:
      case 15:
      case 51:
      case 56:
      case 57:
      case 58:
        return ProductType.book;
      case 62:
      case 63:
      case 64:
      case 65:
      case 66:
        return ProductType.document;
      case 10:
      case 61:
        return ProductType.partition;
      default:
        return ProductType.book;
    }
  }
}

enum ProductType {
  comic,
  news,
  book,
  audioBook,
  document,
  partition,
  podcast,
}

enum DownloadProgressState {
  downloading,
  paused,
  cancelled,
  completed,
  failed,
}

// class ProgressData {
//   ProgressData(this.percentage, this.productId, this.progressState,
//       this.filePath, this.password,
//       [this.productTitle]);

//   double percentage;
//   num productId;
//   DownloadProgressState progressState;
//   String filePath;
//   String password;
//   String? productTitle;
// }
