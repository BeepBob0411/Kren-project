import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _conUsername = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();

  String _usernameNotification = "";
  String _emailNotification = "";
  String _passwdNotification = "";
  String _cpasswdNotification = "";
  String _selectedProvinceId = "";
  String _selectedProvince = "";
  String _selectedRegency = "";

  List<Map<String, dynamic>> _provinces = [];
  List<String> _regencies = [];

  Future<void> _fetchProvinces() async {
    try {
      final response = await http.get(Uri.parse(
          'https://emsifa.github.io/api-wilayah-indonesia/api/provinces.json'));

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> provincesData =
            List<Map<String, dynamic>>.from(
          (json.decode(response.body) as List<dynamic>).map((province) {
            return {
              "name": province["name"],
              "id": province["id"],
            };
          }),
        );

        setState(() {
          _provinces = provincesData;
        });
      } else {
        print('Failed to load provinces');
      }
    } catch (error) {
      print('Error fetching provinces: $error');
    }
  }

  Future<void> _fetchRegencies(String provinceId) async {
    try {
      final response = await http.get(Uri.parse(
          'https://emsifa.github.io/api-wilayah-indonesia/api/regencies/$provinceId.json'));

      if (response.statusCode == 200) {
        final List<String> regenciesData =
            List<String>.from(json.decode(response.body));

        setState(() {
          _regencies = regenciesData;
        });
      } else {
        print('Failed to load regencies');
      }
    } catch (error) {
      print('Error fetching regencies: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProvinces();
  }

  signUp(BuildContext context) {
    // Add your signup logic here
  }

  Widget provinceDropdown() {
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
        SizedBox(height: 5),
        DropdownButton<String>(
          isExpanded: true,
          value: _selectedProvince.isNotEmpty ? _selectedProvince : null,
          items: _provinces.map((province) {
            return DropdownMenuItem<String>(
              value: province["name"],
              child: Text(province["name"]),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _selectedProvince = value ?? "";
              _selectedProvinceId = _provinces.firstWhere(
                  (province) => province["name"] == _selectedProvince)["id"];
              _fetchRegencies(_selectedProvinceId);
            });
          },
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget regencyDropdown() {
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
        SizedBox(height: 5),
        DropdownButton<String>(
          isExpanded: true,
          value: _selectedRegency,
          items: _regencies.map((regency) {
            return DropdownMenuItem<String>(
              value: regency,
              child: Text(regency),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _selectedRegency = value!;
            });
          },
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget inputFile({
    String? label,
    bool obscureText = false,
    TextEditingController? controller,
    Widget? icon,
    double? size,
    Color? color,
    TextInputType? inputType,
    String? hintName,
    Function(bool isVisible)? isPasswordVisible,
    String? notificationText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label ?? "",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            prefixIcon: icon != null
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: icon,
                  )
                : null,
            hintText: hintName,
            suffixIcon: isPasswordVisible != null
                ? IconButton(
                    onPressed: () {
                      isPasswordVisible(!obscureText);
                    },
                    icon: obscureText
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                    color: Colors.grey,
                  )
                : null,
          ),
        ),
        if (notificationText != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
            child: Text(
              notificationText,
              style: TextStyle(color: Colors.red),
            ),
          ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create an account, It's free ",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      inputFile(
                        label: 'Username',
                        controller: _conUsername,
                        icon: const Icon(Icons.person),
                        notificationText: _usernameNotification,
                      ),
                      inputFile(
                        label: 'Email',
                        controller: _conEmail,
                        icon: const Icon(Icons.email),
                        notificationText: _emailNotification,
                      ),
                      provinceDropdown(),
                      regencyDropdown(),
                      inputFile(
                        label: 'Password',
                        obscureText: false,
                        controller: _conPassword,
                        icon: const Icon(Icons.lock),
                        notificationText: _passwdNotification,
                      ),
                      inputFile(
                        label: 'Confirm Password',
                        obscureText: false,
                        controller: _conCPassword,
                        icon: const Icon(Icons.lock_outline),
                        notificationText: _cpasswdNotification,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(),
                  decoration: BoxDecoration(),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      signUp(context);
                    },
                    color: Color(0xff0095FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
