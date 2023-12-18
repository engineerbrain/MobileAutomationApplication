import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference booksCollection =
      FirebaseFirestore.instance.collection('kitaplar');

  Stream<QuerySnapshot> getBook() {
    return booksCollection.snapshots();
  }

  Future<void> addBook(Map<String, dynamic> book) {
    return booksCollection.add(book);
  }

  Future<void> updateBook(String bookId, Map<String, dynamic> book) {
    return booksCollection.doc(bookId).update(book);
  }

  Future<void> deleteBook(String bookId) {
    return booksCollection.doc(bookId).delete();
  }
}
