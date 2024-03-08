import 'dart:io';

import 'package:codejam/controller/chatController.dart';
import 'package:codejam/widget/customtexfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
              CustomTextfeild(
                controller: chatController.searchController,
                hintText: "Search",
                icon: Icons.search,
              ),
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
                child: Padding(
                  padding: const EdgeInsets.all(15),
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
                        controller: chatController.userNameController,
                        hintText: "Username",
                        icon: Icons.person,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextfeild(
                        controller: chatController.messageController,
                        hintText: "Message",
                        icon: Icons.message,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                              child: Obx(() => Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: chatController.imagePath.isNotEmpty
                                          ? FileImage(File(
                                              chatController.imagePath.value))
                                          : const AssetImage(
                                                  'assets/default.png')
                                              as ImageProvider<Object>,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(Icons.camera_alt_sharp))))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          shadowColor: const Color(0xff1E346F),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Add",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "GeneralSans",
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
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