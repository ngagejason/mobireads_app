import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobi_reads/blocs/app_bloc/app_state.dart';
import 'package:mobi_reads/entities/login/LoginUserResponse.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();
  static const _currentStorageKey = '_currentStorageKey';
  static const _storageKey = '_storageKey';

  static Future clearAll() async =>
      await _storage.deleteAll();

  static Future setCurrentUser(String id) async {
    await _storage.write(key: _currentStorageKey, value: id);
  }

  static Future<AppState?> getAppState(String id) async {
    String storageKey = getStorageKey(id);
    String? appStateString = await _storage.read(key: storageKey);
    if(appStateString != null && appStateString.length > 0){
      var a = json.decode(appStateString);
      return AppState.fromJson(a);
    }

    return null;
  }

  static Future storeAppState(AppState appState) async {
    if(!(await _storage.containsKey(key: getStorageKey(appState.Id)))){
      await _storage.write(key:  getStorageKey(appState.Id), value: json.encode(appState));
    }
    else{
      await _storage.delete(key: getStorageKey(appState.Id));
      await _storage.write(key:  getStorageKey(appState.Id), value: json.encode(appState));
    }
  }

  static Future<List<AppState>> GetAllAppStates() async {
    Map<String, String> allEntries = await _storage.readAll();
    List<AppState> appStates = [];

    allEntries.forEach((k,v) {
      if(k.startsWith(_storageKey + ":")){
        var a = json.decode(v);
        appStates.add(AppState.fromJson(a));
      }
    });

    return appStates;
  }

  static Future storeAppStateAndSetCurrent(AppState appState) async {
    await setCurrentUser(appState.Id);
    await storeAppState(appState);
  }

  static Future<String?> getBearer() async{
    String currentStorageKey = await _storage.read(key: _currentStorageKey) ?? '';
    AppState? user = await getAppState(currentStorageKey);
    if(user != null){
      return user.Bearer;
    }

    return '';
  }

  static String getStorageKey(String id){
    return _storageKey + ":" + id;
  }
}