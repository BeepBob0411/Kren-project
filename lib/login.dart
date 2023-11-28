import 'package:flutter/material.dart';
import 'package:kren/signup.dart';
import 'package:kren/nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Login to your account",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      )
                    ],
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
                        inputFile(
                          label: "Password",
                          obscureText: true,
                          controller: _passwordController,
                          errorText: _passwordError,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.only(),
                      decoration: BoxDecoration(),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () async {
                          String loginInput = _loginInputController.text;
                          String password = _passwordController.text;

                          setState(() {
                            _loginInputError =
                            loginInput.isEmpty ? "Enter your username or email" : '';
                            _passwordError = password.isEmpty ? "Enter your password" : '';
                            _accountNotExistError = ''; // Clear previous error
                          });

                          if (_loginInputError.isEmpty && _passwordError.isEmpty) {
                            bool loginSuccess = false;
                            bool accountExists = false;

                            // Check if the login input looks like an email
                            bool isEmail = loginInput.contains('@');

                            UserCredential? userCredential;

                            try {
                              if (isEmail) {
                                // Use email for authentication
                                userCredential = await _auth.signInWithEmailAndPassword(
                                  email: loginInput,
                                  password: password,
                                );
                              } else {
                                // Use username for authentication
                                // Implement your own logic to check existence by username
                                accountExists = await checkAccountExistenceByUsername(loginInput);

                                if (accountExists) {
                                  // If account exists, try to sign in with email
                                  // You may need to store user emails in a separate field in your database
                                  String userEmail = await getUserEmailByUsername(loginInput);
                                  userCredential = await _auth.signInWithEmailAndPassword(
                                    email: userEmail,
                                    password: password,
                                  );
                                }
                              }

                              if (userCredential?.user != null) {
                                // Authentication successful
                                loginSuccess = true;

                                // Retrieve additional user data from Firestore
                                DocumentSnapshot userDoc = await _firestore
                                    .collection('users')
                                    .doc(userCredential!.user!.uid)
                                    .get();

                                if (userDoc.exists) {
                                  String userEmail = userDoc['email'];
                                  String username = userDoc['username'];

                                  print('User Email: $userEmail');
                                  print('Username: $username');
                                }
                              }
                            } catch (e) {
                              // Handle authentication failure
                              print('Authentication failed: $e');
                              setState(() {
                                _accountNotExistError = "Invalid credentials. Please try again.";
                              });
                            }

                            if (loginSuccess) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavPages(),
                                ),
                              );
                            }
                          }
                        },
                        color: Color(0xff0095FF),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 60),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
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
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 100),
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Function to check if the account exists by username
  Future<bool> checkAccountExistenceByUsername(String username) async {
    // Implement your logic to check if the account exists by username
    // Return true if the account exists, false otherwise
    // This is a placeholder function, replace it with your actual implementation
    return false;
  }

  // Function to get user email by username
  Future<String> getUserEmailByUsername(String username) async {
    // Implement your logic to retrieve the user email by username from your database
    // This is a placeholder function, replace it with your actual implementation
    return '';
  }

  Widget inputFile({
    label,
    obscureText = false,
    TextEditingController? controller,
    errorText,
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
