import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:sathuh/core/widgets/app_button.dart';
import 'package:sathuh/core/widgets/app_router.dart';
import 'package:sathuh/core/widgets/flash_message.dart';
import 'package:sathuh/screens/driver_screens/home_layout/chats/chat_details/chat_details.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/driver_bottom_nav.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';

class DrivOrderDetails extends StatelessWidget {
  final int index;
  final bool isPending;
  const DrivOrderDetails({
    super.key,
    required this.index,
    this.isPending = false,
  });

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
                Container(height: 8.h),
                Text(address, style: TextStyle(fontSize: 16.sp)),
                Container(height: 12.h),
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
                          userAgentPackageName: 'sathuh',
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
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return DriverBottomNav(
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
                        IconButton(
                          icon: const Icon(Icons.chat, color: Colors.green),
                          onPressed: () {
                            AppRouter.navigateTo(
                              context,
                              DrivChatDetails(
                                id:
                                    isPending
                                        ? AppCubit.get(
                                          context,
                                        ).pendingRequestsList[index]['userId']
                                        : AppCubit.get(
                                          context,
                                        ).completedRequestsList[index]['userId'],
                              ),
                            );
                          },
                        ),
                        // Row(
                        //   children: [
                        //     AppText(
                        //       text: LocaleKeys.customer_name.tr(),
                        //       size: 16.sp,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //     const Spacer(),
                        //     SizedBox(
                        //       width: 150.w,
                        //       child: AppText(
                        //         textAlign: TextAlign.end,
                        //         text:
                        //             AppCubit.get(
                        //               context,
                        //             ).pendingRequestsList[index]['userId'],
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(vertical: 8.h),
                        //   child: const Divider(color: Colors.grey),
                        // ),
                        // Row(
                        //   children: [
                        //     AppText(
                        //       text: LocaleKeys.driver_name.tr(),
                        //       size: 16.sp,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //     const Spacer(),
                        //     SizedBox(
                        //       width: 150.w,
                        //       child: const AppText(
                        //         textAlign: TextAlign.end,
                        //         text: 'خالد علي',
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(vertical: 8.h),
                        //   child: const Divider(color: Colors.grey),
                        // ),
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
                              child: AppText(
                                textAlign: TextAlign.end,
                                text:
                                    isPending
                                        ? AppCubit.get(
                                                  context,
                                                ).pendingRequestsList[index]['serviceId'] ==
                                                '6832d41daaf83e5694854d65'
                                            ? 'سطحه عاديه'
                                            : 'سطحه هيدروليك'
                                        : AppCubit.get(
                                              context,
                                            ).completedRequestsList[index]['serviceId'] ==
                                            '6832d41daaf83e5694854d65'
                                        ? 'سطحه عاديه'
                                        : 'سطحه هيدروليك',
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

                        // Row(
                        //   children: [
                        //     AppText(
                        //       text: LocaleKeys.customer_phone.tr(),
                        //       size: 16.sp,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //     const Spacer(),
                        //     InkWell(
                        //       splashColor: Colors.transparent,
                        //       highlightColor: Colors.transparent,
                        //       onTap: () {
                        //         makePhoneCall('0100000000');
                        //       },
                        //       child: SizedBox(
                        //         width: 150.w,
                        //         child: const AppText(
                        //           textAlign: TextAlign.end,
                        //           text: '0100000000',
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.blue,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(vertical: 8.h),
                        //   child: const Divider(color: Colors.grey),
                        // ),
                        // Row(
                        //   children: [
                        //     AppText(
                        //       text: LocaleKeys.driver_phone.tr(),
                        //       size: 16.sp,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //     const Spacer(),
                        //     InkWell(
                        //       splashColor: Colors.transparent,
                        //       highlightColor: Colors.transparent,
                        //       onTap: () {
                        //         makePhoneCall('0100000000');
                        //       },
                        //       child: SizedBox(
                        //         width: 150.w,
                        //         child: const AppText(
                        //           textAlign: TextAlign.end,
                        //           text: '0100000000',
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.blue,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(vertical: 8.h),
                        //   child: const Divider(color: Colors.grey),
                        // ),
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
                                    LatLng(
                                      isPending
                                          ? AppCubit.get(
                                            context,
                                          ).pendingRequestsList[index]['pickupLocation']['coordinates'][1]
                                          : AppCubit.get(
                                            context,
                                          ).completedRequestsList[index]['pickupLocation']['coordinates'][1],
                                      isPending
                                          ? AppCubit.get(
                                            context,
                                          ).pendingRequestsList[index]['pickupLocation']['coordinates'][0]
                                          : AppCubit.get(
                                            context,
                                          ).completedRequestsList[index]['pickupLocation']['coordinates'][0],
                                    ), // إحداثيات الرياض كمثال
                                  ),

                              child: SizedBox(
                                width: 150.w,
                                child: FutureBuilder<String>(
                                  future: getAddressFromLatLng(
                                    isPending
                                        ? AppCubit.get(
                                          context,
                                        ).pendingRequestsList[index]['pickupLocation']['coordinates'][1]
                                        : AppCubit.get(
                                          context,
                                        ).completedRequestsList[index]['pickupLocation']['coordinates'][1],
                                    isPending
                                        ? AppCubit.get(
                                          context,
                                        ).pendingRequestsList[index]['pickupLocation']['coordinates'][0]
                                        : AppCubit.get(
                                          context,
                                        ).completedRequestsList[index]['pickupLocation']['coordinates'][0],
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
                                    LatLng(
                                      isPending
                                          ? AppCubit.get(
                                            context,
                                          ).pendingRequestsList[index]['dropoffLocation']['coordinates'][1]
                                          : AppCubit.get(
                                            context,
                                          ).completedRequestsList[index]['dropoffLocation']['coordinates'][1],
                                      isPending
                                          ? AppCubit.get(
                                            context,
                                          ).pendingRequestsList[index]['dropoffLocation']['coordinates'][0]
                                          : AppCubit.get(
                                            context,
                                          ).completedRequestsList[index]['dropoffLocation']['coordinates'][0],
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
                              child: AppText(
                                textAlign: TextAlign.end,
                                text:
                                    '${isPending ? AppCubit.get(context).pendingRequestsList[index]['distanceInMeters'].toString() : AppCubit.get(context).completedRequestsList[index]['distanceInMeters'].toString()} ',
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
                                text:
                                    '${isPending ? AppCubit.get(context).pendingRequestsList[index]['totalPrice'].toString() : AppCubit.get(context).completedRequestsList[index]['totalPrice'].toString()} ${LocaleKeys.sar.tr()}',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  isPending
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 40.h,
                            child: BlocConsumer<AppCubit, AppState>(
                              listener: (context, state) {
                                if (state is RequestStatusDriverSuccess) {
                                  showFlashMessage(
                                    message: state.message,
                                    type: FlashMessageType.success,
                                    context: context,
                                  );
                                } else if (state
                                    is RequestStatusDriverFailure) {
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
                                    AppCubit.get(context).requestStatusDriver(
                                      requestId:
                                          AppCubit.get(
                                            context,
                                          ).pendingRequestsList[index]['id'],
                                      type: 'accept',
                                    );
                                  },
                                  color: Colors.green,
                                  width: 100.w,
                                  child: AppText(
                                    text: LocaleKeys.accept.tr(),
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                            child: BlocConsumer<AppCubit, AppState>(
                              listener: (context, state) {
                                if (state is RequestStatusDriverSuccess) {
                                  showFlashMessage(
                                    message: state.message,
                                    type: FlashMessageType.success,
                                    context: context,
                                  );
                                } else if (state
                                    is RequestStatusDriverFailure) {
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
                                    AppCubit.get(context).requestStatusDriver(
                                      requestId:
                                          AppCubit.get(
                                            context,
                                          ).pendingRequestsList[index]['id'],
                                      type: 'reject',
                                    );
                                  },
                                  color: Colors.red,
                                  width: 100.w,
                                  child: AppText(
                                    text: LocaleKeys.reject.tr(),
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                            child: BlocConsumer<AppCubit, AppState>(
                              listener: (context, state) {
                                if (state is RequestStatusDriverSuccess) {
                                  showFlashMessage(
                                    message: state.message,
                                    type: FlashMessageType.success,
                                    context: context,
                                  );
                                } else if (state
                                    is RequestStatusDriverFailure) {
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
                                    AppCubit.get(context).requestStatusDriver(
                                      requestId:
                                          AppCubit.get(
                                            context,
                                          ).pendingRequestsList[index]['id'],
                                      type: 'compelete',
                                    );
                                  },
                                  color: Colors.black,
                                  width: 100.w,
                                  child: AppText(
                                    text: LocaleKeys.complete_order.tr(),
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
