import 'package:flutter/material.dart';
import 'package:kren/routes/app_routes.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: SizedBox(
          width: MyUtils.h(375, context),
          child: Column(
            children: [
              _buildAppNavigation(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          context,
                          screenTitle: "Halaman Utama Admin - Container",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.halamanUtamaAdminContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Laporan Bencana Admin",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.laporanBencanaAdminScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Laporan Bencana Admin One",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.laporanBencanaAdminOneScreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(height: MyUtils.v(10, context)),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MyUtils.h(20, context)),
              child: Text(
                "App Navigation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: MyUtils.fSize(20, context),
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: MyUtils.v(10, context)),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: MyUtils.h(20, context)),
              child: Text(
                "Check your app's UI from the below demo screens of your app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF888888),
                  fontSize: MyUtils.fSize(16, context),
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: MyUtils.v(5, context)),
          Divider(
            height: MyUtils.v(1, context),
            thickness: MyUtils.v(1, context),
            color: Color(0xFF000000),
          ),
        ],
      ),
    );
  }

  Widget _buildScreenTitle(
      BuildContext context, {
        required String screenTitle,
        required Function onTapScreenTitle,
      }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(height: MyUtils.v(10, context)),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MyUtils.h(20, context)),
                child: Text(
                  screenTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: MyUtils.fSize(20, context),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: MyUtils.v(10, context)),
            SizedBox(height: MyUtils.v(5, context)),
            Divider(
              height: MyUtils.v(1, context),
              thickness: MyUtils.v(1, context),
              color: Color(0xFF888888),
            ),
          ],
        ),
      ),
    );
  }

  void onTapScreenTitle(
      BuildContext context,
      String routeName,
      ) {
    Navigator.pushNamed(context, routeName);
  }
}

class MyUtils {
  static double h(double value, BuildContext context) {
    return MediaQuery.of(context).size.width * (value / 375.0);
  }

  static double v(double value, BuildContext context) {
    return MediaQuery.of(context).size.height * (value / 812.0);
  }

  static double fSize(double value, BuildContext context) {
    return MediaQuery.of(context).textScaleFactor * value;
  }
}
