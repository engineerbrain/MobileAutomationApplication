import 'package:flutter/material.dart';
import '../main.dart';
import '../firestore.dart';

class addBookPage extends StatefulWidget {
  final Map<String, dynamic>? bookData;
  final String? bookId;

  const addBookPage({super.key, this.bookData, this.bookId});

  @override
  _addBookPageState createState() => _addBookPageState();
}

class _addBookPageState extends State<addBookPage> {
  Map<String, dynamic> kitap = {};
  bool sayfaGirisiHatali = false;
  bool isPublic = false;
  final FirestoreService firestore = FirestoreService();
  final TextEditingController adController = TextEditingController();
  final TextEditingController yayinEviController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();
  final TextEditingController yazarController = TextEditingController();
  final TextEditingController sayfaSayisiController = TextEditingController();
  final TextEditingController basimTarihiController = TextEditingController();
  final TextEditingController listeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Eğer mevcut bir kitap düzenleniyorsa, var olan verileri controller'lara set et
    if (widget.bookData != null) {
      adController.text = widget.bookData!['ad'] ?? '';
      yayinEviController.text = widget.bookData!['yayin'] ?? '';
      kategoriController.text = widget.bookData!['kategori'] ?? '';
      yazarController.text = widget.bookData!['yazar'] ?? '';
      sayfaSayisiController.text = widget.bookData!['sayfa'] ?? '';
      basimTarihiController.text = widget.bookData!['basim'] ?? '';
      listeController.text = widget.bookData!['liste'].toString() ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kitap Ekle"),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              // Çarpı tuşuna basıldığında sayfayı kapat
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: adController,
              obscureText: false,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Kitap adı',
              ),
              onChanged: (value) {
                kitap['ad'] = value;
              },
            ),
            TextField(
              controller: yayinEviController,
              obscureText: false,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Yayınevi',
              ),
              onChanged: (value) {
                kitap['yayin'] = value;
              },
            ),
            DropdownButtonFormField(
                hint: const Text("Kategori Seç"),
                items: const [
                  DropdownMenuItem(
                    value: "Roman",
                    child: Text("Roman"),
                  ),
                  DropdownMenuItem(
                    value: "Tarih",
                    child: Text("Tarih"),
                  ),
                  DropdownMenuItem(
                    value: "Edebiyat",
                    child: Text("Edebiyat"),
                  ),
                  DropdownMenuItem(
                    value: "Şiir",
                    child: Text("Şiir"),
                  ),
                  DropdownMenuItem(
                    value: "Ansiklopedi",
                    child: Text("Ansiklopedi"),
                  ),
                ],
                onChanged: (value) => {kitap['kategori'] = value}),
            TextField(
              controller: yazarController,
              obscureText: false,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Yazarlar',
              ),
              onChanged: (value) {
                kitap['yazar'] = value;
              },
            ),
            TextField(
                controller: sayfaSayisiController,
                obscureText: false,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Sayfa Sayısı',
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (int.tryParse(value) == null) {
                      sayfaGirisiHatali = true;
                    } else {
                      kitap['sayfa'] = value;
                      sayfaGirisiHatali = false;
                    }
                  }
                }),
            TextField(
              controller: basimTarihiController,
              obscureText: false,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Basım Yılı',
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  if (int.tryParse(value) == null) {
                    sayfaGirisiHatali = true;
                  } else {
                    kitap['yil'] = value;
                    sayfaGirisiHatali = false;
                  }
                }
              },
            ),
            CheckboxListTile(
                title: const Text('Kitap Yayınlansın mı?'),
                value: isPublic,
                onChanged: (bool? newValue) {
                  setState(() {
                    isPublic = newValue ?? false;
                  });
                  kitap['liste'] = isPublic ? true : false;
                }),
            ElevatedButton(
              onPressed: () async {
                if (isPublic) {
                  kitap['liste'] = true;
                } else {
                  kitap['liste'] = false;
                }
                if (int.tryParse(kitap['sayfa']) == null ||
                    int.tryParse(kitap['yil']) == null) {
                } else {
                  if (kitap['ad'] == null) {
                    kitap['ad'] = 'Tanımlanmadı';
                  }
                  if (kitap['yayin'] == null) {
                    kitap['yayin'] = 'Tanımlanmadı';
                  }
                  if (kitap['yazar'] == null) {
                    kitap['yazar'] = "Tanımlanmadı";
                  }
                  if (kitap['kategori'] == null) {
                    kitap['kategori'] = "Tanımlanmadı";
                  }
                  if (kitap['liste'] == null) {
                    kitap['liste'] = false;
                  }
                  firestore.addBook(kitap);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MyApp()));
                }
              },
              child: const Text("Kaydet"),
            ),
          ],
        ),
      ),
    );
  }
}
