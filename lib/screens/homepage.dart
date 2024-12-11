import 'dart:developer';
import 'dart:io';
import 'package:contact_diry/screens/globels.dart';
import 'package:contact_diry/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:local_auth/local_auth.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (AppTheme.isDark) ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor:
            (AppTheme.isDark) ? Colors.teal.shade200 : Colors.black,
        elevation: 0,
        title: Text(
          "Contacts",
          style:
              TextStyle(color: (AppTheme.isDark) ? Colors.black : Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                AppTheme.isDark = !AppTheme.isDark;
              });
            },
            icon: Icon(
              (AppTheme.isDark) ? Icons.sunny : Icons.dark_mode_outlined,
              color: (AppTheme.isDark) ? Colors.black : Colors.white,
            ),
          ),
          IconButton(
            onPressed: () async {
              LocalAuthentication auth = LocalAuthentication();
              try {
                bool isCheckBioMetrics = await auth.canCheckBiometrics;

                log("AUTH Check : $isCheckBioMetrics");

                if (isCheckBioMetrics) {
                  bool isAuth = await auth.authenticate(
                    localizedReason:
                        "Auth is required for show hide contact page",
                    options: const AuthenticationOptions(
                      biometricOnly: false,
                    ),
                  );

                  if (isAuth) {
                    Navigator.pushNamed(context, 'hidepage');
                  }
                }
              } catch (e) {
                log("ERROR : $e");
              }
            },
            icon: Icon(
              Icons.remove_red_eye_outlined,
              color: (AppTheme.isDark) ? Colors.black : Colors.white,
            ),
          ),
        ],
      ),
      floatingActionButton: Theme(
        data: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.lightBlue),
        ),
        child: FloatingActionButton(
          backgroundColor:
              (AppTheme.isDark) ? Colors.teal.shade200 : Colors.black,
          child: Icon(
            Icons.add,
            color: (AppTheme.isDark) ? Colors.black : Colors.white,
            size: 30,
          ),
          onPressed: () {
            setState(() {
              Navigator.of(context).pushNamed('newcontact');
            });
          },
        ),
      ),
      body: (Global.allcontacts.isEmpty)
          ? Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_box_outlined,
                    size: 50,
                    color: (AppTheme.isDark) ? Colors.white : Colors.black,
                  ),
                  Text(
                    "Add New Contact",
                    style: TextStyle(
                      color: (AppTheme.isDark) ? Colors.white : Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: Global.allcontacts.length,
              itemBuilder: (context, i) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('detail', arguments: Global.allcontacts[i]);
                  },
                  leading: CircleAvatar(
                    backgroundImage: (Global.allcontacts[i].image != null)
                        ? FileImage(Global.allcontacts[i].image as File)
                        : null,
                  ),
                  title: Text(
                    "${Global.allcontacts[i].firstname} ${Global.allcontacts[i].lastname}",
                    style: TextStyle(
                        color: (AppTheme.isDark) ? Colors.white : Colors.black),
                  ),
                  subtitle: Text(
                    "+91 ${Global.allcontacts[i].phonenumber} ",
                    style: TextStyle(
                        color: (AppTheme.isDark) ? Colors.white : Colors.black),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.phone),
                    color: Colors.green,
                    onPressed: () async {
                      Uri url = Uri.parse(
                          "tel:+91 ${Global.allcontacts[i].phonenumber}");

                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Can't be launched..."),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
