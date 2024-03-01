import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social/DataLayer/Models/MessageModel.dart';
import 'package:social/DomainLayer/Entities/RegisterEnt.dart';

abstract class AbstractRemoteData {
  Future<UserE?> RegisterUser(
      String Email, String Password, String ConfirmPassword);
  Future<UserE?> LoginUser(
    String Email,
    String Password,
  );
  Future<UserE?> CreateUser(String UserName);
  Future<DocumentSnapshot<Map<String, dynamic>>> GetUserDetails();
  Future<void> Addpost(String massge);
  Stream<QuerySnapshot> getPostsStream();
  Future<void> SendMessage(String reciverid, String message);
  Stream<QuerySnapshot> getMessages(String UserID, String OtherUserID);
}

class RemoteData implements AbstractRemoteData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;
  UserCredential? userCredential;
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("Posts");

  @override
  //Login
  Future<UserE?> LoginUser(String Email, String Password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: Email, password: Password);
    return null;
  }

  @override
  // Register
  Future<UserE?> RegisterUser(
      String Email, String Password, String ConfirmPassword) async {
    if (Password != ConfirmPassword) {
      print('Error Passwords Dosent match');
    } else {
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: Email, password: Password);
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    }
    return null;
  }

  @override
  //Add new post
  Future<void> Addpost(String massge) {
    return posts.add({
      "UserEmail": currentUser!.email,
      "PostMessage": massge,
      "TimeStamp": Timestamp.now()
    });
  }

  @override
  // Create User Profile
  Future<UserE?> CreateUser(String UserName) async {
    if (userCredential != null && userCredential!.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential!.user!.email)
          .set({
        "email": userCredential!.user!.email,
        "username": UserName,
        "uid": userCredential!.user!.uid
      });
    } else {
      print('A7a');
    }
    return null;
  }

// Get User Details
  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> GetUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Stream<QuerySnapshot<Object?>> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("TimeStamp", descending: true)
        .snapshots();

    return postsStream;
  }

  @override
  Future<void> SendMessage(
    String Reciverid,
    String Message,
  ) async {
    // get current user info
    final String currentUserID = currentUser!.uid;
    final String? currentUserEmail = currentUser!.email;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    MessageModel newMessages = MessageModel(
        currentUserID, currentUserEmail, Reciverid, Message, timestamp);

    //constrcut Chat room id from curent and reeciver ids
    List<String> ids = [currentUserID, Reciverid];
    ids.sort();
    String ChatRoomId = ids.join(
        '_'); // Combining id's to single String used as UNique ChatRoom Id

    // add new message to Db

    await _firestore
        .collection('chat_rooms')
        .doc(ChatRoomId)
        .collection('messages')
        .add(newMessages.toMap());
  }

  @override
  Stream<QuerySnapshot<Object?>> getMessages(
      String UserID, String OtherUserID) {
    //Constcut Chat room id from ids'
    List<String> IDs = [UserID, OtherUserID];
    IDs.sort();
    String chatroomID = IDs.join('_');

    //GetMessages
    return _firestore
        .collection('chat_rooms')
        .doc(chatroomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
