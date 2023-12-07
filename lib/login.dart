import 'package:flutter/material.dart';
import 'package:kren/signup.dart';
import 'package:kren/nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _loginInputController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _loginInputError = '';
  String _passwordError = '';
  String _accountNotExistError = '';
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool _isLoading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadRememberMeStatus();
  }

  // Load "Remember Me" status from SharedPreferences
  _loadRememberMeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('rememberMe') ?? false;
      if (_rememberMe) {
        _loginInputController.text = prefs.getString('savedLoginInput') ?? '';
      }
    });
  }

  // Save "Remember Me" status to SharedPreferences
  _saveRememberMeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', _rememberMe);
    if (_rememberMe) {
      prefs.setString('savedLoginInput', _loginInputController.text);
    } else {
      prefs.remove('savedLoginInput');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color(0xFF0095FF);

    ThemeData _themeData = ThemeData(
      primaryColor: primaryColor,
      textTheme: GoogleFonts.poppinsTextTheme(),
    );

    return MaterialApp(
      theme: _themeData,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: 80,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: <Widget>[
                            inputFile(
                              label: "Username or Email",
                              controller: _loginInputController,
                              errorText: _loginInputError,
                            ),
                            SizedBox(height: 20),
                            inputFile(
                              label: "Password",
                              obscureText: !_isPasswordVisible,
                              controller: _passwordController,
                              errorText: _passwordError,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                            ),
                            Text("Remember Me"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: _isLoading
                              ? null
                              : () async {
                            String loginInput = _loginInputController.text;
                            String password = _passwordController.text;

                            setState(() {
                              _loginInputError =
                              loginInput.isEmpty ? "Enter your username or email" : '';
                              _passwordError =
                              password.isEmpty ? "Enter your password" : '';
                              _accountNotExistError = '';
                            });

                            if (_loginInputError.isEmpty &&
                                _passwordError.isEmpty) {
                              try {
                                setState(() {
                                  _isLoading = true;
                                });

                                await _auth.signInWithEmailAndPassword(
                                  email: _loginInputController.text,
                                  password: _passwordController.text,
                                );

                                _saveRememberMeStatus();

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NavPages(),
                                  ),
                                );

                                print("Login successful");
                              } catch (error) {
                                print("Invalid email or password");
                                setState(() {
                                  _accountNotExistError =
                                  "Invalid email or password. Please try again.";
                                });
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            }
                          },
                          color: primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      if (_accountNotExistError.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            _accountNotExistError,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account?"),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(),
                                ),
                              );
                            },
                            child: Text(
                              " Sign Up",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Stack(
                          children: [
                            ClipPath(
                              clipper: CurvedClipper(),
                              child: Container(
                                height: 80,
                                color: primaryColor,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/background.png"),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputFile({
    label,
    obscureText = false,
    TextEditingController? controller,
    errorText,
    Widget? suffixIcon,
  }) {
    controller ??= TextEditingController();

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
            suffixIcon: suffixIcon,
          ),
        ),
        if (errorText != null && errorText.isNotEmpty)
          Text(
            errorText,
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height - 20);
    double midPoint = size.width / 2;
    double controlHeight = 30.0;
    double endPoint = size.width;

    path.quadraticBezierTo(midPoint - controlHeight, size.height, midPoint, size.height - 20);
    path.quadraticBezierTo(midPoint + controlHeight, size.height - 40, endPoint, size.height - 20);
    path.lineTo(endPoint, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
