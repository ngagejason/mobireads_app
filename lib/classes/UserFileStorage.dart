import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobi_reads/blocs/app_bloc/app_state.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_state.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineChapter.dart';
import 'package:path_provider/path_provider.dart';

class UserFileStorage {

  static Future<String> get getLocalPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> createFolderInAppDocDir(String folderName) async {
    if(folderName == null || folderName.length == 0){
      throw 'Cannot create folder with empty name.';
    }

    //Get this App Document Directory
    final Directory _directory = await getApplicationDocumentsDirectory();

    var rootDirExists = await _directory.exists();

    //App Document Directory + folder name
    folderName = folderName.replaceAll("-", "");
    final Directory _folder = Directory('${_directory.path}/$folderName/');

    //if folder already exists return path
    if (await _folder.exists()) {
      return _folder.path;
    }

    //if folder not exists create folder and then return its path
    final Directory _newDir = await _folder.create(recursive: true);
    return _newDir.path;
  }

  static Future<List<OutlineChapter>> getChapters(String folderName) async {
    String path = await createFolderInAppDocDir(folderName);
    final Directory _folder = Directory(path);

    List<OutlineChapter> chapters = [];
    List<FileSystemEntity> files = _folder.listSync(recursive: false, followLinks: false);
    for(int i = 0; i < files.length; i++) {
      FileSystemEntity file = files[i];
      if(file is File){
        String text = await (file as File).readAsString();
        if(text.length > 0){
          var a = json.decode(text);
          chapters.add(OutlineChapter.fromJson(a));
        }
        else{
          // Invalid chapter.
          file.delete();
        }
      }
    }

    return chapters;
  }

  static Future<void> saveChapters(String folderName, List<OutlineChapter> chapters) async {

    if(folderName.length == 0){
      return;
    }

    String path = await createFolderInAppDocDir(folderName);
    chapters.forEach((element) async {
      String id = element.Id.replaceAll("-", "");
      File file = File(path + id);
      if(await file.exists()){
        await file.delete();
      }
      await file.create();
      await file.writeAsString(json.encode(element));
    });
  }

  static Future<void> deleteChapter(String folderName, String chapterId) async {
    String path = await createFolderInAppDocDir(folderName);
    String id = chapterId.replaceAll("-", "");
    File file = File(path + id);
    if(await file.exists()){
      await file.delete();
    }
  }

  static Future<void> saveChapter(String folderName, OutlineChapter chapter) async {
    String path = await createFolderInAppDocDir(folderName);
    String id = chapter.Id.replaceAll("-", "");
    File file = File(path + id);
    if(await file.exists()){
      await file.delete();
    }

    await file.create();
    await file.writeAsString(json.encode(chapter));
  }

  static Future<void> clearAll() async {
    final Directory rootDirectory = await getApplicationDocumentsDirectory();
    var allBooks = rootDirectory.listSync(recursive: false);
    allBooks.forEach((element) async {
      await element.delete(recursive: true);
    });
  }

  static Future<void> clearBook(String folderName) async {
    String path = await createFolderInAppDocDir(folderName);
    final Directory _folder = Directory(path);

    List<FileSystemEntity> files = _folder.listSync(recursive: false, followLinks: false);
    for(int i = 0; i < files.length; i++) {
      FileSystemEntity file = files[i];
      if(file is File){
        file.delete();
      }
    }
  }

}