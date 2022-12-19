//===========================================================
//Model of category
class CategoryModel {
  final String path;
  int nfiles;
  final int colorValue;
  int order;
  CategoryModel({
    required this.path,
    required this.nfiles,
    required this.colorValue,
    required this.order,
  });

//Method converting a Json(Map<String, dynamic>) to a Category
  factory CategoryModel.fromRTDB(Map<String, dynamic> data) {
    return CategoryModel(
        path: data['path'],
        nfiles: data['nfiles'],
        colorValue: data['colorValue'],
        order: data['order']);
  }
}
//===========================================================
