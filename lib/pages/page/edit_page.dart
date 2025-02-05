// ignore_for_file: unused_element

import 'package:clay_containers/widgets/clay_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tadween/generated/l10n.dart';
import 'package:tadween/pages/home_page.dart';

class EditPage extends StatefulWidget {
  const EditPage({
    super.key, 
    required this.docId, 
    required this.oldTitle, 
    required this.oldContent,
    required this.oldColor, // قيمة اللون المخزنة (int)
  });

  final String docId;
  final String oldTitle;
  final String oldContent;
  final int oldColor;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  // تغيير اسم المفتاح إلى formKey لتوضيح أنه مفتاح للنموذج
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  
  // متغير لتخزين اللون المختار (يتم تهيئته من اللون القديم)
  Color selectedColor = Colors.white;
  
  CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  /// دالة لتحديث الملاحظة في Firestore
  Future<void> updateNote() async {
    // عرض الـ document ID للتأكد من أنه ليس فارغاً
    print("Document ID: ${widget.docId}");
    return notes.doc(widget.docId).update({
      'title': title.text,
      'content': content.text,
      'id': FirebaseAuth.instance.currentUser!.uid,
      'color': selectedColor.value, // تحديث قيمة اللون كـ int
    }).then((value) {
      print("Note Updated Successfully");
    }).catchError((error) {
      print("Failed to update note: $error");
    });
  }

  /// أداة اختيار اللون التي تعرض مجموعة من الألوان
  Widget buildColorPicker() {
    List<Color> colors = [
        Colors.blue,
        Colors.green,
        Colors.deepPurpleAccent,
        Colors.orange.shade600,
        const Color.fromARGB(255, 111, 21, 127),
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

  @override
  void initState() {
    super.initState();
    // تهيئة حقول النصوص بالبيانات القديمة
    title.text = widget.oldTitle;
    content.text = widget.oldContent;
    // تهيئة اللون المختار باللون المخزن
    selectedColor = Color(widget.oldColor);
  }

  @override
  void dispose() {
    title.dispose();
    content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formKey,
        child: Container(
          color: Colors.black,
          child: Center(
            child: Expanded(
              child: ClayContainer(
                color: const Color.fromARGB(255, 8, 2, 2),
                height: size.height*.88,
                width: size.width * 0.88,
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.025),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: title,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).empty;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(139, 228, 221, 221),
                          hintText: "${S.of(context).Title}",
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 240, 235, 235),
                          ),
                          prefixIcon: const Icon(Icons.text_fields_outlined),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0, color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0, color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.025),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: content,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).empty;
                          }
                          return null;
                        },
                        minLines: 2,
                        maxLines: 6,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(139, 228, 221, 221),
                          hintText: "${S.of(context).Content}",
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 240, 235, 235),
                          ),
                          prefixIcon: const Icon(Icons.content_paste),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0, color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0, color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Select the Color",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    buildColorPicker(),
                    SizedBox(height: 25),
                    Center(
                      child: MaterialButton(
                        height: size.width * 0.13,
                        minWidth: 200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: const Color(0xff50C2C9),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              await updateNote();
                              // بعد التحديث ننتقل للصفحة الرئيسية
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                                (route) => false,
                              );
                            } catch (e) {
                              print("Error updating note: $e");
                            }
                          }
                        },
                        child: Text(
                          "${S.of(context).Save}",
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
