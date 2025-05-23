import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../gen/assets.gen.dart';

class DriverSwiper extends StatelessWidget {
  const DriverSwiper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 180.h,
          width: 343.w,
          margin: EdgeInsetsDirectional.only(
            top: 20.h,
            bottom: 20.h,
            start: 20.w,
            end: 20.w,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.r,
                spreadRadius: 1.r,
                offset: Offset(0, 5.r),
              ),
            ],
          ),
          child: Swiper(
            itemBuilder:
                (context, index) =>
      Image.asset(Assets.img.background.path, fit: BoxFit.cover),
            autoplay: true,
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            curve: Curves.fastOutSlowIn,
            pagination: SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                color: const Color(0xffB3B3B3),
                activeColor: AppColors.primary,
                size: 8.r,
                activeSize: 11.r,
              ),
            ),
          ),
        );
  }
}
