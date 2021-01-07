
import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:test_app/business_logic/models/model_test.dart';
import 'package:test_app/business_logic/services/strings.dart';

class TestApiProvider {
  final _url = ApiString.TEST_API;

  Future<TestModel> fetchTestList() async {
    print("entered test list api");

    try {
      final response = await http.get(_url);

      if (response.statusCode == 200) {
        return TestModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      return null;
    }
  }
}