import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social/DataLayer/Drs/DataSource.dart';
import 'package:social/DomainLayer/AbsRepositry/AbsReposity.dart';
import 'package:social/DomainLayer/Entities/RegisterEnt.dart';

class Repositry implements AbsRepositry {
  final AbstractRemoteData abstractRemoteData;

  Repositry(this.abstractRemoteData);

  @override
  @override
  Future<void> RegistUser(String Email, String Password, String Confirmpassword,
      String username) async {
    return await abstractRemoteData.RegisterUser(
        Email, Password, Confirmpassword, username);
  }

  @override
  Future<UserE?> LoginUser(String Email, String Password) async {
    return await abstractRemoteData.LoginUser(Email, Password);
  }

  @override
  Future<void> Addpost(String massge) {
    return abstractRemoteData.addPost(massge);
  }

  @override
  Future<void> CreateUser(String Username) async {
    await abstractRemoteData.createUser(Username);
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> GetUserDetails() async {
    return await abstractRemoteData.getUserDetails();
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

  @override
  Future<void> deletePost(String postId) async {
    await abstractRemoteData.deletePost(postId);
  }
}
