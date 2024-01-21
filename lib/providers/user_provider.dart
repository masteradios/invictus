import 'package:flutter/cupertino.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  ModelUser _user = ModelUser(
      username: '',
      email: '',
      userid: '',
      phoneNumber:'',
      address: '',
      gender: '',
      age: "",
      education_qualification: '',
      edu_board: '',
      family_income: '',
      caste: '');
  ModelUser get user => _user;

  void getUserDetails(ModelUser user) {
    _user = user;
    notifyListeners();
  }


}
