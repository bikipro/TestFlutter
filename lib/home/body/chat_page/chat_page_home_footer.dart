import 'package:flutter/material.dart';

class ChatPageHomeFooter extends StatelessWidget {
  final TextEditingController msgController;
  final Function callback2;
  final Function callback;

  const ChatPageHomeFooter({
    Key? key,
    required this.msgController,
    required this.callback2,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.only(left: 5, right: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(50),
      ),
      height: 50,
      //alignment: Alignment.bottomCenter,

      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            //color: Colors.blue,
            // alignment: Alignment.bottomCenter,
            height: 40,
            width: MediaQuery.of(context).size.width -
                MediaQuery.of(context).size.width / 3,
            child: TextField(
              textAlign: TextAlign.left,
              controller: msgController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                prefixIcon: InkWell(
                  onTap: () {
                    callback2("img");
                  },
                  child: const Icon(
                    Icons.image,
                    color: Color(0xFFF7F3F0),
                  ),
                ),
                hintText: "Message...",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              callback("msg");
            },
            child: const Icon(Icons.send),
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            )),
          )
          //SendBtn(title: "", icons: Icons.send, call: callback),
        ],
      ),
    );
  }
}
