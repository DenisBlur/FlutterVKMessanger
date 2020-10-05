import 'package:flutter_vk_app/supports/variables.dart';

String nameAttachment(String type) {
  switch (type) {
    case "sticker":
      return "Cтикер";
      break;
    case "photo":
      return "Фотография";
      break;
    case "call":
      return "Звонок";
      break;
    case "wall":
      return "Запись на стены";
      break;
    case "audio":
      return "Аудиозапись";
      break;
    default:
      return type;
  }
}

bool isMeFun (int id) {

  if (id.toString() == USER_ID) {
    return true;
  } else {
    return false;
  }

}