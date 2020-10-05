// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ConverstationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Converstation _$ConverstationFromJson(Map<String, dynamic> json) {
  return Converstation(
    response: json['response'] == null
        ? null
        : conResponse.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ConverstationToJson(Converstation instance) =>
    <String, dynamic>{
      'response': instance.response,
    };

conResponse _$conResponseFromJson(Map<String, dynamic> json) {
  return conResponse(
    count: json['count'] as int,
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : conItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    profiles: (json['profiles'] as List)
        ?.map((e) =>
            e == null ? null : conProfile.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$conResponseToJson(conResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'items': instance.items,
      'profiles': instance.profiles,
    };

conProfile _$conProfileFromJson(Map<String, dynamic> json) {
  return conProfile(
    id: json['id'] as int,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    photo_100: json['photo_100'] as String,
    online: json['online'] as int,
  );
}

Map<String, dynamic> _$conProfileToJson(conProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'photo_100': instance.photo_100,
      'online': instance.online,
    };

conItem _$conItemFromJson(Map<String, dynamic> json) {
  return conItem(
    json['isAttachment'] as bool,
    json['isMe'] as bool,
    json['isWrite'] as bool,
    json['conversation'] == null
        ? null
        : conConverstation
            .fromJson(json['conversation'] as Map<String, dynamic>),
    json['last_message'] == null
        ? null
        : conLastMessage.fromJson(json['last_message'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$conItemToJson(conItem instance) => <String, dynamic>{
      'isAttachment': instance.isAttachment,
      'isMe': instance.isMe,
      'isWrite': instance.isWrite,
      'conversation': instance.conversation,
      'last_message': instance.last_message,
    };

conConverstation _$conConverstationFromJson(Map<String, dynamic> json) {
  return conConverstation(
    json['peer'] == null
        ? null
        : conPeer.fromJson(json['peer'] as Map<String, dynamic>),
    json['last_message_id'] as int,
  );
}

Map<String, dynamic> _$conConverstationToJson(conConverstation instance) =>
    <String, dynamic>{
      'peer': instance.peer,
      'last_message_id': instance.last_message_id,
    };

conPeer _$conPeerFromJson(Map<String, dynamic> json) {
  return conPeer(
    json['id'] as int,
    json['type'] as String,
    json['local_id'] as int,
  );
}

Map<String, dynamic> _$conPeerToJson(conPeer instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'local_id': instance.local_id,
    };

conLastMessage _$conLastMessageFromJson(Map<String, dynamic> json) {
  return conLastMessage(
    json['text'] as String,
    json['from_id'] as int,
    (json['attachments'] as List)
        ?.map((e) => e == null
            ? null
            : conAttachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$conLastMessageToJson(conLastMessage instance) =>
    <String, dynamic>{
      'text': instance.text,
      'from_id': instance.from_id,
      'attachments': instance.attachments,
    };

conAttachment _$conAttachmentFromJson(Map<String, dynamic> json) {
  return conAttachment(
    json['type'] as String,
  );
}

Map<String, dynamic> _$conAttachmentToJson(conAttachment instance) =>
    <String, dynamic>{
      'type': instance.type,
    };
