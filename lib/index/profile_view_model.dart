import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  TextEditingController nameSurnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
}
