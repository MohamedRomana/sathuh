import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:sathuh/core/constants/colors.dart';
import 'package:sathuh/core/widgets/app_button.dart';
import 'package:sathuh/generated/locale_keys.g.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/flash_message.dart';
import 'widgets/pay_details.dart';

class OpenStreetMapView extends StatefulWidget {
  const OpenStreetMapView({super.key});

  @override
  State<OpenStreetMapView> createState() => _OpenStreetMapViewState();
}

class _OpenStreetMapViewState extends State<OpenStreetMapView> {
  final Distance distance = const Distance();
  double? totalDistance;
  LatLng? currentLocation;
  LatLng? destinationLocation;
  bool isSelectingDestination = false;

  final mapController = MapController();

  Future<void> _getMyLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });

    mapController.move(currentLocation!, 15);
  }

  void _enableDestinationSelection() {
    setState(() {
      isSelectingDestination = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(LocaleKeys.tap_to_select_destination.tr())),
    );
  }

  void _onMapTap(LatLng tappedPoint) {
    if (isSelectingDestination) {
      setState(() {
        destinationLocation = tappedPoint;
        isSelectingDestination = false;
        if (currentLocation != null) {
          totalDistance = distance.as(
            LengthUnit.Meter,
            currentLocation!,
            destinationLocation!,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: const LatLng(24.7136, 46.6753),
              initialZoom: 12,
              onTap: (_, latLng) => _onMapTap(latLng),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.app',
              ),
              PolylineLayer(
                polylines: [
                  if (currentLocation != null && destinationLocation != null)
                    Polyline(
                      points: [currentLocation!, destinationLocation!],
                      color: Colors.red,
                      strokeWidth: 4,
                    ),
                ],
              ),
              MarkerLayer(
                markers: [
                  if (currentLocation != null)
                    Marker(
                      point: currentLocation!,
                      width: 60,
                      height: 60,
                      child: const Icon(
                        Icons.my_location,
                        size: 35,
                        color: Colors.blue,
                      ),
                    ),
                  if (destinationLocation != null)
                    Marker(
                      point: destinationLocation!,
                      width: 60,
                      height: 60,
                      child: const Icon(
                        Icons.flag,
                        size: 35,
                        color: Colors.green,
                      ),
                    ),
                ],
              ),
            ],
          ),

          // زر تحديد موقعي
          PositionedDirectional(
            top: 60.h,
            start: 20.w,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(Size(150.w, 50.h)),
                iconColor: WidgetStateProperty.all(AppColors.primary),
                backgroundColor: WidgetStateProperty.all(Colors.white),
              ),
              onPressed: _getMyLocation,
              icon: const Icon(Icons.my_location),
              label: AppText(
                text: LocaleKeys.detect_location.tr(),
                size: 16.sp,
                color: AppColors.primary,
              ),
            ),
          ),

          PositionedDirectional(
            top: 120.h,
            start: 20.w,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(Size(150.w, 50.h)),
                iconColor: WidgetStateProperty.all(AppColors.primary),
                backgroundColor: WidgetStateProperty.all(Colors.white),
              ),
              onPressed: _enableDestinationSelection,
              icon: const Icon(Icons.location_on),
              label: AppText(
                text: LocaleKeys.confirm_destination.tr(),
                size: 16.sp,
                color: AppColors.primary,
              ),
            ),
          ),
          if (totalDistance != null)
            PositionedDirectional(
              top: 180.h,
              start: 20.w,
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.r,
                      spreadRadius: 1.r,
                    ),
                  ],
                ),
                child: Text(
                  "${LocaleKeys.distance.tr()} ${totalDistance!.toStringAsFixed(0)} متر"
                  " (${(totalDistance! / 1000).toStringAsFixed(2)} ${LocaleKeys.km.tr()})",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          PositionedDirectional(
            bottom: 20.h,
            start: 16.w,
            end: 16.w,
            child: AppButton(
              onPressed: () {
                if (totalDistance != null) {
                  showModalBottomSheet(
                    context: context,
                    builder:
                        (context) =>
                            PaymentDetails(totalDistance: totalDistance),
                  );
                } else {
                  showFlashMessage(
                    context: context,
                    message: LocaleKeys.set_destination.tr(),
                    type: FlashMessageType.error,
                  );
                }
              },
              child: AppText(
                text: LocaleKeys.confirm.tr(),
                size: 21.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

