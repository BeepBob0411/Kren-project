import 'package:flutter/material.dart';

class Screen5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Tambahkan logika untuk menangani tombol pengaturan di sini
              showSettingsMenu(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth,
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80.0,
                    backgroundImage: NetworkImage('URL_FOTO_USER'),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Nama Pengguna',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text('Lokasi Pengguna', style: TextStyle(color: Colors.white)),
                  Text('Email Pengguna', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            // Teks "Tentang" dan "BNPB" berada di kiri
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Tentang',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(width: 4.0),
                Text(
                  'BNPB',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.orange),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            // Container box baru dengan informasi pengguna (warna putih)
            Container(
              width: screenWidth * 0.9, // Mengisi 90% lebar layar
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.symmetric(horizontal: (screenWidth * 0.1) / 2), // Margin sesuai lebar yang diisi
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Menambahkan garis pinggir
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Badan Nasional Penanggulangan Bencana',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 12.0),
                  CircleAvatar(
                    radius: 60.0, // Mengurangi ukuran foto
                    backgroundImage: NetworkImage('URL_FOTO_USER'),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            // Kelima container box untuk struktur organisasi
            buildOrganizationalProfile(
              screenWidth,
              'URL_FOTO_ORG_1',
              'Nama Pemilik Foto 1',
              'Posisi Pemilik Foto 1',
            ),
            buildOrganizationalProfile(
              screenWidth,
              'URL_FOTO_ORG_2',
              'Nama Pemilik Foto 2',
              'Posisi Pemilik Foto 2',
            ),
            buildOrganizationalProfile(
              screenWidth,
              'URL_FOTO_ORG_3',
              'Nama Pemilik Foto 3',
              'Posisi Pemilik Foto 3',
            ),
            buildOrganizationalProfile(
              screenWidth,
              'URL_FOTO_ORG_4',
              'Nama Pemilik Foto 4',
              'Posisi Pemilik Foto 4',
            ),
            buildOrganizationalProfile(
              screenWidth,
              'URL_FOTO_ORG_5',
              'Nama Pemilik Foto 5',
              'Posisi Pemilik Foto 5',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOrganizationalProfile(double screenWidth, String imageUrl, String ownerName, String ownerPosition) {
    return Container(
      width: screenWidth * 0.9,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(horizontal: (screenWidth * 0.1) / 2, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Foto di kiri container box
          CircleAvatar(
            radius: 40.0,
            backgroundImage: NetworkImage(imageUrl),
          ),
          SizedBox(width: 16.0), // Memberikan jarak antara foto dan teks
          // Teks sejajar dengan foto
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ownerName,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                ownerPosition,
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showSettingsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Change Profile'),
              onTap: () {
                // Tambahkan logika untuk mengganti profil di sini
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Log Out'),
              onTap: () {
                // Tambahkan logika untuk log out di sini
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }
}
