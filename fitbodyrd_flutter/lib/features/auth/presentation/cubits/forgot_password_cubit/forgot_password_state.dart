part of 'forgot_password_cubit.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial();
}

final class ForgotPasswordLoading extends ForgotPasswordState {
  const ForgotPasswordLoading();
}

final class ForgotPasswordSuccess extends ForgotPasswordState {
  const ForgotPasswordSuccess();
}

final class ForgotPasswordError extends ForgotPasswordState {
  const ForgotPasswordError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

final class ForgotPasswordEmailSent extends ForgotPasswordState {
  const ForgotPasswordEmailSent();
}
