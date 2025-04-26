part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class ChangeIndex extends AppState {}

final class GetCurrentLocationLoading extends AppState {}

final class GetCurrentLocationSuccess extends AppState {}

final class ServerError extends AppState {}

final class Timeoutt extends AppState {}

final class GetIntroLoading extends AppState {}

final class ChangeCount extends AppState {}

final class GetIntroSuccess extends AppState {}

final class ChangeBottomNav extends AppState {}

final class IsSecureIcon extends AppState {}

final class GetIntroFailure extends AppState {
  final String error;

  GetIntroFailure({required this.error});
}

final class AddAddressLoading extends AppState {}

final class AddAddressSuccess extends AppState {
  final String message;
  AddAddressSuccess({required this.message});
}

final class AddAddressFailure extends AppState {
  final String error;

  AddAddressFailure({required this.error});
}

final class DeleteAddressLoading extends AppState {}

final class DeleteAddressSuccess extends AppState {
  final String message;
  DeleteAddressSuccess({required this.message});
}

final class DeleteAddressFailure extends AppState {
  final String error;

  DeleteAddressFailure({required this.error});
}

final class ChooseImageSuccess extends AppState {}

final class RemoveImageSuccess extends AppState {}

final class UpdateProfileLoading extends AppState {}

final class UpdateProfileSuccess extends AppState {
  final String message;
  UpdateProfileSuccess({required this.message});
}

final class UpdateProfileFailure extends AppState {
  final String error;
  UpdateProfileFailure({required this.error});
}

final class UploadImagesLoading extends AppState {}

final class UploadImagesSuccess extends AppState {}

final class UploadImagesFailure extends AppState {}

final class AboutUsLoading extends AppState {}

final class AboutUsSuccess extends AppState {}

final class AboutUsFailure extends AppState {
  final String error;
  AboutUsFailure({required this.error});
}

final class ContactUsLoading extends AppState {}

final class ContactUsSuccess extends AppState {
  final String message;
  ContactUsSuccess({required this.message});
}

final class ContactUsFailure extends AppState {
  final String error;
  ContactUsFailure({required this.error});
}

final class PrivacyPolicyLoading extends AppState {}

final class PrivacyPolicySuccess extends AppState {}

final class PrivacyPolicyFailure extends AppState {
  final String error;
  PrivacyPolicyFailure({required this.error});
}

final class GetChatMessagesLoading extends AppState {}

final class GetChatMessagesSuccess extends AppState {}

final class GetChatMessagesFailure extends AppState {
  final String error;
  GetChatMessagesFailure({required this.error});
}

final class SendMessageLoading extends AppState {}

final class SendMessageSuccess extends AppState {}

final class SendMessageFailure extends AppState {
  final String error;
  SendMessageFailure({required this.error});
}

final class GetSectionsLoading extends AppState {}

final class GetSectionsSuccess extends AppState {}

final class GetSectionsFailure extends AppState {
  final String error;
  GetSectionsFailure({required this.error});
}

final class GetQuestionsLoading extends AppState {}

final class GetQuestionsSuccess extends AppState {}

final class GetQuestionsFailure extends AppState {
  final String error;
  GetQuestionsFailure({required this.error});
}

final class ShowUserLoading extends AppState {}

final class ShowUserSuccess extends AppState {}

final class ShowUserFailure extends AppState {
  final String error;
  ShowUserFailure({required this.error});
}

final class UpdateUserLoading extends AppState {}

final class UpdateUserSuccess extends AppState {
  final String message;
  UpdateUserSuccess({required this.message});
}

final class UpdateUserFailure extends AppState {
  final String error;
  UpdateUserFailure({required this.error});
}

final class ShowNotificationsLoading extends AppState {}

final class ShowNotificationsSuccess extends AppState {
  final String message;
  ShowNotificationsSuccess({required this.message});
}

final class ShowNotificationsFailure extends AppState {
  final String error;
  ShowNotificationsFailure({required this.error});
}

final class DeleteNotificationLoading extends AppState {}

final class DeleteNotificationSuccess extends AppState {
  final String message;
  DeleteNotificationSuccess({required this.message});
}

final class DeleteNotificationFailure extends AppState {
  final String error;
  DeleteNotificationFailure({required this.error});
}

final class FileSelected extends AppState {}

final class FileNotSelected extends AppState {}