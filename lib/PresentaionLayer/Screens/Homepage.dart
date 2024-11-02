import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:social/DataLayer/Drs/DataSource.dart';
import 'package:social/DataLayer/Repositry/Repositry.dart';
import 'package:social/DomainLayer/AbsRepositry/AbsReposity.dart';
import 'package:social/DomainLayer/UseCases/LoginUseCase.dart';
import 'package:social/PresentaionLayer/Component/Clicker/MyDrawer.dart';
import 'package:social/PresentaionLayer/Component/Clicker/MyTexTField.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController type = TextEditingController();

  void postMessage() {
    AbstractRemoteData abstractRemoteData = RemoteData();
    AbsRepositry absRepositry = Repositry(abstractRemoteData);
    if (type.text.isNotEmpty) {
      UseCases(absRepositry).CaseAddpost(type.text);
      type.clear();
    }
  }

  Stream<QuerySnapshot<Object?>> Getposts() {
    AbstractRemoteData abstractRemoteData = RemoteData();
    AbsRepositry absRepositry = Repositry(abstractRemoteData);
    return UseCases(absRepositry).CasegetPostsStream();
  }

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: (AppBar(
        title: const Text('Posts'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'Users');
                },
                child: const Icon(Icons.messenger_rounded)),
          )
        ],
      )),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          //TextField For Type poST

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTEXTFIELD(
                      controller: type,
                      hint: "What's on your mind?",
                      observer: false),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(35)),
                  height: 40,
                  width: 60,
                  child: Center(
                    child: MaterialButton(
                      onPressed: postMessage,
                      child: const Icon(Icons.done),
                    ),
                  ),
                )
              ],
            ),
          ),

          // Posts

          Consumer<UseCases>(
            builder: (context, value, child) => StreamBuilder(
                stream: value.CasegetPostsStream(),
                builder: (context, snapshot) {
                  // if Has Error
                  if (snapshot.hasError) {
                    return Text('Error : ${snapshot.data}');
                  }
                  // Show loading circual
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // get all data
                  final posts = snapshot.data!.docs;
                  // If no data

                  if (snapshot.data == null || posts.isEmpty) {
                    return const Center(
                        child: Text('No Posts.. Post something!'));
                  }
                  if (snapshot.hasData && snapshot.data != null) {
                    // return as list
                    return Expanded(
                      child: ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (builder, index) {
                            // indivdiual post
                            final post = posts[index];
                            // get data from each post
                            String message = post['PostMessage'];
                            Timestamp timestamp = post['TimeStamp'];
                            DateTime dateTime = timestamp.toDate();
                            String formattedDate =
                                "${dateTime.day} / ${dateTime.month}";
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      if (currentUser!.email ==
                                          post["UserName"]) {
                                        value.UseCasedeletePost(post.id);
                                      }
                                    },
                                    icon: Icons.delete,
                                    backgroundColor: Colors.red,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8, bottom: 8),
                                child: ListTile(
                                  title: Text(message),
                                  subtitle: Text(
                                    post["UserName"],
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                  leading: Text(" $formattedDate"),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                  return const Text('Ok');
                }),
          )
        ],
      ),
    );
  }
}
