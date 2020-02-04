import 'package:http/http.dart' as http;


class Data<T> {
  final Uri uri;
  T Function(http.Response response) parse;

  Data({this.uri, this.parse});
}

class Webservice {
   Future<T> load<T>(Data<T> data) async{
     print(data.uri.toString());
    final response = await http.get(data.uri);
    if(response.statusCode == 200){
      print(response.statusCode);
      return data.parse(response);
    }else{
      throw Exception(response.reasonPhrase);
    }
  }
}