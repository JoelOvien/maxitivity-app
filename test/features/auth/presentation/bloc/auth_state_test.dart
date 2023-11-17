import 'package:ambeego_test/core/api/abstract_api_response.dart';
import 'package:ambeego_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAbstractApiResponse extends Mock implements AbstractApiResponse {}

void main() {
  group('auth state test - ', () {
    test('AuthInitialState', () {
      AuthInitial authInitialState = AuthInitial();

      expect(authInitialState, const TypeMatcher<AuthInitial>());
    });

    test('LoginLoadingState', () {
      LoginLoading loginLoadingState = LoginLoading();

      expect(loginLoadingState, const TypeMatcher<LoginLoading>());
    });

    test('loginSuccessState', () {
      LoginSuccess loginStccessState =
          LoginSuccess(data: _MockAbstractApiResponse());

      expect(loginStccessState, const TypeMatcher<LoginSuccess>());
    });

    test('LoginErrorState', () {
      LoginError loginErrorState = LoginError(error: 'error occured');

      expect(loginErrorState, const TypeMatcher<LoginError>());
    });
  });
}
