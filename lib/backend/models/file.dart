//===========================================================
//Model of File
class FileModel {
  final List<Object?> path;
  final List<Object?> extension;
  final String categoryName;
  final String expiration;
  final String subTitle1;
  final String dateUpload;
  bool isFavourite;
  FileModel({
    required this.path,
    required this.categoryName,
    required this.expiration,
    required this.subTitle1,
    required this.isFavourite,
    required this.dateUpload,
    required this.extension,
  });

//Method converting a Json(Map<String, dynamic>) to a File
  factory FileModel.fromRTDB(Map<String, dynamic> data) {
    /*  return File(
        path: data['path'],
        categoryName: data['categoryName'],
        subTitle1: data['subTitle1'],
        icon: data['icon']);*/
    return FileModel(
      path: data['path'],
      categoryName: data['categoryName'],
      expiration: data['expiration'],
      subTitle1: '216 Members',
      isFavourite: data['isFavourite'],
      dateUpload: data['dateUpload'],
      extension: data['extension'],
    );
  }
}
//===========================================================
