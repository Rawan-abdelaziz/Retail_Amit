import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'data_model.dart';

class ApiProvider with ChangeNotifier {
  DataModel _dataModel = DataModel();
  Dio dio = Dio();

  Future<DataModel> getData() async {
    /// Server LockUp - Get Response from it
    final response = await dio.get('https://retail.amit-learning.com/api/products');
    try {
      print('Data Model : ${response.data}');
      return _dataModel = DataModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to load Data - ${error.toString()}');
    }
  }



  DataModel get dataModel => _dataModel;
}
