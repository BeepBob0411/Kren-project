// component_signup.dart

import 'package:flutter/material.dart';

class SignupComponents {
  static Widget inputFile({
    required String label,
    required TextEditingController controller,
    required Icon icon,
    required String notificationText,
    bool obscureText = false,
    ValueChanged<bool>? isPasswordVisible,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            prefixIcon: icon,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff5ac18e)),
            ),
            suffixIcon: obscureText
                ? IconButton(
              onPressed: () {
                isPasswordVisible!(obscureText);
              },
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[600],
              ),
            )
                : null,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          notificationText,
          style: TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  static Widget provinceDropdown({
    required List<Map<String, dynamic>> provinces,
    required String selectedProvinceId,
    required String selectedProvince,
    ValueChanged<String?>? onChanged,
  }) {
    List<DropdownMenuItem<String>> items = provinces.map((province) {
      return DropdownMenuItem<String>(
        value: province['id'].toString(),
        child: Text(province['name']),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Province',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        DropdownButtonFormField<String>(
          value: selectedProvinceId.isNotEmpty ? selectedProvinceId : null,
          items: items,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff5ac18e)),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          selectedProvinceId.isEmpty ? 'Please select a province' : '',
          style: TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  static Widget regencyDropdown({
    required List<String> regencies,
    required String selectedRegency,
    ValueChanged<String?>? onChanged,
  }) {
    List<DropdownMenuItem<String>> items = regencies.map((regency) {
      return DropdownMenuItem<String>(
        value: regency,
        child: Text(regency),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Regency',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        DropdownButtonFormField<String>(
          value: selectedRegency.isNotEmpty ? selectedRegency : null,
          items: items,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff5ac18e)),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          selectedRegency.isEmpty ? 'Please select a regency' : '',
          style: TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}


