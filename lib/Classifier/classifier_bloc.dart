import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaundice_image_detector/Classifier/classifier_dao.dart';

class ClassifierService {
  ClassifierDAO classifierDAO = ClassifierDAO();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool?> classifyImage(String filePath) async {
    //jwt authentication token
    //var authToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNhbTEyM0BnbWFpbC5jb20iLCJzdWIiOiI2MDViOTgxZDRkOTk4YjMxMjRhODEyMDQiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2MTgyMzQ4NjUsImV4cCI6MTYxODMyMTI2NX0.lYUfZ20TlFZZQO_1JKZbKYZublPRoejqnmxKOAM9CN0';
    //user im use to upload image
    //Note: this authToken and user id parameter will depend on my backend api structure
    //in your case it can be only auth token
    //var _userId = '605b981d4d998b3124a81204';

    try {
      final FormData formData = FormData.fromMap(
          {"file": await MultipartFile.fromFile(filePath, filename: "dp")});
      print("--------------------->Entré api call<---------------------");
      final Response response = await Dio().post(
        "https://jaundice-detector.herokuapp.com/classify",
        data: formData,
        /*options: Options(
              headers: <String, String>{
                'Authorization': 'Bearer $authToken',
              }
          )*/
      );
      print("--------------------->Salí api call<---------------------");
      if (response.statusCode == 200) {
        final bool result = response.data!['jaundice'] as bool;
        classifierDAO.addClassification(auth.currentUser!.uid, result);
        return result;
      } else {
        return null;
      }
    } on DioError catch (e) {
      print(e.response);
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<Map?> getPredictions() async {
    return classifierDAO.getPredictions(auth.currentUser!.uid);
  }
}
