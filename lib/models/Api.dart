import 'package:http/http.dart' as http;

const String url = 'https://bookevritin.com/api';

var header = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
  'Authorization': 'Bearer '
};

interceptor(response){
  if (response.statusCode == 200 || response.statusCode == 201 ) {
   return response;
  }
  if(response.statusCode == 207){
    //logout this user coz token has expired
  }
}

Future<http.Response> get(String endPoint) async {
  final http.Response response = await http.get(
      '$url/$endPoint', headers: header
  );
  interceptor(response);
  return response;
}

Future<http.Response> post(String endPoint) async {
  final http.Response response = await http.post(
      '$url/$endPoint', headers: header
  );
  interceptor(response);
  return response;
}

Future<http.Response> put(String endPoint) async {
  final http.Response response = await http.put(
      '$url/$endPoint', headers: header
  );
  interceptor(response);
  return response;
}

Future<http.Response> delete(String endPoint) async {
  final http.Response response = await http.delete(
    '$url/$endPoint', headers: header
  );
  interceptor(response);
  return response;
}
