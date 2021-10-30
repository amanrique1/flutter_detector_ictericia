import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaundice_image_detector/Authentication/AuthStateEnum.dart';
import 'package:jaundice_image_detector/Authentication/user_dao.dart';
import 'package:jaundice_image_detector/Authentication/user_model.dart';

class AuthBloc {

  UserDAO userDAO = UserDAO();

  Future<AuthState> register(String email, String password, UserModel userModel) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      await userDAO.createUpdateUser(credential.user!.uid, userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return AuthState.WEAK_PASS;
      } else if (e.code == 'email-already-in-use') {
        return AuthState.EMAIL_TAKEN;
      }
    } catch (e) {
      return AuthState.UNKNOWN;
    }
    return AuthState.SUCCESS;
  }


  Future<AuthState> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return AuthState.USER_NOT_FOUND;
      } else if (e.code == 'wrong-password') {
        return AuthState.WRONG_PASS;
      }
    } catch (e) {
      return AuthState.UNKNOWN;
    }
    return AuthState.SUCCESS;
  }
}