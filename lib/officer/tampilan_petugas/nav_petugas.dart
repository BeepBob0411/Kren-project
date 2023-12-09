import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:kren/screen/onboarding/screen_one.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(const NavPagesPetugas());
}

class NavPagesPetugas extends StatelessWidget {
  const NavPagesPetugas({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _isFirstTimeUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            bool isFirstTimeUser = snapshot.data as bool;

            if (isFirstTimeUser) {
              // New user, show onboarding screen one
              return OnboardingScreenOne();
            } else {
              // Returning user, navigate to home screen
              return _buildNavPagesPetugas(context);
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildNavPagesPetugas(BuildContext context) {
    return PersistentTabView(
      context,
      controller: PersistentTabController(initialIndex: 0),
      screens: _buildScreens(),
      items: _navBarsItems(context),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 0.5, blurRadius: 0.7)],
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }

  List<Widget> _buildScreens() {
    return [
      ReportReception(),
      Container(),
      Container(),
      Container(),
      Container(), // Add other screens as needed
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Data",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.data_usage),
        title: "Berita",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.report),
        title: "Lapor",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.security),
        title: "Mitigasi",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: "Setting",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  Future<bool> _isFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTimeUser = prefs.getBool('firstTimeUser') ?? true;

    if (isFirstTimeUser) {
      prefs.setBool('firstTimeUser', false);
    }

    return isFirstTimeUser;
  }
}

class ReportReception extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laporan Diterima"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('reports').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    String imageUrl = data['imageUrl'] ?? '';

                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text("Jenis Bencana: ${data['jenisBencana']}"),
                        subtitle: Text("Nama Bencana: ${data['namaBencana']}"),
                        leading: imageUrl.isNotEmpty
                            ? Hero(
                                tag: 'imageHero_$imageUrl',
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              )
                            : Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey[300],
                                child: Icon(Icons.image, color: Colors.grey[600]),
                              ),
                        onTap: () {
                          _showReportDetails(context, data, document.id, imageUrl);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showReportDetails(BuildContext context, Map<String, dynamic> data, String documentId, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Detail Laporan"),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Jenis Bencana: ${data['jenisBencana']}"),
                Text("Nama Bencana: ${data['namaBencana']}"),
                Text("Lokasi Bencana: ${data['lokasiBencana'] ?? ''}"),
                Text("Keterangan Bencana: ${data['keteranganBencana'] ?? ''}"),
                imageUrl.isNotEmpty
                    ? Hero(
                        tag: 'imageHero_$imageUrl',
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _approveReport(documentId);
                Navigator.pop(context);
              },
              child: Text("Approve"),
            ),
            ElevatedButton(
              onPressed: () {
                _rejectReport(documentId);
                Navigator.pop(context);
              },
              child: Text("Reject"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  void _approveReport(String documentId) {
    // Implement logic for approving a report
  }

  void _rejectReport(String documentId) {
    // Implement logic for rejecting a report
  }
}
