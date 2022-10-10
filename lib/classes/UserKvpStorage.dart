import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobi_reads/blocs/app_bloc/app_state.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_state.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineChapter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserKvpStorage {

  static SharedPreferences? prefs;

  static Future<double> getScrollOffset(String bookId) async {
    await setupReader();
    return prefs?.getDouble(bookId + "_currentOffset") ?? 0;
  }

  static Future<void> setScrollOffset(String bookId, double offset) async {
    await setupReader();
    prefs?.setDouble(bookId + "_currentOffset", offset);
  }

  static Future<double> getFontSize(String bookId) async {
    await setupReader();
    return prefs?.getDouble(bookId + "_fontSize") ?? 1;
  }

  static Future<void> setFontSize(String bookId, double offset) async {
    await setupReader();
    prefs?.setDouble(bookId + "_fontSize", offset);
  }

  static Future<String> getCurrentBookId() async {
    await setupReader();
    return prefs?.getString('CURRENT_BOOK_ID') ?? '';
  }

  static Future<void> setCurrentBookId(String bookId) async {
    await setupReader();
    prefs?.setString('CURRENT_BOOK_ID', bookId);
  }

  static Future<void> clearAll() async {
    setupReader();
    if(prefs != null){
      await prefs!.clear();
    }
  }

  static Future<void> clearCurrentBookId() async {
    await setupReader();
    prefs?.remove('CURRENT_BOOK_ID');
  }

  static Future<void> setupReader() async {
    if(prefs == null){
      prefs = await SharedPreferences.getInstance();
    }
  }
}