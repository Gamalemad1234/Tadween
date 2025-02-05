import 'package:flutter/material.dart';
import 'package:tadween/pages/page/add_page.dart';
import 'package:tadween/pages/page/display_page.dart';
import 'package:tadween/pages/page/favourit_page.dart';
import 'package:tadween/pages/page/search_page.dart';
import 'package:tadween/pages/page/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   int current = 0;
   List pages = 
   [
     DisplayPage(),
     AddPage(),
     SearchPage(),
     FavouritPage(),
     SettingPage(),
   ];

  @override
  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
       floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
     floatingActionButtonAnimator:FloatingActionButtonAnimator.scaling ,
     floatingActionButton:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          // padding: EdgeInsets.symmetric(vertical: 10),
          height: size.height*.10,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BottomNavigationBar(
                type:BottomNavigationBarType.shifting,
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                mouseCursor: MouseCursor.uncontrolled,
                
                landscapeLayout:BottomNavigationBarLandscapeLayout.linear,
                elevation: 20,
                unselectedIconTheme: IconThemeData(color: const Color.fromARGB(113, 158, 158, 158) , size: 35),               
                selectedIconTheme: IconThemeData(color: const Color.fromARGB(255, 255, 255, 255),size: 30),
                currentIndex: current,
                iconSize: 30,
                
                onTap: (index) {
                  setState(() {
                    current = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    backgroundColor: const Color.fromARGB(173, 0, 0, 0),
                    icon: Icon(Icons.home,size: 40,),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                     backgroundColor: const Color.fromARGB(137, 0, 0, 0),
                    icon: Icon(Icons.add_box,size: 40,),
                    label: '',
                  ), BottomNavigationBarItem(
                     backgroundColor: const Color.fromARGB(137, 0, 0, 0),
                    icon: Icon(Icons.search , size: 40,),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                     backgroundColor:  const Color.fromARGB(173, 0, 0, 0),
                    icon: Icon(Icons.favorite,size: 40,),
                    label: '',
                  ),
                   BottomNavigationBarItem(
                     backgroundColor:  const Color.fromARGB(173, 0, 0, 0),
                    icon: Icon(Icons.settings,size: 40,),
                    label: '',
                  ),
                 
                ],
              ),
            ),
          ),
        ),
     ),
     body: pages[current],
    );
  }
}