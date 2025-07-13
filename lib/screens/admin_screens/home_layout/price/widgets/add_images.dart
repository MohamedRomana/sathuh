// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/constants/colors.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import 'package:sathuh/core/widgets/app_cached.dart';
import 'package:sathuh/core/widgets/flash_message.dart';
import '../../../../../core/cache/cache_helper.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../generated/locale_keys.g.dart';

class AddImages extends StatefulWidget {
  const AddImages({super.key});

  @override
  State<AddImages> createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getBanner();
  }

  Future<List<File>> _pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      final newImages = result.paths.map((path) => File(path!)).toList();
      AppCubit.get(context).addBanners(newImages); // مباشرة إلى السيرفر
      return newImages;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        debugPrint(CacheHelper.getUserToken());
        return Column(
          children: [
            Container(height: 24.h),
            AppCubit.get(context).banners.isEmpty
                ? Center(
                  child: AppText(
                    text: LocaleKeys.no_saved_images.tr(),
                    size: 18.sp,
                    fontWeight: FontWeight.bold,
                    bottom: 16.h,
                  ),
                )
                : SizedBox(
                  height: 150.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: AppCubit.get(context).banners.length,
                    separatorBuilder: (context, index) => Container(width: 16),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: AppCachedImage(
                              image: AppCubit.get(context).banners[index],
                              width: 160,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Positioned(
                            top: 4,
                            right: 4,
                            child: BlocConsumer<AppCubit, AppState>(
                              listener: (context, state) {
                                if (state is DeleteBannerSuccess) {
                                  showFlashMessage(
                                    message: state.message,
                                    type: FlashMessageType.success,
                                    context: context,
                                  );
                                } else if (state is DeleteBannerFailure) {
                                  showFlashMessage(
                                    message: state.error,
                                    type: FlashMessageType.error,
                                    context: context,
                                  );
                                }
                              },
                              builder: (context, state) {
                                return InkWell(
                                  onTap: () {
                                    final imageUrl =
                                        AppCubit.get(context).banners[index];
                                    final imageName = imageUrl.split('/').last;

                                    AppCubit.get(context).deleteBanner(
                                      bannerId:
                                          AppCubit.get(
                                            context,
                                          ).bannerIds[index],
                                      image: imageName,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
            Container(height: 10.h),
            BlocConsumer<AppCubit, AppState>(
              listener: (context, state) {
                if (state is AddBannerSuccess) {
                  showFlashMessage(
                    message: state.message,
                    type: FlashMessageType.success,
                    context: context,
                  );
                } else if (state is AddBannerFailure) {
                  showFlashMessage(
                    message: state.error,
                    type: FlashMessageType.error,
                    context: context,
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () async {
                    await _pickImages();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      AppColors.primary,
                    ),
                  ),
                  child:
                      state is AddBannerLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : AppText(
                            text: LocaleKeys.add_images.tr(),
                            size: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
