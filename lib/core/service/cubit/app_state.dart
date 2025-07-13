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

final class UploadProfileImageLoading extends AppState {}

final class UploadProfileImageSuccess extends AppState {
  final String message;
  UploadProfileImageSuccess({required this.message});
}

final class UploadProfileImageFailure extends AppState {
  final String error;
  UploadProfileImageFailure({required this.error});
}

final class GetProfileLoading extends AppState {}

final class GetProfileSuccess extends AppState {}

final class GetProfileFailure extends AppState {
  final String error;
  GetProfileFailure({required this.error});
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

final class OTPEmailLoading extends AppState {}

final class OTPEmailSuccess extends AppState {
  final String message;
  OTPEmailSuccess({required this.message});
}

final class OTPEmailFailure extends AppState {
  final String error;
  OTPEmailFailure({required this.error});
}

final class UpdatePasswordLoading extends AppState {}

final class UpdatePasswordSuccess extends AppState {
  final String message;
  UpdatePasswordSuccess({required this.message});
}

final class UpdatePasswordFailure extends AppState {
  final String error;
  UpdatePasswordFailure({required this.error});
}

final class DeleteProfileLoading extends AppState {}

final class DeleteProfileSuccess extends AppState {
  final String message;
  DeleteProfileSuccess({required this.message});
}

final class DeleteProfileFailure extends AppState {
  final String error;
  DeleteProfileFailure({required this.error});
}

final class AddCarsLoading extends AppState {}

final class AddCarsSuccess extends AppState {
  final String message;
  AddCarsSuccess({required this.message});
}

final class AddCarsFailure extends AppState {
  final String error;
  AddCarsFailure({required this.error});
}

final class GetCarsLoading extends AppState {}

final class GetCarsSuccess extends AppState {}

final class GetCarsFailure extends AppState {
  final String error;
  GetCarsFailure({required this.error});
}

final class DeleteCarLoading extends AppState {}

final class DeleteCarSuccess extends AppState {
  final String message;
  DeleteCarSuccess({required this.message});
}

final class DeleteCarFailure extends AppState {
  final String error;
  DeleteCarFailure({required this.error});
}

final class EditCarLoading extends AppState {}

final class EditCarSuccess extends AppState {
  final String message;
  EditCarSuccess({required this.message});
}

final class EditCarFailure extends AppState {
  final String error;
  EditCarFailure({required this.error});
}

final class GetBannerLoading extends AppState {}

final class GetBannerSuccess extends AppState {}

final class GetBannerFailure extends AppState {
  final String error;
  GetBannerFailure({required this.error});
}

final class AddBannerLoading extends AppState {}

final class AddBannerSuccess extends AppState {
  final String message;
  AddBannerSuccess({required this.message});
}

final class AddBannerFailure extends AppState {
  final String error;
  AddBannerFailure({required this.error});
}

final class GetDriversLoading extends AppState {}

final class GetDriversSuccess extends AppState {}

final class GetDriversFailure extends AppState {
  final String error;
  GetDriversFailure({required this.error});
}

final class GetComplaintsLoading extends AppState {}

final class GetComplaintsSuccess extends AppState {}

final class GetComplaintsFailure extends AppState {
  final String error;
  GetComplaintsFailure({required this.error});
}

final class DriverBanLoading extends AppState {}

final class DriverBanSuccess extends AppState {
  final String message;
  DriverBanSuccess({required this.message});
}

final class DriverBanFailure extends AppState {
  final String error;
  DriverBanFailure({required this.error});
}

final class GetCarProblemsLoading extends AppState {}

final class GetCarProblemsSuccess extends AppState {}

final class GetCarProblemsFailure extends AppState {
  final String error;
  GetCarProblemsFailure({required this.error});
}

final class GetServicesLoading extends AppState {}

final class GetServicesSuccess extends AppState {}

final class GetServicesFailure extends AppState {
  final String error;
  GetServicesFailure({required this.error});
}

final class AddRequestLoading extends AppState {}

final class AddRequestSuccess extends AppState {
  final String message;
  AddRequestSuccess({required this.message});
}

final class AddRequestFailure extends AppState {
  final String error;
  AddRequestFailure({required this.error});
}

final class GetRequestsLoading extends AppState {}

final class GetRequestsSuccess extends AppState {}

final class GetRequestsFailure extends AppState {
  final String error;
  GetRequestsFailure({required this.error});
}

final class GetCompletedRequestsLoading extends AppState {}

final class GetCompletedRequestsSuccess extends AppState {}

final class GetCompletedRequestsFailure extends AppState {
  final String error;
  GetCompletedRequestsFailure({required this.error});
}

final class ConfirmRequestLoading extends AppState {}

final class ConfirmRequestSuccess extends AppState {
  final String message;
  ConfirmRequestSuccess({required this.message});
}

final class ConfirmRequestFailure extends AppState {
  final String error;
  ConfirmRequestFailure({required this.error});
}

final class InRoadRequestLoading extends AppState {}

final class InRoadRequestSuccess extends AppState {
  final String message;
  InRoadRequestSuccess({required this.message});
}

final class InRoadRequestFailure extends AppState {
  final String error;
  InRoadRequestFailure({required this.error});
}

final class GetAllNearDriversLoading extends AppState {}

final class GetAllNearDriversSuccess extends AppState {}

final class GetAllNearDriversFailure extends AppState {
  final String error;
  GetAllNearDriversFailure({required this.error});
}

class GetChatRoomsLoading extends AppState {}

class GetChatRoomsSuccess extends AppState {
  final List<ChatRoomModel> chatRooms;
  GetChatRoomsSuccess(this.chatRooms);
}

class GetChatRoomsError extends AppState {
  final String error;
  GetChatRoomsError(this.error);
}

class GetChatMessagesLoading extends AppState {}

class GetChatMessagesSuccess extends AppState {
  final List<ChatMessageModel> messages;
  GetChatMessagesSuccess(this.messages);
}

class GetChatMessagesError extends AppState {
  final String error;
  GetChatMessagesError(this.error);
}

class SendMessageLoading extends AppState {}

class SendMessageSuccess extends AppState {}

class SendMessageError extends AppState {
  final String error;
  SendMessageError(this.error);
}

class SendMessagePending extends AppState {}

class CreateChatRoomLoading extends AppState {}

class CreateChatRoomSuccess extends AppState {}

class CreateChatRoomError extends AppState {
  final String error;
  CreateChatRoomError(this.error);
}

class DeleteBannerLoading extends AppState {}

class DeleteBannerSuccess extends AppState {
  final String message;
  DeleteBannerSuccess({required this.message});
}

class DeleteBannerFailure extends AppState {
  final String error;
  DeleteBannerFailure({required this.error});
}

class UpdatePriceLoading extends AppState {}

class UpdatePriceSuccess extends AppState {
  final String message;
  UpdatePriceSuccess({required this.message});
}

class UpdatePriceFailure extends AppState {
  final String error;
  UpdatePriceFailure({required this.error});
}

class GetSubscriptionsLoading extends AppState {}

class GetSubscriptionsSuccess extends AppState {}

class GetSubscriptionsFailure extends AppState {
  final String error;
  GetSubscriptionsFailure({required this.error});
}

class UpdateSubscriptionLoading extends AppState {
}

class UpdateSubscriptionSuccess extends AppState {
  final String message;
  UpdateSubscriptionSuccess({required this.message});
}

class UpdateSubscriptionFailure extends AppState {
  final String error;
  UpdateSubscriptionFailure({required this.error});
}