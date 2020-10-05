import '../ConverstationModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'MessageJson.g.dart';

@JsonSerializable()
class MessageJson {

  messResponse response;

  MessageJson(this.response);

  factory MessageJson.fromJson(Map<String, dynamic> json) =>
      _$MessageJsonFromJson(json);

}

@JsonSerializable()
class messResponse {

  List<messItem> items;

  messResponse(this.items);

  factory messResponse.fromJson(Map<String, dynamic> json) =>
      _$messResponseFromJson(json);

}

@JsonSerializable()
class messItem {

  String text;
  List<conAttachment> attachments;
  int from_id;

  messItem(this.text, this.attachments, this.from_id);

  factory messItem.fromJson(Map<String, dynamic> json) =>
      _$messItemFromJson(json);

}