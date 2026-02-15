import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../entities/user_entity/user_entity.dart';

part 'app_user_cubit.freezed.dart';
part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(const AppUserState.initial());

  void updateUser(UserEntity? user) {
    if (user == null) {
      emit(const .initial());
    } else {
      emit(.loggedIn(user));
    }
  }
}
