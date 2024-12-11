import 'package:contact_diry/screens/add_new_contact.dart';
import 'package:contact_diry/screens/details_page.dart';
import 'package:contact_diry/screens/edit_page.dart';
import 'package:contact_diry/screens/homepage.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static String spleshscreen = '/';
  static String homepage = 'home_page';
  static String detailpage = 'detail_page';
  static String addnewcontact = 'add_new_contact';
  static String editpage = 'edit_page';

  static Map<String, WidgetBuilder> myRoutes = {
    homepage: (context) => const Home_Page(),
    detailpage: (context) => const Detail_Page(),
    addnewcontact: (context) => const Add_new(),
    editpage: (context) => const Edit_Page(),
  };
}
