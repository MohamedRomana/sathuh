import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../../gen/assets.gen.dart';
import 'widgets/custom_current_orders.dart';
import 'widgets/driver_swiper.dart';
import 'widgets/driver_top_home.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({super.key});

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  IO.Socket? socket;
  void initSocketConnection() {
    socket = IO.io("https://towtruck.cloud", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket!.connect();

    socket!.onConnect((_) {
      debugPrint("✅ Connected to socket");
    });

    socket!.onDisconnect((_) {
      debugPrint("Socket disconnected");
    });

    socket!.on("unauthorized", (message) {
      debugPrint("Unauthorized: $message");
    });
  }

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

    // 🔥 هنا بنبعت الموقع بعد ما يتحدد
    socket?.emit("updateDriverLocation", {
      "latitude": position.latitude,
      "longitude": position.longitude,
    });

    final address = await getAddressFromLatLng(currentLatLng!);
    setState(() {
      currentAddress = address;
    });

    // 🛰️ بنسمع لتغير الموقع كل ثانية مثلاً
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((position) {
      socket?.emit("updateDriverLocation", {
        "latitude": position.latitude,
        "longitude": position.longitude,
      });
      print(
        "📤 Updated Driver Location: ${position.latitude}, ${position.longitude}",
      );
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
        return placemark.locality ?? "الموقع غير معروف";
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
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white.withAlpha(210),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 61.h),
                DriverTopHome(currentAddress: currentAddress),
                const DriverSwiper(),
                const CustomCurrentOrders(),
                Container(height: 120.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
