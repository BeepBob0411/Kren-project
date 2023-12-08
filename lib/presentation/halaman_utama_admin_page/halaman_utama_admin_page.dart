import 'package:flutter/material.dart';
import 'package:kren/core/app_export.dart';
import 'package:kren/widgets/app_bar/appbar_subtitle.dart';
import 'package:kren/widgets/app_bar/appbar_title.dart';
import 'package:kren/widgets/app_bar/appbar_trailing_circleimage.dart';
import 'package:kren/widgets/app_bar/custom_app_bar.dart';
import 'package:kren/widgets/custom_elevated_button.dart';
import 'package:kren/widgets/custom_radio_button.dart';
import 'package:kren/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class HalamanUtamaAdminPage extends StatelessWidget {
  HalamanUtamaAdminPage({Key? key})
      : super(
          key: key,
        );

  TextEditingController arrowrightController = TextEditingController();

  String radioGroup = "";

  TextEditingController aceptbuttonController = TextEditingController();

  String radioGroup1 = "";

  TextEditingController aceptbuttonController1 = TextEditingController();

  String radioGroup2 = "";

  TextEditingController aceptbuttonController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 5.v),
            child: Padding(
              padding: EdgeInsets.only(
                left: 17.h,
                right: 29.h,
                bottom: 12.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildThirtyNine(context),
                  SizedBox(height: 32.v),
                  Text(
                    "Laporan dari Masyarakat",
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(height: 31.v),
                  _buildOne(context),
                  SizedBox(height: 14.v),
                  Padding(
                    padding: EdgeInsets.only(left: 36.h),
                    child: Text(
                      "Tolak Laporam:",
                      style: CustomTextStyles.labelMediumGray800,
                    ),
                  ),
                  SizedBox(height: 2.v),
                  _buildAceptbutton(context),
                  SizedBox(height: 32.v),
                  _buildThree(context),
                  SizedBox(height: 14.v),
                  Padding(
                    padding: EdgeInsets.only(left: 38.h),
                    child: Text(
                      "Tolak Laporam:",
                      style: CustomTextStyles.labelMediumGray800,
                    ),
                  ),
                  SizedBox(height: 2.v),
                  _buildAceptbutton1(context),
                  SizedBox(height: 30.v),
                  _buildFive(context),
                  SizedBox(height: 14.v),
                  Padding(
                    padding: EdgeInsets.only(left: 38.h),
                    child: Text(
                      "Tolak Laporam:",
                      style: CustomTextStyles.labelMediumGray800,
                    ),
                  ),
                  SizedBox(height: 2.v),
                  _buildAceptbutton2(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Padding(
        padding: EdgeInsets.only(left: 27.h),
        child: Column(
          children: [
            AppbarSubtitle(
              text: "Selamat datang",
              margin: EdgeInsets.only(right: 139.h),
            ),
            AppbarTitle(
              text: "Admin Situmorang",
            ),
          ],
        ),
      ),
      actions: [
        AppbarTrailingCircleimage(
          imagePath: ImageConstant.imgProfile,
          margin: EdgeInsets.fromLTRB(29.h, 9.v, 29.h, 13.v),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildArrowright(BuildContext context) {
    return CustomTextFormField(
      controller: arrowrightController,
      hintText: "masukkan alert yang ingin ditambahi",
      suffix: Container(
        margin: EdgeInsets.fromLTRB(30.h, 10.v, 16.h, 10.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgArrowright,
          height: 16.v,
          width: 12.h,
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 157.v,
      ),
      maxLines: 9,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 16.v,
      ),
      borderDecoration: TextFormFieldStyleHelper.outlineBlack,
    );
  }

  /// Section Widget
  Widget _buildThirtyNine(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.h),
      padding: EdgeInsets.symmetric(
        horizontal: 11.h,
        vertical: 12.v,
      ),
      decoration: AppDecoration.fillIndigoA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 21.v),
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgLineMdAlert,
                  height: 60.adaptSize,
                  width: 60.adaptSize,
                ),
                Container(
                  width: 148.h,
                  margin: EdgeInsets.only(
                    left: 16.h,
                    top: 8.v,
                    bottom: 16.v,
                  ),
                  child: Text(
                    "Terjadi banjir di laguboti\n26 July 2023",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.labelLargeWhiteA700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 76.v),
          _buildArrowright(context),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildACC(BuildContext context) {
    return CustomElevatedButton(
      width: 65.h,
      text: "ACC",
      margin: EdgeInsets.only(top: 7.v),
    );
  }

  /// Section Widget
  Widget _buildOne(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 9.h),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgPictureReport,
            height: 280.v,
            width: 373.h,
            radius: BorderRadius.vertical(
              top: Radius.circular(15.h),
            ),
          ),
          SizedBox(height: 10.v),
          Padding(
            padding: EdgeInsets.only(
              left: 14.h,
              right: 11.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 26.v,
                  width: 219.h,
                  margin: EdgeInsets.only(bottom: 3.v),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: CustomRadioButton(
                          text: "Bencana Alam",
                          value: "Bencana Alam",
                          groupValue: radioGroup,
                          onChange: (value) {
                            radioGroup = value;
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Bencana alam yang membahayakan",
                          style: CustomTextStyles.labelMediumWhiteA700,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildACC(context),
              ],
            ),
          ),
          SizedBox(height: 10.v),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAceptbutton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24.h,
        right: 13.h,
      ),
      child: CustomTextFormField(
        controller: aceptbuttonController,
        hintText: "masukkan alasan penolakan",
        alignment: Alignment.center,
        suffix: Container(
          margin: EdgeInsets.fromLTRB(30.h, 11.v, 15.h, 12.v),
          child: CustomImageView(
            imagePath: ImageConstant.imgAceptButton,
            height: 20.adaptSize,
            width: 20.adaptSize,
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 43.v,
        ),
        contentPadding: EdgeInsets.only(
          left: 26.h,
          top: 14.v,
          bottom: 14.v,
        ),
        borderDecoration: TextFormFieldStyleHelper.outlineBlack,
      ),
    );
  }

  /// Section Widget
  Widget _buildACC1(BuildContext context) {
    return CustomElevatedButton(
      width: 65.h,
      text: "ACC",
      margin: EdgeInsets.only(top: 7.v),
    );
  }

  /// Section Widget
  Widget _buildThree(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 11.h),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgPictureReport,
            height: 280.v,
            width: 373.h,
            radius: BorderRadius.vertical(
              top: Radius.circular(15.h),
            ),
          ),
          SizedBox(height: 10.v),
          Padding(
            padding: EdgeInsets.only(
              left: 14.h,
              right: 11.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 26.v,
                  width: 219.h,
                  margin: EdgeInsets.only(bottom: 3.v),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: CustomRadioButton(
                          text: "Bencana Alam",
                          value: "Bencana Alam",
                          groupValue: radioGroup1,
                          onChange: (value) {
                            radioGroup1 = value;
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Bencana alam yang membahayakan",
                          style: CustomTextStyles.labelMediumWhiteA700,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildACC1(context),
              ],
            ),
          ),
          SizedBox(height: 10.v),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAceptbutton1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 26.h,
        right: 11.h,
      ),
      child: CustomTextFormField(
        controller: aceptbuttonController1,
        hintText: "masukkan alasan penolakan",
        alignment: Alignment.center,
        suffix: Container(
          margin: EdgeInsets.fromLTRB(30.h, 11.v, 15.h, 12.v),
          child: CustomImageView(
            imagePath: ImageConstant.imgAceptButton,
            height: 20.adaptSize,
            width: 20.adaptSize,
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 43.v,
        ),
        contentPadding: EdgeInsets.only(
          left: 26.h,
          top: 14.v,
          bottom: 14.v,
        ),
        borderDecoration: TextFormFieldStyleHelper.outlineBlack,
      ),
    );
  }

  /// Section Widget
  Widget _buildACC2(BuildContext context) {
    return CustomElevatedButton(
      width: 65.h,
      text: "ACC",
      margin: EdgeInsets.only(top: 7.v),
    );
  }

  /// Section Widget
  Widget _buildFive(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 11.h),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgPictureReport,
            height: 280.v,
            width: 373.h,
            radius: BorderRadius.vertical(
              top: Radius.circular(15.h),
            ),
          ),
          SizedBox(height: 10.v),
          Padding(
            padding: EdgeInsets.only(
              left: 14.h,
              right: 11.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 26.v,
                  width: 219.h,
                  margin: EdgeInsets.only(bottom: 3.v),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: CustomRadioButton(
                          text: "Bencana Alam",
                          value: "Bencana Alam",
                          groupValue: radioGroup2,
                          onChange: (value) {
                            radioGroup2 = value;
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Bencana alam yang membahayakan",
                          style: CustomTextStyles.labelMediumWhiteA700,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildACC2(context),
              ],
            ),
          ),
          SizedBox(height: 10.v),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAceptbutton2(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 26.h,
        right: 11.h,
      ),
      child: CustomTextFormField(
        controller: aceptbuttonController2,
        hintText: "masukkan alasan penolakan",
        textInputAction: TextInputAction.done,
        alignment: Alignment.center,
        suffix: Container(
          margin: EdgeInsets.fromLTRB(30.h, 11.v, 15.h, 12.v),
          child: CustomImageView(
            imagePath: ImageConstant.imgAceptButton,
            height: 20.adaptSize,
            width: 20.adaptSize,
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 43.v,
        ),
        contentPadding: EdgeInsets.only(
          left: 26.h,
          top: 14.v,
          bottom: 14.v,
        ),
        borderDecoration: TextFormFieldStyleHelper.outlineBlack,
      ),
    );
  }
}
