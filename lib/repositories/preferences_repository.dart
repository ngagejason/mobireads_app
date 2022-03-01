import 'dart:convert';

import 'package:mobi_reads/classes/IOFactory.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/entities/RequestResult.dart';
import 'package:mobi_reads/entities/bool_response/bool_response.dart';
import 'package:mobi_reads/entities/preferences/TogglePreferenceRequest.dart';
import 'package:mobi_reads/entities/preferences/PreferencesResponse.dart';

import '../server_paths.dart';

class PreferencesRepository {

  Future<PreferencesResponse> getUserPreferences() async {
    var response = await IOFactory.doGetWithBearer(urlExtension: ServerPaths.USER_PREFERENCES);
    if (response.statusCode == 200) {
      RequestResult<PreferencesResponse> result =  RequestResult<PreferencesResponse>.fromJson(jsonDecode(response.body), (data) => PreferencesResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.Preferences;
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to Confirm Account');
  }

  Future<BoolResponse> togglePreference(TogglePreferenceRequest toggle) async {
    var response = await IOFactory.doPostWithBearer(urlExtension: ServerPaths.TOGGLE_PREFERENCE, data: toggle);
    if (response.statusCode == 200) {
      RequestResult<BoolResponse> result =  RequestResult<BoolResponse>.fromJson(jsonDecode(response.body), (data) => BoolResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.ErrorBoolResponse;
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to Confirm Account');
  }
}
