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

  Future<UserE?> CaseRegistUser(
      String Email, String Password, String ConfirmPassword) async {
    return await absRepositry.RegistUser(Email, Password, ConfirmPassword);
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

  Future<UserE?> CreateUser(String userName) async {
    return await absRepositry.CreateUser(userName);
  }

  Future<void> UseCaseSendMessage(String receiverId, String message) async {
    return await absRepositry.SendMessage(receiverId, message);
  }

  Stream<QuerySnapshot> UseCaseGetMessages(String UserID, String OtherUserID) {
    return absRepositry.getMessages(UserID, OtherUserID);
  }
}
