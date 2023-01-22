import 'package:docs_manager/backend/models/category.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CategoryModel sut;

  setUp(() {
    sut = CategoryModel(path: "", nfiles: 0, colorValue: 0, order: 0);
  });

  group('file model methods', () {
    test(
      "initialize",
      () async {
        expect(sut.path, "");
        expect(sut.nfiles, 0);
        expect(sut.colorValue, 0);
        expect(sut.order, 0);
      },
    );
    test(
      "convert json to data",
      () async {
        Map<String, dynamic> myJson = {
          "path": "Credit Cards.png",
          "colorValue": 4282682111,
          "nfiles": 1,
          "order": 0
        };
        sut = CategoryModel.fromRTDB(myJson);
        expect(sut.path, "Credit Cards.png");
        expect(sut.nfiles, 1);
        expect(sut.colorValue, 4282682111);
        expect(sut.order, 0);
      },
    );
  });
}
