import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaundice_image_detector/Authentication/AuthStateEnum.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:jaundice_image_detector/Authentication/auth_bloc.dart';
import 'package:jaundice_image_detector/Authentication/user_model.dart';
class BlocsManager implements Bloc{
  final Stream<User?> _streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User?> get user => _streamFirebase;
  AuthBloc authBloc = AuthBloc();

  Future<AuthState> register(String email, String password, UserModel userModel) async {
    return authBloc.register(email, password, userModel);
  }

  Future<AuthState> login(String email, String password) async {
    return authBloc.login(email, password);
  }

  @override
  void dispose() {}
}