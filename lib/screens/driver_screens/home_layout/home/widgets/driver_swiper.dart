import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_cached.dart';
import '../../../../../core/widgets/custom_shimmer.dart';

class DriverSwiper extends StatefulWidget {
  const DriverSwiper({super.key});

  @override
  State<DriverSwiper> createState() => _DriverSwiperState();
}

class _DriverSwiperState extends State<DriverSwiper> {
  @override
  void initState() {
    AppCubit.get(context).getBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return state is GetBannerLoading &&
                AppCubit.get(context).banners.isEmpty
            ? CustomShimmer(
              child: Container(
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
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                ),
              ),
            )
            : Container(
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
                itemBuilder: (context, index) {
                  return AppCachedImage(
                    image: AppCubit.get(context).banners[index],
                    fit: BoxFit.cover,
                  );
                },
                autoplay: true,
                itemCount: AppCubit.get(context).banners.length,
                scrollDirection: Axis.horizontal,
                curve: Curves.fastOutSlowIn,
                // pagination: SwiperPagination(
                //   alignment: Alignment.bottomCenter,
                //   builder: DotSwiperPaginationBuilder(
                //     color: const Color(0xffB3B3B3),
                //     activeColor: AppColors.primary,
                //     size: 8.r,
                //     activeSize: 11.r,
                //   ),
                // ),
              ),
            );
      },
    );
  }
}
