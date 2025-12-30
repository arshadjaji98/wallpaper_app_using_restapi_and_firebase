class PhotosModel {
  String? url;
  SrcModel? src;

  PhotosModel({this.url, this.src});

  // Factory constructor to create a PhotosModel instance from a map
  factory PhotosModel.fromMap(Map<String, dynamic> parsedJson) {
    // Ensure that 'src' exists in parsedJson before calling SrcModel.fromMap
    return PhotosModel(
      url: parsedJson['url'],
      src: parsedJson['src'] != null
          ? SrcModel.fromMap(parsedJson["src"])
          : null,
    );
  }
}

class SrcModel {
  String? portrait;
  String? large;
  String? landscape;
  String? medium;

  SrcModel({this.portrait, this.large, this.landscape, this.medium});

  // Factory constructor to create a SrcModel instance from a map
  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
      portrait: srcJson['portrait'],
      large: srcJson['large'],
      landscape: srcJson['landscape'],
      medium: srcJson['medium'],
    );
  }
}
