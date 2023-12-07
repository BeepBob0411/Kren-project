import 'package:flutter/material.dart';
import 'package:kren/core/app_export.dart';
import 'package:kren/widgets/custom_elevated_button.dart';
import 'package:kren/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LaporanBencanaAdminOneScreen extends StatelessWidget {
  LaporanBencanaAdminOneScreen({Key? key}) : super(key: key);

  TextEditingController supartoController = TextEditingController();

  TextEditingController alamController = TextEditingController();

  TextEditingController longsorController = TextEditingController();

  TextEditingController solarpointonmapbrokenController =
      TextEditingController();

  TextEditingController fifteenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 12.v),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 35.v),
                      CustomImageView(
                          imagePath: ImageConstant.imgArrowLeft,
                          height: 30.adaptSize,
                          width: 30.adaptSize,
                          margin: EdgeInsets.only(left: 5.h),
                          onTap: () {
                            onTapImgArrowLeft(context);
                          }),
                      SizedBox(height: 32.v),
                      Padding(
                          padding: EdgeInsets.only(left: 25.h),
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Laporan ",
                                    style: theme.textTheme.headlineSmall),
                                TextSpan(
                                    text: "Bencana",
                                    style:
                                        CustomTextStyles.headlineSmallYellow900)
                              ]),
                              textAlign: TextAlign.left)),
                      SizedBox(height: 32.v),
                      CustomImageView(
                          imagePath: ImageConstant.imgImage3,
                          height: 196.v,
                          width: 389.h,
                          radius: BorderRadius.circular(27.h)),
                      SizedBox(height: 17.v),
                      Padding(
                          padding: EdgeInsets.only(left: 23.h),
                          child: Text("Keterangan",
                              style: theme.textTheme.titleSmall)),
                      SizedBox(height: 6.v),
                      Padding(
                          padding: EdgeInsets.only(left: 37.h),
                          child: Text("Pengirim :",
                              style: theme.textTheme.labelLarge)),
                      SizedBox(height: 6.v),
                      _buildSuparto(context),
                      SizedBox(height: 21.v),
                      Padding(
                          padding: EdgeInsets.only(left: 36.h),
                          child: Text("Jenis bencana :",
                              style: theme.textTheme.labelLarge)),
                      SizedBox(height: 3.v),
                      _buildAlam(context),
                      SizedBox(height: 8.v),
                      Padding(
                          padding: EdgeInsets.only(left: 37.h),
                          child: Text("Nama bencana :",
                              style: theme.textTheme.labelLarge)),
                      SizedBox(height: 7.v),
                      _buildLongsor(context),
                      SizedBox(height: 8.v),
                      Padding(
                          padding: EdgeInsets.only(left: 37.h),
                          child: Text("Lokasi bencana :",
                              style: theme.textTheme.labelLarge)),
                      SizedBox(height: 7.v),
                      _buildSolarpointonmapbroken(context),
                      SizedBox(height: 9.v),
                      Padding(
                          padding: EdgeInsets.only(left: 36.h),
                          child: Text("Keterangan dari bencana tersebut : ",
                              style: theme.textTheme.labelLarge)),
                      SizedBox(height: 6.v),
                      _buildFifteen(context)
                    ])),
            bottomNavigationBar: _buildFortyEight(context)));
  }

  /// Section Widget
  Widget _buildSuparto(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 16.h, right: 17.h),
        child: CustomTextFormField(
            controller: supartoController,
            hintText:
                "Suparto                                              1142100056",
            hintStyle: CustomTextStyles.titleMediumGray400,
            alignment: Alignment.center));
  }

  /// Section Widget
  Widget _buildAlam(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 16.h, right: 17.h),
        child: CustomTextFormField(
            controller: alamController,
            hintText: "Alam",
            alignment: Alignment.center));
  }

  /// Section Widget
  Widget _buildLongsor(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 16.h, right: 17.h),
        child: CustomTextFormField(
            controller: longsorController,
            hintText: "Longsor",
            alignment: Alignment.center));
  }

  /// Section Widget
  Widget _buildSolarpointonmapbroken(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 16.h, right: 17.h),
        child: CustomTextFormField(
            controller: solarpointonmapbrokenController,
            hintText: "Parapat",
            alignment: Alignment.center,
            suffix: Container(
                margin: EdgeInsets.fromLTRB(30.h, 14.v, 20.h, 15.v),
                child: CustomImageView(
                    imagePath: ImageConstant.imgSolarpointonmapbroken,
                    height: 24.adaptSize,
                    width: 24.adaptSize)),
            suffixConstraints: BoxConstraints(maxHeight: 53.v),
            contentPadding:
                EdgeInsets.only(left: 21.h, top: 18.v, bottom: 18.v)));
  }

  /// Section Widget
  Widget _buildFifteen(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 15.h, right: 17.h),
        child: CustomTextFormField(
            controller: fifteenController,
            hintText: "Terjadi longsor sehingga menutupi jalan lintas",
            textInputAction: TextInputAction.done,
            alignment: Alignment.center));
  }

  /// Section Widget
  Widget _buildHAPUS(BuildContext context) {
    return Expanded(
        child: CustomElevatedButton(
            height: 44.v,
            text: "HAPUS",
            margin: EdgeInsets.only(right: 19.h),
            buttonStyle: CustomButtonStyles.outlineBlack,
            buttonTextStyle: theme.textTheme.titleMedium!));
  }

  /// Section Widget
  Widget _buildKIRIM(BuildContext context) {
    return Expanded(
        child: CustomElevatedButton(
            height: 44.v,
            text: "KIRIM",
            margin: EdgeInsets.only(left: 19.h),
            buttonStyle: CustomButtonStyles.outlineBlack,
            buttonTextStyle: theme.textTheme.titleMedium!));
  }

  /// Section Widget
  Widget _buildFortyEight(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 36.h, right: 36.h, bottom: 40.v),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_buildHAPUS(context), _buildKIRIM(context)]));
  }

  /// Navigates back to the previous screen.
  onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
