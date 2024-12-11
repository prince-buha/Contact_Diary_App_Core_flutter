import 'package:contact_diry/screens/add_new_contact.dart';
import 'package:contact_diry/screens/details_page.dart';
import 'package:contact_diry/screens/edit_page.dart';
import 'package:contact_diry/screens/hide_contact_page.dart';
import 'package:contact_diry/screens/homepage.dart';
import 'package:flutter/material.dart';

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Home_Page(),
        'newcontact': (context) => const Add_new(),
        'detail': (context) => const Detail_Page(),
        'editpage': (context) => const Edit_Page(),
        'hidepage': (context) => const HideContactPage(),
      },
    );
  }
}
