import 'package:social/DomainLayer/Entities/MessageEntity.dart';

class MessageModel extends MessageEntity {
  MessageModel(super.senderId, super.senderEmail, super.receiverID,
      super.message, super.timestamp);

  //convert to map

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'message': message,
      "timestamp": timestamp
    };
  }
}
