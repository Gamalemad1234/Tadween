import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tadween/Authentication/signup_page.dart';
import 'package:tadween/generated/l10n.dart';
import 'package:tadween/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> globalKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool selected = false;

  // Function to show loading dialog
  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing dialog by tapping outside
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // Function to show error dialog
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).errorTitle),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(S.of(context).ok),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Form(
        key: globalKey,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(
                  image: Localizations.localeOf(context).languageCode == "en"
                      ? AssetImage("images/2.png")
                      : AssetImage("images/2r.png"),
                  height: 200,
                ),
              ],
            ),
            SizedBox(height: size.height * .055),
            Center(
              child: Text(
                "${S.of(context).signInTitel}",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: size.height * .05),
            Image(image: AssetImage("images/3.png"), height: 210),
            SizedBox(height: size.height * .025),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: email,
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).empty;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(139, 228, 221, 221),
                  hintText: "${S.of(context).email}",
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 240, 235, 235),
                  ),
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * .025),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                obscureText: selected,
                style: TextStyle(color: Colors.white),
                controller: password,
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).empty;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(139, 228, 221, 221),
                  hintText: "${S.of(context).password}",
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 240, 235, 235),
                  ),
                  prefixIcon: Icon(Icons.admin_panel_settings_sharp),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        selected = !selected;
                      });
                    },
                    icon: Icon(
                        selected ? Icons.visibility_off : Icons.visibility),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * .025),
            Center(
              child: MaterialButton(
                height: size.width * .13,
                minWidth: 200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Color(0xff50C2C9),
                onPressed: () async {
                  if (globalKey.currentState!.validate()) {
                    showLoadingDialog(); // Show loading indicator
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                      Navigator.of(context).pop(); // Close loading dialog
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false,
                      );
                    } on FirebaseAuthException catch (e) {
                      Navigator.of(context).pop(); // Close loading dialog
                      if (e.code == 'user-not-found') {
                        showErrorDialog(
                            "No user found for that email."); // Error dialog
                      } else if (e.code == 'wrong-password') {
                        showErrorDialog(
                            "Wrong password provided for that user."); // Error dialog
                      }
                    }
                  }
                },
                child: Text(
                  "${S.of(context).signIn}",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
             SizedBox(height: size.height * .025),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${S.of(context).dontHave}",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => SignupPage(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Text(
                      "${S.of(context).signUp}",
                      style: TextStyle(
                          color: Color(0xff50C2C9), fontSize: 20),
                    ),
                  ),
                ],
              ),
            )
          ],
        

        ),
      ),
    );
  }
}




/**
            SizedBox(height: size.height*.025,),
            Center(
              child: Text("${S.maybeOf(context)?.forgotPassword}", style: TextStyle(
                                         color: Color(0xff50C2C9),
                                         fontSize: 20
                                       ),),
            ), */