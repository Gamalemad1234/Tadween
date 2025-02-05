import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tadween/Authentication/login_page.dart';
import 'package:tadween/generated/l10n.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  bool isLoading = false;    

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
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
              "${S.of(context).Verification}",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: size.height * .05),
          Image(image: AssetImage("images/4.png"), height: 210),
          SizedBox(height: size.height * .1),
          Center(
            child: isLoading
                ? CircularProgressIndicator(
                    color: Color(0xff50C2C9),
                  )
                : MaterialButton(
                    height: size.width * .13,
                    minWidth: 200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color(0xff50C2C9),
                    onPressed: () async {
                      setState(() {
                        isLoading = true; // إظهار مؤشر التحميل
                      });
                      try {
                        await FirebaseAuth.instance.currentUser!
                            .sendEmailVerification();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                          (route) => false,
                        );
                      } catch (e) {
                          
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Error sending verification email: $e",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      } finally {
                        setState(() {
                          isLoading = false; // إخفاء مؤشر التحميل
                        });
                      }
                    },
                    child: Text(
                      "${S.of(context).Verification}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
