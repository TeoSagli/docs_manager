//===========================================================
//Model of File
class FileModel {
  List<Object?> path = [];
  List<Object?> extension = [];
  String categoryName = "";
  String dateUpload = "";
  String expiration = "";
  bool isFavourite;
  FileModel({
    required this.path,
    required this.categoryName,
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
      isFavourite: data['isFavourite'],
      dateUpload: data['dateUpload'],
      extension: data['extension'],
      expiration: data['expiration'],
    );
  }
}
//===========================================================
