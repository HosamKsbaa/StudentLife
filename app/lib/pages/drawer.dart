import 'package:flutter/material.dart';
import 'package:nu_ra_stu_jur/Auth/LocalAuth/FireabaseAuth.dart';
import 'package:nu_ra_stu_jur/pages/settings/settings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ThemeData.dart';
import '../main.dart';
import 'NotificationPage.dart';

class DrawerTileAction extends StatelessWidget {
  final String text;
  final void Function() onPress;

  const DrawerTileAction({
    required this.text,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 12,
      ),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onPress,
    );
  }
}

class HDMDrawer extends StatelessWidget {
  const HDMDrawer({Key? key}) : super(key: key);
  final double _uiDistanceFromTheRight = 20;
  final double _wordDistanceFromTheRight = 25;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0),
              bottomRight: Radius.circular(0)),
        ),
        // shape: null, // Remove any rounding


        // width: MediaQuery.of(context).size.width * .4,
        child: Container(
          color: Colors.grey[100],
          child: Column(
            children: [
              Expanded(

                child: ListView(

                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * .34,
                      color: appBarColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: _uiDistanceFromTheRight,
                                    left: _uiDistanceFromTheRight * 1,
                                    top: 40,
                                    bottom: 10,
                                  ),
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: BackGround,
                                    backgroundImage: AssetImage('assets/2024-07-30_17-37.png'), // Use backgroundImage instead of child
                                  ),
                                ),
                                 Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 10,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        "Welcome",
                                        style: TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        "${profile.name} Welcome",
                                        style: TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            color: Colors.white,
                            endIndent: 8,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              right: 10,
                              left: 10,
                            ),
                            child: Center(
                              child: Text(
                                "Enjoy more options",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              right: 10,
                              left: 10,
                              top: 2,
                              bottom: 2,
                            ),
                            child: Center(
                              child: Text(
                                "with your Course Navigator",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            endIndent: 8,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                      height: 15,
                    ),
                    DrawerTileAction(
                      text: 'Settings',
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SettingsPage()),
                        );
                      },
                    ),
                    DrawerTileAction(
                      text: 'Notifications',
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotificationPage()),
                        );
                      },
                    ),
                    DrawerTileAction(
                      text: "Share App",
                      onPress: () async {
                        await launchUrl(Uri.parse("https://studentlife.pages.dev/"));
                        // Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                color: primaryColor,
                child: ListTile(
                  trailing: const Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 12,
                  ),
                  title: const Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    AuthService.logout();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
