import 'package:dio/dio.dart';

class ImageService{
  static Future<dynamic> uploadFile(filePath) async {
    //jwt authentication token
    //var authToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNhbTEyM0BnbWFpbC5jb20iLCJzdWIiOiI2MDViOTgxZDRkOTk4YjMxMjRhODEyMDQiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2MTgyMzQ4NjUsImV4cCI6MTYxODMyMTI2NX0.lYUfZ20TlFZZQO_1JKZbKYZublPRoejqnmxKOAM9CN0';
    //user im use to upload image
    //Note: this authToken and user id parameter will depend on my backend api structure
    //in your case it can be only auth token
    //var _userId = '605b981d4d998b3124a81204';

    try {
      FormData formData =
      new FormData.fromMap({
        "file":
        await MultipartFile.fromFile(filePath, filename: "dp")});
      print("--------------------->Entré api call<---------------------");
      Response response =
      await Dio().post(
          "https://jaundice-detector.herokuapp.com/classify",
          data: formData,
          /*options: Options(
              headers: <String, String>{
                'Authorization': 'Bearer $authToken',
              }
          )*/
      );
      print("--------------------->Salí api call<---------------------");
      return response;
    }on DioError catch (e) {
      return e.response;
    } catch(e){
    }
  }
}