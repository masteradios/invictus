import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUser {
  final String username;
  final String email;
  final String phoneNumber;
  final String userid;
  final String address;
  final String gender;
  final String education_qualification;
  final String edu_board;
  final String family_income;
  final String caste;
  final String age;
  ModelUser(
      {required this.username,
      required this.email,
        required this.age,
      required this.gender,
      required this.education_qualification,
      required this.edu_board,
      required this.family_income,
      required this.caste,
      required this.userid,
      required this.phoneNumber,
      required this.address});

  Map<String, dynamic> toMap() {
    return {
      'id': userid,
      'username': username,
      'email': email,
      'address': address,
      'phoneNumber': phoneNumber,
      "gender":gender,
      "education_qualification":education_qualification,
      "edu_board":edu_board,
      "family_income":family_income,
      "caste":caste,
      "age":age
    };
  }

  static ModelUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ModelUser(
        email: snapshot['email'],
        age:snapshot["age"]??"",
        username: snapshot['username'],
        userid: snapshot['id'],
        phoneNumber: snapshot['phoneNumber']??"",
        gender:snapshot['gender']??"",
        education_qualification:snapshot['education_qualification']??"",
        edu_board:snapshot['edu_board']??"",
        family_income:snapshot['family_income']??"",
        caste:snapshot['caste']??"",
        address: snapshot['address']??"");
  }
}
