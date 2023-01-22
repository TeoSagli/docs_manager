import 'package:docs_manager/backend/handlers/handleRegistration.dart';
import 'package:docs_manager/backend/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserCredsModel extends Mock implements UserCredsModel {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late HandleRegistration sut;
  late MockUserCredsModel mockUser;
  late MockBuildContext context;

  setUp(() {
    mockUser = MockUserCredsModel();
    context = MockBuildContext();
    sut = HandleRegistration(mockUser);
  });

  group('tests registration working', () {
    void initUser(e, p) {
      mockUser.setEmail(e);
      mockUser.setPassword(p);
    }

    test(
      "set user",
      () async {
        initUser("marcorossi@gmail.com", "password1234");
        sut.setUser(mockUser);
        expect(sut.user, mockUser);
      },
    );
    /* test(
      "new user registers",
      () async {
        initUser("marcorossi@gmail.com", "password1234");
        sut.setUser(mockUser);
        expect(sut.register(context), true);
      },
    );*/
  });
}
