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
    identityImage =
        pickedImages
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
    licenseImage =
        pickedImages
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
    carImage =
        pickedImages
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
    required String deviceToken,
  }) async {
    if (deviceToken.isEmpty) {
      emit(
        RegisterFailure(error: "deviceToken غير موجود، يرجى إعادة المحاولة"),
      );
      return;
    }
    emit(RegisterLoading());

    final response = await http.post(
      Uri.parse("${baseUrl}auth/signUp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userName": fullName,
        "email": email,
        "phone": phoneNumber,
        "password": password,
        "confirmationPassword": confirmPassword,
        "address": {"country": country, "city": city, "area": town},
        "deviceToken": deviceToken,
      }),
    );

    debugPrint("Response status: ${response.statusCode}");
    debugPrint("Response body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        final data = jsonDecode(response.body);
        debugPrint(data.toString());

        final message = data["message"] ?? "تم التسجيل بنجاح";
        emit(RegisterSuccess(message: message));
      } catch (e) {
        debugPrint("Decoding error: $e");
        emit(RegisterFailure(error: "خطأ في تحليل بيانات الاستجابة"));
      }
    } else {
      try {
        final errorData = jsonDecode(response.body);

        if (errorData['validationResult'] != null) {
          final List validationErrors = errorData['validationResult'];
          final List<String> errorMessages = [];

          for (var error in validationErrors) {
            final path = error['path']?.join('.') ?? '';
            final message = error['message'] ?? 'خطأ غير معروف في $path';
            errorMessages.add('$path: $message');
          }

          final fullErrorMessage = errorMessages.join('\n');
          emit(RegisterFailure(error: fullErrorMessage));
        } else {
          emit(
            RegisterFailure(error: errorData['message'] ?? 'حدث خطأ غير متوقع'),
          );
        }
      } catch (e) {
        emit(RegisterFailure(error: 'فشل تحليل رسالة الخطأ'));
      }
    }
  }

  Future otp({required String email, required String code}) async {
    emit(OTPLoading());
    http.Response response = await http.patch(
      Uri.parse("${baseUrl}auth/confirmEmail"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "code": code}),
    );
    final data = jsonDecode(response.body);
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      // await CacheHelper.setUserId(data["data"]["id"].toString());
      emit(OTPSuccess());
    } else {
      emit(OTPFailure(error: data["message"]));
    }
  }

  Future logIn({
    required String phone,
    required String password,
    required String deviceToken,
  }) async {
    emit(LogInLoading());

    try {
      final response = await http.post(
        Uri.parse("${baseUrl}auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "phone": phone,
          "password": password,
          "deviceToken": deviceToken,
        }),
      );

      debugPrint("Response status: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final message = data["message"] ?? "تم تسجيل الدخول بنجاح";
        final token = data["data"]["token"];
        await CacheHelper.setUserToken(token);
        debugPrint("Saved Token: $token");
        emit(LogInSuccess(message: message));
      } else {
        final errorMessage = data["message"] ?? "فشل تسجيل الدخول";
        emit(LogInFailure(error: errorMessage));
      }
    } catch (e) {
      debugPrint("Decoding error: $e");
      emit(LogInFailure(error: "حدث خطأ غير متوقع أثناء تسجيل الدخول"));
    }
  }

  Future logOut() async {
    emit(LogOutLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");

    http.Response response = await http.patch(
      Uri.parse("${baseUrl}auth/logout"),
      headers: {"Content-Type": "application/json", "Authorization": token},
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      // CacheHelper.setUserId("");
      CacheHelper.setUserToken("");
      emit(LogOutSuccess(message: data["message"]));
    } else {
      emit(LogOutFailure(error: data["message"]));
    }
  }

  String resetPassId = "";
  Future forgetPass({required String email}) async {
    emit(ForgetPassLoading());
    http.Response response = await http.patch(
      Uri.parse("${baseUrl}auth/forgetPassword"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );
    debugPrint("Response status: ${response.statusCode}");
    debugPrint("Response body: ${response.body}");

    final data = jsonDecode(response.body);

    if (data["data"] != null) {
      // resetPassId = data["data"]["id"].toString();
      debugPrint(resetPassId);
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(ForgetPassSuccess(message: data["message"]));
    } else {
      debugPrint(data["msg"]);
      emit(ForgetPassFailure(error: data["message"]));
    }
  }

  Future resendCode({required String email}) async {
    emit(ResendCodeLoading());

    http.Response response = await http.post(
      Uri.parse("${baseUrl}auth/resendCode"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(ResendCodeSuccess(message: data["message"]));
    } else {
      debugPrint(data["message"]);
      emit(ResendCodeFailure(error: data["message"]));
    }
  }

  Future resetPass({
    required String code,
    required String password,
    required String email,
    required String confirmPassword,
  }) async {
    emit(ResetPassLoading());
    http.Response response = await http.patch(
      Uri.parse("${baseUrl}auth/resetPassword"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "code": code,
        "password": password,
        "confirmationPassword": confirmPassword,
      }),
    );
    debugPrint("Response status: ${response.statusCode}");
    debugPrint("Response body: ${response.body}");
    debugPrint(
      "email: $email, code: $code, password: $password, confirmPassword: $confirmPassword",
    );

    final data = jsonDecode(response.body);
    debugPrint(data.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(ResetPassSuccess(message: data["message"]));
    } else {
      emit(ResetPassFailure(error: data["message"]));
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
