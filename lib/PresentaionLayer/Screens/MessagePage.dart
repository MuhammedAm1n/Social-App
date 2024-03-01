import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/DomainLayer/UseCases/LoginUseCase.dart';
import 'package:social/PresentaionLayer/Component/Clicker/ChatBubbles.dart';
import 'package:social/PresentaionLayer/Component/Clicker/ChatBubblesright.dart';
import 'package:social/PresentaionLayer/Component/Clicker/MyTexTField.dart';

class MessagePage extends StatefulWidget {
  final String reciverUserEmail;
  final String reciverId;
  final TextEditingController _messageController = TextEditingController();

  MessagePage({
    super.key,
    required this.reciverUserEmail,
    required this.reciverId,
  });

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.reciverUserEmail),
      ),
      body: Column(children: [
        //messages
        Expanded(
          child: _buildMessageList(),
        ),
        // user Input
        _buildMessageInput(),
        SizedBox(
          height: 15,
        )

        //
      ]),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyTEXTFIELD(
              keyboardType: TextInputType.text,
              controller: widget._messageController,
              hint: 'Enter message',
              observer: false),
        )),
// send button
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.circular(35)),
          height: 40,
          width: 60,
          child: Center(
            child: Consumer<UseCases>(
              builder: (BuildContext context, UseCases value, Widget? child) =>
                  MaterialButton(
                onPressed: () async {
                  await value.UseCaseSendMessage(
                      widget.reciverId, widget._messageController.text);

                  widget._messageController.clear();
                },
                child: Icon(Icons.done),
              ),
            ),
          ),
        )
      ],
    );
  }

// Messeges Item

  Widget _buildMessageItem(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == widget.reciverId)
        ? Alignment.centerLeft
        : Alignment.centerRight;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: (data['senderId'] == widget.reciverId)
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            mainAxisAlignment: (data['senderId'] == widget.reciverId)
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              Text(data['senderEmail']),
              SizedBox(
                height: 5,
              ),
              (data['senderId'] == widget.reciverId)
                  ? ChatBubbles(messages: data['message'])
                  : ChatBubblesright(messages: data['message'])
            ]),
      ),
    );
  }

// List OF Messges
  Widget _buildMessageList() {
    return Consumer<UseCases>(
      builder: (BuildContext context, UseCases value, Widget? child) =>
          StreamBuilder(
              stream:
                  value.UseCaseGetMessages(widget.reciverId, currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView(
                  children: snapshot.data!.docs
                      .map((document) => _buildMessageItem(document))
                      .toList(),
                );
              }),
    );
  }
}
