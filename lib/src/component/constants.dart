import 'package:flutter/material.dart';

var myDefaultBackground = Colors.grey[350];

var mysecondaryBackground = const Color.fromRGBO(147, 179, 239, 1);

var colorstone1fontwhite1 = const Color.fromRGBO(0, 129, 167, 1);
var colorstone1fontwhite2 = const Color.fromRGBO(0, 175, 185, 1);
var colorstone1fontblack1 = const Color.fromRGBO(254, 217, 183, 1);
var colorstone1fontblack2 = const Color.fromRGBO(253, 252, 220, 1);
var colorstone1fontwhite3 = const Color.fromRGBO(240, 113, 103, 1);

var mygreycolors = Colors.grey[200];
var myAppBar = AppBar(
  backgroundColor: Colors.grey[300],
);

var myDrawer = SizedBox(
  width: 280,
  child: Drawer(
    backgroundColor: Colors.blue[200],
    child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          DrawerHeader(
              child: Card(
                  child: Image.network(
                      "https://www.siamtobacco.com/STEC-logoLandScape.png"))),
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://s.isanook.com/tr/0/ud/201/1009004/222.jpg"),
                    fit: BoxFit.fill)),
            accountName: Text("Thotsapol Pinthong"),
            accountEmail: Text("thotsapol@siamtobacco.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://pbs.twimg.com/profile_images/794107415876747264/g5fWe6Oh_400x400.jpg"),
            ),
            otherAccountsPictures: [
              CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://pbs.twimg.com/profile_images/794107415876747264/g5fWe6Oh_400x400.jpg")),
              CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://pbs.twimg.com/profile_images/794107415876747264/g5fWe6Oh_400x400.jpg")),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('H O M E P A G E'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person_search_rounded),
            title: const Text('E m p l o y e e'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.attach_money_rounded),
            title: const Text('S A L A R Y'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today_outlined),
            title: const Text('C A L E N D A R'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('S E T T I N G'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('L O G O U T'),
            onTap: () {
              // SharedPreferences preferences =
              //     await SharedPreferences.getInstance();
              // preferences.clear();
              // // Navigator.popAndPushNamed(
              // //     navigatorState.currentContext!, AppRoute.login);
              // Navigator.of(navigatorState.currentContext!).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (context) => const LoginPage()),
              //     (Route route) => false);
            },
          ),
          // BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          //   return ListTile(
          //     leading: const Icon(Icons.logout),
          //     title: const Text('L O G O U T B L O C'),
          //     onTap: () {
          //       context.read<LoginBloc>().add(LoginEventLogout());
          //     },
          //   );
          // }),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text('L O G O U T'),
          ),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text('L O G O U T'),
          ),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text('L O G O U T'),
          ),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text('L O G O U T'),
          ),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text('L O G O U T'),
          ),
        ]),
  ),
);
