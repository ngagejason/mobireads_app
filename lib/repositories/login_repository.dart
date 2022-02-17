import 'dart:convert';

import 'package:mobi_reads/classes/IOFactory.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/entities/RequestResult.dart';
import 'package:mobi_reads/entities/bool_response/bool_response.dart';
import 'package:mobi_reads/entities/login/LoginUserRequest.dart';
import 'package:mobi_reads/entities/login/LoginUserResponse.dart';

import '../server_paths.dart';

class LoginRepository {

  Future<LoginUserResponse> login(LoginUserRequest loginUserRequest) async {
    var response = await IOFactory.doPost<LoginUserRequest>(urlExtension: ServerPaths.LOG_IN_USER, data: loginUserRequest);
    if (response.statusCode == 200) {
      RequestResult<LoginUserResponse> result =  RequestResult<LoginUserResponse>.fromJson(jsonDecode(response.body), (data) => LoginUserResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.ErrorLoginUserResponse;
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to login.');
  }

  Future<LoginUserResponse> loginAsGuest() async {
    var response = await IOFactory.doGet(urlExtension: ServerPaths.LOG_IN_AS_GUEST);
    if (response.statusCode == 200) {
      RequestResult<LoginUserResponse> result =  RequestResult<LoginUserResponse>.fromJson(jsonDecode(response.body), (data) => LoginUserResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.ErrorLoginUserResponse;
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to login.');
  }

  Future<LoginUserResponse> isLoggedIn() async {
   //return DefaultEntities.ErrorLoginUserResponse;

    var response = await IOFactory.doGetWithBearer(urlExtension: ServerPaths.IS_LOGGED_IN);
    if (response.statusCode == 200) {
      RequestResult<LoginUserResponse> result =  RequestResult<LoginUserResponse>.fromJson(jsonDecode(response.body), (data) => LoginUserResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.ErrorLoginUserResponse;
      else
        throw Exception(result.Message);
    }

    return DefaultEntities.ErrorLoginUserResponse;
  }

  Future<BoolResponse> logout() async {
    var response = await IOFactory.doGetWithBearer(urlExtension: ServerPaths.LOGOUT_USER);
    if (response.statusCode == 200) {
      RequestResult<BoolResponse> result =  RequestResult<BoolResponse>.fromJson(jsonDecode(response.body), (data) => BoolResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.ErrorBoolResponse;
    }

    return BoolResponse(false, '');
  }
}
