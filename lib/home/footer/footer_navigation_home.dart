import 'package:flutter/material.dart';

class FooterNavigation extends StatefulWidget {
  const FooterNavigation({Key? key}) : super(key: key);

  @override
  State<FooterNavigation> createState() => _FooterNavigationState();
}

class _FooterNavigationState extends State<FooterNavigation> {
  int selectedIted = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF7F3F0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildNavBarItem(Icons.chat, "CHAT", context, 0),
          buildNavBarItem(Icons.home, "HOOME", context, 1),
          buildNavBarItem(Icons.contact_page, "CONTACT", context, 2)
        ],
      ),
    );
    //   return BottomNavigationBar(backgroundColor: Color(0xFFFBF6D9), items: [
    //     BottomNavigationBarItem(icon: Icon(Icons.chat), label: "CHAT"),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.home),
    //       label: "HOME",
    //     ),
    //     BottomNavigationBarItem(icon: Icon(Icons.contact_page), label: "CONTACT")
    //   ]);
    // }
  }

  Widget buildNavBarItem(
      IconData icon, String title, BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIted = index;
        });
      },
      child: Container(
          decoration: BoxDecoration(
              color: index == selectedIted ? Colors.pink : Colors.white,
              borderRadius: BorderRadius.circular(10)),
          height: 50,
          width: MediaQuery.of(context).size.width / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              Text(
                title,
                style: const TextStyle(fontSize: 10),
              )
            ],
          )),
    );
  }
}
