import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:sathuh/core/widgets/app_button.dart';
import 'package:sathuh/core/widgets/app_text.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../satha_service/satha_service.dart';

class DriverLocation extends StatelessWidget {
  final double? lat;
  final double? lng;
  final bool? isAdmin;
  const DriverLocation({super.key, this.isAdmin = false, this.lat, this.lng});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(lat ?? 24.7136, lng ?? 46.6753),
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.app',
                tileProvider: NetworkTileProvider(),
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(lat ?? 24.7136, lng ?? 46.6753),
                    width: 80,
                    height: 80,
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
          isAdmin!
              ? Container()
              : PositionedDirectional(
                bottom: 30.h,
                start: 20.w,
                child: AppButton(
                  onPressed: () {
                    AppRouter.navigateTo(context, const SathaService(serviceId: '',));
                  },
                  child: AppText(
                    text: LocaleKeys.serviceRequest.tr(),
                    color: Colors.white,
                    family: FontFamily.tajawalBold,
                    size: 21.sp,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
