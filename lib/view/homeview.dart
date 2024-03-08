import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          backgroundColor: Color(0xff1E346F),
          onPressed: () {
            Get.bottomSheet(Container(
              height: 300,
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
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Message",
                        labelStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xff4D4B4B),
                            fontFamily: "GeneralSans",
                            fontWeight: FontWeight.w400),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
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
