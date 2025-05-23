import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:sathuh/core/widgets/custom_bottom_nav.dart';
import '../../../../../core/constants/contsants.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  void showAddressBottomSheet(
    BuildContext context,
    String title,
    String address,
    LatLng location,
  ) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) {
        return SizedBox(
          height: 400.h,
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 60.w,
                    height: 5.h,
                    margin: EdgeInsets.only(bottom: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(address, style: TextStyle(fontSize: 16.sp)),
                SizedBox(height: 12.h),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: location,
                        initialZoom: 15,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: location,
                              width: 40,
                              height: 40,
                              child: const Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> getAddressFromLatLng(double lat, double lon) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon',
    );

    final response = await http.get(
      url,
      headers: {
        'User-Agent': 'FlutterApp', // لازم يكون في user agent
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['display_name'] ?? 'Unknown location';
    } else {
      return 'Failed to get address';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
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
          Column(
            children: [
              CustomAppBar(title: LocaleKeys.orderDetails.tr()),
              Container(
                width: 343.w,
                padding: EdgeInsets.all(16.r),
                margin: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(100),
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
                          text: LocaleKeys.customer_name.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 150.w,
                          child: const AppText(
                            textAlign: TextAlign.end,
                            text: 'محمد احمد',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Divider(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        AppText(
                          text: LocaleKeys.driver_name.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 150.w,
                          child: const AppText(
                            textAlign: TextAlign.end,
                            text: 'خالد علي',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Divider(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        AppText(
                          text: LocaleKeys.service_name.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 150.w,
                          child: const AppText(
                            textAlign: TextAlign.end,
                            text: 'خدمة سطحه',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Divider(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        AppText(
                          text: LocaleKeys.customer_phone.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            makePhoneCall('0100000000');
                          },
                          child: SizedBox(
                            width: 150.w,
                            child: const AppText(
                              textAlign: TextAlign.end,
                              text: '0100000000',
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Divider(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        AppText(
                          text: LocaleKeys.driver_phone.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            makePhoneCall('0100000000');
                          },
                          child: SizedBox(
                            width: 150.w,
                            child: const AppText(
                              textAlign: TextAlign.end,
                              text: '0100000000',
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Divider(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        AppText(
                          text: LocaleKeys.customer_location.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap:
                              () => showAddressBottomSheet(
                                context,
                                LocaleKeys.customer_location.tr(),
                                LocaleKeys.full_start_location_here.tr(),
                                const LatLng(
                                  24.7136,
                                  46.6753,
                                ), // إحداثيات الرياض كمثال
                              ),

                          child: SizedBox(
                            width: 150.w,
                            child: FutureBuilder<String>(
                              future: getAddressFromLatLng(
                                24.7136,
                                46.6753,
                              ), // الإحداثيات الفعلية
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return AppText(
                                    textAlign: TextAlign.end,
                                    text: LocaleKeys.loading.tr(),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  );
                                } else if (snapshot.hasError) {
                                  return AppText(
                                    textAlign: TextAlign.end,
                                    text: LocaleKeys.error_occurred.tr(),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  );
                                } else {
                                  return AppText(
                                    textAlign: TextAlign.end,
                                    text:
                                        snapshot.data ??
                                        LocaleKeys.no_address.tr(),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Divider(color: Colors.grey),
                    ),

                    Row(
                      children: [
                        AppText(
                          text: LocaleKeys.dropoff_location.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap:
                              () => showAddressBottomSheet(
                                context,
                                LocaleKeys.dropoff_location.tr(),
                                LocaleKeys.full_start_location_here.tr(),
                                const LatLng(
                                  24.7136,
                                  46.6753,
                                ), // إحداثيات الرياض كمثال
                              ),

                          child: SizedBox(
                            width: 150.w,
                            child: FutureBuilder<String>(
                              future: getAddressFromLatLng(
                                24.7136,
                                46.6753,
                              ), // الإحداثيات الفعلية
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return AppText(
                                    textAlign: TextAlign.end,
                                    text: LocaleKeys.loading.tr(),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  );
                                } else if (snapshot.hasError) {
                                  return AppText(
                                    textAlign: TextAlign.end,
                                    text: LocaleKeys.error_occurred.tr(),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  );
                                } else {
                                  return AppText(
                                    textAlign: TextAlign.end,
                                    text:
                                        snapshot.data ??
                                        LocaleKeys.no_address.tr(),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Divider(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        AppText(
                          text: LocaleKeys.distance_or_meter.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 150.w,
                          child: const AppText(
                            textAlign: TextAlign.end,
                            text: '100 كم',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Divider(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        AppText(
                          text: LocaleKeys.service_price.tr(),
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 150.w,
                          child: AppText(
                            textAlign: TextAlign.end,
                            text: '1000 ${LocaleKeys.sar.tr()}',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
