//===========================================================
//Model of category
class CategoryModel {
  String path = "";
  int nfiles = 0;
  int colorValue = 0;
  int order = 0;
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
