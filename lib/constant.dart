import 'package:http/http.dart' as http;
class Constant{
  //ganti api menjadi url api anda
  static String url = "http://10.14.76.132:8080/api_crud/";


  }

Future httpPost(String url, Map<String, String> params) async {
  try {
    final response =
    await http.post(url, body: params);
    print("ini url :${url}  param ${params}");


    if (response.statusCode == 200) {
      print('data body ${response.body}');
      // If the call to the server was successful, parse the JSON
      return response.body;
    } else {
      // If that call was not successful, throw an error.
      //throw Exception('Failed to load post');
      return null;
    }
  } catch (e) {
    return null;
  }
}
