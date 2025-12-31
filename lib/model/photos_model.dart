class PhotosModel {
  String? url;
  SrcModel? src;

  PhotosModel({this.url, this.src});

  factory PhotosModel.fromMap(Map<String, dynamic> parsedJson) {
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

  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
      portrait: srcJson['portrait'],
      large: srcJson['large'],
      landscape: srcJson['landscape'],
      medium: srcJson['medium'],
    );
  }
}
