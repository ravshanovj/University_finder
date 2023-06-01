import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class GetInformationRepository {
  getInformation({required String name}) async {
    try {
      final url =
          Uri.parse("http://universities.hipolabs.com/search?country=$name");
      final res = await http.get(url);
      dynamic data = jsonDecode(res.body);
      return data;
    } on DioError catch (e) {
      return e.message.toString();
    }
  }
}
