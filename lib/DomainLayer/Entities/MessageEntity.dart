import 'package:cloud_firestore/cloud_firestore.dart';

class MessageEntity {
  final String senderId;
  final String? senderEmail;
  final String receiverID;
  final String message;
  final Timestamp timestamp;

  MessageEntity(this.senderId, this.senderEmail, this.receiverID, this.message,
      this.timestamp);
}
