import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../core/constants/contsants.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  bool isSecureLogIn = true;
  isSecureLogInIcon(isSecuree) {
    isSecureLogIn = isSecuree;
    emit(IsSecureIcon());
  }

  bool isSecureRegister1 = true;
  isSecureRegisterIcon1(isSecuree) {
    isSecureRegister1 = isSecuree;
    emit(IsSecureIcon());
  }

  bool isSecureRegister2 = true;
  isSecureRegisterIcon2(isSecuree) {
    isSecureRegister2 = isSecuree;
    emit(IsSecureIcon());
  }

  bool isSecureNewPass1 = true;
  isSecureNewPassIcon1(isSecuree) {
    isSecureNewPass1 = isSecuree;
    emit(IsSecureIcon());
  }

  bool isSecureNewPass2 = true;
  isSecureNewPassIcon2(isSecuree) {
    isSecureNewPass2 = isSecuree;
    emit(IsSecureIcon());
  }

  bool agreeTerms = false;
  agreeTermsFun() {
    agreeTerms = !agreeTerms;
    emit(AgreeTermsSuccess());
  }

  List<File> identityImage = [];
  Future<void> getIdentityImage() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    identityImage = pickedImages
        .map((pickedImage) => File(pickedImage.path))
        .take(1)
        .toList();
    emit(ChooseImageSuccess());
  }

  void removeIdentityImage() {
    identityImage.clear();
    emit(RemoveImageSuccess());
  }

  List<File> licenseImage = [];
  Future<void> getLicenseImage() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    licenseImage = pickedImages
        .map((pickedImage) => File(pickedImage.path))
        .take(1)
        .toList();
    emit(ChooseImageSuccess());
  }

  void removeLicenseImage() {
    licenseImage.clear();
    emit(RemoveImageSuccess());
  }

  List<File> carImage = [];
  Future<void> getCarImage() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    carImage = pickedImages
        .map((pickedImage) => File(pickedImage.path))
        .take(1)
        .toList();
    emit(ChooseImageSuccess());
  }

  void removeCarImage() {
    carImage.clear();
    emit(RemoveImageSuccess());
  }

  String cityId = "";
  String sectionId = "";
  Future register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required String country,
    required String city,
    required String town,
  }) async {
    emit(RegisterLoading());

    final response = await http.post(
      Uri.parse("${baseUrl}api/SignUp-User"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
        "confirmPassword": confirmPassword,
        "country": country,
        "city": city,
        "town": town,
      }),
    );

    try {
      final data = jsonDecode(response.body);
      debugPrint(data.toString());

      final message = data["message"] ?? "تم التسجيل بنجاح";

      emit(RegisterSuccess(message: message));
    } catch (e) {
      debugPrint("Decoding error: $e");
      emit(RegisterFailure(error: "حدث خطأ في التسجيل"));
    }
  }

  Future otp({required String code}) async {
    emit(OTPLoading());
    http.Response response = await http.post(
      Uri.parse("${baseUrl}api/active-account"),
      body: {
        "lang": CacheHelper.getLang(),
        "user_id": CacheHelper.getUserId(),
        "code": code,
        "device_id": CacheHelper.getDeviceToken(),
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data.toString());

    if (data["key"] == 1) {
      await CacheHelper.setUserId(data["data"]["id"].toString());
      emit(OTPSuccess());
    } else {
      emit(OTPFailure(error: data["msg"]));
    }
  }

  Future logIn({required String email, required String password}) async {
    emit(LogInLoading());
    http.Response response = await http.post(
      Uri.parse("${baseUrl}api/SignIn-User"),
      headers: {"Content-Type": "application/json"},
      body: {
        // "lang": CacheHelper.getLang(),
        "email": email,
        "password": password,
        // "device_id": CacheHelper.getDeviceToken(),
      },
    );
   try {
      final data = jsonDecode(response.body);
      debugPrint(data.toString());

      final message = data["message"] ?? "تم التسجيل بنجاح";

      emit(LogInSuccess(message: message));
    } catch (e) {
      debugPrint("Decoding error: $e");
      emit(LogInFailure(error: "حدث خطأ في التسجيل"));
    }
  }

  Future logOut() async {
    emit(LogOutLoading());
    http.Response response = await http.post(
      Uri.parse("${baseUrl}api/logout"),
      body: {
        "lang": CacheHelper.getLang(),
        "user_id": CacheHelper.getUserId(),
        "device_id": CacheHelper.getDeviceToken(),
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data.toString());

    if (data["key"] == 1) {
      CacheHelper.setUserId("");
      // CacheHelper.setUserToken("");
      emit(LogOutSuccess(message: data["msg"]));
    } else {
      emit(LogOutFailure(error: data["msg"]));
    }
  }

  String resetPassId = "";
  Future forgetPass({required String phone}) async {
    emit(ForgetPassLoading());
    http.Response response = await http.post(
      Uri.parse("${baseUrl}api/forget-password"),
      body: {"lang": CacheHelper.getLang(), "phone": phone},
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    if (data["data"] != null) {
      resetPassId = data["data"]["id"].toString();
      debugPrint(resetPassId);
    }

    if (data["key"] == 1) {
      emit(ForgetPassSuccess(message: data["msg"]));
    } else {
      debugPrint(data["msg"]);
      emit(ForgetPassFailure(error: data["msg"]));
    }
  }

  Future resendCode() async {
    emit(ResendCodeLoading());
    http.Response response = await http.post(
      Uri.parse("${baseUrl}api/resend-code"),
      body: {"lang": CacheHelper.getLang(), "user_id": CacheHelper.getUserId()},
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data.toString());

    if (data["key"] == 1) {
      emit(ResendCodeSuccess(message: data["msg"]));
    } else {
      debugPrint(data["msg"]);
      emit(ResendCodeFailure(error: data["msg"]));
    }
  }

  Future resetPass({required String code, required String password}) async {
    emit(ResetPassLoading());
    http.Response response = await http.post(
      Uri.parse("${baseUrl}api/reset-password"),
      body: {
        "lang": CacheHelper.getLang(),
        "user_id": resetPassId,
        "code": code,
        "password": password,
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data.toString());

    if (data["key"] == 1) {
      emit(ResetPassSuccess(message: data["msg"]));
    } else {
      emit(ResetPassFailure(error: data["msg"]));
    }
  }

  Future deleteAccount() async {
    emit(DeleteAccountLoading());
    http.Response response = await http.post(
      Uri.parse("${baseUrl}api/destroy-user"),
      body: {
        "lang": CacheHelper.getLang(),
        "user_id": CacheHelper.getUserId(),
        "device_id": CacheHelper.getDeviceToken(),
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data.toString());

    if (data["key"] == 1) {
      CacheHelper.setUserId("");
      // CacheHelper.setUserToken("");
      CacheHelper.setUserType("");
      emit(DeleteAccountSuccess(message: data["msg"]));
    } else {
      emit(DeleteAccountFailure(error: data["msg"]));
    }
  }

  String? identityImageUrl;
  Future uploadIdentityImage({required List<File> identityImage}) async {
    emit(UploadImageLoading());
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}api/upload-image"),
    );
    request.fields['lang'] = CacheHelper.getLang();

    for (var image in identityImage) {
      var stream = http.ByteStream(image.openRead());
      var length = await image.length();
      var multipartFile = http.MultipartFile(
        'image',
        stream,
        length,
        filename: image.path.split('/').last,
      );
      request.files.add(multipartFile);
    }
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    Map<String, dynamic> data = jsonDecode(responseBody);
    identityImageUrl = data["app_url"];
    debugPrint("imageUrl is $identityImageUrl");

    if (data["key"] == 1) {
      emit(UploadImageSuccess());
    } else {
      emit(UploadImageFailure());
    }
  }

  String? licenseImageUrl;
  Future uploadLicenseImage({required List<File> licenseImage}) async {
    emit(UploadImageLoading());
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}api/upload-image"),
    );
    request.fields['lang'] = CacheHelper.getLang();

    for (var image in licenseImage) {
      var stream = http.ByteStream(image.openRead());
      var length = await image.length();
      var multipartFile = http.MultipartFile(
        'image',
        stream,
        length,
        filename: image.path.split('/').last,
      );
      request.files.add(multipartFile);
    }
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    Map<String, dynamic> data = jsonDecode(responseBody);
    licenseImageUrl = data["app_url"];
    debugPrint("imageUrl is $licenseImageUrl");

    if (data["key"] == 1) {
      emit(UploadImageSuccess());
    } else {
      emit(UploadImageFailure());
    }
  }

  String? carImageUrl;
  Future uploadCarImage({required List<File> carImage}) async {
    emit(UploadImageLoading());
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}api/upload-image"),
    );
    request.fields['lang'] = CacheHelper.getLang();

    for (var image in carImage) {
      var stream = http.ByteStream(image.openRead());
      var length = await image.length();
      var multipartFile = http.MultipartFile(
        'image',
        stream,
        length,
        filename: image.path.split('/').last,
      );
      request.files.add(multipartFile);
    }
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    Map<String, dynamic> data = jsonDecode(responseBody);
    carImageUrl = data["app_url"];
    debugPrint("imageUrl is $carImageUrl");

    if (data["key"] == 1) {
      emit(UploadImageSuccess());
    } else {
      emit(UploadImageFailure());
    }
  }
}
