import 'package:ambeego_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ambeego_test/features/timer/presentation/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> providers = [
  BlocProvider<AuthBloc>(
    create: (BuildContext context) => AuthBloc(),
  ),
  BlocProvider<TimerBloc>(
    create: (BuildContext context) => TimerBloc(),
  ),
];
