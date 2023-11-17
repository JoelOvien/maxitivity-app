import 'package:ambeego_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthEvent - ', () {
    test('LoginEvent has proper props', () {
      final data = {'EmailAddress': 'some@example.com', 'Password': 'password'};

      LoginUserEvent loginUserEvent = LoginUserEvent(data: data);

      expect(
          loginUserEvent,
          const TypeMatcher<LoginUserEvent>()
              .having((p0) => p0.data, 'login user data', loginUserEvent.data));
    });
  });
}
