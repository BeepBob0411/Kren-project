import 'package:flutter/material.dart';
import 'package:kren/login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _conUsername = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();

  bool _passwordVisible = false;
  bool _cPasswordVisible = false;

  String _usernameNotification = "";
  String _emailNotification = "";
  String _passwdNotification = "";
  String _cpasswdNotification = "";

  signUp(BuildContext context) {
    String uname = _conUsername.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;
    String cpasswd = _conCPassword.text;

    String usernameNotificationText = "";
    String emailNotificationText = "";
    String passwdNotificationText = "";
    String cpasswdNotificationText = "";

    if (uname.isEmpty) {
      usernameNotificationText = "Masukkan Username Anda!";
    } else if (email.isEmpty) {
      emailNotificationText = "Masukkan Email Anda!";
    } else if (passwd.isEmpty) {
      passwdNotificationText = "Masukkan Password Anda!";
    } else if (cpasswd.isEmpty || passwd != cpasswd) {
      cpasswdNotificationText = "Password Anda Tidak Sesuai!";
    }

    setState(() {
      _usernameNotification = usernameNotificationText;
      _emailNotification = emailNotificationText;
      _passwdNotification = passwdNotificationText;
      _cpasswdNotification = cpasswdNotificationText;
    });

    if (!_passwordVisible) {
      _conPassword.text = passwd;
    }
    if (!_cPasswordVisible) {
      _conCPassword.text = cpasswd;
    }

    // Add your signup logic here
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
    controller ??= TextEditingController();

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
    _passwordVisible = false;
    _cPasswordVisible = false;

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
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
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
              Column(
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
                  inputFile(
                    label: 'Password',
                    obscureText: _passwordVisible,
                    controller: _conPassword,
                    icon: const Icon(Icons.lock),
                    isPasswordVisible: (isVisible) {
                      setState(() {
                        _passwordVisible = isVisible;
                      });
                    },
                    notificationText: _passwdNotification,
                  ),
                  inputFile(
                    label: 'Confirm Password',
                    obscureText: _cPasswordVisible,
                    controller: _conCPassword,
                    icon: const Icon(Icons.lock_outline),
                    isPasswordVisible: (isVisible) {
                      setState(() {
                        _cPasswordVisible = isVisible;
                      });
                    },
                    notificationText: _cpasswdNotification,
                  ),
                ],
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
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      " Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
