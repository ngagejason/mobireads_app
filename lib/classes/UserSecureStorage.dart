import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobi_reads/blocs/app_bloc/app_state.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_state.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();
  static const _currentStorageKey = '_currentStorageKey';
  static const _appStorageKey = '_appStorageKey';
  static const _bookStorageKey = '_bookStorageKey';

  static Future clearAll() async =>
      await _storage.deleteAll();

  static Future clearKey(AppState appState) async =>
      await _storage.delete(key: getAppStorageKey(appState.Id));

  static Future setCurrentUserId(String id) async {
    await _storage.write(key: _currentStorageKey, value: id);
  }

  static Future<String?> getCurrentUserId() async {
    return await _storage.read(key: _currentStorageKey);
  }

  static Future<List<AppState>> GetAllAppStates() async {
    Map<String, String> allEntries = await _storage.readAll();
    List<AppState> appStates = [];

    allEntries.forEach((k,v) {
      if(k.startsWith(_appStorageKey + ":")){
        var a = json.decode(v);
        appStates.add(AppState.fromJson(a));
      }
    });

    return appStates;
  }

  static Future storeAppStateAndSetCurrent(AppState appState) async {
    await setCurrentUserId(appState.Id);
    await storeAppState(appState);
  }

  static Future<String?> getBearer() async{
    String currentUserId = await getCurrentUserId() ?? '';
    AppState? user = await getAppState(currentUserId);
    if(user != null){
      return user.Bearer;
    }

    return '';
  }

  static String getAppStorageKey(String id){
    return _appStorageKey + ":" + id;
  }

  static Future<AppState?> getAppState(String id) async {
    String storageKey = getAppStorageKey(id);
    String? appStateString = await _storage.read(key: storageKey);
    if(appStateString != null && appStateString.length > 0){
      var a = json.decode(appStateString);
      return AppState.fromJson(a);
    }

    return null;
  }

  static Future storeAppState(AppState appState) async {
    if(!(await _storage.containsKey(key: getAppStorageKey(appState.Id)))){
      await _storage.write(key:  getAppStorageKey(appState.Id), value: json.encode(appState));
    }
    else{
      await _storage.delete(key: getAppStorageKey(appState.Id));
      await _storage.write(key:  getAppStorageKey(appState.Id), value: json.encode(appState));
    }
  }

}