import 'dart:convert';
import 'package:mobi_reads/blocs/app_bloc/app_state.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_state.dart';
import 'package:mobi_reads/classes/IOFactory.dart';
import 'package:mobi_reads/classes/UserKvpStorage.dart';
import 'package:mobi_reads/constants.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/entities/RequestResult.dart';
import 'package:mobi_reads/entities/bool_response/bool_response.dart';
import 'package:mobi_reads/entities/events/EventLogRequest.dart';

class EventLogRepository {

  static EventLogRepository shared = new EventLogRepository();

  Future<BoolResponse> logEvent(EventLogRequest req) async {
    var response = await IOFactory.doPostWithBearer(urlExtension: ServerPaths.LOG_EVENT, data: req);
    if (response.statusCode == 200) {
      RequestResult<BoolResponse> result =  RequestResult<BoolResponse>.fromJson(jsonDecode(response.body), (data) => BoolResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.ErrorBoolResponse;
    }

    return new BoolResponse(false, "Server Error");
  }

  Future<BoolResponse> logState(ReaderState readerState) async {
    Map<String, dynamic> logs = new Map<String, dynamic>();

    if(readerState.book != null){
      logs["currentBookId"] = readerState.book!.Id;
      logs["scrollOffset"] = await UserKvpStorage.getScrollOffset(readerState.book!.Id);
      logs["fontSize"] = await UserKvpStorage.getFontSize(readerState.book!.Id);
    }

    EventLogRequest req = new EventLogRequest(EventTypes.MESSAGE, "EventLogRepository", "logState", jsonEncode(logs));
    var response = await IOFactory.doPostWithBearer(urlExtension: ServerPaths.LOG_EVENT, data: req);
    if (response.statusCode == 200) {
      RequestResult<BoolResponse> result =  RequestResult<BoolResponse>.fromJson(jsonDecode(response.body), (data) => BoolResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.ErrorBoolResponse;
    }

    return new BoolResponse(false, "Server Error");
  }
}
