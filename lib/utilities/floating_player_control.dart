import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:youscribe/config/app_locator.dart';
import 'package:youscribe/core/entities/product_entity.dart';

class FloatingPlayerControl with ChangeNotifier {
  FloatingPlayerControl() {
    checkPlayingState();
  }
  ProductEntity _currentProduct = ProductEntity();
  ProductEntity get currentProduct => _currentProduct;
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  bool _hasExtraction = false;
  bool get hasExtraction => _hasExtraction;
  int _chapterStopSeconds = 0;
  int get chapterStopSeconds => _chapterStopSeconds;
  bool _isCollectionProduct = false;
  bool get isCollectionProduct => _isCollectionProduct;

  List<ProductEntity> _currentCollectionProducts = [];
  List<ProductEntity> get currentCollectionProducts =>
      _currentCollectionProducts;
  int _extraChapterIndex = 0;
  int get extraChapterIndex => _extraChapterIndex;
  AudioPlayer _player = AudioPlayer();
  AudioPlayer get player => locator();

  Future<void> changeProduct(
      ProductEntity newProduct,
      bool hasExtraction,
      int extraChapterIndex,
      bool isCollectionProduct,
      int chapterStopSeconds,
      List<ProductEntity> collection) async {
    _currentProduct = newProduct;
    _hasExtraction = hasExtraction;
    _extraChapterIndex = extraChapterIndex;
    _isCollectionProduct = isCollectionProduct;
    _currentCollectionProducts = collection;
    _chapterStopSeconds = chapterStopSeconds;
    notifyListeners();
  }

  Future<void> changePlayingState(AudioPlayer player) async {
    _player = player;
    // _isPlaying = player.playing;
    notifyListeners();
  }

  // check if player is playing
  Future<void> checkPlayingState() async {
    _isPlaying = !(_player.audioSource == null);
    notifyListeners();
  }
}
