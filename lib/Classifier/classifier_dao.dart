import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ClassifierDAO {
  final classifierRef = FirebaseFirestore.instance.collection('clasificaciones');

  Future<Map?> getPredictions(String uid) async {
    try {
      return await classifierRef
          .doc(uid)
          .get()
          .then((snapshot) => snapshot.data() ?? {});
    } catch (error) {
      return null;
    }
  }

  void addClassification(String uid, bool result) {
      classifierRef.doc(uid).set({
        DateFormat('dd/MM/yyyy hh:mm:ss').format(DateTime.now().toUtc()): result
      },SetOptions(merge: true));
  }
}