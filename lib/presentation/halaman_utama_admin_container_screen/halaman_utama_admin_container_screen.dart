import 'package:flutter/material.dart';
import 'package:kren/core/app_export.dart';
import 'package:kren/presentation/halaman_utama_admin_page/halaman_utama_admin_page.dart';
import 'package:kren/widgets/custom_bottom_app_bar.dart';

// ignore_for_file: must_be_immutable
class HalamanUtamaAdminContainerScreen extends StatelessWidget {
  HalamanUtamaAdminContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: Navigator(
                key: navigatorKey,
                initialRoute: AppRoutes.halamanUtamaAdminPage,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name!),
                    transitionDuration: Duration(seconds: 0))),
            bottomNavigationBar: _buildEight(context),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked));
  }

  /// Section Widget
  Widget _buildEight(BuildContext context) {
    return CustomBottomAppBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return "/";
      case BottomBarEnum.Laporan:
        return AppRoutes.halamanUtamaAdminPage;
      case BottomBarEnum.Data:
        return "/";
      case BottomBarEnum.Setting:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.halamanUtamaAdminPage:
        return HalamanUtamaAdminPage();
      default:
        return DefaultWidget();
    }
  }
}
