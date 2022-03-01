import 'dart:convert';
import 'package:mobi_reads/classes/IOFactory.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/entities/RequestResult.dart';
import 'package:mobi_reads/entities/peek/PeekResponse.dart';
import '../server_paths.dart';

class PeekRepository {

  Future<PeekResponse> getPeeks(int code) async {
    var response = await IOFactory.doGetWithBearer(urlExtension: ServerPaths.GET_PEEKS, args: {'code': code.toString()});
    if (response.statusCode == 200) {
      RequestResult<PeekResponse> result =  RequestResult<PeekResponse>.fromJson(jsonDecode(response.body), (data) => PeekResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.ErrorPeekResponse;
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to Load Data');
  }
}
