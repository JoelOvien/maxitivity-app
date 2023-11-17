part of 'timer_bloc.dart';

@immutable
sealed class TimerEvent {}

class CreateFocusHistoryEntryEvent extends TimerEvent {
  CreateFocusHistoryEntryEvent({required this.data});
  final RequestParams<String> data;
}

class GetFocusHistoryEntriesEvent extends TimerEvent {
  GetFocusHistoryEntriesEvent({required this.data});
  final RequestParams<String> data;
}
