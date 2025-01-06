part of 'audio_player_cubit.dart';

sealed class AudioPlayerState extends Equatable {
  const AudioPlayerState();

  @override
  List<Object> get props => [];
}

/// Initial state of the audio player
final class AudioPlayerInitialState extends AudioPlayerState {}

/// State when the audio player has an error
final class AudioPlayerErrorState extends AudioPlayerState {
  const AudioPlayerErrorState(this.error);
  final AppException? error;
}

/// State when the audio player is loaded
final class AudioPlayerLoadedState extends AudioPlayerState {
  const AudioPlayerLoadedState({
    required this.chapters,
    required this.product,
    required this.collection,
    required this.isProductCollection,
    this.hasExtractRestrictions = false,
    this.isPremium = false,
    this.extractChapterIndex = 0,
    this.chapterStopSeconds = 0,
    this.currentChapterIndex = 0,
  });

  final bool hasExtractRestrictions;
  final bool isPremium;
  final int extractChapterIndex;
  final List<AudioChapterEntity> chapters;
  final int currentChapterIndex;
  final int chapterStopSeconds;
  final ProductEntity product;
  final List<ProductEntity> collection;
  final bool isProductCollection;

  @override
  List<Object> get props => [
        hasExtractRestrictions,
        extractChapterIndex,
        chapterStopSeconds,
        chapters,
        product,
        collection,
        isProductCollection
      ];
}

/// State when the audio player is playing and the extract time is reached
/// This state is used to stop the audio player when the extract time is reached
/// when the user has no more time to listen to the audio
final class AudioExtractStopTimeReachedState extends AudioPlayerLoadedState {
  const AudioExtractStopTimeReachedState({
    required super.chapters,
    required super.product,
    required super.collection,
    required super.isProductCollection,
    super.hasExtractRestrictions = false,
    super.isPremium = false,
    super.extractChapterIndex = 0,
    super.chapterStopSeconds = 0,
    super.currentChapterIndex = 0,
  });

  @override
  List<Object> get props => [
        hasExtractRestrictions,
        extractChapterIndex,
        chapterStopSeconds,
        chapters,
        product,
        collection,
        isProductCollection
      ];
}
