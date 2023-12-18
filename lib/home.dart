import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vizeodev_mobil/addBook.dart';
import '../firestore.dart';
import 'dart:async';

class home extends StatefulWidget {
  const home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final FirestoreService firestore = FirestoreService();
  late StreamSubscription<QuerySnapshot> subscription;

  @override
  void initState() {
    super.initState();
    subscription = firestore.getBook().listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const addBookPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        constraints: const BoxConstraints(maxHeight: 500),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.getBook(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List bookList = snapshot.data!.docs;
              return ListView.builder(
                itemCount: bookList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = bookList[index];
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String kitapAd = data['ad'];
                  String kitapSayfa = data['sayfa'];
                  String kitapYazar = data['yazar'];
                  bool yayin = data['liste'];

                  if (yayin) {
                    return Container(
                      margin: const EdgeInsets.all(3),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 229, 255, 232),
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          kitapAd,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Yazar:$kitapYazar, Sayfa Sayısı:$kitapSayfa",
                          style: const TextStyle(fontSize: 14),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => addBookPage(
                                          bookData: data, bookId: document.id)),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title:
                                          const Text('Silmek istiyor musunuz?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('İptal.'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            firestore.deleteBook(document.id);
                                            Navigator.of(context).pop();
                                          },
                                          child:
                                              const Text('Silmek istiyorum.'),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              );
            } else {
              return const Text("Kitap Ekleyin");
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Kitaplar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Satın Al',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
        ],
      ),
    );
  }
}
