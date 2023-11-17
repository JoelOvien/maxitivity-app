import 'package:ambeego_test/core/api/abstract_api_response.dart';
import 'package:ambeego_test/core/utils/typedefs.dart';
import 'package:ambeego_test/features/timer/data/repository/abstract_timer_repository.dart';
import 'package:ambeego_test/features/timer/data/timer_datasource.dart';
import 'package:dartz/dartz.dart';

class TimerRepository extends AbstractTimerRepository {
  final TimerDataSource timerDataSource;

  TimerRepository({
    required this.timerDataSource,
  });
  @override
  ResponseFormat<AbstractApiResponse> createFocusHistoryEntry(
      RequestParams<String> data) async {
    final response = await timerDataSource.createFocusHistoryEntry(data);

    if (response.status == true) {
      return Right(response);
    } else {
      return Left(response.message ?? 'Unable to create focus history entry');
    }
  }

  @override
  ResponseFormat<AbstractApiResponse> getFocusHistoryEntries(
      RequestParams<String> data) async {
    final response = await timerDataSource.getFocusHistoryEntries(data);

    if (response.status == true) {
      return Right(response);
    } else {
      return Left(
          response.message ?? 'Unable to retrieve focus history entries');
    }
  }
}
