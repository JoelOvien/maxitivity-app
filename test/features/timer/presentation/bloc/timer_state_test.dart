import 'package:ambeego_test/core/api/abstract_api_response.dart';
import 'package:ambeego_test/features/timer/presentation/bloc/timer_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAbstractApiResponse extends Mock implements AbstractApiResponse {}

void main() {
  group('timer state test - ', () {
    test('TimerInitialState', () {
      TimerInitial timerInitialState = TimerInitial();

      expect(timerInitialState, const TypeMatcher<TimerInitial>());
    });

    test('getFocusHistoryEntriesLoadingState', () {
      GetFocusHistoryEntriesLoading getFocusHistoryEntriesLoadingState =
          GetFocusHistoryEntriesLoading();

      expect(
          getFocusHistoryEntriesLoadingState, const TypeMatcher<GetFocusHistoryEntriesLoading>());
    });

    test('getFocusHistoryEntriesSuccessState', () {
      GetFocusHistoryEntriesSuccess getFocusHistoryEntriesSuccessState =
          GetFocusHistoryEntriesSuccess(data: _MockAbstractApiResponse());

      expect(
          getFocusHistoryEntriesSuccessState, const TypeMatcher<GetFocusHistoryEntriesSuccess>());
    });

    test('getFocusHistoryEntriesErrorState', () {
      GetFocusHistoryEntriesError getFocusHistoryEntriesErrorState =
          GetFocusHistoryEntriesError(error: 'error occured');

      expect(getFocusHistoryEntriesErrorState, const TypeMatcher<GetFocusHistoryEntriesError>());
    });
  });
}
