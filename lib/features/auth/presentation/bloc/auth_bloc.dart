// ignore_for_file: depend_on_referenced_packages

import 'package:ambeego_test/core/api/abstract_api_response.dart';
import 'package:ambeego_test/core/api/exception.dart';
import 'package:ambeego_test/core/utils/app_module.dart';
import 'package:ambeego_test/core/utils/typedefs.dart';
import 'package:ambeego_test/features/auth/data/auth_datasource.dart';
import 'package:ambeego_test/features/auth/data/repository/abstract_auth_repository.dart';
import 'package:ambeego_test/features/auth/data/repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({AbstractAuthRepository? authRepository})
      : _authRepository =
            authRepository ?? AuthRepository(authDataSource: AuthDataSource()),
        super(AuthInitial()) {
    on<LoginUserEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await _authRepository.login(event.data);
        response.fold((l) => emit(LoginError(error: l)), (r) {
          module.token = r.accessToken;
          module.email = r.data['EmailAddress'];
          module.fullname = r.data['FirstName'] + ' ' + r.data['Surname'];
          emit(LoginSuccess(data: r));
        });
      } on DioError catch (e) {
        final ex = NetworkExceptions.getDioException(e);
        emit(LoginError(error: ex));
      }
    });
  }

  final AbstractAuthRepository _authRepository;
}
