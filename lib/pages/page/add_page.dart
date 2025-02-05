// ignore_for_file: unused_element

import 'package:clay_containers/widgets/clay_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tadween/generated/l10n.dart';
import 'package:tadween/pages/home_page.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  DateTime dateTime = DateTime.now();
  GlobalKey<FormState> Global = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  Color selectedColor = Colors.white; // 🟢 لون الملاحظة الافتراضي

  @override
  Widget build(BuildContext context) {
    CollectionReference notes = FirebaseFirestore.instance.collection('notes');

    Future<void> addNotes() {
      DateTime now = DateTime.now();
      String formattedDate = "${now.year}-${now.month}-${now.day}";
      String formattedTime = DateFormat('h:mm a').format(now);

      return notes
          .add({
            'title': title.text,
            'content': content.text,
            'id': FirebaseAuth.instance.currentUser!.uid,
            'phone': FirebaseAuth.instance.currentUser!.phoneNumber,
            'createdAt': FieldValue.serverTimestamp(),
            'date': formattedDate,
            'time': formattedTime,
            'name': FirebaseAuth.instance.currentUser!.displayName,
            'color': selectedColor.value, // 🟢 تخزين اللون هنا
          })
          .then((value) => print("Note Added"))
          .catchError((error) => print("Failed to add note: $error"));
    }

    Widget buildColorPicker() {
      List<Color> colors = [
        Colors.blue,
        Colors.green,
        Colors.deepPurpleAccent,
        Colors.orange.shade600,
        const Color.fromARGB(80, 104, 20, 119),
        const Color.fromARGB(177, 104, 15, 121),
        const Color.fromARGB(4, 0, 0, 0),Colors.red.shade300,
        const Color.fromARGB(88, 33, 79, 243),
        const Color.fromARGB(53, 76, 175, 79),
        const Color.fromARGB(56, 124, 77, 255),
        const Color(0x50FB8A00),
        Colors.purple,
        Colors.white10,
        const Color.fromARGB(139, 94, 37, 4)
      ];

      return Wrap(
        spacing: 8,
        children: colors.map((color) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedColor = color;
              });
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selectedColor == color ? Colors.white : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
          );
        }).toList(),
      );
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: Global,
        child: Container(
          color: Colors.black,
          child: Center(
            child: ClayContainer(
              color: const Color.fromARGB(255, 8, 2, 2),
              height: size.height * .88,
              width: size.width * .88,
              child: Column(
                children: [
                  SizedBox(height: size.height * .025),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: title,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).empty;
                        }
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(139, 228, 221, 221),
                          hintText: "${S.of(context).Title}",
                          hintStyle: TextStyle(color: const Color.fromARGB(255, 240, 235, 235)),
                          prefixIcon: Icon(Icons.text_fields_outlined),
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
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      minLines: 2,
                      maxLines: 6,
                      style: TextStyle(color: Colors.white),
                      controller: content,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).empty;
                        }
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(139, 228, 221, 221),
                          hintText: "${S.of(context).Content}",
                          hintStyle: TextStyle(color: const Color.fromARGB(255, 240, 235, 235)),
                          prefixIcon: Icon(Icons.content_paste),
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
                  SizedBox(height: 15),
                  Text("Select the Color", style: TextStyle(color: Colors.white, fontSize: 16)),
                  SizedBox(height: 10),
                  buildColorPicker(), // 🟢 عرض أداة اختيار اللون
                  SizedBox(height: 25),
                  Center(
                    child: MaterialButton(
                      height: size.width * .13,
                      minWidth: 200,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: Color(0xff50C2C9),
                      onPressed: () async {
                        if (Global.currentState!.validate()) {
                          await addNotes();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      child: Text(
                        "${S.of(context).Add}",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
