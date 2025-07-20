// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:sathuh/screens/admin_screens/home_layout/chats/admin_chats.dart';
import 'package:sathuh/screens/admin_screens/home_layout/complaints/complaints.dart';
import 'package:sathuh/screens/admin_screens/home_layout/drivers/drivers.dart';
import 'package:sathuh/screens/admin_screens/home_layout/price/price.dart';
import 'package:sathuh/screens/driver_screens/home_layout/chats/driver_chats.dart';
import 'package:sathuh/screens/driver_screens/home_layout/home/driver_home.dart';
import 'package:sathuh/screens/user_screens/home_layout/my_cars/my_cars.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../generated/locale_keys.g.dart';
import '../../../screens/driver_screens/home_layout/orders/driver_orders.dart';
import '../../../screens/driver_screens/home_layout/subscribes/subscribes.dart';
import '../../../screens/user_screens/chat_details/chat_details.dart';
import '../../../screens/user_screens/home_layout/chats/chats.dart';
import '../../../screens/user_screens/home_layout/home/home.dart';
import '../../../screens/user_screens/home_layout/orders/orders.dart';
import '../../cache/cache_helper.dart';
import '../../constants/contsants.dart';
import '../../widgets/app_router.dart';
import '../models/chat_models.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  int bottomNavIndex = 1;
  List<Widget> bottomNavScreens = [
    const MyCars(),
    const Home(),
    const Orders(),
    const Chats(),
  ];

  int bottomAdminNavIndex = 1;
  List<Widget> bottomAdminNavScreens = [
    const Drivers(),
    const Price(),
    const Complaints(),
    const AdminChats(),
  ];

  void changebottomAdminNavIndex(index) async {
    bottomAdminNavIndex = index;
    emit(ChangeBottomNav());
  }

  int bottomDriverNavIndex = 1;
  List<Widget> bottomDriverNavScreens = [
    const Subscribes(),
    const DriverHome(),
    const DriverOrders(),
    const DriverChats(),
  ];

  void changebottomDriverNavIndex(index) async {
    bottomDriverNavIndex = index;
    emit(ChangeBottomNav());
  }

  double? lat = 0;
  double? lng = 0;
  String? address;
  void changeAddress({required String newAddress}) {
    address = newAddress;
    emit(ChangeIndex());
  }

  bool isSecureLogIn = true;
  isSecureLogInIcon(isSecuree) {
    isSecureLogIn = isSecuree;
    emit(IsSecureIcon());
  }

  bool isSecureDelete = true;
  isSecureDeleteIcon(isSecuree) {
    isSecureDelete = isSecuree;
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

  int drawerIndex = -1;
  void changedrawerIndex({required int index}) {
    if (drawerIndex != index) {
      drawerIndex = index;
      emit(ChangeIndex());
    }
    emit(ChangeIndex());
  }

  int subScripeIndex = -1;
  void changesubScripeIndex({required int index}) {
    subScripeIndex = index;
    emit(ChangeIndex());
  }

  int paymentIndex = -1;
  void changePaymentIndex({required int index}) {
    paymentIndex = index;
    emit(ChangeIndex());
  }

  int requestType = -1;
  void changerequestTypeIndex({required int index}) {
    requestType = index;
    emit(ChangeIndex());
  }

  int shipIndex = -1;
  void changeShipIndex({required int index}) {
    shipIndex = index;
    emit(ChangeIndex());
  }

  int count = 1;
  void increseCount() {
    count++;
    emit(ChangeCount());
  }

  void decreseCount() {
    if (count > 0) {
      count--;
    }
    emit(ChangeCount());
  }

  int count2 = 1;
  void increseCount2() {
    count2++;
    emit(ChangeCount());
  }

  void decreseCount2() {
    if (count2 > 0) {
      count2--;
    }
    emit(ChangeCount());
  }

  int count3 = 1;
  void increseCount3() {
    count3++;
    emit(ChangeCount());
  }

  void decreseCount3() {
    if (count3 > 0) {
      count3--;
    }
    emit(ChangeCount());
  }

  bool hasCertificate = false;
  void changeCertificate() {
    hasCertificate = !hasCertificate;
    emit(ChangeIndex());
  }

  // int isTab = -1;
  // changeIsTab({required int index}) {
  //   isTab = index;
  //   emit(ChangeIndex());
  // }

  int isTab = 0;
  final SwiperController swiperController = SwiperController();
  void changeIsSwiperTab({required int index}) {
    isTab = index;
    swiperController.move(index);
    emit(ChangeIndex());
  }

  void changebottomNavIndex(index) async {
    bottomNavIndex = index;
    emit(ChangeBottomNav());
  }

  int changeLangIndex = 0;
  void changeLangIndexs({required int index}) {
    changeLangIndex = index;
    emit(ChangeIndex());
  }

  List<int> selectedCarIndexes = [-1];
  void changeSelectedCar({required int index}) {
    selectedCarIndexes = [index];
    emit(ChangeIndex());
  }

  List<int> selectedProblemIndexes = [];
  void changeSelectedProblem({required int index}) {
    if (selectedProblemIndexes.contains(index)) {
      selectedProblemIndexes.remove(index);
    } else {
      selectedProblemIndexes.add(index);
    }
    emit(ChangeIndex());
  }

  int changeIndex = 0;
  void changeIndexs({required int index}) {
    changeIndex = index;
    emit(ChangeIndex());
  }

  int changeFavIndex = 0;
  void changeFavIndexs({required int index}) {
    changeFavIndex = index;
    emit(ChangeIndex());
  }

  int changeTermsIndex = -1;
  void changeTermsIndexs({required int index}) {
    changeTermsIndex = index;

    emit(ChangeIndex());
  }

  // Get Images
  List<File> requestImage = [];
  Future<void> getRequestImage(BuildContext context) async {
    final picker = ImagePicker();
    final int? pickedOption = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.select_image_source.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () => Navigator.pop(context, 1),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () => Navigator.pop(context, 2),
              ),
            ],
          ),
        );
      },
    );

    if (pickedOption == null) return;

    XFile? pickedImage;

    if (pickedOption == 1) {
      pickedImage = await picker.pickImage(source: ImageSource.camera);
    } else if (pickedOption == 2) {
      final pickedImages = await picker.pickMultiImage();
      if (pickedImages.isNotEmpty) {
        requestImage.addAll(pickedImages.map((e) => File(e.path)));
      }
    }

    if (pickedImage != null) {
      requestImage.add(File(pickedImage.path));
    }

    emit(ChooseImageSuccess());
  }

  void removeRequestImage(int index) {
    requestImage.removeAt(index);
    emit(RemoveImageSuccess());
  }

  List<File> profileCoverImage = [];
  Future<void> getProfileCoverImage(BuildContext context) async {
    final picker = ImagePicker();
    final int? pickedOption = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.select_image_source.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () => Navigator.pop(context, 1),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () => Navigator.pop(context, 2),
              ),
            ],
          ),
        );
      },
    );

    if (pickedOption == null) return;

    XFile? pickedImage;

    if (pickedOption == 1) {
      pickedImage = await picker.pickImage(source: ImageSource.camera);
    } else if (pickedOption == 2) {
      final pickedImages = await picker.pickMultiImage();
      if (pickedImages.isNotEmpty) {
        pickedImage = pickedImages.first;
      }
    }

    if (pickedImage != null) {
      profileCoverImage = [File(pickedImage.path)];
      emit(ChooseImageSuccess());
    }
  }

  void removeProfileCoverImage() {
    profileCoverImage.clear();
    emit(RemoveImageSuccess());
  }

  List<File> profileImage = [];
  Future<void> getProfileImage(BuildContext context) async {
    final picker = ImagePicker();
    final int? pickedOption = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.select_image_source.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () => Navigator.pop(context, 1),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () => Navigator.pop(context, 2),
              ),
            ],
          ),
        );
      },
    );

    if (pickedOption == null) return;

    XFile? pickedImage;

    if (pickedOption == 1) {
      pickedImage = await picker.pickImage(source: ImageSource.camera);
    } else if (pickedOption == 2) {
      final pickedImages = await picker.pickMultiImage();
      if (pickedImages.isNotEmpty) {
        pickedImage = pickedImages.first;
      }
    }

    if (pickedImage != null) {
      profileImage = [File(pickedImage.path)];
      emit(ChooseImageSuccess());
    }
  }

  void removeProfileImage() {
    profileImage.clear();
    emit(RemoveImageSuccess());
  }

  List<File> profileCoverImage2 = [];
  Future<void> getProfileCoverImage2(BuildContext context) async {
    final picker = ImagePicker();
    final int? pickedOption = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.select_image_source.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () => Navigator.pop(context, 1),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () => Navigator.pop(context, 2),
              ),
            ],
          ),
        );
      },
    );

    if (pickedOption == null) return;

    XFile? pickedImage;

    if (pickedOption == 1) {
      pickedImage = await picker.pickImage(source: ImageSource.camera);
    } else if (pickedOption == 2) {
      final pickedImages = await picker.pickMultiImage();
      if (pickedImages.isNotEmpty) {
        pickedImage = pickedImages.first;
      }
    }

    if (pickedImage != null) {
      profileCoverImage2 = [File(pickedImage.path)];
      emit(ChooseImageSuccess());
    }
  }

  void removeProfileCoverImage2() {
    profileCoverImage2.clear();
    emit(RemoveImageSuccess());
  }

  List<File> profileImage2 = [];
  Future<void> getProfileImage2(BuildContext context) async {
    final picker = ImagePicker();
    final int? pickedOption = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.select_image_source.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () => Navigator.pop(context, 1),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () => Navigator.pop(context, 2),
              ),
            ],
          ),
        );
      },
    );

    if (pickedOption == null) return;

    XFile? pickedImage;

    if (pickedOption == 1) {
      pickedImage = await picker.pickImage(source: ImageSource.camera);
    } else if (pickedOption == 2) {
      final pickedImages = await picker.pickMultiImage();
      if (pickedImages.isNotEmpty) {
        pickedImage = pickedImages.first;
      }
    }

    if (pickedImage != null) {
      profileImage2 = [File(pickedImage.path)];
      emit(ChooseImageSuccess());
    }
  }

  void removeProfileImage2() {
    profileImage2.clear();
    emit(RemoveImageSuccess());
  }

  String aboutUsTitle = '';
  Future aboutUs() async {
    emit(AboutUsLoading());
    http.Response response = await http.post(
      Uri.parse("${baseUrl}api/page"),
      body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
        "title": "about",
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    aboutUsTitle = data["data"]['desc'];
    debugPrint(data.toString());

    if (data["key"] == 1) {
      emit(AboutUsSuccess());
    } else {
      emit(AboutUsFailure(error: data["msg"]));
    }
  }

  String privacyPolicyTitle = '';
  Future privacyPolicy() async {
    emit(PrivacyPolicyLoading());
    http.Response response = await http.post(
      Uri.parse("${baseUrl}api/page"),
      body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
        "title": "condition",
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    privacyPolicyTitle = data["data"]['desc'];
    debugPrint(data.toString());

    if (data["key"] == 1) {
      emit(PrivacyPolicySuccess());
    } else {
      emit(PrivacyPolicyFailure(error: data["msg"]));
    }
  }

  Future contactUs({
    required String name,
    required String phone,
    required String message,
  }) async {
    emit(ContactUsLoading());

    String? token = CacheHelper.getUserToken();

    http.Response response = await http.post(
      Uri.parse("${baseUrl}complaint/callUs"),
      headers: {"Content-Type": "application/json", "Authorization": token},
      body: jsonEncode({"userName": name, "phone": phone, "message": message}),
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(ContactUsSuccess(message: data["message"]));
    } else {
      emit(ContactUsFailure(error: data["message"]));
    }
  }

  int buttonIndex = 0;
  void chanebuttonIndex({required int index}) {
    bottomNavIndex = index;
    emit(ChangeIndex());
  }

  List<File> addFiles = [];
  Future pickAddFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null && result.files.isNotEmpty) {
      final newFiles =
          result.files
              .where((file) => file.path != null)
              .map((file) => File(file.path!))
              .toList();

      for (var file in newFiles) {
        if (!addFiles.contains(file)) {
          addFiles.add(file);
          debugPrint('Selected file path: ${file.path}');
        }
      }
      emit(FileSelected());
    } else {
      emit(FileNotSelected());
    }
  }

  void removeAddFile(File file) {
    addFiles.remove(file);
    emit(FileNotSelected());
  }

  Future<List<LocationResult>> searchPlaces(String query) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1',
    );
    final response = await http.get(
      url,
      headers: {'User-Agent': 'YourAppName'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((item) {
        return LocationResult(
          name: item['display_name'],
          latLng: LatLng(double.parse(item['lat']), double.parse(item['lon'])),
        );
      }).toList();
    } else {
      throw Exception("Failed to fetch places");
    }
  }

  // Services

  Map showProfileMap = {};
  Future showProfile() async {
    emit(GetProfileLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    debugPrint("Token from CacheHelper: $token");
    http.Response response = await http.get(
      Uri.parse("${baseUrl}user/profile"),
      headers: {"Content-Type": "application/json", "Authorization": token},
    );

    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data.toString());
    debugPrint("Profile API response: $data");

    if (response.statusCode == 200 || response.statusCode == 201) {
      CacheHelper.setUserId(data["data"]['user']['_id']);
      showProfileMap = data["data"]['user'];
      emit(GetProfileSuccess());
    } else {
      emit(GetProfileFailure(error: data["message"] ?? "حدث خطاء"));
    }
  }

  Future updateProfile({
    required String userName,
    required String phone,
  }) async {
    emit(UpdateProfileLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    debugPrint("Token from CacheHelper: $token");
    http.Response response = await http.patch(
      Uri.parse("${baseUrl}user/profile/updateProfile"),
      headers: {"Content-Type": "application/json", "Authorization": token},
      body: jsonEncode({"userName": userName, "phone": phone}),
    );
    final data = jsonDecode(response.body);
    debugPrint(data.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(UpdateProfileSuccess(message: data["message"]));
      showProfile();
    } else {
      emit(UpdateProfileFailure(error: data["message"] ?? "حدث خطاء"));
    }
  }

  String? profileImageUrl;

  Future<void> uploadProfileImage(
    File imageFile, {
    required String type,
  }) async {
    emit(UploadProfileImageLoading());

    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    var request = http.MultipartRequest(
      'PATCH',
      Uri.parse(
        "${baseUrl}user/profile/uploadUserImage",
      ).replace(queryParameters: {'type': type}),
    );
    request.headers['Authorization'] = token;

    request.files.add(
      await http.MultipartFile.fromPath(
        'attachment',
        imageFile.path,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    debugPrint('Sending file: ${imageFile.path}');
    debugPrint('Token: Bearer $token');
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      emit(
        UploadProfileImageSuccess(message: data["message"] ?? "تم الرفع بنجاح"),
      );
      showProfile();
    } else {
      emit(UploadProfileImageFailure(error: "حدث خطأ أثناء رفع الصورة"));
    }
  }

  Future updateProfileEmail({required String email}) async {
    emit(UpdateProfileLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    debugPrint("Token from CacheHelper: $token");
    http.Response response = await http.patch(
      Uri.parse("${baseUrl}user/profile/updateEmail"),
      headers: {"Content-Type": "application/json", "Authorization": token},
      body: jsonEncode({"email": email}),
    );
    final data = jsonDecode(response.body);
    debugPrint(data.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(UpdateProfileSuccess(message: data["message"]));
      showProfile();
    } else {
      emit(UpdateProfileFailure(error: data["message"] ?? "حدث خطاء"));
    }
  }

  Future otpEmail({required String code}) async {
    emit(OTPEmailLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    debugPrint("Token from CacheHelper: $token");
    http.Response response = await http.patch(
      Uri.parse("${baseUrl}user/profile/resetEmail"),
      headers: {"Content-Type": "application/json", "Authorization": token},
      body: jsonEncode({"code": code}),
    );
    final data = jsonDecode(response.body);
    debugPrint(data.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(OTPEmailSuccess(message: data["message"]));
      showProfile();
    } else {
      emit(OTPEmailFailure(error: data["message"] ?? "حدث خطاء"));
    }
  }

  Future updatePassword({
    required String oldPassword,
    required String password,
    required String confirmPassword,
  }) async {
    emit(UpdatePasswordLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    debugPrint("Token from CacheHelper: $token");
    http.Response response = await http.patch(
      Uri.parse("${baseUrl}user/profile/updatePassword"),
      headers: {"Content-Type": "application/json", "Authorization": token},
      body: jsonEncode({
        "password": oldPassword,
        "newPassword": password,
        "confirmationPassword": confirmPassword,
      }),
    );
    final data = jsonDecode(response.body);
    debugPrint(data.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(UpdatePasswordSuccess(message: data["message"]));
      showProfile();
    } else {
      emit(UpdatePasswordFailure(error: data["message"] ?? "حدث خطاء"));
    }
  }

  Future deleteProfile({
    required String phone,
    required String password,
  }) async {
    emit(DeleteProfileLoading());

    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");

    try {
      http.Response response = await http.delete(
        Uri.parse("${baseUrl}user/profile/deleteAccount"),
        headers: {"Content-Type": "application/json", "Authorization": token},
        body: jsonEncode({"phone": phone, "password": password}),
      );

      final data = jsonDecode(response.body);
      debugPrint(data.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        CacheHelper.setUserToken("");
        emit(DeleteProfileSuccess(message: data["message"]));
      } else {
        emit(
          DeleteProfileFailure(
            error: data["message"] ?? "حدث خطأ أثناء حذف الحساب",
          ),
        );
      }
    } catch (e) {
      emit(DeleteProfileFailure(error: "فشل الاتصال بالخادم: $e"));
    }
  }

  List<File> carImage = [];
  Future<void> getCarImage(BuildContext context) async {
    final picker = ImagePicker();
    final int? pickedOption = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.select_image_source.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () => Navigator.pop(context, 1),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () => Navigator.pop(context, 2),
              ),
            ],
          ),
        );
      },
    );

    if (pickedOption == null) return;

    XFile? pickedImage;

    if (pickedOption == 1) {
      pickedImage = await picker.pickImage(source: ImageSource.camera);
    } else if (pickedOption == 2) {
      final pickedImages = await picker.pickMultiImage();
      if (pickedImages.isNotEmpty) {
        pickedImage = pickedImages.first;
      }
    }

    if (pickedImage != null) {
      carImage = [File(pickedImage.path)];
      emit(ChooseImageSuccess());
    }
  }

  void removeCarImage() {
    carImage.clear();
    emit(RemoveImageSuccess());
  }

  Future addCars({
    required String type,
    required String manufactureYear,
    required String color,
    required String chassisNumber,
    required String model,
    required String carPlateNumber,
  }) async {
    emit(AddCarsLoading());

    try {
      if (carImage.isEmpty) {
        emit(AddCarsFailure(error: "يرجى اختيار صورة للسيارة"));
        return;
      }

      final token = CacheHelper.getUserToken();
      if (token.isEmpty) {
        emit(AddCarsFailure(error: "لم يتم العثور على رمز التفويض (التوكن)"));
        return;
      }

      debugPrint("Token: $token");

      final request = http.MultipartRequest(
        'POST',
        Uri.parse("${baseUrl}car/addCar"),
      );

      request.headers.addAll({
        "Authorization": token,
        "Content-Type": "multipart/form-data", // ← تحديد نوع المحتوى يدويًا
      });

      request.fields['type'] = type;
      request.fields['manufactureYear'] = manufactureYear;
      request.fields['color'] = color;
      request.fields['chassisNumber'] = chassisNumber;
      request.fields['model'] = model;
      request.fields['carPlateNumber'] = carPlateNumber;

      debugPrint("Request Fields: ${request.fields}");

      final stream = http.ByteStream(carImage.first.openRead());
      final length = await carImage.first.length();
      debugPrint("Image Size: $length");

      final multipartFile = http.MultipartFile(
        'attachment', // ← الاسم مؤكد من API
        stream,
        length,
        filename: carImage.first.path.split('/').last,
        contentType: MediaType('image', 'jpeg'), // ← تأكيد نوع الصورة
      );

      request.files.add(multipartFile);
      debugPrint(
        "Request Files: ${request.files.map((f) => f.filename).toList()}",
      );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Headers: ${response.headers}");
      debugPrint("Response Body: $responseBody");

      Map<String, dynamic> data = {};
      try {
        data = jsonDecode(responseBody);
      } catch (e) {
        debugPrint("خطأ في فك الـ JSON: $e");
      }

      final message = (data["message"] as String?) ?? "حدث خطأ غير معروف";

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddCarsSuccess(message: message));
        getCars();
      } else if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        if (data['validationResult'] != null) {
          final List validationErrors = data['validationResult'];
          final List<String> errorMessages = [];

          for (var error in validationErrors) {
            final path = error['path']?.join('.') ?? '';
            final message = error['message'] ?? 'خطأ غير معروف في $path';
            errorMessages.add('$path: $message');
          }

          final fullErrorMessage = errorMessages.join('\n');
          emit(AddCarsFailure(error: fullErrorMessage));
        } else {
          emit(AddCarsFailure(error: message));
        }
      }
    } catch (e) {
      debugPrint("Error: $e");
      emit(AddCarsFailure(error: e.toString()));
    }
  }

  List carsList = [];
  Future getCars() async {
    emit(GetCarsLoading());

    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    debugPrint("Token from CacheHelper: $token");
    http.Response response = await http.get(
      Uri.parse("${baseUrl}car/getUserCar"),
      headers: {"Authorization": token},
    );

    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Headers: ${response.headers}");
    debugPrint("Response Body: ${response.body}");

    Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      carsList = data["data"]['cars'];
      emit(GetCarsSuccess());
    } else {
      emit(GetCarsFailure(error: data["message"]));
    }
  }

  Future deleteCar({required String carId}) async {
    emit(DeleteCarLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.delete(
      Uri.parse("${baseUrl}car/deleteUserCar/$carId"),
      headers: {"Authorization": token},
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      getCars();
      emit(DeleteCarSuccess(message: data["message"]));
    } else {
      emit(DeleteCarFailure(error: data["message"]));
    }
  }

  Map editCarMap = {};
  Future editCar({
    required String type,
    required String manufactureYear,
    required String color,
    required String chassisNumber,
    required String model,
    required String carPlateNumber,
    required String carId,
  }) async {
    emit(EditCarLoading());
    try {
      if (carImage.isEmpty) {
        emit(EditCarFailure(error: "يرجى اختيار صورة للسيارة"));
        return;
      }

      final token = CacheHelper.getUserToken();
      if (token.isEmpty) {
        emit(EditCarFailure(error: "لم يتم العثور على رمز التفويض (التوكن)"));
        return;
      }

      debugPrint("Token: $token");

      final request = http.MultipartRequest(
        'PATCH',
        Uri.parse("${baseUrl}car/updateUserCar/$carId"),
      );

      request.headers.addAll({
        "Authorization": token,
        "Content-Type": "multipart/form-data",
      });

      request.fields['type'] = type;
      request.fields['manufactureYear'] = manufactureYear;
      request.fields['color'] = color;
      request.fields['chassisNumber'] = chassisNumber;
      request.fields['model'] = model;
      request.fields['carPlateNumber'] = carPlateNumber;

      debugPrint("Request Fields: ${request.fields}");

      final stream = http.ByteStream(carImage.first.openRead());
      final length = await carImage.first.length();
      debugPrint("Image Size: $length");

      final multipartFile = http.MultipartFile(
        'attachment',
        stream,
        length,
        filename: carImage.first.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      );

      request.files.add(multipartFile);
      debugPrint(
        "Request Files: ${request.files.map((f) => f.filename).toList()}",
      );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Headers: ${response.headers}");
      debugPrint("Response Body: $responseBody");

      Map<String, dynamic> data = {};
      try {
        data = jsonDecode(responseBody);
      } catch (e) {
        debugPrint("خطأ في فك الـ JSON: $e");
      }

      final message = (data["message"] as String?) ?? "حدث خطأ غير معروف";

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(EditCarSuccess(message: message));
        getCars();
      } else if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        if (data['validationResult'] != null) {
          final List validationErrors = data['validationResult'];
          final List<String> errorMessages = [];

          for (var error in validationErrors) {
            final path = error['path']?.join('.') ?? '';
            final message = error['message'] ?? 'خطأ غير معروف في $path';
            errorMessages.add('$path: $message');
          }

          final fullErrorMessage = errorMessages.join('\n');
          emit(EditCarFailure(error: fullErrorMessage));
        } else {
          emit(EditCarFailure(error: message));
        }
      }
    } catch (e) {
      debugPrint("Error: $e");
      emit(EditCarFailure(error: e.toString()));
    }
  }

  List banners = [];
  List bannerIds = [];
  Future getBanner() async {
    emit(GetBannerLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.get(
      Uri.parse("${baseUrl}user/getBanner"),
      headers: {"Authorization": token},
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final updatedBanners = data['data']['updatedBanners'] as List;
      banners = [];
      bannerIds = [];

      for (var banner in updatedBanners) {
        final images = banner['image'] as List;
        banners.addAll(images);
      }

      for (var banner in updatedBanners) {
        final id = banner['_id'] as String;
        bannerIds.add(id);
      }

      emit(GetBannerSuccess());
    } else {
      emit(GetBannerFailure(error: data["message"]));
    }
  }

  Future deleteBanner({required String bannerId, required String image}) async {
    emit(DeleteBannerLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.delete(
      Uri.parse("${baseUrl}admin/deleteBanner/$bannerId/$image"),
      headers: {"Authorization": token},
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(DeleteBannerSuccess(message: data["message"]));
    } else {
      emit(DeleteBannerFailure(error: data["message"]));
    }
  }

  List carProblemsList = [];
  Future carProblems() async {
    emit(GetCarProblemsLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.get(
      Uri.parse("${baseUrl}problem/getCarProblems"),
      headers: {"Authorization": token},
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      carProblemsList = data['data']['allCarProblems'];
      emit(GetCarProblemsSuccess());
    } else {
      emit(GetCarProblemsFailure(error: data["message"]));
    }
  }

  List servicesList = [];
  Future services() async {
    emit(GetServicesLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.get(
      Uri.parse("${baseUrl}service//getAllServices"),
      headers: {"Authorization": token},
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      servicesList = data['data']['allServices'];
      emit(GetServicesSuccess());
    } else {
      emit(GetServicesFailure(error: data["message"]));
    }
  }

  String requestId = "";
  Future addRequest({
    required String serviceId,
    required String carId,
    required List<String> problemId,
    required String otherProblemText,
    required double pickLat,
    required double pickLng,
    required double dropLat,
    required double dropLng,
  }) async {
    emit(AddRequestLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.post(
      Uri.parse("${baseUrl}request/addRequest/$serviceId"),
      headers: {"Authorization": token, "Content-Type": "application/json"},
      body: jsonEncode({
        "carId": carId,
        "problems": problemId,
       if (otherProblemText.isNotEmpty)  "otherProblemText": otherProblemText,
        "pickupLocation": {
          "coordinates": [pickLng, pickLat],
        },
        "dropoffLocation": {
          "coordinates": [dropLng, dropLat],
        },
      }),
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(AddRequestSuccess(message: data["message"]));
      requestId = data["data"]["request"]["_id"];
    } else {
      emit(AddRequestFailure(error: data["message"]));
    }
  }

  Map requestMap = {};
  Future getRequests({required String requestId}) async {
    emit(GetRequestsLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.get(
      Uri.parse("${baseUrl}request/details/$requestId"),
      headers: {"Authorization": token},
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");

    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      requestMap = data['data']['request'];
      emit(GetRequestsSuccess());
    } else {
      emit(GetRequestsFailure(error: data["message"]));
    }
  }

  Future confirmRequest({required String requestId}) async {
    emit(ConfirmRequestLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");

    http.Response response = await http.patch(
      Uri.parse("${baseUrl}request/confirm/$requestId"),
      headers: {"Authorization": token, "Content-Type": "application/json"},
      body: jsonEncode({
        "paymentMethod": paymentIndex == 0 ? "cash" : "online",
      }),
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    debugPrint("requestId Body: $requestId");

    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(ConfirmRequestSuccess(message: data["message"]));
    } else {
      emit(ConfirmRequestFailure(error: data["message"]));
    }
  }

  List allNearDriversList = [];
  Future allNearDrivers({required String requestId}) async {
    emit(GetAllNearDriversLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.get(
      Uri.parse("${baseUrl}request/allNearDrivers/$requestId"),
      headers: {"Authorization": token},
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      allNearDriversList = data['data']['nearbyDrivers'];
      emit(GetAllNearDriversSuccess());
    } else {
      emit(GetAllNearDriversFailure(error: data["message"]));
    }
  }

  List completedRequestsList = [];
  Future completedRequest() async {
    emit(GetCompletedRequestsLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.get(
      Uri.parse("${baseUrl}request/completed?page=1&size=1"),
      headers: {"Authorization": token},
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      completedRequestsList = data['data']['requests'];
      emit(GetCompletedRequestsSuccess());
    } else {
      emit(GetCompletedRequestsFailure(error: data["message"]));
    }
  }

  List inRoadRequestsList = [];
  Future inRoadRequest() async {
    emit(InRoadRequestLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.get(
      Uri.parse("${baseUrl}request/inRoad?page=1&size=1"),
      headers: {"Authorization": token},
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      inRoadRequestsList = data['data']['requests'];
      emit(InRoadRequestSuccess(message: data["message"]));
    } else {
      emit(InRoadRequestFailure(error: data["message"]));
    }
  }

  List pendingRequestsList = [];
  Future pendingRequest() async {
    emit(PendingRequestLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.get(
      Uri.parse("${baseUrl}request/pending?page=1&size=10"),
      headers: {"Authorization": token},
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      pendingRequestsList = data['data']['requests']['data'];
      emit(PendingRequestSuccess());
    } else {
      emit(PendingRequestFailure(error: data["message"]));
    }
  }

  // ADMIN SERVICES

  List newBanners = [];
  List oldBanners = [];
  Future addBanners(List<File> images) async {
    emit(AddBannerLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}admin/addBanner"),
    );

    request.headers.addAll({"Authorization": token});

    for (var imageFile in images) {
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();

      var multipartFile = http.MultipartFile(
        'attachment',
        stream,
        length,
        filename: imageFile.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      );

      request.files.add(multipartFile);
    }

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: $responseBody");

      Map<String, dynamic> data = jsonDecode(responseBody);

      if (response.statusCode == 200 || response.statusCode == 201) {
        oldBanners = data["data"]['newBanner']['image'];
        newBanners.addAll(
          List<String>.from(data["data"]['newBanner']['image']),
        );
        newBanners = newBanners.toSet().toList();
        debugPrint("newBanners = $newBanners");
        emit(AddBannerSuccess(message: data["message"]));
      } else {
        emit(AddBannerFailure(error: data["message"]));
      }
    } catch (e) {
      debugPrint("Error uploading banners: $e");
      emit(AddBannerFailure(error: e.toString()));
    }
  }

  List driversList = [];
  Future getDrivers() async {
    emit(GetDriversLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.get(
      Uri.parse("${baseUrl}admin/getAllDrivers"),
      headers: {"Content-Type": "application/json", "Authorization": token},
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      driversList = data["data"]['drivers'];
      emit(GetDriversSuccess());
    } else {
      emit(GetDriversFailure(error: data["message"]));
    }
  }

  List complaintsList = [];
  Future getComplaints() async {
    emit(GetComplaintsLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.get(
      Uri.parse("${baseUrl}admin/getAllCompliants"),
      headers: {"Content-Type": "application/json", "Authorization": token},
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      complaintsList = data["data"]['complaints'];
      emit(GetComplaintsSuccess());
      getDrivers();
    } else {
      emit(GetComplaintsFailure(error: data["message"]));
    }
  }

  Future driverBan({required String driverId, required String type}) async {
    emit(DriverBanLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.patch(
      Uri.parse(
        "${baseUrl}admin/banDriver/$driverId",
      ).replace(queryParameters: {"type": type}),
      headers: {"Content-Type": "application/json", "Authorization": token},
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      getDrivers();
      emit(DriverBanSuccess(message: data["message"]));
    } else {
      emit(DriverBanFailure(error: data["message"]));
    }
  }

  final Dio _dio = Dio(); // استخدم Dio لجلب البيانات من الـ API
  late IO.Socket socket; // اجعل السوكيت جزءًا من الـ Cubit لإدارة مركزية
  List<ChatRoomModel> chatRooms = []; // قائمة الرومات
  List<ChatMessageModel> currentChatMessages = []; // رسائل المحادثة الحالية

  // بيانات المستخدم الحالي (افترض أنها موجودة في showProfileMap)
  Map<String, dynamic> currentUser = {'_id': CacheHelper.getUserId()};

  void initSocket() {
    socket = IO.io(
      'https://towtruck.cloud', // URL السيرفر
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect() // لا تتصل تلقائيًا، سنتحكم في الاتصال يدوياً
          .setExtraHeaders({
            'Authorization': CacheHelper.getUserToken(),
          }) // التوكن
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      debugPrint('✅ Socket Connected to https://towtruck.cloud');
      // يمكنك هنا إرسال حدث للـ server لإعلامه بأن المستخدم متصل
      // مثلاً: socket.emit('userOnline', {'userId': showProfileMap['_id']});
    });

    socket.on('successMessage', (data) {
      debugPrint('✅ successMessage: $data');
      if (data != null && data['message'] != null) {
        final newMessage = ChatMessageModel.fromJson(data['message']);
        currentChatMessages.add(newMessage);
        emit(SendMessageSuccess());
      }
    });

    socket.on('receiveMessage', (data) {
      debugPrint('📩 receiveMessage: $data');
      if (data != null && data['message'] != null) {
        final newMessage = ChatMessageModel.fromJson(data['message']);
        currentChatMessages.add(newMessage);
        emit(GetChatMessagesSuccess(List.from(currentChatMessages)));
      }
    });

    socket.on('socket_Error', (error) {
      debugPrint('❌ Socket Error: $error');
      emit(AppError('Socket Error: $error'));
    });

    socket.onDisconnect((_) {
      debugPrint('❌ Socket Disconnected');
    });
  }

  Future<void> getChatRooms() async {
    emit(GetChatRoomsLoading());
    try {
      final response = await _dio.get(
        'https://towtruck.cloud/chat/getAllChats',
        options: Options(
          headers: {'Authorization': CacheHelper.getUserToken()},
        ),
      );

      if (response.statusCode == 200) {
        chatRooms =
            (response.data['data'] as List)
                .map((e) => ChatRoomModel.fromJson(e))
                .toList();
        emit(GetChatRoomsSuccess(chatRooms));
      } else {
        emit(
          GetChatRoomsError(
            response.data['message'] ?? 'Failed to load chat rooms',
          ),
        );
      }
    } catch (e) {
      debugPrint('Error getting chat rooms: $e');
      emit(GetChatRoomsError(e.toString()));
    }
  }

  Future<void> getChatMessages(String destId) async {
    emit(GetChatMessagesLoading());
    try {
      final response = await _dio.get(
        'https://towtruck.cloud/api/chat/messages/$destId',
        options: Options(
          headers: {'Authorization': CacheHelper.getUserToken()},
        ),
      );

      if (response.statusCode == 200) {
        currentChatMessages =
            (response.data['data'] as List)
                .map((e) => ChatMessageModel.fromJson(e))
                .toList();
        emit(GetChatMessagesSuccess(currentChatMessages));
      } else {
        emit(
          GetChatMessagesError(
            response.data['message'] ?? 'Failed to load messages',
          ),
        );
      }
    } catch (e) {
      debugPrint('Error getting chat messages: $e');
      emit(GetChatMessagesError(e.toString()));
    }
  }

  void sendMessage(String message, String destId) {
    if (message.trim().isEmpty) return;

    // Emit الرسالة للسيرفر
    socket.emit('sendMessage', {'message': message, 'destId': destId});

    // ضفها محليًا مؤقتًا بانتظار successMessage
    currentChatMessages.add(
      ChatMessageModel(
        fromId: showProfileMap['_id'],
        message: message,
        timestamp: DateTime.now().toIso8601String(),
      ),
    );

    emit(SendMessagePending()); // حالة pending بدل success مباشرة
  }

  Future<void> createNewChatRoom({
    required String destId,
    required String otherUserName,
    required BuildContext context,
  }) async {
    emit(CreateChatRoomLoading());
    try {
      final response = await _dio.post(
        'https://towtruck.cloud/api/chat/createRoom',
        data: {'destId': destId},
        options: Options(
          headers: {'Authorization': CacheHelper.getUserToken()},
        ),
      );

      if (response.statusCode == 200) {
        emit(CreateChatRoomSuccess());
        AppRouter.navigateTo(
          context,
          ChatDetails(destId: destId, otherUserName: otherUserName),
        );
      } else {
        emit(CreateChatRoomError('فشل إنشاء غرفة الدردشة'));
      }
    } catch (e) {
      debugPrint('❌ Error creating chat room: $e');
      emit(CreateChatRoomError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    socket.disconnect();
    socket.dispose();
    return super.close();
  }

  Future updatePrice({
    required String serviceId,
    required String pricePerMeter,
  }) async {
    emit(UpdatePriceLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.patch(
      Uri.parse("${baseUrl}admin/updatePricePerMeter/$serviceId"),
      headers: {"Authorization": token},
      body: jsonEncode({"pricePerMeter": pricePerMeter}),
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(UpdatePriceSuccess(message: data["message"]));
    } else {
      emit(UpdatePriceFailure(error: data["message"]));
    }
  }

  Map subMap = {};
  Future getSubscriptions() async {
    emit(GetSubscriptionsLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.get(
      Uri.parse("${baseUrl}driver/subscription/Price?type=monthly"),
      headers: {"Authorization": token},
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      subMap = data["data"]['subscription'];
      emit(GetSubscriptionsSuccess());
    } else {
      emit(GetSubscriptionsFailure(error: data["message"]));
    }
  }

  Future updateSubscription({
    required String type,
    required serviceId,
    required String price,
  }) async {
    emit(UpdateSubscriptionLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.patch(
      Uri.parse("${baseUrl}admin/subscription/update"),
      headers: {"Authorization": token},
      body: jsonEncode({
        "planType": type,
        "serviceId": serviceId,
        "price": price,
      }),
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(UpdateSubscriptionSuccess(message: data["message"]));
    } else {
      emit(UpdateSubscriptionFailure(error: data["message"]));
    }
  }

  List notificationsList = [];
  Future getNotifications({int page = 0, int size = 1}) async {
    emit(GetNotificationsLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.get(
      Uri.parse("${baseUrl}user/notification?page=$page&size=$size"),
      headers: {"Authorization": token},
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      notificationsList = data["data"]['notifications'];
      emit(GetNotificationsSuccess());
    } else {
      emit(GetNotificationsFailure(error: data["message"]));
    }
  }
}

class LocationResult {
  final String name;
  final LatLng latLng;
  LocationResult({required this.name, required this.latLng});
}

// app_state.dart
class AppError extends AppState {
  final String error;
  AppError(this.error);
}
