import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaundice_image_detector/Authentication/AuthStateEnum.dart';
import 'package:jaundice_image_detector/Authentication/user_dao.dart';
import 'package:jaundice_image_detector/Authentication/user_model.dart';

class ProfileBloc {

  UserDAO userDAO = UserDAO();
  User user = FirebaseAuth.instance.currentUser!;

  Future<AuthState> update(String? email, String? password, UserModel? userModel) async {
    try {
      if(email != null && email != user.email) {
        await user.updateEmail(email);
      }
      if(password != null) {
        await user.updatePassword(password);
      }
      if(userModel != null){
        await userDAO.createUpdateUser(user.uid, userModel);
      }
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

  Future<UserModel?> getUser() async{
    return userDAO.getUserInfo(user.uid);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  String getAuthUserEmail() => user.email ?? "";
}