import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../../../gen/assets.gen.dart';
import 'widgets/custom_driver_near_you.dart';
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
    _getCurrentLocationAndAddress();
  }

  Future<void> _getCurrentLocationAndAddress() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    currentLatLng = LatLng(position.latitude, position.longitude);

    final address = await getAddressFromLatLng(currentLatLng!);
    setState(() {
      currentAddress = address;
    });
  }

  Future<String> getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        return "${placemark.administrativeArea ?? ""} , ${placemark.locality ?? ""}";
      }
    } catch (e) {
      debugPrint("Failed to get address: $e");
    }

    return "الموقع غير معروف";
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
                SizedBox(height: 61.h),
                CustomTopBar(
                  currentAddress: currentAddress ?? "جارٍ تحديد الموقع...",
                ),
                const CustomSwiper(),
                const CustomServices(),
                const CustomDriverNearYou(),
                SizedBox(height: 120.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
