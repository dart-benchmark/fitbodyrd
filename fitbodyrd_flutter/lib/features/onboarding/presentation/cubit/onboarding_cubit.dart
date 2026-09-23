import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/repositories/user_repository.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_result/record_result.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({
    required this.userRepository,
    required this.sessionManager,
  }) : super(const OnboardingState()) {
    _initializeUserProfile();
  }

  final UserRepository userRepository;
  final SessionManager sessionManager;

  void _initializeUserProfile() {
    final userInfo = sessionManager.signedInUser;
    if (userInfo != null) {
      final initialProfile = UserProfile(
        userInfoId: userInfo.id!,
        fullName: userInfo.userName ?? '',
        email: userInfo.email ?? '',
        birthDate: DateTime.now(),
        sex: Sex.male,
        weightKgs: 0,
        heightMs: 0,
        bodyGoal: BodyGoal.loseWeight,
        activityLevel: ActivityLevel.sedentary,
        daysPerWeekExercise: 3,
        timePerExerciseSessionMinutes: 30,
        experienceLevel: ExerciseDifficulty.beginner,
        hasEquipment: true,
        dietaryRestrictions: DietaryRestriction.none,
      );
      emit(state.copyWith(userProfile: initialProfile));
    }
  }

  void updateUserProfile(UserProfile userProfile) {
    emit(state.copyWith(userProfile: userProfile));
  }

  void nextPage() {
    emit(state.copyWith(currentStep: state.currentStep + 1));
  }

  void previousPage() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  Future<void> submit() async {
    if (state.userProfile == null) return;

    emit(state.copyWith(status: OnboardingStatus.submitting));

    final result = await userRepository.createUserProfile(state.userProfile!);

    result.fold(
      (success) => emit(state.copyWith(status: OnboardingStatus.success)),
      (failure) => emit(
        state.copyWith(
          status: OnboardingStatus.failure,
          errorMessage: failure.message,
        ),
      ),
    );
  }
}
