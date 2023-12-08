import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:kren/constants/location_picker_map.dart';
import 'package:permission_handler/permission_handler.dart';

enum JenisBencana { alam, nonAlam }

extension JenisBencanaExtension on JenisBencana {
  String get name {
    switch (this) {
      case JenisBencana.alam:
        return 'Alam';
      case JenisBencana.nonAlam:
        return 'Non Alam';
      default:
        throw ArgumentError('Unsupported JenisBencana: $this');
    }
  }
}

class LaporkanKejadian extends StatefulWidget {
  @override
  _LaporkanKejadianState createState() => _LaporkanKejadianState();
}

class _LaporkanKejadianState extends State<LaporkanKejadian> {
  final _namaBencanaController = TextEditingController();
  final _lokasiBencanaController = TextEditingController();
  final _keteranganBencanaController = TextEditingController();
  File? _image;
  JenisBencana? _selectedJenisBencana;
  bool _isSubmitting = false;

  LatLng? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laporkan Kejadian"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              SizedBox(height: 16.0),
              _buildDropdown(),
              SizedBox(height: 16.0),
              _buildTextField(
                _namaBencanaController,
                "Nama Bencana",
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                _lokasiBencanaController,
                "Lokasi Bencana",
                readOnly: true,
                onTap: () => _pickLocation(context),
              ),
              SizedBox(height: 16.0),
              // Display selected location
              if (_selectedLocation != null)
                Text(
                  "Selected Location: Lat: ${_selectedLocation!.latitude}, Lng: ${_selectedLocation!.longitude}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              SizedBox(height: 16.0),
              _buildTextField(
                _keteranganBencanaController,
                "Keterangan Bencana",
              ),
              SizedBox(height: 16.0),
              _buildImageSelection(),
              SizedBox(height: 16.0),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Laporkan Kejadian",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Bencana",
          style: TextStyle(
            fontSize: 20,
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonFormField(
        value: _selectedJenisBencana,
        hint: Text("Pilih Jenis Bencana"),
        items: JenisBencana.values
            .map((e) => DropdownMenuItem(
          value: e,
          child: Text(e.name),
        ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedJenisBencana = value;
          });
        },
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText,
      {bool readOnly = false, Function()? onTap}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: controller,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }

  Future<void> _pickLocation(BuildContext context) async {
    LatLng? pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerMap(),
      ),
    );

    if (pickedLocation != null) {
      setState(() {
        _selectedLocation = pickedLocation;
        _lokasiBencanaController.text =
        "Lat: ${pickedLocation.latitude}, Lng: ${pickedLocation.longitude}";
      });
    }
  }

  Widget _buildImageSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _image != null
            ? Image.file(
          _image!,
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        )
            : Container(),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () async {
                final ImageSource source = ImageSource.camera;
                final XFile? image =
                await ImagePicker().pickImage(source: source);

                if (image != null) {
                  setState(() {
                    _image = File(image.path);
                  });
                }
              },
              child: Text("Pilih Gambar dari Kamera"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _isSubmitting ? null : () => _submitReport(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: EdgeInsets.all(16.0),
      ),
      child: _isSubmitting
          ? CircularProgressIndicator(color: Colors.white)
          : Text(
        'Lapor',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }

  bool _validateForm() {
    if (_selectedJenisBencana == null ||
        _namaBencanaController.text.isEmpty ||
        _lokasiBencanaController.text.isEmpty ||
        _keteranganBencanaController.text.isEmpty ||
        _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Harap lengkapi semua field dan pilih gambar"),
        ),
      );
      return false;
    }
    return true;
  }

  void _submitReport() async {
    if (_validateForm()) {
      setState(() {
        _isSubmitting = true;
      });

      // Memeriksa dan meminta izin
      var status = await Permission.location.request();

      if (status == PermissionStatus.granted) {
        // Izin diberikan, lanjutkan dengan logika pengiriman laporan
        // Simulate submission delay
        Future.delayed(Duration(seconds: 2), () {
          // Actual logic for submitting the report to the server
          print('Data Terkirim!');

          // Reset the form and loading state
          _resetForm();
        });
      } else {
        // Izin tidak diberikan
        print('Location permission denied.');

        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _resetForm() {
    setState(() {
      _isSubmitting = false;
      _selectedJenisBencana = null;
      _namaBencanaController.clear();
      _lokasiBencanaController.clear();
      _keteranganBencanaController.clear();
      _image = null;
      _selectedLocation = null;
    });
  }
}

void main() {
  runApp(MaterialApp(
    home: LaporkanKejadian(),
  ));
}
