import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social/DataLayer/Drs/DataSource.dart';
import 'package:social/DomainLayer/AbsRepositry/AbsReposity.dart';
import 'package:social/DomainLayer/Entities/RegisterEnt.dart';

class Repositry implements AbsRepositry {
  final AbstractRemoteData abstractRemoteData;

  Repositry(this.abstractRemoteData);

  @override
  @override
  Future<UserE?> RegistUser(
      String Email, String Password, String Confirmpassword) async {
    return await abstractRemoteData.RegisterUser(
        Email, Password, Confirmpassword);
  }

  @override
  Future<UserE?> LoginUser(String Email, String Password) async {
    return await abstractRemoteData.LoginUser(Email, Password);
  }

  @override
  Future<void> Addpost(String massge) {
    return abstractRemoteData.Addpost(massge);
  }

  @override
  Future<UserE?> CreateUser(String Username) async {
    return await abstractRemoteData.CreateUser(Username);
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> GetUserDetails() async {
    return await abstractRemoteData.GetUserDetails();
  }

  @override
  Stream<QuerySnapshot<Object?>> getPostsStream() {
    return abstractRemoteData.getPostsStream();
  }

  @override
  Future<void> SendMessage(String receiverId, String message) async {
    await abstractRemoteData.SendMessage(receiverId, message);
  }

  @override
  Stream<QuerySnapshot> getMessages(String UserID, String OtherUserID) {
    return abstractRemoteData.getMessages(UserID, OtherUserID);
  }
}
