// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessageJson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageJson _$MessageJsonFromJson(Map<String, dynamic> json) {
  return MessageJson(
    json['response'] == null
        ? null
        : messResponse.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MessageJsonToJson(MessageJson instance) =>
    <String, dynamic>{
      'response': instance.response,
    };

messResponse _$messResponseFromJson(Map<String, dynamic> json) {
  return messResponse(
    (json['items'] as List)
        ?.map((e) =>
            e == null ? null : messItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$messResponseToJson(messResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

messItem _$messItemFromJson(Map<String, dynamic> json) {
  return messItem(
    json['text'] as String,
    (json['attachments'] as List)
        ?.map((e) => e == null
            ? null
            : conAttachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['from_id'] as int,
  );
}

Map<String, dynamic> _$messItemToJson(messItem instance) => <String, dynamic>{
      'text': instance.text,
      'attachments': instance.attachments,
      'from_id': instance.from_id,
    };
