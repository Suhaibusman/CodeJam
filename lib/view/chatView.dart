import 'package:codejam/controller/chatController.dart';
import 'package:codejam/widget/customtexfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  "Messages",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "GeneralSans",
                      fontWeight: FontWeight.w400),
                ),
              ),
              CustomTextfeild(controller: chatController.searchController),
              Expanded(
                  child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      child: Text('$index'),
                    ),
                    title: Text(
                      'Message $index',
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "GeneralSans",
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Message $index',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff4D4B4B),
                          fontFamily: "GeneralSans",
                          fontWeight: FontWeight.w400),
                    ),
                  );
                },
              )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff1E346F),
          onPressed: () {
            Get.bottomSheet(SingleChildScrollView(
              child: Container(
                height: 400,
                width: Get.width * 1,
                color: Colors.white,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Add Message",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "GeneralSans",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    CustomTextfeild(
                        controller: chatController.userNameController),
                    CustomTextfeild(
                        controller: chatController.messageController),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Upload Image :",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff4D4B4B),
                                fontFamily: "GeneralSans",
                                fontWeight: FontWeight.w400)),
                        InkWell(
                            onTap: () {
                              chatController.getImage();
                            },
                            child: const CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 25,
                                child: Icon(Icons.camera_alt_sharp)))
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "GeneralSans",
                            fontWeight: FontWeight.w400),
                      ),
                      style: ElevatedButton.styleFrom(
                        shadowColor: const Color(0xff1E346F),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 24,
          ),
        ));
  }
}
