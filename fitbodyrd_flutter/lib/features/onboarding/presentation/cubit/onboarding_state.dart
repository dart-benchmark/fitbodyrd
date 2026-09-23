import 'package:equatable/equatable.dart';
import 'package:fitbodyrd_client/fitbodyrd_client.dart';

enum OnboardingStatus { initial, submitting, success, failure }

class OnboardingState extends Equatable {
  const OnboardingState({
    this.userProfile,
    this.currentStep = 0,
    this.status = OnboardingStatus.initial,
    this.errorMessage,
  });

  final UserProfile? userProfile;
  final int currentStep;
  final OnboardingStatus status;
  final String? errorMessage;

  OnboardingState copyWith({
    UserProfile? userProfile,
    int? currentStep,
    OnboardingStatus? status,
    String? errorMessage,
  }) {
    return OnboardingState(
      userProfile: userProfile ?? this.userProfile,
      currentStep: currentStep ?? this.currentStep,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [userProfile, currentStep, status, errorMessage];
}
