import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaundice_image_detector/Authentication/user_model.dart';

class UserDAO {
  final usersRef = FirebaseFirestore.instance
      .collection('usuarios')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  Future<UserModel?> getUserInfo(String email) async {
    try {
      return await usersRef
          .doc(email)
          .get()
          .then((snapshot) => snapshot.data()!);
    } catch (error) {
      return null;
    }
  }

  Future<void> createUser(String uid, UserModel userModel) async {
      await usersRef.doc(uid).set(userModel);
  }
}
