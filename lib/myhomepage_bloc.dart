import 'dart:async';

import 'package:bloc_test/address_model.dart';
import 'package:dio/dio.dart';

class MyHomePageBloc {

  final StreamController<String> _streamController = StreamController<String>();
  Sink<String> get input => _streamController.sink;
  Stream<AddressModel> get output =>
      _streamController.stream
          .where((cep) => cep.length > 7)
          .asyncMap((cep) => _searchCep(cep));

  String url(String cep) => "https://viacep.com.br/ws/$cep/json/";

  Future<AddressModel> _searchCep(String cep) async {
    Response response = await Dio().get(url(cep));
    return AddressModel.fromJson(response.data);
  }

}