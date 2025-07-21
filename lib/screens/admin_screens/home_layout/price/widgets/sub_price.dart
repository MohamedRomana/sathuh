import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/service/cubit/app_cubit.dart';
import 'custom_add_sub.dart';
import 'custom_update_sub.dart';

final _priceController = TextEditingController();
final _subTypeController = TextEditingController();
final _priceupdateController = TextEditingController();
final _subTypeupdateController = TextEditingController();

class SubscribePrice extends StatefulWidget {
  const SubscribePrice({super.key});

  @override
  State<SubscribePrice> createState() => _SubscribePriceState();
}

class _SubscribePriceState extends State<SubscribePrice> {
  @override
  Widget build(BuildContext context) {
    final List subType = [
      {"title": "monthly"},
      {"title": "yearly"},
    ];
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              CustomAddSub(
                subType: subType,
                priceController: _priceController,
                subTypeController: _subTypeController,
              ),
              SizedBox(height: 16.h),
              CustomUpdateSub(
                subType: subType,
                priceupdateController: _priceupdateController,
                subTypeupdateController: _subTypeupdateController,
              ),
              SizedBox(height: 140.h),
            ],
          ),
        );
      },
    );
  }
}
