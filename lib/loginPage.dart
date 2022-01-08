import 'package:admin_app_my_market/applicantScreen.dart';
import 'package:admin_app_my_market/homePage.dart';
import 'package:admin_app_my_market/registerAsAdmin.dart';
import 'package:admin_app_my_market/services/database.dart';
import 'package:admin_app_my_market/services/widgets.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool logging = false;
  String username = "", password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: const Color(0xff386641),
      ),
      // ignore: avoid_unnecessary_containers
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
              const Text("Login here",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffBC4749))),
              const SizedBox(
                height: 28,
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    username = val;
                  });
                },
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Color(0xff6A994E))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Color(0xffA7C957))),
                    filled: true,
                    fillColor: Color(0xffF2E8CF),
                    hintText: "Username"),
              ),
              const SizedBox(
                height: 28,
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                obscureText: true,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Color(0xff6A994E))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Color(0xffA7C957))),
                    filled: true,
                    fillColor: Color(0xffF2E8CF),
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
                    if (!await Database()
                        .checkUsernameandPassword(username, password)) {
                      setState(() {
                        logging = false;
                      });
                      
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                    else if (!await Database()
                        .checkApplicant(username, password)) {
                      setState(() {
                        logging = false;
                      });
                      
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ApplicantScreen(username: username,)));
                    } else {
                      setState(() {
                        logging = false;
                      });
                      bool? check = await showMyDialog(
                          context,
                          "Credentials not matched!",
                          "Either username or password is not correct.",
                          "Want to register?");

                      if (check != null) {
                        if (check) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterAsAdmin()));
                        }
                      }
                    }
                  }
                },
                child: const Text("Login"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xff386641))),
              )
            ],
          )),
        )),
      ),
    );
  }
}
