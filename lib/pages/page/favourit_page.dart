import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FavouritPage extends StatefulWidget {
  const FavouritPage({super.key});

  @override
  State<FavouritPage> createState() => _FavouritPageState();
}

class _FavouritPageState extends State<FavouritPage> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  // دالة لجلب العناصر المفضلة
  Stream<QuerySnapshot> getFavorites() {
    return FirebaseFirestore.instance
        .collection('users') // مجموعة المستخدمين
        .doc(userId) // وثيقة المستخدم
        .collection('favorites') // مجموعة المفضلات
        .snapshots(); // بث مباشر للبيانات
  }

  // دالة لحذف عنصر من المفضلة
  Future<void> removeFromFavorites(String itemId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(itemId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item removed from favorites!')),
      );
    } catch (e) {
      print("Error removing favorite: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Favorites',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Lottie.asset('assets/circle_rectangle_squer_loding.json'),
            );
          }

          final favorites = snapshot.data!.docs;

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final item = favorites[index];
              final itemId = item.id;
              final itemData = item.data() as Map<String, dynamic>;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(26, 251, 251, 251),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              itemData['title'] ?? 'Unknown Title',
                              style: TextStyle(color: Colors.white, fontSize: 19),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => removeFromFavorites(itemId),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          itemData['content'] ?? 'Unknown Content',
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                      ),
                      Text(
                        "Added At: ${(itemData['addedAt'] as Timestamp?)?.toDate() ?? ''}",
                        style: TextStyle(color: const Color.fromARGB(255, 20, 229, 34)),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
