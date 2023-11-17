// ignore_for_file: depend_on_referenced_packages

import 'package:ambeego_test/core/api/abstract_api_response.dart';
import 'package:ambeego_test/core/api/exception.dart';
import 'package:ambeego_test/core/utils/typedefs.dart';
import 'package:ambeego_test/features/timer/data/repository/abstract_timer_repository.dart';
import 'package:ambeego_test/features/timer/data/repository/timer_repository.dart';
import 'package:ambeego_test/features/timer/data/timer_datasource.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc({AbstractTimerRepository? timerRepository})
      : _timerRepository = timerRepository ??
            TimerRepository(timerDataSource: TimerDataSource()),
        super(TimerInitial()) {
    on<CreateFocusHistoryEntryEvent>((event, emit) async {
      try {
        emit(CreateFocusHistoryEntryLoading());
        final response =
            await _timerRepository.createFocusHistoryEntry(event.data);
        response.fold((l) => emit(CreateFocusHistoryEntryError(error: l)),
            (r) => emit(CreateFocusHistoryEntrySuccess(data: r)));
      } on DioError catch (e) {
        final ex = NetworkExceptions.getDioException(e);
        emit(CreateFocusHistoryEntryError(error: ex));
      }
    });
    on<GetFocusHistoryEntriesEvent>((event, emit) async {
      try {
        emit(GetFocusHistoryEntriesLoading());
        final response =
            await _timerRepository.getFocusHistoryEntries(event.data);

        response.fold((l) => emit(GetFocusHistoryEntriesError(error: l)),
            (r) => emit(GetFocusHistoryEntriesSuccess(data: r)));
      } on DioError catch (e) {
        final ex = NetworkExceptions.getDioException(e);
        emit(GetFocusHistoryEntriesError(error: ex));
      }
    });
  }

  final AbstractTimerRepository _timerRepository;
}
