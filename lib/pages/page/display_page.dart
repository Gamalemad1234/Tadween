// ignore_for_file: deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glow_container/glow_container.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:tadween/generated/l10n.dart';
import 'package:tadween/pages/page/edit_page.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  List<QueryDocumentSnapshot> data = [];
  List<bool> isFavorite = []; // قائمة لتتبع حالة المفضلة لكل عنصر
  List<Color> noteColors = []; // قائمة لحفظ ألوان الملاحظات
  bool loading = true;

  // دالة لجلب البيانات من Firebase
  getData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("notes")
          .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      // لكل وثيقة في الملاحظات، نقوم بجلب قيمة اللون وتخزينها
      for (var doc in querySnapshot.docs) {
        // تحقق إذا كانت الملاحظة مضافة إلى المفضلة
        var favoriteDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('favorites')
            .doc(doc.id)
            .get();
        isFavorite.add(favoriteDoc.exists); // true إذا كانت موجودة في المفضلة

        // استرجاع قيمة اللون وتحوّلها إلى كائن Color
        // اللون المخزن يكون عبارة عن int (selectedColor.value)
        int colorValue = doc['color'] ?? Colors.white.value;
        noteColors.add(Color(colorValue));
      }

      setState(() {
        data.addAll(querySnapshot.docs);
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      print("Error fetching data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) { 
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : data.isEmpty
              ? Center(
                  child: Lottie.asset('assets/Animation1.json'),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                        width: size.width * .88,
                        height: size.height * .1,
                        child: GlowContainer(
                          glowRadius: 20,
                          gradientColors: [
                            Colors.blue,
                            Colors.purple,
                            Colors.pink
                          ],
                          rotationDuration: Duration(seconds: 3),
                          containerOptions: ContainerOptions(
                            width: size.width * .75,
                            height: 100,
                            borderRadius: 15,
                            backgroundColor: Colors.black,
                          ),
                          transitionDuration: Duration(milliseconds: 300),
                          showAnimatedBorder: true,
                          child: Center(
                            child: Text(
                              '${S.of(context).notes}',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 9),
                            child: Container(
                              decoration: BoxDecoration(
                                // يتم تطبيق اللون المخزن هنا على الخلفية
                                color: noteColors[index],
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(30) , bottomRight: Radius.circular(30) ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${data[index]['title']}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                Dialogs.materialDialog(
                                                  msg:
                                                      'Are you sure? You can\'t undo this',
                                                  title: "Delete",
                                                  color: Colors.white,
                                                  context: context,
                                                  actions: [
                                                    IconsOutlineButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      text: 'Cancel',
                                                      iconData: Icons
                                                          .cancel_outlined,
                                                      textStyle: TextStyle(
                                                          color: Colors.grey),
                                                      iconColor: Colors.grey,
                                                    ),
                                                    IconsButton(
                                                      onPressed: () async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('notes')
                                                            .doc(data[index]
                                                                .id)
                                                            .delete();
                                                        setState(() {
                                                          data.removeAt(index);
                                                          isFavorite
                                                              .removeAt(index);
                                                          noteColors
                                                              .removeAt(index);
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      text: 'Delete',
                                                      iconData: Icons.delete,
                                                      color: Colors.red,
                                                      textStyle: TextStyle(
                                                          color: Colors.white),
                                                      iconColor: Colors.white,
                                                    ),
                                                  ],
                                                );
                                              },
                                              icon: Icon(Icons.delete),
                                              color: Colors.red,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditPage(
                                                      docId: data[index].id,
                                                      oldTitle: data[index]
                                                          ['title'],
                                                      oldContent: data[index]
                                                          ['content'], oldColor: noteColors[index].value,
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: Icon(Icons.edit),
                                              color: const Color.fromARGB(
                                                  255, 20, 186, 8),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                try {
                                                  String noteId =
                                                      data[index].id;
                                                  String userId =
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid;

                                                  if (isFavorite[index]) {
                                                    // إذا كانت في المفضلة، احذفها
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(userId)
                                                        .collection(
                                                            'favorites')
                                                        .doc(noteId)
                                                        .delete();

                                                    setState(() {
                                                      isFavorite[index] =
                                                          false; // تحديث الحالة
                                                    });
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Item removed from favorites!'),
                                                      ),
                                                    );
                                                  } else {
                                                    // إذا لم تكن في المفضلة، أضفها
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(userId)
                                                        .collection(
                                                            'favorites')
                                                        .doc(noteId)
                                                        .set({
                                                      'title': data[index]
                                                          ['title'],
                                                      'content': data[index]
                                                          ['content'],
                                                      'time': data[index]
                                                          ['time'],
                                                      'date': data[index]
                                                          ['date'],
                                                      'addedAt': FieldValue
                                                          .serverTimestamp(),
                                                    });

                                                    setState(() {
                                                      isFavorite[index] =
                                                          true; // تحديث الحالة
                                                    });
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Item added to favorites!'),
                                                      ),
                                                    );
                                                  }
                                                } catch (e) {
                                                  print(
                                                      "Error managing favorites: $e");
                                                }
                                              },
                                              icon: Icon(
                                                isFavorite[index]
                                                    ? Icons.favorite
                                                    : Icons
                                                        .favorite_border_outlined,
                                              ),
                                              color: isFavorite[index]
                                                  ? Colors.red
                                                  : Colors.white,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 20, left: 20),
                                    child: Text(
                                      "${data[index]['content']}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 10, left: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Time :  ${data[index]['time']}",
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 147, 255, 6),
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "Date : ${data[index]['date']}",
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 147, 255, 6),
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
