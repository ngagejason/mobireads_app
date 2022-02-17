import 'dart:convert';

import 'package:mobi_reads/blocs/login_bloc/login_event.dart';
import 'package:mobi_reads/classes/IOFactory.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/entities/RequestResult.dart';
import 'package:mobi_reads/entities/account/confirm_account_request.dart';
import 'package:mobi_reads/entities/account/create_account_request.dart';
import 'package:mobi_reads/entities/account/password_reset_confirm.dart';
import 'package:mobi_reads/entities/account/password_reset_request.dart';
import 'package:mobi_reads/entities/bool_response/bool_response.dart';
import 'package:mobi_reads/entities/login/LoginUserResponse.dart';

import '../server_paths.dart';

class AccountRepository {

  Future<LoginUserResponse> confirmAccount(ConfirmAccountRequest confirmAccountRequest) async {
    var response = await IOFactory.doPost<ConfirmAccountRequest>(urlExtension: ServerPaths.CONFIRM_ACCOUNT, data: confirmAccountRequest);
    if (response.statusCode == 200) {
      RequestResult<LoginUserResponse> result =  RequestResult<LoginUserResponse>.fromJson(jsonDecode(response.body), (data) => LoginUserResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.ErrorLoginUserResponse;
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to Confirm Account');
  }

  Future<BoolResponse> createAccount(CreateAccountRequest createAccountRequest) async {
    var response = await IOFactory.doPost<CreateAccountRequest>(urlExtension: ServerPaths.CREATE_ACCOUNT, data: createAccountRequest);
    if (response.statusCode == 200) {
      RequestResult<BoolResponse> result =  RequestResult<BoolResponse>.fromJson(jsonDecode(response.body), (data) => BoolResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? BoolResponse(false, 'Unknown Error');
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to Create Account');
  }

  Future<BoolResponse> checkAvailability(String username) async {
    var response = await IOFactory.doGet(urlExtension: ServerPaths.CHECK_AVAILABILITY, args: {'username': username});
    if (response.statusCode == 200) {
      RequestResult<BoolResponse> result =  RequestResult<BoolResponse>.fromJson(jsonDecode(response.body), (data) => BoolResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? BoolResponse(false, 'Unknown Error');
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to Create Account');
  }

  Future<BoolResponse> sendPasswordResetRequest(PasswordResetRequest request) async {
    var response = await IOFactory.doPost<PasswordResetRequest>(urlExtension: ServerPaths.PASSWORD_RESET_REQUEST, data: request);
    if (response.statusCode == 200) {
      RequestResult<BoolResponse> result =  RequestResult<BoolResponse>.fromJson(jsonDecode(response.body), (data) => BoolResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? BoolResponse(false, 'Unknown Error');
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to Create Account');
  }

  Future<LoginUserResponse> sendPasswordResetConfirm(PasswordResetConfirm confirm) async {
    var response = await IOFactory.doPost<PasswordResetConfirm>(urlExtension: ServerPaths.PASSWORD_RESET_CONFIRM, data: confirm);
    if (response.statusCode == 200) {
      RequestResult<LoginUserResponse> result =  RequestResult<LoginUserResponse>.fromJson(jsonDecode(response.body), (data) => LoginUserResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.ErrorLoginUserResponse;
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to Create Account');
  }
}
