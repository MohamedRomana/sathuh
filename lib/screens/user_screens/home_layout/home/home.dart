import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:sathuh/core/cache/cache_helper.dart';
import 'package:sathuh/core/constants/contsants.dart';
import '../../../../gen/assets.gen.dart';
import 'widgets/custom_services.dart';
import 'widgets/custom_swiper.dart';
import 'widgets/custom_top_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? currentAddress = "جارٍ تحديد الموقع...";
  LatLng? currentLatLng;

  @override
  void initState() {
    super.initState();
    _getCurrentLocationAndFetchAddress();
  }

  Future<void> _getCurrentLocationAndFetchAddress() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    currentLatLng = LatLng(position.latitude, position.longitude);

    final address = await fetchAddressFromApi(
      position.latitude,
      position.longitude,
    );

    setState(() {
      currentAddress = address;
    });
  }

  Future<String> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        return placemark.locality ?? "الموقع غير معروف";
      }
    } catch (e) {
      debugPrint("Failed to get address: $e");
    }
    return "الموقع غير معروف";
  }

  Future<String> fetchAddressFromApi(double latitude, double longitude) async {
    final url = Uri.parse('${baseUrl}user/addLocation');

    final token = CacheHelper.getUserToken();
    if (token.isEmpty) {
      return "رمز التفويض غير موجود";
    }

    final body = {
      "location": {
        "type": "Point",
        "coordinates": [longitude, latitude],
      },
    };

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json", "Authorization": token},
      body: jsonEncode(body),
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['address'] ??
          await getAddressFromCoordinates(latitude, longitude);
    } else {
      return await getAddressFromCoordinates(latitude, longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Assets.img.background.path,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white.withAlpha(210),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 61.h),
                CustomTopBar(
                  currentAddress: currentAddress ?? "جارٍ تحديد الموقع...",
                ),
                const CustomSwiper(),
                const CustomServices(),
                Container(height: 120.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
