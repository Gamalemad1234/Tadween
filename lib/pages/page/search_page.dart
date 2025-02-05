// ignore_for_file: deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glow_container/glow_container.dart';
import 'package:lottie/lottie.dart';
import 'package:tadween/generated/l10n.dart';
import 'package:tadween/pages/page/edit_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<QueryDocumentSnapshot> allData = [];
  List<QueryDocumentSnapshot> filteredData = [];
  List<bool> isFavorite = []; // قائمة لتتبع حالة المفضلة لكل عنصر
  List<Color> noteColors = []; // قائمة لحفظ ألوان الملاحظات
  bool loading = true;
  TextEditingController searchController = TextEditingController();

  // دالة لجلب البيانات من Firebase للمستخدم الحالي
  Future<void> getData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("notes")
          .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      // إعادة تهيئة القوائم
      allData = [];
      filteredData = [];
      isFavorite = [];
      noteColors = [];

      // لكل وثيقة في الملاحظات
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
        int colorValue = doc['color'] ?? Colors.white.value;
        noteColors.add(Color(colorValue));

        // إضافة الوثيقة إلى قائمة جميع البيانات
        allData.add(doc);
      }

      // في البداية تكون النتائج المفلترة هي كل البيانات
      filteredData = List.from(allData);

      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      print("Error fetching data: $e");
    }
  }

  // دالة لتصفية البيانات بناءً على نص البحث
  void filterData(String query) {
    List<QueryDocumentSnapshot> results = [];
    if (query.isEmpty) {
      results = List.from(allData);
    } else {
      results = allData.where((doc) {
        String title = doc['title'].toString().toLowerCase();
        String content = doc['content'].toString().toLowerCase();
        return title.contains(query.toLowerCase()) ||
            content.contains(query.toLowerCase());
      }).toList();
    }
    setState(() {
      filteredData = results;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    searchController.addListener(() {
      filterData(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { 
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
     
      body: loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
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
                // حقل البحث
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: S.of(context).Search,
                      hintStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(Icons.search, color: Colors.white70),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                // في حال عدم وجود نتائج عرض لوتي متحركة
                if (filteredData.isEmpty)
                  Expanded(
                    child: Center(
                      child: Lottie.asset('assets/circle_rectangle_squer_loding.json'),
                    ),
                  )
                else
                  // عرض النتائج المفلترة
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        // للحصول على موقع العنصر في القوائم isFavorite و noteColors، نبحث عن فهرس الوثيقة في قائمة allData
                        int actualIndex = allData.indexWhere(
                            (doc) => doc.id == filteredData[index].id);
                        Color noteColor = actualIndex >= 0
                            ? noteColors[actualIndex]
                            : Colors.white;
                        bool favStatus = actualIndex >= 0
                            ? isFavorite[actualIndex]
                            : false;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: Container(
                            decoration: BoxDecoration(
                              color: noteColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
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
                                          "${filteredData[index]['title']}",
                                          style: const TextStyle(
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
                                              // تأكيد الحذف
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text("Delete"),
                                                    content: const Text(
                                                        "Are you sure? You can't undo this"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const Text("Cancel"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection('notes')
                                                              .doc(filteredData[index]
                                                                  .id)
                                                              .delete();
                                                          setState(() {
                                                            // حذف العنصر من القوائم بناءً على الفهرس
                                                            int pos = allData.indexWhere(
                                                                (doc) => doc.id ==
                                                                    filteredData[index].id);
                                                            if (pos != -1) {
                                                              allData.removeAt(pos);
                                                              isFavorite.removeAt(pos);
                                                              noteColors.removeAt(pos);
                                                            }
                                                            filteredData.removeAt(index);
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const Text("Delete"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: const Icon(Icons.delete),
                                            color: Colors.red,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) => EditPage(
                                                    docId: filteredData[index].id,
                                                    oldTitle:
                                                        filteredData[index]
                                                            ['title'],
                                                    oldContent:
                                                        filteredData[index]
                                                            ['content'],
                                                    oldColor: noteColor.value,
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.edit),
                                            color: const Color.fromARGB(
                                                255, 20, 186, 8),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              try {
                                                String noteId =
                                                    filteredData[index].id;
                                                String userId = FirebaseAuth
                                                    .instance
                                                    .currentUser!
                                                    .uid;

                                                if (favStatus) {
                                                  // إذا كانت في المفضلة، احذفها
                                                  await FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(userId)
                                                      .collection('favorites')
                                                      .doc(noteId)
                                                      .delete();
                                                  setState(() {
                                                    int pos = allData.indexWhere(
                                                        (doc) =>
                                                            doc.id ==
                                                            filteredData[index].id);
                                                    if (pos != -1) {
                                                      isFavorite[pos] = false;
                                                    }
                                                  });
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Item removed from favorites!')));
                                                } else {
                                                  // إذا لم تكن في المفضلة، أضفها
                                                  await FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(userId)
                                                      .collection('favorites')
                                                      .doc(noteId)
                                                      .set({
                                                    'title':
                                                        filteredData[index]
                                                            ['title'],
                                                    'content':
                                                        filteredData[index]
                                                            ['content'],
                                                    'time': filteredData[index]
                                                        ['time'],
                                                    'date': filteredData[index]
                                                        ['date'],
                                                    'addedAt':
                                                        FieldValue.serverTimestamp(),
                                                  });
                                                  setState(() {
                                                    int pos = allData.indexWhere(
                                                        (doc) =>
                                                            doc.id ==
                                                            filteredData[index].id);
                                                    if (pos != -1) {
                                                      isFavorite[pos] = true;
                                                    }
                                                  });
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Item added to favorites!')));
                                                }
                                              } catch (e) {
                                                print(
                                                    "Error managing favorites: $e");
                                              }
                                            },
                                            icon: Icon(
                                              favStatus
                                                  ? Icons.favorite
                                                  : Icons
                                                      .favorite_border_outlined,
                                            ),
                                            color: favStatus
                                                ? Colors.red
                                                : Colors.white,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, left: 20),
                                  child: Text(
                                    "${filteredData[index]['content']}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Time :  ${filteredData[index]['time']}",
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 147, 255, 6),
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "Date : ${filteredData[index]['date']}",
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
