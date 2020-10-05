import 'package:json_annotation/json_annotation.dart';
part 'LongPollWrapper.g.dart';

@JsonSerializable()
class LongPollWrapper {

  LongPollServerResponse response;

  LongPollWrapper(this.response);

  factory LongPollWrapper.fromJson(Map<String, dynamic> json) =>
      _$LongPollWrapperFromJson(json);

}

@JsonSerializable()
class LongPollServerResponse {

  String key;
  String server;
  int ts;

  LongPollServerResponse(this.key, this.server, this.ts);

  factory LongPollServerResponse.fromJson(Map<String, dynamic> json) =>
      _$LongPollServerResponseFromJson(json);

}

@JsonSerializable()
class LongPollAnswer {

  int ts;
  List<List<Object>> updates;

  LongPollAnswer(this.ts, this.updates);

  factory LongPollAnswer.fromJson(Map<String, dynamic> json) =>
      _$LongPollAnswerFromJson(json);

}