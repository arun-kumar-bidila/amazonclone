import 'package:amazon_clone/models/userModel.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: "",
      name: "",
      email: "",
      password: "",
      address: "",
      type: "",
      token: "",
      cart: []);
  bool _isLoading = true;

  User get user => _user;
  bool get isLoading => _isLoading;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }

  void setIsLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }
}
