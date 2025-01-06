abstract class FileService {
  String get basePath;
  Future<void> initialize();
  String getDatabasePath();
  Future<String> getProductRelativeFolderPath(int userId, String extension);
  Future<bool> productFileExists(int userId, int productId, String extension);
  Future<bool> productFileZipExists(int userId, int productId, String type);
  Future<String> getProductFilePath(
      int userId, int productId, String extension);
  Future<List<String>> getAudioChapterPaths(int userId, int productId);
  Future<String> getProductFileName(int productId, String extension);
  Future<String> getProductFilePathWithoutExtension(int userId, int productId);
  Future<String?> getProductZipPath(
    int userId,
    int productId,
    String type,
  );
  Future<String> getProductTempFilePath(
      int userId, int productId, String extension);
  Future<void> deleteProductFiles(int userId, Iterable<int> productIds);
  Future<void> deleteProductFile(int userId, int productId,
      [String extension = '']);
  Future<List<String>> getFilesInDirectory(String directory, String fileType);
  Future<void> deleteEveryBook(int userId);
  Future<List<LocalBook>> getEveryDownloadedBook(int userId);
  Future<void> moveFile(String sourcePath, String destinationPath);
}

class LocalBook {
  LocalBook(
      this.productId, this.extension, this.creationDate);

  final int productId;
  final String extension;
  final DateTime creationDate;
}
