// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LongPollWrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LongPollWrapper _$LongPollWrapperFromJson(Map<String, dynamic> json) {
  return LongPollWrapper(
    json['response'] == null
        ? null
        : LongPollServerResponse.fromJson(
            json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LongPollWrapperToJson(LongPollWrapper instance) =>
    <String, dynamic>{
      'response': instance.response,
    };

LongPollServerResponse _$LongPollServerResponseFromJson(
    Map<String, dynamic> json) {
  return LongPollServerResponse(
    json['key'] as String,
    json['server'] as String,
    json['ts'] as int,
  );
}

Map<String, dynamic> _$LongPollServerResponseToJson(
        LongPollServerResponse instance) =>
    <String, dynamic>{
      'key': instance.key,
      'server': instance.server,
      'ts': instance.ts,
    };

LongPollAnswer _$LongPollAnswerFromJson(Map<String, dynamic> json) {
  return LongPollAnswer(
    json['ts'] as int,
    (json['updates'] as List)?.map((e) => e as List)?.toList(),
  );
}

Map<String, dynamic> _$LongPollAnswerToJson(LongPollAnswer instance) =>
    <String, dynamic>{
      'ts': instance.ts,
      'updates': instance.updates,
    };
