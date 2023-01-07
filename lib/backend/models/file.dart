//===========================================================
//Model of File
class FileModel {
  final List<Object?> path;
  final List<Object?> extension;
  final String categoryName;
  final String subTitle1;
  final String dateUpload;
  final String expiration;
  bool isFavourite;
  FileModel({
    required this.path,
    required this.categoryName,
    required this.subTitle1,
    required this.isFavourite,
    required this.dateUpload,
    required this.extension,
    required this.expiration,
  });

//Method converting a Json(Map<String, dynamic>) to a File
  factory FileModel.fromRTDB(Map<String, dynamic> data) {
    return FileModel(
      path: data['path'],
      categoryName: data['categoryName'],
      subTitle1: '216 Members',
      isFavourite: data['isFavourite'],
      dateUpload: data['dateUpload'],
      extension: data['extension'],
      expiration: data['expiration'],
    );
  }
}
//===========================================================
