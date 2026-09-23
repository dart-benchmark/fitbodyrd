import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/repositories/user_repository.dart';
import 'package:fitbodyrd_flutter/src/core/services/refresh_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_result/record_result.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._repository, this._refreshHelper) : super(const UserInitial());

  final UserRepository _repository;
  final RefreshHelper _refreshHelper;

  StreamSubscription<void>? _refreshSubscription;

  @override
  Future<void> close() async {
    await _refreshSubscription?.cancel();
    return super.close();
  }

  Future<void> getUser({UserProfile? user}) async {
    listenToRefresh();
    if (user != null) {
      emit(UserLoaded(user));
      return;
    }
    await refreshUser();
  }

  void listenToRefresh() {
    _refreshSubscription = _refreshHelper.refreshUserStream.listen((_) {
      unawaited(refreshUser());
    });
  }

  Future<void> refreshUser() async {
    emit(const UserLoading());
    final result = await _repository.getCachedUser();

    result.fold(
      (user) => emit(UserLoaded(user!)),
      (error) => emit(UserError(error.message)),
    );
  }
}
