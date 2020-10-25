import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_exceptions.dart';

const String apiBase = 'https://rickandmortyapi.com/api/';

class HTTPClient {
  static final HTTPClient _singleton = HTTPClient();
  static HTTPClient get instance => _singleton;

  Future<dynamic> fetchData(String url,
      {Map<String, String> headersType, Map<String, String> params}) async {
    dynamic responseJson;
    final String uri =
        apiBase + url + ((params != null) ? queryParameters(params) : '');

    try {
      final http.Response response = await http.get(uri,
          headers: (headersType != null) ? headersType : <String, String>{});
      print(response.body.toString());
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> deleteData(String url, Map<String, String> headersType,
      {Map<String, String> params}) async {
    dynamic responseJson;

    final String uri =
        apiBase + url + ((params != null) ? queryParameters(params) : '');
    try {
      final http.Response response =
          await http.delete(uri, headers: headersType);
      print(response.body.toString());
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> postData(
      String url, dynamic body, Map<String, String> headerType) async {
    print(body.toString());
    dynamic responseJson;
    try {
      final http.Response response = await http.post(apiBase + url,
          body: jsonEncode(body), headers: headerType);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw InternetException('No internet connection');
    } on Exception catch (_) {
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> postMultipartData(String url, Map<String, String> body,
      Map<String, String> headerType) async {
    print(body.toString());
    dynamic responseJson;
    try {
      final Uri uri = Uri.parse(apiBase + url);
      final http.MultipartRequest request = http.MultipartRequest('POST', uri)
        ..fields.addAll(body);
      final http.StreamedResponse response = await request.send();
      final http.Response parserResponse =
          await http.Response.fromStream(response);
      responseJson = _returnResponse(parserResponse);
    } on SocketException {
      throw InternetException('No internet connection');
    } on Exception catch (_) {
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> postMultipartImage(
      String url, Map<String, String> headerType, String imageFile) async {
    print(imageFile);

    dynamic responseJson;
    try {
      final Uri uri = Uri.parse(apiBase + url);
      final http.MultipartRequest request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath('image', imageFile));
      request.headers.addAll(headerType);
      final http.StreamedResponse response = await request.send();
      final http.Response parserResponse =
          await http.Response.fromStream(response);
      responseJson = _returnResponse(parserResponse);
      print(responseJson);
    } on SocketException {
      throw InternetException('No internet connection');
    } on Exception catch (_) {
      rethrow;
    }
    return responseJson;
  }

  String queryParameters(Map<String, String> params) {
    if (params != null) {
      final Uri jsonString = Uri(queryParameters: params);
      return '?${jsonString.query}';
    }
    return '';
  }

  dynamic _returnResponse(http.Response response) {
    print(response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        final dynamic responseJson =
            json.decode(utf8.decode(response.bodyBytes));
        return responseJson;
      case 201:
        final dynamic responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        final dynamic responseJson = json.decode(response.body.toString());
        throw BadRequestValidationException.fromJson(responseJson);
      case 401:
        final dynamic responseJson = json.decode(response.body.toString());
        throw BadRequestValidationException.fromJson(responseJson,
            code: response.statusCode);
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
