import 'package:ambeego_test/features/timer/presentation/bloc/timer_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TimerEvent - ', () {
    test('TimerEvent has proper props', () {
      final data = {"email": "some@example.com"};

      GetFocusHistoryEntriesEvent timerEvent = GetFocusHistoryEntriesEvent(data: data);

      expect(
          timerEvent,
          const TypeMatcher<GetFocusHistoryEntriesEvent>()
              .having((p0) => p0.data, 'focus history data', timerEvent.data));
    });
  });
}
