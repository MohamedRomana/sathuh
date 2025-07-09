import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:sathuh/core/constants/colors.dart';
import 'package:sathuh/core/widgets/app_button.dart';
import 'package:sathuh/generated/locale_keys.g.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/flash_message.dart';
import 'widgets/pay_details.dart';

class OpenStreetMapView extends StatefulWidget {
  final List<String> problemIds;
  final String carsId;
  final String serviceId;
  final TextEditingController problemController;

  const OpenStreetMapView({
    super.key,
    required this.problemController,
    required this.carsId,
    required this.serviceId,
    required this.problemIds,
  });

  @override
  State<OpenStreetMapView> createState() => _OpenStreetMapViewState();
}

class _OpenStreetMapViewState extends State<OpenStreetMapView> {
  TextEditingController searchController = TextEditingController();
  List<LocationResult> searchResults = [];
  bool isSearching = false;
  final Distance distance = const Distance();
  double? totalDistance;
  LatLng? currentLocation;
  LatLng? destinationLocation;
  bool isSelectingDestination = false;

  final mapController = MapController();

  Future<List<LocationResult>> searchPlaces(String query) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1',
    );
    final response = await http.get(
      url,
      headers: {'User-Agent': 'flutter_map_app'},
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

  int estimateTravelTimeInMinutes(
    double distanceInMeters, {
    double speedKmPerHour = 40,
  }) {
    double distanceKm = distanceInMeters / 1000;
    double timeInHours = distanceKm / speedKmPerHour;
    return (timeInHours * 60).round();
  }

  String getEstimatedArrivalTime(int travelMinutes) {
    final now = DateTime.now();
    final arrivalTime = now.add(Duration(minutes: travelMinutes));
    return DateFormat.Hm().format(arrivalTime);
  }

  @override
  Widget build(BuildContext context) {
    final travelTime = estimateTravelTimeInMinutes(totalDistance ?? 0);
    final arrivalTime = getEstimatedArrivalTime(travelTime);

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
            top: 120.h,
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
            top: 180.h,
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
              top: 240.h,
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
            child: BlocConsumer<AppCubit, AppState>(
              listener: (context, state) {
                if (state is AddRequestSuccess) {
                  showFlashMessage(
                    message: state.message,
                    type: FlashMessageType.success,
                    context: context,
                  );
                  showModalBottomSheet(
                    context: context,
                    builder:
                        (context) => PaymentDetails(
                          totalDistance: totalDistance,
                          travelTime: travelTime,
                          arrivalTime: arrivalTime,
                        ),
                  );
                } else if (state is AddRequestFailure) {
                  showFlashMessage(
                    message: state.error,
                    type: FlashMessageType.error,
                    context: context,
                  );
                }
              },
              builder: (context, state) {
                return AppButton(
                  onPressed: () {
                    if (totalDistance != null) {
                      debugPrint("serviceId: ${widget.serviceId},");
                      debugPrint("carId: ${widget.carsId}");
                      debugPrint("problemId: ${widget.problemIds}");
                      debugPrint(
                        "otherProblemText: ${widget.problemController.text}",
                      );
                      debugPrint("pickLat: ${currentLocation!.latitude}");
                      debugPrint("pickLng: ${currentLocation!.longitude}");
                      debugPrint("dropLat: ${destinationLocation!.latitude}");
                      debugPrint("dropLng: ${destinationLocation!.longitude}");
                      AppCubit.get(context).addRequest(
                        serviceId: widget.serviceId,
                        carId: widget.carsId,
                        problemId: widget.problemIds,
                        otherProblemText: widget.problemController.text,
                        pickLat: currentLocation!.latitude,
                        pickLng: currentLocation!.longitude,
                        dropLat: destinationLocation!.latitude,
                        dropLng: destinationLocation!.longitude,
                      );
                    } else {
                      showFlashMessage(
                        context: context,
                        message: LocaleKeys.set_destination.tr(),
                        type: FlashMessageType.error,
                      );
                    }
                  },
                  child:
                      state is AddRequestLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : AppText(
                            text: LocaleKeys.confirm.tr(),
                            size: 21.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                );
              },
            ),
          ),
          PositionedDirectional(
            top: 50.h,
            start: 16.w,
            end: 16.w,
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.search.tr(),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (query) async {
                    if (query.length >= 3) {
                      setState(() {
                        isSearching = true;
                      });
                      final results = await searchPlaces(query);
                      setState(() {
                        searchResults = results;
                        isSearching = false;
                      });
                    } else {
                      setState(() {
                        searchResults = [];
                      });
                    }
                  },
                ),
                if (searchResults.isNotEmpty)
                  Container(
                    color: Colors.white,
                    height: 200.h,
                    child: ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final result = searchResults[index];
                        return ListTile(
                          leading: const Icon(Icons.place),
                          title: Text(
                            result.name,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          onTap: () {
                            setState(() {
                              destinationLocation = result.latLng;
                              if (currentLocation != null) {
                                totalDistance = distance.as(
                                  LengthUnit.Meter,
                                  currentLocation!,
                                  destinationLocation!,
                                );
                              }
                              searchResults.clear();
                              searchController.clear();
                            });
                            mapController.move(result.latLng, 15);
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
