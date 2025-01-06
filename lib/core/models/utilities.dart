import 'package:html/parser.dart';
import 'package:youscribe/core/entities/product_facet_entity.dart';

String parseHtmlToPlainString(String html) {
  if (html.isEmpty) {
    return '';
  }
  final plainText = parse(html);
  return plainText.documentElement?.text ?? '';
}

Duration convertStringTimeSpanToDuration(String estimatedReadTime) {
  if (estimatedReadTime.isEmpty) {
    return Duration.zero;
  }

  final timeParts = estimatedReadTime.split(':');

  if (timeParts.length != 3) {
    return Duration.zero;
  }

  final hours = double.parse(timeParts[0]);
  final minutes = double.parse(timeParts[1]);
  final seconds = double.parse(timeParts[2]);

  final totalSeconds = hours * 3600 + minutes * 60 + seconds;

  return Duration(seconds: totalSeconds.toInt());
}

List<ProductFacetEntity> getAllChildren(List<ProductFacetEntity> items) {
  final List<ProductFacetEntity> result = [];
  for (final item in items) {
    result
      ..add(item)
      ..addAll(getAllChildren(item.children));
  }
  
  return result;
}

String concatenateStringList(List<String>? strings, String delimiter) {
  final concatBuffer = StringBuffer();
  if (strings != null && strings.isNotEmpty) {
    for (int i = 0; i < strings.length; i++) {
      concatBuffer.write(strings[i]);
      if (i != strings.length - 1) {
        concatBuffer.write(delimiter);
      }
    }
  }
  return concatBuffer.toString();
}

List<String> convertList(List<String?>? nullableList) {
  if (nullableList == null) {
    return []; // or throw an error if needed
  }

  return nullableList
      .where((item) => item != null)
      .map((item) => item!)
      .toList();
}
