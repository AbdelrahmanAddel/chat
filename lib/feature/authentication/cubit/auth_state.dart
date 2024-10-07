part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoadingToCrateAccountStata extends AuthState {}

final class CrateAccountSuccessStata extends AuthState {}

final class FailedToCeateAccountState extends AuthState {
  final String errorMessage;

  FailedToCeateAccountState({required this.errorMessage});

}

final class ChangeObsecureIcon extends AuthState {}

final class GetImageSuccess extends AuthState {}

final class LoadingToUploadImage extends AuthState {}

final class FialedToGetImage extends AuthState {}

final class SignInWithEmailAndPasswordSuccess extends AuthState {}

final class FailedToSignInWithEmailAndPassword extends AuthState {
  final String errorMessage;

  FailedToSignInWithEmailAndPassword({required this.errorMessage});
}

final class LoadingToSignInWithEmailAndPassword extends AuthState {}



