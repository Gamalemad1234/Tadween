import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tadween/pages/welcom_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: size.width * 0.88,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 30, 30, 30),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             

             Center(child: Text("Communication to help" , style: TextStyle(
              color: Colors.white,
              fontSize: 20,
             ),),),

              const SizedBox(height: 10),

              // البريد الإلكتروني
              InkWell(
                onTap: () {
                   final Uri emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: 'emadg6139@gmail.com',
                              );
                            launchUrl(emailLaunchUri);
                },
                child: Card(
                  color: Colors.black,
                  child: Row(
                    children: [
                      const Icon(Icons.email, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        "emadg6139@gmail.com",
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                   
                      
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // رقم الهاتف
              InkWell(
                onTap: () {
                    final Uri phoneNumber = Uri(
                                scheme: 'tel',
                               path: '01019649483',
                               );
                                launchUrl(phoneNumber);
                },
                child: Card(
                  color: Colors.black,
                  child: Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        "01019649483",
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // زر تسجيل الخروج
              ElevatedButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const WelcomPage(),),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text("Log Out"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 164, 164, 164),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
