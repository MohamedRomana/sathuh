// ignore_for_file: deprecated_member_use

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/colors.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_text.dart';
import '../../../gen/assets.gen.dart';
import 'widgets/on_boarding_buttons.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  double currPage = 0.0;
  PageController pageController = PageController(initialPage: 0);
  List pagesList = [
    {
      "image1": Assets.img.clock.path,
      "title": "معاك علي مدار 24 ساعة",
      "desc":
          "جميع الخدمات متاحه علي مدار 24/7 جميع أيام الأسبوع والعطلات الرسمية",
    },
    {
      "image1": Assets.img.easy.path,
      "title": "سهولة في التعامل",
      "desc": "بخطوات بسيطة وسهله تقدر تطلب وتستمتع بجميع الخدمات",
    },
    {
      "image1": Assets.img.savemony.path,
      "title": "توفير لوقتك وفلوسك",
      "desc": "بخطوات بسيطة وسهله تقدر تطلب وتستمتع بجميع الخدمات",
    },
    {
      "image1": Assets.img.saver.path,
      "title": "أمان ليك ولعربيتك",
      "desc":
          "يتم متابعة وحدة الإنقاذ لحظة بلحظة ومعرفة عدد الدقائق لحين وصولها للعميل ويتم مراقبة السياره بكاميرا تصوير أونلاين",
    },
  ];

  @override
  void initState() {
    super.initState();
    // AppCubit.get(context).intro();
    pageController = PageController(initialPage: 0)..addListener(() {
      setState(() {
        currPage = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          body:
          // state is GetIntroLoading
          //     ? const Center(
          //         child: CircularProgressIndicator(color: AppColors.primary),
          //       )
          //     :
          Stack(
            children: [
              PageView.builder(
                controller: pageController,
                itemCount: pagesList.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            pagesList[index]['image1'],
                            fit: BoxFit.cover,
                          ),
                          AppText(
                            top: 74.h,
                            bottom: 5.h,
                            start: 26.w,
                            end: 26.w,
                            text: pagesList[index]['title'],
                            size: 30.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          AppText(
                            textAlign: TextAlign.center,
                            text: pagesList[index]['desc'],
                            lines: 3,
                            start: 26.w,
                            end: 26.w,
                            size: 14.sp,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      CustomOnBoardingButtons(
                        pagesList: pagesList,
                        currPage: currPage,
                        pageController: pageController,
                      ),
                    ],
                  );
                },
              ),
              PositionedDirectional(
                bottom: 50.h,
                end: 20.w,
                start: 20.w,
                child: DotsIndicator(
                  dotsCount: pagesList.length,
                  position: currPage,
                  decorator: DotsDecorator(
                    activeColor: AppColors.primary,
                    color: const Color(0xff878787).withOpacity(0.3),
                    size: Size.square(12.r),
                    activeSize: Size(20.w, 12.h),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
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
