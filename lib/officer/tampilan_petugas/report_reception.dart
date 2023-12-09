import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
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
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        )
                      : Container(width: 50, height: 50), // Placeholder if no image
                  onTap: () {
                    _showReportDetails(context, data, document.id, imageUrl);
                  },
                ),
              );
            }).toList(),
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
    print("Report approved: $documentId");
  }
}
