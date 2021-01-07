
import 'dart:async';

import 'package:test_app/business_logic/models/model_test.dart';
import 'package:test_app/business_logic/services/providers.dart';

class TestBloc{
  final _testApiProvider=  TestApiProvider();
  // final _companyRepository = CompanyRepository();
  final _testBlocStreamController = StreamController<TestModel>.broadcast();

  Stream<TestModel> get testListStream =>
      _testBlocStreamController.stream;

  fetchTestList() async {
    TestModel testModel = await _testApiProvider.fetchTestList();
    _testBlocStreamController.sink.add(testModel);
  }

  dispose() {
    _testBlocStreamController.close();
  }
}

var testBloc=TestBloc();