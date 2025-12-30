import 'dart:html' as html;
import 'dart:typed_data';

void saveImageWeb(Uint8List data) {
  final blob = html.Blob([data]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  // ignore: unused_local_variable
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', 'image.jpg')
    ..click();
  html.Url.revokeObjectUrl(url);
}
