import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

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

          return ListView.builder(
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
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: imageUrl.isNotEmpty
                            ? CachedNetworkImageProvider(imageUrl)
                            : AssetImage('assets/placeholder_image.png') as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  onTap: () {
                    _showReportDetails(context, data, document.id, imageUrl);
                  },
                ),
              );
            },
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
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jenis Bencana: ${data['jenisBencana']}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 12),
                Text("Nama Bencana: ${data['namaBencana']}"),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    if (data['latitude'] != null && data['longitude'] != null) {
                      _openGoogleMaps(data['latitude']?.toDouble(), data['longitude']?.toDouble());
                    }
                  },
                  child: Text(
                    "Lokasi Bencana: ${data['lokasiBencana'] ?? ''} (Klik untuk buka Google Maps)",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text("Keterangan Bencana: ${data['keteranganBencana'] ?? ''}"),
                SizedBox(height: 24),
                imageUrl.isNotEmpty
                    ? Hero(
                  tag: 'imageHero_$imageUrl',
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
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
    FirebaseFirestore.instance.collection('reports').doc(documentId).delete();
  }

  void _openGoogleMaps(double? latitude, double? longitude) async {
    if (latitude != null && longitude != null) {
      String url = "https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print("Could not launch Google Maps");
      }
    }
  }
}
