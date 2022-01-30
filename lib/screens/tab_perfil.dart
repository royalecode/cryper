import 'package:cryper/components/SettingsRow.dart';
import 'package:cryper/constantes_app.dart';
import 'package:cryper/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const int SYSTEM_THEME = 1;
const int DARK_THEME = 2;
const int LIGHT_THEME = 3;

Future<int> getSelectedTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("themeMode")) {
    print(prefs.getInt("themeMode"));
    if (prefs.getInt("themeMode") == SYSTEM_THEME) {
      return SYSTEM_THEME;
    }
    if (prefs.getInt("themeMode") == DARK_THEME) {
      return DARK_THEME;
    }
    if (prefs.getInt("themeMode") == LIGHT_THEME) {
      return LIGHT_THEME;
    }
  }
  prefs.setInt("themeMode", SYSTEM_THEME);
  return SYSTEM_THEME;
}


class TabPerfil extends StatefulWidget {
  const TabPerfil({Key? key}) : super(key: key);

  @override
  _TabPerfil createState() => _TabPerfil();
}

class _TabPerfil extends State<TabPerfil> {
  int? selectedTheme;

  @override
  void initState() {
    getSelectedTheme().then((value) => {
          setState(() {
            selectedTheme = value;
          })
        });
    super.initState();
  }

  Icon getThemeIcon(int theme){
    if(theme == (selectedTheme ?? 0)){
      return Icon(Icons.check_circle_rounded, color: Theme.of(context).colorScheme.primary);
    }
    return const Icon(Icons.circle_outlined, color: Color(0xFF747E98), size: 20,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: primaryColor,
        body: SafeArea(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Settings",
                      style: Theme.of(context).textTheme.headline2,
                    )
                  ],
                ),
              ),
              SettingsRow(
                  iconData: Icons.dark_mode_outlined,
                  label: "Theme",
                  onpress: () {
                    showModalBottomSheet(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            ListTile(
                              title: const Text("Dark",
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: "Inter")),
                              leading: getThemeIcon(DARK_THEME),
                            ),
                            ListTile(
                              title: const Text("Light",
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: "Inter")),
                              leading: getThemeIcon(LIGHT_THEME),
                            ),
                            ListTile(
                              title: const Text("System",
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: "Inter")),
                              leading: getThemeIcon(SYSTEM_THEME),
                            ),
                          ],
                        );
                      },
                    );
                  }),
              SettingsRow(
                  iconData: Icons.payments_outlined,
                  label: "Currency",
                  onpress: () {}),
              SettingsRow(
                  iconData: Icons.logout,
                  label: "Logout",
                  onpress: () {
                    _signOut();
                  }),
            ],
          )),
    ));
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    //print(FirebaseAuth.instance.currentUser?.email);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
