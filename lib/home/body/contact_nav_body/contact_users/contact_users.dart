import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pay/home/body/friend_model.dart';
import 'package:pay/keep_login.dart';
import 'package:pay/sign_up/page_title.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactUsers extends StatefulWidget {
  ContactUsers({Key? key}) : super(key: key);

  @override
  State<ContactUsers> createState() => _ContactUsersState();
}

class _ContactUsersState extends State<ContactUsers> {
  List contact = [];
  //List users = [];
  bool isLoded = false;
  @override
  void initState() {
    initial();

    super.initState();
  }

  Future initial() async {
    if (KeepLogin.prefs.getStringList("uid") == null) {
      contact = await getContact().whenComplete(() {
        setState(() {
          // contact = value;
          //print("contactttttttttttttt" + value.length.toString());
          isLoded = true;
        });
      });
      // contactInDatabase().then((value) {
      //   contact = value;
      //   print("contactttttttttttttt" + value.length.toString());
      //   isLoded = true;
      //   setState(() {});
      // });
    } else {
      contact = KeepLogin.prefs.getStringList("uid")!.toList();

      setState(() {
        isLoded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoded
        ? Container(
            color: const Color(0xFFF7F3F0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: RefreshIndicator(
              onRefresh: () async {
                KeepLogin.prefs.remove("uid");
                await initial();
              },
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30.0, left: 10),
                    child: PageTitle(
                      title: "Contacts",
                      leftPad: 1.1,
                      titleColor: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: contact.isEmpty
                        ? const Text("Please add number in contact")
                        : FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('Users')
                                .get(),
                            builder: (BuildContext context, snapshot) {
                              List<FriendModel> users = [];
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                for (int i = 0;
                                    i < snapshot.data!.docs.length;
                                    i++) {
                                  if (contact.contains(
                                      snapshot.data!.docs[i]['number'])) {
                                    users.add(FriendModel(
                                        "",
                                        snapshot.data!.docs[i]['name'],
                                        "",
                                        snapshot.data!.docs[i]['profile'],
                                        snapshot.data!.docs[i]['number']));
                                  }
                                }
                                // int j = snapshot.data!.docs.length;
                                // print(snapshot.data!.docs[0].id);
                                // if (j > 0) {
                                //   for (int i = 0; i < j; i++) {
                                //     if (contact
                                //         .contains(snapshot.data!.docs[i].id)) {
                                //       users.add(FriendModel(
                                //           snapshot.data!.docs[i]['name'],
                                //           "",
                                //           snapshot.data!.docs[i]['profile'],
                                //           snapshot.data!.docs[i]['number']));
                                //     }
                                //   }
                                // }
                                if (users.isEmpty) {
                                  return const Text("No users in contact");
                                } else {
                                  return ListView.builder(
                                      //padding: EdgeInsets.all(16),

                                      //primary: false,
                                      itemCount: users.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(users[index].name),
                                          leading: SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: users[index].profile != ""
                                                  ? CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                              users[index]
                                                                  .profile))
                                                  : CircleAvatar(
                                                      child: Text(users[index]
                                                          .name[0]
                                                          .toString()
                                                          .toUpperCase()),
                                                      backgroundColor:
                                                          Colors.white,
                                                    )),
                                          subtitle: Text(users[index].number),
                                          onTap: () {
                                            print(users[index].name);
                                          },
                                        );
                                      });
                                }
                              }
                            },
                          ),
                  ),
                ],
              ),
            ))
        : const Center(child: CircularProgressIndicator());
  }

  Future<List> contactInDatabase() async {
    List contactU = [];
    List<String> users = [];
    contactU = await getContact();
    if (contactU.isNotEmpty) {
      print("abcd" + contactU.toString());

      int i = 0;
      int j = 0;
      FirebaseFirestore fs = FirebaseFirestore.instance;
      QuerySnapshot snapshot = await fs.collection('Users').get();
      //print(contactU[i]);
      print(snapshot.docs[j]['number']);
      for (i = 0; i < contactU.length; i++) {
        for (j = 0; j < snapshot.docs.length; j++) {
          if (contactU[i] == snapshot.docs[j]['number']) {
            users.add(snapshot.docs[j].id);

            print(snapshot.docs[j].id);
          }
        }
      }
      print("contactInDb" + contactU.length.toString());
      KeepLogin.prefs.setStringList("uid", users);

      return users;
    }
    print("emptyyyyyyyyyyyyyyyyy");
    return users;
  }

  Future<List> getContact() async {
    List<String> contact = [];
    try {
      PermissionStatus status = await Permission.contacts.status;
      if (status == PermissionStatus.granted) {
        Iterable<Contact> contacts = await ContactsService.getContacts();
        contacts.forEach((cnts) {
          cnts.phones!.toSet().forEach((element) {
            String number = element.value!;
            if (number.length >= 10) {
              contact.add(number.substring(element.value!.length - 10));
              print("number is" + number.substring(element.value!.length - 10));
            }
          });
        });
        if (contact.isNotEmpty) {
          KeepLogin.prefs.setStringList("uid", contact);
        }
        //contact = contacts;
        // for (var element in contacts) {
        //   contact.add(element.phones!.elementAt(0).value);
        //   print(element.displayName.toString() +
        //       '' +
        //       "" +
        //       element.phones!.elementAt(0).value.toString());
        // }

        return contact;
        //setState(() {});
      } else {
        status = await requestPermission();
        if (status == PermissionStatus.granted) {
          Iterable<Contact> contacts = await ContactsService.getContacts();

          //contact = contacts;
          contacts.forEach((cnts) {
            cnts.phones!.toSet().forEach((element) {
              String number = element.value!;
              if (number.length >= 10) {
                contact.add(number.substring(element.value!.length - 10));
                print(
                    "number is" + number.substring(element.value!.length - 10));
              }
            });
          });
          if (contact.isNotEmpty) {
            KeepLogin.prefs.setStringList("uid", contact);
          }

          return contact;
          //setState(() {});
        }
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
    return contact;
  }

  Future<PermissionStatus> requestPermission() async {
    final status = await Permission.contacts.request();
    return status;
  }
}
