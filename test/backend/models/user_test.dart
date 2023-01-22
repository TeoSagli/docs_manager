import 'package:docs_manager/backend/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UserCredsModel sut;

  setUp(() {
    sut = UserCredsModel("", "");
  });

  group("user credentials model methods", () {
    test(
      "initialize",
      () async {
        expect(sut.email, "");
        expect(sut.password, "");
      },
    );
    test(
      "change values",
      () async {
        sut.setEmail("test@test.it");
        sut.setPassword("provapassword");
        expect(sut.email, "test@test.it");
        expect(sut.password, "provapassword");
      },
    );
    test(
      "convert json to strings",
      () async {
        Map<String, dynamic> myJson = {
          "email": "marco@rossi.it",
          "password": "mypassword1234"
        };
        sut = UserCredsModel.fromJson(myJson);
        expect(sut.email, "marco@rossi.it");
        expect(sut.password, "mypassword1234");
      },
    );
    test(
      "convert strings to json",
      () async {
        sut = UserCredsModel("marco@rossi.it", "mypassword1234");
        final newJson = sut.toJson();
        expect(
            newJson, {"email": "marco@rossi.it", "password": "mypassword1234"});
      },
    );
  });
}
