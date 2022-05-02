import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pay/home/body/friend_model.dart';

class MyProfile extends StatefulWidget {
  final String myId;
  final FriendModel detail;

  

  const MyProfile({Key? key, this.myId = "", required this.detail}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool wait = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("My Profile"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color(0xFFF7F3F0),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: AlignmentDirectional.center,
        children:[ SizedBox(
                    height: 200,
                    width: 200,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Scaffold(
                          body: Center(
                              child: Image.network(widget.detail.profile)))));
                        
                      },
                      child: widget.detail.profile == ""
                          ? Card(
                            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
                            elevation: 2,
                            child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                              widget.detail.name[0].toUpperCase(),
                              style: GoogleFonts.actor(
                    textStyle: const TextStyle(
                        fontSize: 50, color: Colors.black)),
                  )),
                            )
                          : Card(
                            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
                            elevation: 2,
                            child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.detail.profile))),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(25)
                      ),
                      
                      height: 70,
                      width: 70,
                      child: const Icon(Icons.camera,size: 40,color:Colors.white)),
                      onTap:(){
                        changeProfile();
                      }
                  ),
        ]
                ),
              ),
              
              SizedBox(
                height: 30,
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                            widget.detail.name,
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                          ),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text(
                            widget.detail.email,
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                              fontSize: 12,
                            )),
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future changeProfile() async {
    if (wait) {
      try {
        //final picker=ImagePicker();
        final image;
        wait = false;
        image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) {
          wait = true;
        } else {
          wait = false;
          File? cropedImage = await ImageCropper().cropImage(
              sourcePath: image.path, maxHeight: 1080, maxWidth: 1080
              aspectRatioPresets:[
                CropAspectRatioPreset.square,
              ],
        // androidUiSettings: AndroidUiSettings(
        //     toolbarTitle: 'Cropper',
        //     toolbarColor: Colors.deepOrange,
        //     toolbarWidgetColor: Colors.white,
        //     initAspectRatio: CropAspectRatioPreset.original,
        //     lockAspectRatio: false),
        // iosUiSettings: IOSUiSettings(
        //   title: 'Cropper',
        // )
              );
          if (cropedImage != null) {
            print("picked");
            var snapshot = await FirebaseStorage.instance
                .ref()
                .child('profiles')
                .child(widget.myId)
                .putFile(File(cropedImage.path));
            String url = await snapshot.ref.getDownloadURL();
            FirebaseFirestore.instance
                .collection("Users")
                .doc(widget.myId)
                .update({'profile': url}).whenComplete(() {
              wait = true;
              widget.detail.profile = url;
              setState(() {});
            });
          }else{wait=true;}
        }
      } catch (e) {
        print(e);
      }
    }
  }
}