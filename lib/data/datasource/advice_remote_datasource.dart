import 'package:adviser/data/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/advice_model.dart';

abstract class AdviceRemoteDatasource {
  Future<AdviceModel> getRandomAdviceFromApi();
}

class AdviceRemoteDatasourceImpl implements AdviceRemoteDatasource {
  AdviceRemoteDatasourceImpl({required this.client});
  final http.Client client;
  @override
  Future<AdviceModel> getRandomAdviceFromApi() async {
    final res = await client.get(
        Uri.parse('https://api.flutter-community.de/api/v1/advice'),
        headers: {
          'content-type': 'application/json',
        });
    if (res.statusCode != 200) {
      throw ServerException();
    } else {
      final resData = json.decode(res.body);
      return AdviceModel.fromJson(resData);
    }
  }
}
