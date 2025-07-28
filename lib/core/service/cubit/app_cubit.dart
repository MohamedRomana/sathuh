// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:card_swiper/card_swiper.dart';
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
import '../../../generated/locale_keys.g.dart';
import '../../../screens/driver_screens/home_layout/orders/driver_orders.dart';
import '../../../screens/driver_screens/home_layout/subscribes/subscribes.dart';
import '../../../screens/user_screens/home_layout/chats/chats.dart';
import '../../../screens/user_screens/home_layout/home/home.dart';
import '../../../screens/user_screens/home_layout/orders/orders.dart';
import '../../cache/cache_helper.dart';
import '../../constants/contsants.dart';
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

  int paymentIndex2 = -1;
  void changePaymentIndex2({required int index}) {
    paymentIndex2 = index;
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
        if (otherProblemText.isNotEmpty) "otherProblemText": otherProblemText,
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

  int completedCurrentPage = 1;
  bool completedHasMore = true;
  bool completedIsLoading = false;

  List completedRequestsList = [];

  Future completedRequest({bool isRefresh = false}) async {
    if (completedIsLoading || !completedHasMore) return;

    completedIsLoading = true;
    emit(GetCompletedRequestsLoading());

    if (isRefresh) {
      completedCurrentPage = 1;
      completedRequestsList.clear();
      completedHasMore = true;
    }

    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");

    final response = await http.get(
      Uri.parse(
        "${baseUrl}request/completed?page=$completedCurrentPage&size=10",
      ),
      headers: {"Authorization": token},
    );

    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List newRequests = data['data']['requests']['data'];

      if (newRequests.length < 10) {
        completedHasMore = false;
      }

      completedRequestsList.addAll(newRequests);
      completedCurrentPage++;
      emit(GetCompletedRequestsSuccess());
    } else {
      emit(GetCompletedRequestsFailure(error: data["message"]));
    }

    completedIsLoading = false;
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

  int currentPage = 1;
  int currentSize = 10;
  bool isLoadingMore = false;
  bool hasMoreData = true;

  List pendingRequestsList = [];

  Future<void> pendingRequest({bool loadMore = false}) async {
    if (isLoadingMore || !hasMoreData) return;

    if (loadMore) {
      currentSize += 10; // أو currentPage++ لو الـ API بيشتغل بالصفحات
      isLoadingMore = true;
    } else {
      currentPage = 1;
      currentSize = 10;
      hasMoreData = true;
      pendingRequestsList.clear();
    }

    emit(PendingRequestLoading());

    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");

    final response = await http.get(
      Uri.parse("${baseUrl}request/pending?page=1&size=$currentSize"),
      headers: {"Authorization": token},
    );

    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List newData = data['data']['requests']['data'];

      if (newData.length < 10) hasMoreData = false;

      pendingRequestsList =
          newData; // أو ممكن تستخدم addAll لو كنت بتزيد الصفحة
      emit(PendingRequestSuccess());
    } else {
      emit(PendingRequestFailure(error: data["message"] ?? "خطأ"));
    }

    isLoadingMore = false;
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

  Future addPrice({
    required String serviceId,
    required String pricePerMeter,
  }) async {
    emit(AddPriceLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.post(
      Uri.parse("${baseUrl}admin//pricePerMeter/$serviceId"),
      headers: {"Authorization": token, "Content-Type": "application/json"},
      body: jsonEncode({"pricePerMeter": pricePerMeter}),
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(AddPriceSuccess(message: data["message"]));
    } else {
      emit(AddPriceFailure(error: data["message"]));
    }
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
      headers: {"Authorization": token, "Content-Type": "application/json"},
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

  List<File> nationalImage = [];
  Future<void> getNationalImage(BuildContext context) async {
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
      nationalImage = [File(pickedImage.path)];
      emit(ChooseImageSuccess());
    }
  }

  void removeNationalImage() {
    nationalImage.clear();
    emit(RemoveImageSuccess());
  }

  Future<void> uploadDriverImage(File imageFile, {required String type}) async {
    emit(UploadDriverImageLoading());

    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");

    final uri = Uri.parse(
      "${baseUrl}driver/uploadImages",
    ).replace(queryParameters: {'type': type});

    var request = http.MultipartRequest('PATCH', uri);
    request.headers['Authorization'] = token;

    request.files.add(
      await http.MultipartFile.fromPath(
        'attachment',
        imageFile.path,
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    debugPrint('Sending file: ${imageFile.path}');
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      emit(
        UploadDriverImageSuccess(message: data["message"] ?? "تم الرفع بنجاح"),
      );
      // ممكن تضيف reload أو تحديث للبيانات
    } else {
      emit(UploadDriverImageFailure(error: "فشل في رفع الصورة"));
    }
  }

  Future chooseService({required String serviceId}) async {
    emit(ChooseServiceLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.post(
      Uri.parse("${baseUrl}driver/chooseService/$serviceId"),
      headers: {"Authorization": token, "Content-Type": "application/json"},
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(ChooseServiceSuccess(message: data["message"]));
    } else {
      emit(ChooseServiceFailure(error: data["message"]));
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

  Map subYearMap = {};
  Future getSubYearscriptions() async {
    emit(GetSubscriptionsLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.get(
      Uri.parse("${baseUrl}driver/subscription/Price?type=yearly"),
      headers: {"Authorization": token},
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      subYearMap = data["data"]['subscription'];
      emit(GetSubscriptionsSuccess());
    } else {
      emit(GetSubscriptionsFailure(error: data["message"]));
    }
  }

  Future addPercentage({required String percentage}) async {
    emit(AddPercentageLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.post(
      Uri.parse("${baseUrl}admin/percentage"),
      headers: {"Authorization": token, "Content-Type": "application/json"},
      body: jsonEncode({"adminPercentage": percentage}),
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(AddPercentageSuccess(message: data["message"]));
    } else {
      emit(AddPercentageFailure(error: data["message"]));
    }
  }

  Future updatePercentage({required String percentage}) async {
    emit(UpdatePercentageLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.patch(
      Uri.parse("${baseUrl}admin/percentage"),
      headers: {"Authorization": token, "Content-Type": "application/json"},
      body: jsonEncode({"adminPercentage": percentage}),
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(UpdatePercentageSuccess(message: data["message"]));
    } else {
      emit(UpdatePercentageFailure(error: data["message"]));
    }
  }

  Future addSubscription({
    required String type,
    required serviceId,
    required String price,
  }) async {
    emit(AddSubscriptionLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.post(
      Uri.parse("${baseUrl}admin/subscription"),
      headers: {"Authorization": token, "Content-Type": "application/json"},
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
      emit(AddSubscriptionSuccess(message: data["message"]));
    } else {
      emit(AddSubscriptionFailure(error: data["message"]));
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
      headers: {"Authorization": token, "Content-Type": "application/json"},
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

  Future requestStatusDriver({
    required String requestId,
    required String type,
  }) async {
    emit(RequestStatusDriverLoading());
    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");
    http.Response response = await http.patch(
      Uri.parse(
        "${baseUrl}driver/request/$requestId",
      ).replace(queryParameters: {"type": type}),
      headers: {"Authorization": token},
    );
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(RequestStatusDriverSuccess(message: data["message"]));
    } else {
      emit(RequestStatusDriverFailure(error: data["message"]));
    }
  }

  List chatsList = [];

  Future getChats() async {
    emit(GetChatsLoading());

    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");

    http.Response response = await http.get(
      Uri.parse("${baseUrl}chat/getAllChats"),
      headers: {"Authorization": token},
    );

    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");

    Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      chatsList = data["data"]['currentChats'];
      emit(GetChatsSuccess());
    } else {
      emit(GetChatsFailure(error: data["message"]));
    }
  }

  List chatsCurrentList = [];

  Future getCurrentChats() async {
    emit(GetChatsLoading());

    String? token = CacheHelper.getUserToken();
    debugPrint("Token: $token");

    http.Response response = await http.get(
      Uri.parse("${baseUrl}chat/getAllChats"),
      headers: {"Authorization": token},
    );

    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");

    Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      chatsCurrentList = data["data"]['previousChats']; // ✅ مش previousChats
      emit(GetChatsSuccess());
    } else {
      emit(GetChatsFailure(error: data["message"]));
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
