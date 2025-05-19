import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:sathuh/core/constants/colors.dart';
import 'package:sathuh/core/widgets/app_button.dart';
import 'package:sathuh/generated/locale_keys.g.dart';
import 'package:sathuh/screens/user_screens/home_layout/home_layout.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_router.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/flash_message.dart';

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

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({super.key, required this.totalDistance});

  final double? totalDistance;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h,
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            text: LocaleKeys.serviceDetails.tr(),
            size: 21.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100.w,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(50),
                      blurRadius: 5.r,
                      spreadRadius: 1.r,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.w,
                      child: AppText(
                        textAlign: TextAlign.center,
                        text: LocaleKeys.arrival_abbreviation.tr(),
                        size: 16.sp,
                        fontWeight: FontWeight.bold,
                        bottom: 5.h,
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                      child: AppText(
                        textAlign: TextAlign.center,
                        text:
                            '${totalDistance!.toStringAsFixed(0)} ${LocaleKeys.meter.tr()}',
                        size: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 100.w,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(50),
                      blurRadius: 5.r,
                      spreadRadius: 1.r,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.w,
                      child: AppText(
                        textAlign: TextAlign.center,
                        text: LocaleKeys.time.tr(),
                        size: 16.sp,
                        fontWeight: FontWeight.bold,
                        bottom: 5.h,
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                      child: AppText(
                        textAlign: TextAlign.center,
                        text: '40 ${LocaleKeys.minute.tr()}',
                        size: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 100.w,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(50),
                      blurRadius: 5.r,
                      spreadRadius: 1.r,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.w,
                      child: AppText(
                        textAlign: TextAlign.center,
                        text: LocaleKeys.arrival_time.tr(),
                        size: 16.sp,
                        fontWeight: FontWeight.bold,
                        bottom: 5.h,
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                      child: AppText(
                        textAlign: TextAlign.center,
                        text: '12:45 PM',
                        size: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: 343.w,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(50),
                  blurRadius: 5.r,
                  spreadRadius: 1.r,
                  offset: Offset(0, 5.r),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    AppText(
                      text: LocaleKeys.meter_price.tr(),
                      size: 16.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    AppText(
                      text: '20 ${LocaleKeys.sar.tr()}',
                      size: 16.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    AppText(
                      text: LocaleKeys.cost.tr(),
                      size: 16.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    AppText(
                      text: '20 ${LocaleKeys.sar.tr()}',
                      size: 16.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppButton(
            color: Colors.white,
            onPressed: () {
              AppRouter.pop(context);
              showModalBottomSheet(
                context: context,
                builder: (context) => const PaymentSheet(),
              );
            },
            child: AppText(
              text: LocaleKeys.confirm.tr(),
              size: 21.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentSheet extends StatelessWidget {
  const PaymentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          height: 350.h,
          padding: EdgeInsets.all(16.r),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: LocaleKeys.choosePaymentMethod.tr(),
                size: 18.sp,
                fontWeight: FontWeight.w500,
                top: 16.h,
              ),
              SizedBox(height: 8.w),
              const Divider(thickness: 1, color: Colors.grey),
              Column(
                children: [
                  SizedBox(height: 18.h),
                  InkWell(
                    onTap: () {
                      if (AppCubit.get(context).paymentIndex == 0) {
                        AppCubit.get(context).changePaymentIndex(index: -1);
                      } else {
                        AppCubit.get(context).changePaymentIndex(index: 0);
                      }
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 5.r,
                            spreadRadius: 1.r,
                            offset: Offset(0, 5.r),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.payment,
                            size: 25.sp,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 8.w),
                          AppText(
                            text: 'Cash',
                            size: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          const Spacer(),
                          Container(
                            height: 25.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  AppCubit.get(context).paymentIndex == 0
                                      ? AppColors.primary
                                      : Colors.transparent,
                              border: Border.all(color: AppColors.primary),
                            ),
                            child: Icon(
                              Icons.done,
                              color:
                                  AppCubit.get(context).paymentIndex == 0
                                      ? Colors.white
                                      : Colors.transparent,
                              size: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 21.h),
                  InkWell(
                    onTap: () {
                      if (AppCubit.get(context).paymentIndex == 1) {
                        AppCubit.get(context).changePaymentIndex(index: -1);
                      } else {
                        AppCubit.get(context).changePaymentIndex(index: 1);
                      }
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 5.r,
                            spreadRadius: 1.r,
                            offset: Offset(0, 5.r),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.payments,
                            size: 25.sp,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 8.w),
                          AppText(
                            text: 'Online',
                            size: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          const Spacer(),
                          Container(
                            height: 25.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  AppCubit.get(context).paymentIndex == 1
                                      ? AppColors.primary
                                      : Colors.transparent,
                              border: Border.all(color: AppColors.primary),
                            ),
                            child: Icon(
                              Icons.done,
                              color:
                                  AppCubit.get(context).paymentIndex == 1
                                      ? Colors.white
                                      : Colors.transparent,
                              size: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: AppButton(
                  onPressed: () {
                    if (AppCubit.get(context).paymentIndex == -1) {
                      showFlashMessage(
                        message: LocaleKeys.choosePaymentMethod.tr(),
                        type: FlashMessageType.warning,
                        context: context,
                      );
                    } else {
                      AppCubit.get(context).changebottomNavIndex(1);
                      AppRouter.navigateAndFinish(context, const HomeLayout());
                    }
                  },
                  top: 30.h,
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
      },
    );
  }
}
