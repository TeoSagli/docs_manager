import 'package:docs_manager/backend/models/file.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FileModel sut;

  setUp(() {
    sut = FileModel(
        path: [],
        categoryName: "",
        isFavourite: false,
        dateUpload: "",
        extension: [],
        expiration: "");
  });

  group('file model methods', () {
    test(
      "initialize",
      () async {
        expect(sut.categoryName, "");
        expect(sut.isFavourite, false);
        expect(sut.dateUpload, "");
        expect(sut.extension, []);
        expect(sut.expiration, "");
        expect(sut.path, []);
      },
    );
    test(
      "convert json to data",
      () async {
        Map<String, dynamic> myJson = {
          "path": [
            "/data/user/0/com.example.docs_manager/cache/scaled_image_picker1642403672838763561.png"
          ],
          "extension": ["png"],
          "expiration": "2030-05-16",
          "dateUpload": "2023-01-19 14:39:16.817407",
          "categoryName": "Other Cards",
          "isFavourite": true
        };
        sut = FileModel.fromRTDB(myJson);
        expect(sut.categoryName, "Other Cards");
        expect(sut.isFavourite, true);
        expect(sut.dateUpload, "2023-01-19 14:39:16.817407");
        expect(sut.extension, ["png"]);
        expect(sut.expiration, "2030-05-16");
        expect(sut.path, [
          "/data/user/0/com.example.docs_manager/cache/scaled_image_picker1642403672838763561.png"
        ]);
      },
    );
  });
}
