part of 'timer_bloc.dart';

@immutable
sealed class TimerState {}

final class TimerInitial extends TimerState {}

class CreateFocusHistoryEntryLoading extends TimerState {}

class CreateFocusHistoryEntrySuccess extends TimerState {
  CreateFocusHistoryEntrySuccess({required this.data});
  final AbstractApiResponse data;
}

class CreateFocusHistoryEntryError extends TimerState {
  CreateFocusHistoryEntryError({required this.error});
  final String error;
}

class GetFocusHistoryEntriesLoading extends TimerState {}

class GetFocusHistoryEntriesSuccess extends TimerState {
  GetFocusHistoryEntriesSuccess({required this.data});
  final AbstractApiResponse data;
}

class GetFocusHistoryEntriesError extends TimerState {
  GetFocusHistoryEntriesError({required this.error});
  final String error;
}
