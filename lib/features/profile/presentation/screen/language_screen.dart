import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joy_bor/core/constants/app_colors.dart';
import 'package:joy_bor/core/constants/app_images.dart';
import 'package:joy_bor/core/constants/language_helper.dart';
import 'package:joy_bor/features/auth/presentation/widgets/arrow_back_leading.dart';
import 'package:joy_bor/features/profile/presentation/widgets/language_row.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(AppImages.bg, fit: BoxFit.cover)),
          Padding(
            padding: EdgeInsets.all(22.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 38.h),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: ArrowBackLeading(),
                    ),
                    SizedBox(width: 90.w),
                    Text(
                      LocaleKeys.language,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  LocaleKeys.otherLanguages,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(height: 24),

                LanguageRow(onChoice: () {
                      context.setLocale(Locale('uz'));
                }, title: "O'zbekcha"),
                LanguageRow(onChoice: () {
                      context.setLocale(Locale('ru'));
                }, title: "Русский"),
                LanguageRow(onChoice: () {
                      context.setLocale(Locale('en'));
                }, title: "English"),
                LanguageRow(
                  onChoice: () {
                    context.setLocale(Locale('kk'));
                  },
                  title: "Қазақша",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
