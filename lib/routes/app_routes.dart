import 'package:flutter/material.dart';
import 'package:kren/presentation/halaman_utama_admin_container_screen/halaman_utama_admin_container_screen.dart';
import 'package:kren/presentation/laporan_bencana_admin_screen/laporan_bencana_admin_screen.dart';
import 'package:kren/presentation/laporan_bencana_admin_one_screen/laporan_bencana_admin_one_screen.dart';
// import 'package:kren/presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String halamanUtamaAdminPage = '/halaman_utama_admin_page';

  static const String halamanUtamaAdminContainerScreen =
      '/halaman_utama_admin_container_screen';

  static const String laporanBencanaAdminScreen =
      '/laporan_bencana_admin_screen';

  static const String laporanBencanaAdminOneScreen =
      '/laporan_bencana_admin_one_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    halamanUtamaAdminContainerScreen: (context) =>
        HalamanUtamaAdminContainerScreen(),
    laporanBencanaAdminScreen: (context) => LaporanBencanaAdminScreen(),
    laporanBencanaAdminOneScreen: (context) => LaporanBencanaAdminOneScreen(),
    // appNavigationScreen: (context) => AppNavigationScreen()
  };
}
