import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kren/login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  @override
  void initState() {
    super.initState();
    _fetchProvinces();
  }

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
        'https://emsifa.github.io/api-wilayah-indonesia/api/regencies/$provinceId.json',
      ));

      if (response.statusCode == 200) {
        final List<String> regenciesData = List<String>.from(
          (json.decode(response.body) as List<dynamic>).map((regency) {
            return regency["name"].toString();
          }),
        );

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

  Future<void> signUp() async {
    // Validation checks
    if (_conUsername.text.isEmpty ||
        _conEmail.text.isEmpty ||
        _conPassword.text.isEmpty ||
        _conCPassword.text.isEmpty ||
        _selectedProvince.isEmpty ||
        _selectedRegency.isEmpty) {
      // Handle empty fields
      setState(() {
        _usernameNotification =
        _conUsername.text.isEmpty ? "Username is required" : "";
        _emailNotification = _conEmail.text.isEmpty ? "Email is required" : "";
        _passwdNotification =
        _conPassword.text.isEmpty ? "Password is required" : "";
        _cpasswdNotification =
        _conCPassword.text.isEmpty ? "Confirm Password is required" : "";
        _selectedProvince =
        _selectedProvince.isEmpty ? "Please select a province" : "";
        _selectedRegency =
        _selectedRegency.isEmpty ? "Please select a regency" : "";
      });

      // Show a notification indicating that all fields are required
      _showSnackBar("Please fill in all required fields");

      return;
    }

    // Check if passwords match
    if (_conPassword.text != _conCPassword.text) {
      setState(() {
        _cpasswdNotification = "Passwords do not match";
      });

      // Show a notification indicating that passwords do not match
      _showSnackBar("Passwords do not match");

      return;
    }

    // Check if the entered username and email are unique
    if (!await isUsernameUnique(_conUsername.text) ||
        !await isEmailUnique(_conEmail.text)) {
      setState(() {
        _usernameNotification = "Username is already taken";
        _emailNotification = "Email is already registered";
      });

      // Show a notification indicating that username or email is not unique
      _showSnackBar("Username or Email is already taken");

      return;
    }

    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: _conEmail.text,
        password: _conPassword.text,
      );

      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'username': _conUsername.text,
        'email': _conEmail.text,
        'province': _selectedProvince,
        'regency': _selectedRegency,
      });

      print('Registration successful!');
      print('Username: ${_conUsername.text}');
      print('Email: ${_conEmail.text}');
      print('Province: $_selectedProvince');
      print('Regency: $_selectedRegency');

      setState(() {
        _usernameNotification = "";
        _emailNotification = "";
        _passwdNotification = "";
        _cpasswdNotification = "";
        _selectedProvince = "";
        _selectedRegency = "";
      });

      _conUsername.clear();
      _conEmail.clear();
      _conPassword.clear();
      _conCPassword.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print('Error creating account: $e');
    }
  }

  Future<bool> isUsernameUnique(String username) async {
    QuerySnapshot result = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();

    return result.docs.isEmpty;
  }

  Future<bool> isEmailUnique(String email) async {
    QuerySnapshot result = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return result.docs.isEmpty;
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
              _selectedProvinceId = _provinces
                  .firstWhere(
                      (province) => province["name"] == _selectedProvince)["id"];
              _fetchRegencies(_selectedProvinceId);
              _selectedRegency = "";
            });
          },
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget regencyDropdown() {
    List<String> regenciesWithEmpty = [""]..addAll(_regencies);

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
          value: _selectedRegency ?? null,
          items: regenciesWithEmpty.map((regency) {
            return DropdownMenuItem<String>(
              value: regency,
              child: Text(regency),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _selectedRegency = value ?? "";
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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
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
              mainAxisAlignment: MainAxisAlignment.start,
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
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
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
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(),
                  decoration: BoxDecoration(),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      signUp();
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
