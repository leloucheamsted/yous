// import 'dart:async';

// // ignore: implementation_imports
// import 'package:dio/src/cancel_token.dart';
// import 'package:youscribe/core/entities/collection_search_results_presentation_model.dart';
// import 'package:youscribe/core/entities/people_search_output_item_entity.dart';
// import 'package:youscribe/core/entities/product_category_entity.dart';
// import 'package:youscribe/core/entities/product_entity.dart';
// import 'package:youscribe/core/entities/product_facet_entity.dart';
// import 'package:youscribe/core/entities/product_search_per_theme_results_entityl.dart';
// import 'package:youscribe/core/entities/product_search_results_entity.dart';
// import 'package:youscribe/core/models/requests/product_search_parameters.dart';
// import 'package:youscribe/core/models/requests/search_by_theme_request_model.dart';
// import 'package:youscribe/core/models/responses/collection_search_output_item_model.dart';
// import 'package:youscribe/core/models/responses/multi_type_search_output_model.dart';
// import 'package:youscribe/core/models/responses/people_search_output_item_model.dart';
// import 'package:youscribe/core/models/responses/product_search_item_output_model.dart';
// import 'package:youscribe/core/repositories/product_search_repository.dart';
// import 'package:youscribe/data/data_sources/product_search_data_source/product_search_remote_data_source.dart';

// class ProductSearchFakeRepositoryImpl implements ProductSearchReposotiry {
//   ProductSearchFakeRepositoryImpl({
//     required ProductSearchRemoteDataSource productSearchRemoteDataSource,
//   }) : _productSearchRemoteDataSource = productSearchRemoteDataSource;

//   final ProductSearchRemoteDataSource _productSearchRemoteDataSource;

//   @override
//   Future<ProductSearchResultsEntity> getAuthorProducts(
//       int authorId, int take, int skip, String deviceLang) {
//     // TODO: implement getAuthorProducts
//     throw UnimplementedError();
//   }

//   @override
//   FutureOr<List<ProductEntity>> getProductCollection(
//       int? collectionId, int take) {
//     // TODO: implement getProductCollection
//     throw UnimplementedError();
//   }

//   @override
//   Future<ProductSearchResultsEntity> getPublisherProducts(
//       int publisherId, int take, int skip, String deviceLang) {
//     // TODO: implement getPublisherProducts
//     throw UnimplementedError();
//   }

//   @override
//   FutureOr<List<ProductCategoryEntity>> getSearchFirstLevelOptions(
//       String currentLang) {
//     // TODO: implement getSearchFirstLevelOptions
//     throw UnimplementedError();
//   }

//   @override
//   FutureOr<MutliTypeSearchOutPutModel> getSearchSuggestions(
//       ProductSearchParameters? searchParameters,
//       String deviceLanguage,
//       CancelToken cancellationToken) {
//     final fakeData = MutliTypeSearchOutPutModel(products: [], authors: []);

//     try {
//       final MutliTypeSearchOutPutModel results = MutliTypeSearchOutPutModel(
//         products: (fakeSuggestionsSearchJson["products"] as List<dynamic>)
//             .map<ProductSearchItemOutputModel>((model) =>
//                 ProductSearchItemOutputModel.fromJson(
//                     model as Map<String, dynamic>))
//             .toList()
//             .where((p) => p.title!.contains(searchParameters!.quicksearch!))
//             .toList(),
//         collections: (fakeSuggestionsSearchJson["collections"]!
//                 as List<Map<String, dynamic>>)
//             .map<CollectionSearchOutputItemModel>(
//                 (model) => CollectionSearchOutputItemModel.fromJson(model))
//             .toList()
//             .where((p) => p.title!.contains(searchParameters!.quicksearch!))
//             .toList(),
//         authors: //[]
//             (fakeSuggestionsSearchJson["authors"]! as List<dynamic>)
//                 .map<PeopleSearchOutputItemModel>((model) =>
//                     PeopleSearchOutputItemModel.fromJson(
//                         model as Map<String, dynamic>))
//                 .toList()
//                 .where((p) => p.name!.contains
// (searchParameters!.quicksearch!))
//                 .toList(),
//       );
//       return results;
//     } catch (e) {
//       Exception(e);
//     }

