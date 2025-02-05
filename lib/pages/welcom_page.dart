// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:tadween/Authentication/signup_page.dart';
import 'package:tadween/generated/l10n.dart';

class WelcomPage extends StatefulWidget {
  const WelcomPage({super.key});

  @override
  State<WelcomPage> createState() => _WelcomPageState();
}

class _WelcomPageState extends State<WelcomPage> {
  @override
  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               Image(image: Localizations.localeOf(context).languageCode == "en" 
               ?AssetImage("images/2.png")
               :
               AssetImage("images/2r.png")
               
               , height: 200,)
              ],
            ),
            Center(child: Image(image: AssetImage("images/1.png") , height: 250,)),
        
            SizedBox(height: size.height*.025),
        
            Text("${S.of(context).welcom0Title}" , style: TextStyle(fontSize: 22 , fontWeight: FontWeight.bold , color: Colors.white) ,),
        
            SizedBox(height: size.height*.075,),
        
            Text("${S.of(context).welcom1Title}" ,
            style: TextStyle(fontSize: 18 , color: Colors.white),),
            Text("${S.of(context).welcom2Title}" ,
            style: TextStyle(fontSize: 18 , color: Colors.white),),
            Text("${S.of(context).welcom3Title}" ,
            style: TextStyle(fontSize: 18 , color: Colors.white),),
            Text("${S.of(context).welcom4Title}" ,
            style: TextStyle(fontSize: 18 , color: Colors.white),),
            
            SizedBox(height: size.height*.075,),
        
            MaterialButton(
              height: size.width*.13,
              minWidth: 200,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: Color(0xff50C2C9),
              onPressed: (){
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SignupPage(),), (route) => false,);
              } , child:
               Text("${S.of(context).started}" , style: TextStyle(color: Colors.white , fontSize: 20),),),
            
        
        
        
          ],
        ),
      ),
    );
  }
}