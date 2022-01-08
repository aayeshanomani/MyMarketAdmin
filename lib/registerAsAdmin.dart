import 'package:admin_app_my_market/applicantScreen.dart';
import 'package:admin_app_my_market/services/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterAsAdmin extends StatefulWidget {
  const RegisterAsAdmin({Key? key}) : super(key: key);

  @override
  _RegisterAsAdminState createState() => _RegisterAsAdminState();
}

class _RegisterAsAdminState extends State<RegisterAsAdmin> {
  bool logging = false;
  String username = "", password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Register"), backgroundColor: Color(0xff6A994E)),
      body: ModalProgressHUD(
        inAsyncCall: logging,
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              child: Column(
            children: [
              const SizedBox(
                height: 28,
              ),
              const Text("Register here",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffBC4749))),
              const SizedBox(
                height: 28,
              ),
              TextFormField(
                style: TextStyle(color: Color(0xffF2E8CF)),
                onChanged: (val) {
                  setState(() {
                    username = val;
                  });
                },
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Color(0xffA7C957))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Color(0xff6A994E))),
                    filled: true,
                    fillColor: Color(0xff386641),
                    hintStyle: TextStyle(color: Color(0xffF2E8CF)),
                    hintText: "Username"),
              ),
              const SizedBox(
                height: 28,
              ),
              TextFormField(
                style: TextStyle(color: Color(0xffF2E8CF)),
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                obscureText: true,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Color(0xffA7C957))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Color(0xff6A994E))),
                    filled: true,
                    fillColor: Color(0xff386641),
                    hintStyle: TextStyle(color: Color(0xffF2E8CF)),
                    hintText: "Password"),
              ),
              const SizedBox(
                height: 28,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    logging = true;
                  });
                  if (username == "" || password == "") {
                    setState(() {
                      logging = false;
                    });
                    showMyDialog(context, "Fields not filled!",
                        "Kindly fill all the fields.", "");
                  } else {
                    Firestore.instance
                        .collection("admins")
                        .document(username)
                        .setData({
                      "username": username,
                      "password": password,
                      "applicant": true,
                    }, merge: true).then((value) {
                      setState(() {
                        logging = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ApplicantScreen(username: username,)));
                    });
                  }
                },
                child: const Text("Register", style: TextStyle(color: Color(0xffBC4749)),),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xffF2E8CF))),
              )
            ],
          )),
        )),
      ),
    );
  }
}
