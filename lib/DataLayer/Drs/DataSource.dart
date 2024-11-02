import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social/DataLayer/Models/MessageModel.dart';
import 'package:social/DomainLayer/Entities/RegisterEnt.dart';

abstract class AbstractRemoteData {
  Future<void> RegisterUser(
      String Email, String Password, String ConfirmPassword, String userName);
  Future<UserE?> LoginUser(
    String Email,
    String Password,
  );
  Future<void> createUser(String UserName);
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails();
  Future<void> addPost(String massge);
  Stream<QuerySnapshot> getPostsStream();
  Future<void> SendMessage(String reciverid, String message);
  Stream<QuerySnapshot> getMessages(String UserID, String OtherUserID);
  Future<void> deletePost(String postId);
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
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: Email, password: Password);
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'invalid-email':
          errorMessage = "The email address is not valid.";
          break;
        case 'user-not-found':
          errorMessage = "No user found with this email.";
          break;
        case 'wrong-password':
          errorMessage = "Incorrect password. Please try again.";
          break;
        case 'user-disabled':
          errorMessage = "This user account has been disabled.";
          break;
        default:
          errorMessage = "An error occurred. Please try again later.";
      }
      throw errorMessage;
    }
    return null;
  }

  @override
// Register
  Future<void> RegisterUser(String email, String password,
      String confirmPassword, String userName) async {
    if (password != confirmPassword) {
      throw "Passwords do not match";
    }

    try {
      // Register user with Firebase Auth
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print("Doneeeeeeeeeeeee");

      // Await profile creation to complete before proceeding
      await createUser(userName);
      // Return a UserE object if registration and profile creation are successful
    } on FirebaseAuthException catch (e) {
      // Customize error messages
      if (e.code == 'email-already-in-use') {
        throw "The email is already in use by another account.";
      } else if (e.code == 'invalid-email') {
        throw "The email address is not valid.";
      } else if (e.code == 'weak-password') {
        throw "The password is too weak. Please use a stronger password.";
      } else {
        throw "Registration failed: ${e.message}";
      }
    } catch (e) {
      print(e.toString());
      throw "An unexpected error occurred: ${e.toString()}";
    }
  }

  @override
// Create User Profile
  Future<void> createUser(String userName) async {
    if (userCredential != null && userCredential!.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential!
              .user!.email) // Use UID as the document ID for uniqueness
          .set({
        "email": userCredential!.user!.email,
        "username": userName,
        "uid": userCredential!.user!.uid
      });
      print("created sucifflyysdkmgksdmgksd");
    } else {
      print("uhdjshgjdsjgdsdjgsd shiiiiiiiit");
    }
  }

  @override
  //Add new post
  Future<void> addPost(String massge) {
    return posts.add({
      "UserName": currentUser!.email,
      "PostMessage": massge,
      "TimeStamp": Timestamp.now(),
    });
  }

  //get posts
  @override
  Stream<QuerySnapshot<Object?>> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("TimeStamp", descending: true)
        .snapshots();

    return postsStream;
  }

// Get User Details
  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Future<void> SendMessage(
    String Reciverid,
    String Message,
  ) async {
    User? currentUser =
        FirebaseAuth.instance.currentUser; // Check current user here
    if (currentUser == null) {
      throw "No user is currently logged in.";
    }
    final String currentUserID = currentUser.uid;
    final String? currentUserEmail = currentUser.email;
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

    _firestore
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

  @override
  Future<void> deletePost(String postId) async {
    try {
      await posts.doc(postId).delete();
    } catch (e) {
      throw Exception("Failed to delete post: $e");
    }
  }
}