//     return fakeData;
//   }

//   @override
//   FutureOr<List<ProductFacetEntity>> getThemes(
//       int categoryId, String deviceLanguage) {
//     // TODO: implement getThemes
//     throw UnimplementedError();
//   }

//   @override
//   FutureOr<List<ProductCategoryEntity>> getYSCategories(String currentLang) {
//     // TODO: implement getYSCategories
//     throw UnimplementedError();
//   }

//   @override
//   Future<PeopleSearchOutputItemEntity> searchAuthors(
//       ProductSearchParameters searchParams, String deviceLanguage) {
//     // TODO: implement searchAuthors
//     throw UnimplementedError();
//   }

//   @override
//   Future<CollectionSearchResultsPresentationModel> searchCollections(
//       ProductSearchParameters searchParams, String deviceLanguage) {
//     // TODO: implement searchCollections
//     throw UnimplementedError();
//   }

//   @override
//   Future<ProductSearchResultsEntity> searchProduct(
//       ProductSearchParameters searchParams,
//       String deviceLanguage,
//       int? parentClassificationId) {
//     // TODO: implement searchProduct
//     throw UnimplementedError();
//   }

//   @override
//   Future<ProductSearchResultsEntity> searchProducts(
//       ProductSearchParameters searchParams,
//       String deviceLanguage,
//       int? parentClassificationId) {
//     // TODO: implement searchProducts
//     throw UnimplementedError();
//   }

//   @override
//   FutureOr<List<ProductSearchPerThemeResultsEntity>> searchProductsByTheme(
//       ProductSearchByThemeInputModel searchParams, String deviceLanguage) {
//     // TODO: implement searchProductsByTheme
//     throw UnimplementedError();
//   }

