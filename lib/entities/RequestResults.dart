import 'package:json_annotation/json_annotation.dart';

/// This allows the `RequestResult` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.

part 'RequestResults.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class RequestResults<T> {

  @JsonKey(defaultValue: false, name: 'success')
  bool Success;
  @JsonKey(name: 'message')
  String? Message;
  @JsonKey(name: 'data')
  List<T>? Data;
  @JsonKey(name: 'redirect')
  String? Redirect;

  RequestResults(this.Success, this.Message, this.Data, this.Redirect);

  factory RequestResults.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>  _$RequestResultsFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$RequestResultsToJson(this, toJsonT);
}