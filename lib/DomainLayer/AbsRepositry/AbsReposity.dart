import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social/DomainLayer/Entities/RegisterEnt.dart';

abstract class AbsRepositry {
  Future<UserE?> RegistUser(
      String Email, String Password, String ConfirmPassword);
  Future<UserE?> LoginUser(String Email, String Password);
  Future<UserE?> CreateUser(String userName);
  Future<DocumentSnapshot<Map<String, dynamic>>> GetUserDetails();
  Future<void> Addpost(String massge);
  Stream<QuerySnapshot> getPostsStream();
  Future<void> SendMessage(String receiverId, String message);
  Stream<QuerySnapshot> getMessages(String UserID, String OtherUserID);
}