//   final Map<String, Object> fakeSuggestionsSearchJson = {
//     "products": [
//       {
//         "Id": 2918098,
//         "Title": "Lettres à Lucilius Lettre XII",
//         "Description": "",
//         "Authors": ["Sénèque", "Spqr"],
//         "Contributors": [
//           {"Name": "Sénèque", "Function": "author"},
//           {"Name": "Spqr", "Function": "narrator"}
//         ],
//         "OwnerId": 2215953,
//         "OwnerUserName": "audio-dp",
//         "OwnerDisplayableUserName": "audio-dp",
//         "NbPages": 9,
//         "PertinenceWeight": 53.95432,
//         "OfferTypes": ["Free"],
//         "PublicFormatExtensions": ["mp3"],
//         "ExtractPublicFormatExtensions": [],
//         "ThumbnailUrls": [
//           {
//             "Url":
//                 "https://img.uscri.be/pth/a6ab4594aef08d328865d867b4c8aa2e5b84ec5a",
//             "Width": 174,
//             "Height": 222,
//             "Type": 3
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/05c63b73c37dc05253ede755f0c8ed8a61c74d68",
//             "Width": 83,
//             "Height": 106,
//             "Type": 2
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/31124acc6d78b699719a5bccedb9588f6587d2f3",
//             "Width": 67,
//             "Height": 86,
//             "Type": 1
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/9d27a16e70ace66eca719d48b76cfb1373f4cb95",
//             "Width": null,
//             "Height": null,
//             "Type": 4
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/b0daadc1df114ca5cfea192b2ce8f5182c48e95f",
//             "Width": null,
//             "Height": null,
//             "Type": 5
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/3f954175649386d5769a0ee446005d506af73f15",
//             "Width": null,
//             "Height": null,
//             "Type": 6
//           }
//         ],
//         "Theme": {
//           "Id": 83,
//           "Name": "philosophie",
//           "Label": "Philosophie",
//           "Parent": {
//             "Id": 76,
//             "Name": "know",
//             "Label": "Savoirs",
//             "Parent": null
//           }
//         },
//         "Category": {
//           "Id": 69,
//           "Name": "audiobooks_root",
//           "IsPublic": true,
//           "Label": "Livres audio",
//           "Description": "Lisez avec vos oreilles !"
//         },
//         "StateId": 3,
//         "EstimatedReadTime": "00:06:45",
//         "Language": "Français",
//         "IsAdultContent": false,
//         "AccessTypes": [],
//         "IsPublic": true,
//         "OnlineDate": "2018-01-14T23:00:00Z",
//         "PublishDate": "0001-01-01T00:00:00",
//         "IsIndexable": true,
//         "Origin": null,
//         "CollectionId": null,
//         "CollectionTitle": null
//       },
//       {
//         "Id": 2918096,
//         "Title": "Lettres à Lucilius Lettre III",
//         "Description": "",
//         "Authors": ["Sénèque", "Spqr"],
//         "Contributors": [
//           {"Name": "Sénèque", "Function": "author"},
//           {"Name": "Spqr", "Function": "narrator"}
//         ],
//         "OwnerId": 2215953,
//         "OwnerUserName": "audio-dp",
//         "OwnerDisplayableUserName": "audio-dp",
//         "NbPages": 5,
//         "PertinenceWeight": 53.859222,
//         "OfferTypes": ["Free"],
//         "PublicFormatExtensions": ["mp3"],
//         "ExtractPublicFormatExtensions": [],
//         "ThumbnailUrls": [
//           {
//             "Url":
//                 "https://img.uscri.be/pth/679b9b17acad5638202f5ab6256e0a554e04ae19",
//             "Width": 174,
//             "Height": 222,
//             "Type": 3
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/48dbda68906b55c9acfdb36c6236f097148ac4dd",
//             "Width": 83,
//             "Height": 106,
//             "Type": 2
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/d5a77ca684109aec8daa68b24e8d2d094fc98229",
//             "Width": 67,
//             "Height": 86,
//             "Type": 1
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/0ee3a9d46de0a24982ddc20d142ea81423705beb",
//             "Width": null,
//             "Height": null,
//             "Type": 4
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/83011f9005fe9fc4099f2c028502bd947387235b",
//             "Width": null,
//             "Height": null,
//             "Type": 5
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/725e3c53ecba9b337a6a4bf1e73b7da8e0577ca2",
//             "Width": null,
//             "Height": null,
//             "Type": 6
//           }
//         ],
//         "Theme": {
//           "Id": 83,
//           "Name": "philosophie",
//           "Label": "Philosophie",
//           "Parent": {
//             "Id": 76,
//             "Name": "know",
//             "Label": "Savoirs",
//             "Parent": null
//           }
//         },
//         "Category": {
//           "Id": 69,
//           "Name": "audiobooks_root",
//           "IsPublic": true,
//           "Label": "Livres audio",
//           "Description": "Lisez avec vos oreilles !"
//         },
//         "StateId": 3,
//         "EstimatedReadTime": "00:03:45",
//         "Language": "Français",
//         "IsAdultContent": false,
//         "AccessTypes": [],
//         "IsPublic": true,
//         "OnlineDate": "2018-01-14T23:00:00Z",
//         "PublishDate": "0001-01-01T00:00:00",
//         "IsIndexable": true,
//         "Origin": null,
//         "CollectionId": null,
//         "CollectionTitle": null
//       },
//       {
//         "Id": 3074894,
//         "Title": "Lettre à toi",
//         "Description":
//             "Les choix les plus simples finissent toujours par être ceux qui 
//influencent le plus votre vie et même s’ils n’avaient absolument plus rien en
// commun, en lui envoyant une simple lettre, Samuel va complètement 
//bouleverser 
//la vie de Claire. Elle, jeune Française devant qui tous les éléments de son 
//monde ploient comme autant d’amants. Manhattan, le rock, les hommes. Ne manque
// de rien. Lui, veuf, sans attache. Survivant d’un génocide aux frontières du 
//Rwanda. Manque de tout. Une seule lettre et c’est l’effet papillon…",
//         "Authors": ["Bruno Christian"],
//         "Contributors": [
//           {"Name": "Bruno Christian", "Function": "author"}
//         ],
//         "OwnerId": 2665381,
//         "OwnerUserName": "les-editions-chapitre-com",
//         "OwnerDisplayableUserName": "Les Editions Chapitre.com",
//         "NbPages": 161,
//         "PertinenceWeight": 58.094173,
//         "OfferTypes": ["Subscription"],
//         "PublicFormatExtensions": ["pdf", "epub", "epub_encrypt_lcp"],
//         "ExtractPublicFormatExtensions": ["pdf", "epub"],
//         "ThumbnailUrls": [
//           {
//             "Url":
//                 "https://img.uscri.be/pth/1291422175549be60455d9c84bccdedc085f1437",
//             "Width": 174,
//             "Height": 222,
//             "Type": 3
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/4622581478aa80b7a843a80ee7e6c98728780adc",
//             "Width": 83,
//             "Height": 106,
//             "Type": 2
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/fe6e84cafbdf2d313e9465e8e5ca26c9041c1dd8",
//             "Width": 67,
//             "Height": 86,
//             "Type": 1
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/ec884d60442cbaa6ab5dcde80648b406fab32690",
//             "Width": null,
//             "Height": null,
//             "Type": 4
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/186fbeaf5ff70c6743337cf4543cdc6b305f6150",
//             "Width": null,
//             "Height": null,
//             "Type": 5
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/8c15ca88fc1b64bc18696ba6e46e8b9c1cd90664",
//             "Width": null,
//             "Height": null,
//             "Type": 6
//           }
//         ],
//         "Theme": {
//           "Id": 55,
//           "Name": "romans-et-nouvelles",
//           "Label": "Romans et nouvelles",
//           "Parent": {
//             "Id": 45,
//             "Name": "literature",
//             "Label": "Littérature",
//             "Parent": null
//           }
//         },
//         "Category": {
//           "Id": 59,
//           "Name": "book_root",
//           "IsPublic": true,
//           "Label": "Ebooks",
//           "Description": "Plongez-vous dans des ouvrages riches et complets"
//         },
//         "StateId": 3,
//         "EstimatedReadTime": "02:00:45",
//         "Language": "Français",
//         "IsAdultContent": false,
//         "AccessTypes": [0],
//         "IsPublic": true,
//         "OnlineDate": "2019-08-15T05:25:03.391893Z",
//         "PublishDate": "2014-05-13T00:00:00Z",
//         "IsIndexable": true,
//         "Origin": null,
//         "CollectionId": null,
//         "CollectionTitle": null
//       },
//       {
//         "Id": 3341734,
//         "Title": "Lettre au fils",
//         "Description":
//             "Kafka, et cette fois du père au fils. Car à la Lettre au père de Franz devait bien répondre une Lettre au fils d'Hermann. C'est cette lettre que le lecteur trouve ici, une lettre qui suscite à son tour d'autres correspondances. Si les Kafka dominent ce recueil de dix nouvelles, les ombres de Bach, de Chamisso, de Coleridge, de Carroll, et d'autres peut-être, se profilent aussi... \n",
//         "Authors": ["Patrick Calais"],
//         "Contributors": [
//           {"Name": "Patrick Calais", "Function": "author"}
//         ],
//         "OwnerId": 3681,
//         "OwnerUserName": "harmattan",
//         "OwnerDisplayableUserName": "Harmattan",
//         "NbPages": 40,
//         "PertinenceWeight": 56.668026,
//         "OfferTypes": ["Subscription"],
//         "PublicFormatExtensions": ["pdf", "epub", "epub_encrypt_lcp"],
//         "ExtractPublicFormatExtensions": ["pdf", "epub"],
//         "ThumbnailUrls": [
//           {
//             "Url":
//                 "https://img.uscri.be/pth/332d46699e8746e9fd028906218009315960674a",
//             "Width": 174,
//             "Height": 222,
//             "Type": 3
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/2baffeb7e4816919e99bf56c19c2da5922cbe60b",
//             "Width": 83,
//             "Height": 106,
//             "Type": 2
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/4856339aec27bfe4a53cdfc99b8077e8ab49c983",
//             "Width": 67,
//             "Height": 86,
//             "Type": 1
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/46f723bfd483193d74399a0faf01c8c116e460a8",
//             "Width": null,
//             "Height": null,
//             "Type": 4
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/f1f8b2e32e2ef9e30bb2a5b173538feb9c8a8181",
//             "Width": null,
//             "Height": null,
//             "Type": 5
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/3d80ace40dcfef35d58bceb30a0d0fdfaeb53369",
//             "Width": null,
//             "Height": null,
//             "Type": 6
//           }
//         ],
//         "Theme": {
//           "Id": 55,
//           "Name": "romans-et-nouvelles",
//           "Label": "Romans et nouvelles",
//           "Parent": {
//             "Id": 45,
//             "Name": "literature",
//             "Label": "Littérature",
//             "Parent": null
//           }
//         },
//         "Category": {
//           "Id": 59,
//           "Name": "book_root",
//           "IsPublic": true,
//           "Label": "Ebooks",
//           "Description": "Plongez-vous dans des ouvrages riches et complets"
//         },
//         "StateId": 3,
//         "EstimatedReadTime": "00:30:00",
//         "Language": "Français",
//         "IsAdultContent": false,
//         "AccessTypes": [0],
//         "IsPublic": true,
//         "OnlineDate": "2022-09-04T06:08:12.636099Z",
//         "PublishDate": "2022-06-02T22:00:00Z",
//         "IsIndexable": false,
//         "Origin": null,
//         "CollectionId": null,
//         "CollectionTitle": null
//       },
//       {
//         "Id": 3480986,
//         "Title": "Letters from the What-Went-Before",
//         "Description":
//             "Another brutal beating. Another trip to A&E. This time,
// a social 
//worker alerts the authorities and Abby's teenage life gets turned upside down.
// The woman she thoughthad died at her birth - is alive - and now is taking
// her home.One year later, a step-dad gets added to the family unit and this 
//latest relationship takes its toll. Lost, Abby tries to escapeby moving t
// London but locking the door to the past is never easy, even with the help o
//f her long-time gay best friendJoshua and Instagram icon, Luna. That is, until
// she meets someone. Jay, a puzzle she can't figure out and yet thesimplest
// answer to a question she's been asking herself for years. Finally she might
// have the reason she started sufferingin the first place.",
//         "Authors": ["Stefanie Sybens"],
//         "Contributors": [
//           {"Name": "Stefanie Sybens", "Function": "author"}
//         ],
//         "OwnerId": 13862579,
//         "OwnerUserName": "troubadorpublishingltd",
//         "OwnerDisplayableUserName": "Troubador Publishing Ltd",
//         "NbPages": 117,
//         "PertinenceWeight": 15.208716,
//         "OfferTypes": ["Subscription"],
//         "PublicFormatExtensions": ["pdf", "epub", "epub_encrypt_lcp"],
//         "ExtractPublicFormatExtensions": ["pdf", "epub"],
//         "ThumbnailUrls": [
//           {
//             "Url":
//                 "https://img.uscri.be/pth/a03bcfa1048b187ed295573c7c2fbc921515e60a",
//             "Width": 174,
//             "Height": 222,
//             "Type": 3
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/a73eeed9d3c44fc2f3900e1c95bd5f41f9322836",
//             "Width": 83,
//             "Height": 106,
//             "Type": 2
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/6223c3dab0d25712c0bd3a045419053ef2702eda",
//             "Width": 67,
//             "Height": 86,
//             "Type": 1
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/3fc88525a5550c2e2ba4369981eb4fa295100d4e",
//             "Width": null,
//             "Height": null,
//             "Type": 4
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/35d06a2646b9185fbc8a740922b927d2de4f1d73",
//             "Width": null,
//             "Height": null,
//             "Type": 5
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/3f2e01c5e5ccf9e47c21027a5cdb921bc996bb8e",
//             "Width": null,
//             "Height": null,
//             "Type": 6
//           }
//         ],
//         "Theme": {
//           "Id": 23,
//           "Name": "bd",
//           "Label": "Bandes dessinées",
//           "Parent": {
//             "Id": 22,
//             "Name": "bd",
//             "Label": "BD - Mangas",
//             "Parent": null
//           }
//         },
//         "Category": {
//           "Id": 60,
//           "Name": "bd_root",
//           "IsPublic": true,
//           "Label": "BD",
//           "Description": "Faites une pause avec des bulles !"
//         },
//         "StateId": 3,
//         "EstimatedReadTime": "01:27:45",
//         "Language": "English",
//         "IsAdultContent": false,
//         "AccessTypes": [0],
//         "IsPublic": true,
//         "OnlineDate": "2023-04-08T00:15:35.78814Z",
//         "PublishDate": "2020-02-11T23:00:00Z",
//         "IsIndexable": true,
//         "Origin": null,
//         "CollectionId": null,
//         "CollectionTitle": null
//       },
//       {
//         "Id": 3500024,
//         "Title": "La Ola desaparecida - La vague disparue",
//         "Description":
// ignore: lines_longer_than_80_chars
//             "Quand une lettre d'alphabet vous manque, tout est dépeuplé ! « Quand une lettre d'alphabet vous manque, tout est dépeuplé ! »Sarah vient passer ses vacances à Madrid, chez ses grand-parents. Sur un ton loufoque, son grand-père l'entraine dans une investigation singulière. Il a remarqué que l'accent tilde en forme de petite vague de la lettre espagnole, appelée « enyé », disparaît des mots espagnols chaque jour un peu plus. Ils décident, alors, de chercher ensemble le coupable afin de préserver les mots qui contiennent cette lettre. C'est le patrimoine de la langue espagnole qu'ils doivent sauver. L'histoire, dont le ton fait un clin d'oeil à l'humour de « Don Quichotte » de Servantès, est espiègle et propose une lecture au second degré. Elle évoque à la fois la langue et la culture espagnoles.Découvrez une BD qui offre une façon ludique de se familiariser avec l'espagnolA PROPOS DES AUTEURSDavid Gondar est professeur de langue espagnole à l'Université de Strasbourg et animateur d'ateliers d'écriture depuis plusieurs années. C'est l'enthousiasme pour la collection La marmite-O-langues, et notamment le premier titre en langue espagnole  Catrina de Maria-Esther d'Anjou, qui lui a donné l'idée d'écrire un titre sur l'Espagne.La tête sur terre et les pieds dans les nuages... ou le contraire ? Ce n'est pas rare dans les parages de voir Marjorie Carola sans dessus dessous, barbouillée de peinture acajou. Depuis toute petite, &#34;Monsieur Dessin&#34; lui tient la main et ses études en communication graphique lui confirment cette passion qu'elle a pour l'illustration. Elle voguera d'imprimerie au plomb en agence de communication, mais toujours à la main son crayon. Ses principaux travaux portent sur l'évènementiel, le cinéma, la danse, la musique... le culturel ça lui fait pousser des ailes ! Son &#34;vrai pays&#34; : c'est le sud. Mais elle s'expatrie ensuite joyeusement dans ce Paris qu'elle aime tant depuis son jeune temps. Des lors, elle entre à la Maison des illustrateurs, et voici donc venu le temps des expositions : elle va alors en faire voir de toutes les couleurs ! ",
//         "Authors": ["David Gondar"],
//         "Contributors": [
//           {"Name": "David Gondar", "Function": "author"}
//         ],
//         "OwnerId": 1547894,
//         "OwnerUserName": "dadoclem",
//         "OwnerDisplayableUserName": "Dadoclem",
//         "NbPages": 47,
//         "PertinenceWeight": 6.0465174,
//         "OfferTypes": ["Subscription"],
//         "PublicFormatExtensions": ["pdf", "epub", "epub_encrypt_lcp"],
//         "ExtractPublicFormatExtensions": ["pdf", "epub"],
//         "ThumbnailUrls": [
//           {
//             "Url":
//                 "https://img.uscri.be/pth/2594f226574afe3ff2b4f6fad5c063b45296027a",
//             "Width": 174,
//             "Height": 222,
//             "Type": 3
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/501df9748be61b637d73c87c5d3c8052e750d190",
//             "Width": 83,
//             "Height": 106,
//             "Type": 2
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/cb14f30879eeff4810ca56c59d4747423caf71a4",
//             "Width": 67,
//             "Height": 86,
//             "Type": 1
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/7c36fc27dc0da662b76399c5de4c75fdd45e23e7",
//             "Width": null,
//             "Height": null,
//             "Type": 4
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/e30566e0e493f59734293ae3c3433444ef482b4c",
//             "Width": null,
//             "Height": null,
//             "Type": 5
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/3eeb901c6bdcefe450acf8bf5de5cb66389fc145",
//             "Width": null,
//             "Height": null,
//             "Type": 6
//           }
//         ],
//         "Theme": {
//           "Id": 114,
//           "Name": "comics",
//           "Label": "Comics",
//           "Parent": null
//         },
//         "Category": {
//           "Id": 60,
//           "Name": "bd_root",
//           "IsPublic": true,
//           "Label": "BD",
//           "Description": "Faites une pause avec des bulles !"
//         },
//         "StateId": 3,
//         "EstimatedReadTime": "00:35:15",
//         "Language": "Français",
//         "IsAdultContent": false,
//         "AccessTypes": [0],
//         "IsPublic": true,
//         "OnlineDate": "2023-05-30T10:09:36.252741Z",
//         "PublishDate": "2018-05-28T22:00:00Z",
//         "IsIndexable": false,
//         "Origin": null,
//         "CollectionId": null,
//         "CollectionTitle": null
//       },
//       {
//         "Id": 3540143,
//         "Title": "La Voie originale n° 835 - du 06/10/2023",
//         "Description":
//             "LAVOIEORIGINALE 8 pagesN°835:Mise en page 105/10/2023 18:39 Page1 -Septième année  Can 2023 en Côte d’Ivoire 300 FCFAN°835VENDREDI 06 & SAMEDI 07 OCTOBRE 2023 La CIE-Sodeci mobilise www.lavloie-originaale.netvQuotidienoivoirien d’Inforimations Généeralesfacebook.coedmf fe/eCLItcaEuv-éoSiouednoereicgviii, nsiAathleem1da6e  ainropp traerrpédio,eakoy uaBoka  Dasns lee casdre deasesgtourneéesnrégtulièrses auprès des collaborateurs et des clients sur l’ensemble du territoire national, à la suite d’autres villes de l’intérieur, le Dg originale Utilisés et méprisésLaxisme dans les enquêtes contre le camp Ouattara après les élections Bouaké :lesGrosse pression sur la CPI à La Haye autochtones baoulés grognent contre le ministre maire Amadou Koné Le procureur Karim Khan toujours dans les promesses Le temps passe et l’espoir de voir la vérité dite devant la Cour Pénale Internationale (CPI) s’amenuise. C’est le moindre qu’on puisse dire. Pour cause, il y a un an, précisément le lundi 03 octobre 2022, l’Observatoire ivoirien des droits de l’homme (OIDH) avait adressé une lettre ouverture au procureur de la CPI, Karim Khan. Dans cette lettre, l’OIDH dirigée par Eric Semien se renseignait auprès du procureur des avancées des enquêtes sur les crimes commis en Côte d‘Ivoire entre 2002 et 2011. Avec la même méthode et dans le même style, Eric Semien, a remis le couvert, le mardi 03 octobre 2023.",
//         "Authors": ["La Voie Originale"],
//         "Contributors": [
//           {"Name": "La Voie Originale", "Function": "author"}
//         ],
//         "OwnerId": 3218634,
//         "OwnerUserName": "la-voie-originale",
//         "OwnerDisplayableUserName": "La Voie originale",
//         "NbPages": 8,
//         "PertinenceWeight": 5.253631,
//         "OfferTypes": ["Subscription"],
//         "PublicFormatExtensions": ["pdf"],
//         "ExtractPublicFormatExtensions": ["pdf"],
//         "ThumbnailUrls": [
//           {
//             "Url":
//                 "https://img.uscri.be/pth/f0b4b2b48a80a50ab21739cf2e76aee6977f8104",
//             "Width": 174,
//             "Height": 222,
//             "Type": 3
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/57da5507b87fcc5a4c86f007b3e082246017241d",
//             "Width": 83,
//             "Height": 106,
//             "Type": 2
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/7c1254e66685a5de2f3f8b17dda1a97b4f171969",
//             "Width": 67,
//             "Height": 86,
//             "Type": 1
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/f9a3e949ca1a71c0005e772c859ce58cee7b9828",
//             "Width": null,
//             "Height": null,
//             "Type": 4
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/fdceed975ac556b8fecd72360c00514dc779ac2c",
//             "Width": null,
//             "Height": null,
//             "Type": 5
//           },
//           {
//             "Url":
//                 "https://img.uscri.be/pth/e305dd34f91f83208558f489916761e94de83e0b",
//             "Width": null,
//             "Height": null,
//             "Type": 6
//           }
//         ],
//         "Theme": {
//           "Id": 190,
//           "Name": "archives_af",
//           "Label": "Archives Afrique",
//           "Parent": {
//             "Id": 182,
//             "Name": "archives",
//             "Label": "Archives",
//             "Parent": null
//           }
//         },
//         "Category": {
//           "Id": 67,
//           "Name": "press_root",
//           "IsPublic": true,
//           "Label": "Presse",
//           "Description": "Retrouvez vos journaux, revues, et magazines"
//         },
//         "StateId": 3,
//         "EstimatedReadTime": "00:06:00",
//         "Language": "Français",
//         "IsAdultContent": false,
//         "AccessTypes": [0],
//         "IsPublic": true,
//         "OnlineDate": "2023-10-06T11:46:45.191627Z",
//         "PublishDate": "2023-10-05T22:00:00Z",
//         "IsIndexable": true,
//         "Origin": null,
//         "CollectionId": 5282,
//         "CollectionTitle": "La Voie Originale"
//       }
//     ],
//     "collections": [
//       {
//         "Id": 3344,
//         "Title": "Lettre à Tita",
//         "Products": [],
//         "ProductsOrder": null,
//         "IsVisible": true,
//         "PertinenceWeight": 0.0,
//         "Origin": null,
//         "ThumbnailUrlS":
//             "https://img.uscri.be/pth/2ffbcc3268f4bb9de31ee6de17c3bd44f3b771bd",
//         "ThumbnailUrlM":
//             "https://img.uscri.be/pth/54114d5f64590559287aae0b1a4477a862278e23",
//         "ThumbnailUrlL":
//             "https://img.uscri.be/pth/74cdc627fcafce5a4260baf69461b51428f7ff25",
//         "ThumbnailUrlS_WebP":
//             "https://img.uscri.be/pth/fbb09179462ea8b83a20c7d0b1a2b78f6bfa41ec",
//         "ThumbnailUrlM_WebP":
//             "https://img.uscri.be/pth/f13e22a23c0ac42d33940d2eb1b2fab4293feda2",
//         "ThumbnailUrlL_WebP":
//             "https://img.uscri.be/pth/84f6da3544d66de112946cc8c5e0771f8f272f4e",
//         "IsAdultContent": false
//       },
//       {
//         "Id": 9994,
//         "Title": "Lettres de mes ancêtres",
//         "Products": [],
//         "ProductsOrder": null,
//         "IsVisible": true,
//         "PertinenceWeight": 0.0,
//         "Origin": null,
//         "ThumbnailUrlS":
//             "https://img.uscri.be/pth/7783f49f40dd98995c1003a8ade8c041813c6fea",
//         "ThumbnailUrlM":
//             "https://img.uscri.be/pth/9247e722f4e4bef0c1eb064a0cb97f9cc83f35ca",
//         "ThumbnailUrlL":
//             "https://img.uscri.be/pth/db3761821922ff6047104611b501d9693c4f7c6d",
//         "ThumbnailUrlS_WebP":
//             "https://img.uscri.be/pth/029176c2085c4bc930887d3c713acc4193a3ad4f",
//         "ThumbnailUrlM_WebP":
//             "https://img.uscri.be/pth/a61b1ba5d3b53c11960ff3fb8ba5f39c1097b582",
//         "ThumbnailUrlL_WebP":
//             "https://img.uscri.be/pth/8d564a6ee02b50293e41071f259cf79892bde501",
//         "IsAdultContent": false
//       }
//     ],
//     "authors": [
//       {
//         "Id": 1292396,
//         "Name": "Les Lettres De Mon Moulin",
//         "PertinenceWeight": 38.156975,
//         "Thumbnails": []
//       },
//       {
//         "Id": 1517576,
//         "Name": "Rebecca Letterman",
//         "PertinenceWeight": 23.666985,
//         "Thumbnails": []
//       }
//     ]
//   };
// }
