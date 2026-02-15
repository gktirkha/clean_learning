import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log('${bloc.runtimeType} Created', name: 'BlocObserver');
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    log(
      'an event Happened in ${bloc.runtimeType} the event is ${event.runtimeType}',
      name: 'BlocObserver',
    );
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log(
      'There was a transition from ${transition.currentState.runtimeType} to ${transition.nextState.runtimeType} in ${bloc.runtimeType}',
      name: 'BlocObserver',
    );
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log(
      'Error happened in ${bloc.runtimeType} with error ${error.runtimeType} and the stacktrace is $stackTrace',
      name: 'BlocObserver',
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    log('${bloc.runtimeType} is closed', name: 'BlocObserver');
    super.onClose(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log(
      'Change on ${bloc.runtimeType} from ${change.currentState.runtimeType} to ${change.nextState.runtimeType}',
      name: 'BlocObserver',
    );
    super.onChange(bloc, change);
  }
}
