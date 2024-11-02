import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:social/DomainLayer/AbsRepositry/AbsReposity.dart';
import 'package:social/DomainLayer/Entities/RegisterEnt.dart';

class UseCases extends ChangeNotifier {
  final AbsRepositry absRepositry;

  UseCases(this.absRepositry);

  Future<UserE?> CaseLoginUser(String Email, String Password) async {
    return await absRepositry.LoginUser(Email, Password);
  }

  Future<void> CaseRegistUser(String Email, String Password,
      String ConfirmPassword, String userName) async {
    try {
      await absRepositry.RegistUser(Email, Password, ConfirmPassword, userName);
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> CaseGetUserDetails() async {
    return await absRepositry.GetUserDetails();
  }

  Future<void> CaseAddpost(String massge) async {
    await absRepositry.Addpost(massge);
    notifyListeners();
  }

  Stream<QuerySnapshot> CasegetPostsStream() {
    return absRepositry.getPostsStream();
  }

  Future<void> CreateUser(String userName) async {
    await absRepositry.CreateUser(userName);
  }

  Future<void> UseCaseSendMessage(String receiverId, String message) async {
    return await absRepositry.SendMessage(receiverId, message);
  }

  Stream<QuerySnapshot> UseCaseGetMessages(String UserID, String OtherUserID) {
    return absRepositry.getMessages(UserID, OtherUserID);
  }

  Future<void> UseCasedeletePost(String postId) async {
    try {
      await absRepositry.deletePost(postId);
    } catch (e) {
      throw Exception("Failed to delete post: $e");
    }
  }
}
