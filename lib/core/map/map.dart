// // ignore_for_file: use_build_context_synchronously
// import 'dart:async';
// import 'dart:collection';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../generated/locale_keys.g.dart';
// import '../constants/colors.dart';
// import '../service/cubit/app_cubit.dart';
// import '../widgets/app_button.dart';
// import '../widgets/app_text.dart';
// import 'location_helper.dart';

// class Location extends StatefulWidget {
//   const Location({super.key});

//   @override
//   State<Location> createState() => _LocationState();
// }

// class _LocationState extends State<Location> {
//   static Position? position;
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();
//   var myMarkers = HashSet<Marker>();

//   @override
//   void initState() {
//     AppCubit.get(context).address = null;
//     AppCubit.get(context).lat = null;
//     AppCubit.get(context).lng = null;
//     getMyCurrentLocation();
//     super.initState();
//   }

//   Future<void> getMyCurrentLocation() async {
//     position = await LocationHelper.determinePosition().whenComplete(() {
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         clipBehavior: Clip.antiAlias,
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(
//             // topRight: Radius.circular(20.r),
//             // topLeft: Radius.circular(20.r),
//           ),
//         ),
//         child:
//             position != null
//                 ? Stack(
//                   children: [
//                     GoogleMap(
//                       mapType: MapType.normal,
//                       myLocationEnabled: true,
//                       myLocationButtonEnabled: false,
//                       zoomControlsEnabled: false,
//                       initialCameraPosition: CameraPosition(
//                         target: LatLng(position!.latitude, position!.longitude),
//                         zoom: 15,
//                       ),
//                       onTap: (argument) async {
//                         myMarkers.clear();
//                         final placeMarkes = await placemarkFromCoordinates(
//                           argument.latitude,
//                           argument.longitude,
//                         );
//                         AppCubit.get(context).changeAddress(
//                           newAddress: placeMarkes[0].street ?? '',
//                         );
//                         projectLocationController.text =
//                             AppCubit.get(context).address ?? "";
//                         debugPrint(AppCubit.get(context).address);
//                         setState(() {
//                           AppCubit.get(context).lat = argument.latitude;
//                           AppCubit.get(context).lng = argument.longitude;
//                           debugPrint(
//                             '${AppCubit.get(context).lat} + ${AppCubit.get(context).lng}',
//                           );
//                         });
//                         myMarkers.add(
//                           Marker(
//                             markerId: const MarkerId('2'),
//                             position: argument,
//                             infoWindow: InfoWindow(
//                               title: AppCubit.get(context).address,
//                             ),
//                           ),
//                         );
//                       },
//                       onMapCreated: (
//                         GoogleMapController googleMapController,
//                       ) async {
//                         _controller.complete(googleMapController);
//                         final placeMarks = await placemarkFromCoordinates(
//                           position!.latitude,
//                           position!.longitude,
//                         );
//                         setState(() {
//                           AppCubit.get(context).changeAddress(
//                             newAddress: placeMarks[0].street ?? '',
//                           );
//                           debugPrint(AppCubit.get(context).address);
//                           AppCubit.get(context).lat = position!.latitude;
//                           AppCubit.get(context).lng = position!.longitude;
//                           debugPrint(AppCubit.get(context).lat.toString());
//                           debugPrint(AppCubit.get(context).lng.toString());
//                           myMarkers.add(
//                             Marker(
//                               markerId: const MarkerId('1'),
//                               position: LatLng(
//                                 position!.latitude,
//                                 position!.longitude,
//                               ),
//                               infoWindow: InfoWindow(
//                                 title:
//                                     AppCubit.get(context).address ?? "location",
//                               ),
//                               onTap: () {},
//                             ),
//                           );
//                         });
//                       },
//                       markers: myMarkers,
//                     ),
//                     Positioned(
//                       bottom: 50.h,
//                       right: 16.w,
//                       left: 16.w,
//                       child: AppButton(
//                         width: 311.w,
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: AppText(
//                           text: LocaleKeys.confirmLocation.tr(),
//                           size: 21.sp,
//                           color: Colors.white,
//                           family: FontFamily.bahijJannaBold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//                 : const Center(
//                   child: CircularProgressIndicator(color: AppColors.primary),
//                 ),
//       ),
//     );
//   }
// }
