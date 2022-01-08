import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  getUserApplications() {
    return Firestore.instance
        .collection("users")
        .where("applicant", isEqualTo: true)
        .snapshots();
  }

  getAdminApplications() {
    return Firestore.instance
        .collection("admins")
        .where("applicant", isEqualTo: true)
        .snapshots();
  }

  Future<bool> checkUsernameandPassword(
      String username, String password) async {
    final result = await Firestore.instance
        .collection("admins")
        .where('username', isEqualTo: username)
        .where('password', isEqualTo: password)
        .where('applicant', isEqualTo: false)
        .getDocuments();
    print(result);
    return result.documents.isEmpty;
  }

  getApplicantDetails(String uid) {
    return Firestore.instance
        .collection("users")
        .where("userId", isEqualTo: uid)
        .snapshots();
  }

  Future<bool> checkApplicant(String username, String password) async {
    final result = await Firestore.instance
        .collection("admins")
        .where('username', isEqualTo: username)
        .where('password', isEqualTo: password)
        .where('applicant', isEqualTo: true)
        .getDocuments();
    print(result);
    return result.documents.isEmpty;
  }
}
