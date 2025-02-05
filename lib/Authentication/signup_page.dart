// ignore_for_file: body_might_complete_normally_nullable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tadween/Authentication/Verification_page.dart';
import 'package:tadween/Authentication/login_page.dart';
import 'package:tadween/generated/l10n.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> Global = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: Global,
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
                )
              ],
            ),
            SizedBox(height: size.height * .080),
            Center(
              child: Text(
                "${S.of(context).signUp1}",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(height: size.height * .01),
            Center(
              child: Text(
                "${S.of(context).signUp2}",
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: size.height * .025),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).empty;
                  }
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(139, 228, 221, 221),
                    hintText: "${S.of(context).Name}",
                    hintStyle: TextStyle(
                        color: const Color.fromARGB(255, 240, 235, 235)),
                    prefixIcon: Icon(Icons.nest_cam_wired_stand_rounded),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
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
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(139, 228, 221, 221),
                    hintText: "${S.of(context).email}",
                    hintStyle: TextStyle(
                        color: const Color.fromARGB(255, 240, 235, 235)),
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    )),
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
                  if (value.length < 6) {
                    return S.of(context).lessPassword;
                  }
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(139, 228, 221, 221),
                    hintText: "${S.of(context).password}",
                    hintStyle: TextStyle(
                        color: const Color.fromARGB(255, 240, 235, 235)),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          selected = !selected;
                        });
                      },
                      icon: Icon(
                          selected ? Icons.visibility_off : Icons.visibility),
                    ),
                    prefixIcon: Icon(Icons.admin_panel_settings_sharp),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            SizedBox(height: size.height * .025),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.white),
                controller: phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).empty;
                  }
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(139, 228, 221, 221),
                    hintText: "${S.of(context).phone}",
                    hintStyle: TextStyle(
                        color: const Color.fromARGB(255, 240, 235, 235)),
                    prefixIcon: Icon(Icons.phone_iphone_rounded),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            SizedBox(height: size.height * .075),
            Center(
              child: MaterialButton(
                height: size.width * .13,
                minWidth: 200,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color(0xff50C2C9),
                onPressed: () async {
                  if (Global.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => VerificationPage(),
                        ),
                        (route) => false,
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(S.of(context).error),
                            content: Text(
                                "The password provided is too weak."),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(),
                                child: Text(S.of(context).ok),
                              ),
                            ],
                          ),
                        );
                      } else if (e.code == 'email-already-in-use') {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(S.of(context).error),
                            content: Text(
                                "The account already exists for that email."),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(),
                                child: Text(S.of(context).ok),
                              ),
                            ],
                          ),
                        );
                      }
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(S.of(context).error),
                          content: Text(
                              "An unexpected error occurred."),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(context).pop(),
                              child: Text(S.of(context).ok),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  "${S.of(context).register}",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: size.height * .050),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${S.of(context).Haveaccount}",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Text(
                    "${S.of(context).signIn}",
                    style: TextStyle(
                        color: Color(0xff50C2C9), fontSize: 20),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
