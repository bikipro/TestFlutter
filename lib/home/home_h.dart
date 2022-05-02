import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _value = 1;
  static const menuItems = <String>[
    'One',
    'Two',
    'Three',
    'Four',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  final List<PopupMenuItem<String>> _popUpMenuItems = menuItems
      .map(
        (String value) => PopupMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _btn1SelectedVal = 'One';
  String? _btn2SelectedVal;
  late String _btn3SelectedVal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Container(
              height: 100,
              color: Colors.white,
              // padding: EdgeInsets.all(3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        //
                        Text(
                          "Stories",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        new Divider(),
                        new Divider(),
                        CircleAvatar(
                          backgroundColor: Color(0xff25d366),
                          radius: 10,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 9,
                      child: Row(
                        children: [
// SizedBox(width: 340,),

                          Container(
                            margin: EdgeInsets.only(top: 28, right: 50),
                            child: CircleAvatar(
                              backgroundColor: Color(0xff25d366),
                              radius: 10,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            elevation: 8,
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Container(
              height: 100,
              color: Colors.white,
              // padding: EdgeInsets.all(3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        //

                        new Divider(),
                        new Divider(),
                        Container(
                          margin: EdgeInsets.only(right: 13),
                          child: CircleAvatar(
                            backgroundColor: Color(0xff25d366),
                            radius: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 14,
                      child: Row(
                        children: [
// SizedBox(width: 340,),

                          Container(
                              child: Text(
                                  'What is your mind ? #Hashing.\n @Mention.. Link')),
                        ],
                      )),
                ],
              ),
            ),
            elevation: 8,
          ),
          Card(
            child: Container(
              width: MediaQuery.of(context).size.width,

              //  margin: EdgeInsets.only(right: 370,),
              height: 100,

              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 30, top: 0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xff25d366),
                        radius: 10,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 0),
                            child: Text(
                              'Welcome Atif ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text(
                                  'Write it on your heart that every day is the \n best day in the year'))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 45),
                        alignment: Alignment.center,
//margin: EdgeInsets.only(right: 67,bottom: 57),
                        child: Icon(Icons.close)),
                  ],
                ),
              ),
            ),
            elevation: 8,
            margin: EdgeInsets.all(10),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Container(
              color: Colors.white,
              height: 100,
              // padding: EdgeInsets.all(3),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            margin: EdgeInsets.only(top: 40, left: 30),
                            child: Text(
                              'Recent Update',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 60, top: 30),
                          child:
                              Icon(Icons.navigation_outlined)), //draw_outlined
                      Container(
                          margin: EdgeInsets.only(left: 30, top: 30),
                          child: Text('All')),
                      Container(
                          margin: EdgeInsets.only(left: 30, top: 30),
                          child: Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                ],
              ),
            ),
            elevation: 8,
          ),
          Card(
            child: Container(
              width: MediaQuery.of(context).size.width,

              //  margin: EdgeInsets.only(right: 370,),
              height: 100,

              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 30, top: 0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xff25d366),
                        radius: 15,
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 1,
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 7,
                              bottom: 0,
                            ),
                            child: Text(
                              'kritkia Sharma ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 17),
                              child: Text('12 hours ago')),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 70, right: 22),
                        alignment: Alignment.center,
//margin: EdgeInsets.only(right: 67,bottom: 57),
                        child: Text('added a video')),

                    /*Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 7,),
                          child:  Text('12 hours ago -  ',style: TextStyle(fontWeight: FontWeight.bold),),

                        ),
                      ],
                    ),*/
                    SizedBox(
                      width: 65,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 0, bottom: 45),
                        child: Icon(Icons.arrow_drop_down)),
                  ],
                ),
              ),
            ),
            elevation: 8,
            margin: EdgeInsets.all(10),
          ),
          Flexible(
            child: Container(
              width: MediaQuery.of(context).size.width,

              //  margin: EdgeInsets.only(right: 370,),
              height: 190,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/img/profile.png'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          //   padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 15.0,
              ),
              title: Text('Atif Raza'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.message_sharp),
              title: Text('Messagesw'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('FAVORITES'),
            ),
            ListTile(
                leading: Icon(Icons.article),
                title: Text('News Feed'),
                onTap: () {},
                trailing: Icon(Icons.keyboard_arrow_down)),
            ListTile(
              leading: Icon(Icons.article_sharp),
              title: Text('My Articles'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.production_quantity_limits_outlined),
              title: Text('My Products'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.post_add_outlined),
              title: Text('Solved Posts'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.memory),
              title: Text('Memories'),
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('ADVERTISING'),
            ),
            ListTile(
              leading: Icon(Icons.adb_sharp),
              title: Text('Ads Manager'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.wallet_giftcard),
              title: Text('Wallet'),
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('EXPLORE'),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('People'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.pages),
              title: Text('Pages'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Groups'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.event_sharp),
              title: Text('Events'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.book_online_outlined),
              title: Text('Blogs'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.place_outlined),
              title: Text('Marketplace'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
        actions: [
          Row(
            children: [],
          )
        ],
        elevation: 0,
        title: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.house_outlined),
                  Icon(Icons.account_balance),
                  Icon(Icons.chat),
                  Icon(Icons.notification_add_outlined),
                  Icon(Icons.card_giftcard),
                  Icon(Icons.search),
                  CircleAvatar(
                    radius: 15.0,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: 30.0,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Country List'),
                                content: new ListView(
                                  children: [
                                    Column(
                                      children: [
                                        DropdownButton<String>(
                                          items: <String>[
                                            'A',
                                            'B',
                                            'C',
                                            'D',
                                            'E',
                                            'F',
                                            'G'
                                          ].map((String value) {
                                            return new DropdownMenuItem<String>(
                                              value: value,
                                              child: new Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (_) {},
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      })
                ])));
  }
}
