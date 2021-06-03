import 'package:json_annotation/json_annotation.dart';

part 'ConverstationModel.g.dart';

@JsonSerializable()
class Converstation {
  conResponse response;

  Converstation({this.response});

  factory Converstation.fromJson(Map<String, dynamic> json) =>
      _$ConverstationFromJson(json);
}

@JsonSerializable()
class conResponse {
  int count;
  List<conItem> items;
  List<conProfile> profiles;

  conResponse({this.count, this.items, this.profiles});

  factory conResponse.fromJson(Map<String, dynamic> json) =>
      _$conResponseFromJson(json);
}

@JsonSerializable()
class conProfile {
  int id;
  String first_name;
  String last_name;
  String photo_100;
  int online;

  conProfile(
      {this.id, this.first_name, this.last_name, this.photo_100, this.online});

  factory conProfile.fromJson(Map<String, dynamic> json) =>
      _$conProfileFromJson(json);
}

@JsonSerializable()
class conItem {
  bool isAttachment;
  bool isMe;
  bool isWrite;
  conConverstation conversation;
  conLastMessage last_message;

  conItem(this.isAttachment, this.isMe, this.isWrite, this.conversation,
      this.last_message);

  factory conItem.fromJson(Map<String, dynamic> json) =>
      _$conItemFromJson(json);
}

@JsonSerializable()
class conConverstation {
  conPeer peer;
  int in_read;
  int out_read;
  int last_message_id;

  conConverstation(
      this.peer, this.last_message_id, this.in_read, this.out_read);

  factory conConverstation.fromJson(Map<String, dynamic> json) =>
      _$conConverstationFromJson(json);
}

@JsonSerializable()
class conPeer {
  int id;
  String type;
  int local_id;

  conPeer(this.id, this.type, this.local_id);

  factory conPeer.fromJson(Map<String, dynamic> json) =>
      _$conPeerFromJson(json);
}

@JsonSerializable()
class conLastMessage {
  String text;
  int from_id;
  List<conAttachment> attachments;

  conLastMessage(this.text, this.from_id, this.attachments);

  factory conLastMessage.fromJson(Map<String, dynamic> json) =>
      _$conLastMessageFromJson(json);
}

@JsonSerializable()
class conAttachment {
  String type;

  conAttachment(this.type);

  factory conAttachment.fromJson(Map<String, dynamic> json) =>
      _$conAttachmentFromJson(json);
}
