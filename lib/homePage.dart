import 'package:admin_app_my_market/applicantDetails.dart';
import 'package:admin_app_my_market/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Console"),
        backgroundColor: const Color(0xff0F7173),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 28,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Applications",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffFFA400),
                      fontFamily: 'Bebas_Neue',
                      letterSpacing: 2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Seller and Delivery",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color(0xffFFA400),
                      fontFamily: 'Bebas_Neue',
                      letterSpacing: 2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: Database().getUserApplications(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      return Container(
                        child: Column(children: [
                          for (var i = 0;
                              i < snapshot.data!.documents.length;
                              i++)
                            GestureDetector(
                              onTap: () {
                                print("uid: " +
                                    snapshot.data!.documents[i]["userId"]);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ApplicantDetails(
                                            uid: snapshot.data!.documents[i]
                                                ["userId"])));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  width: 600,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Color(0xff009FFD),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff232528),
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                        BoxShadow(
                                          color: Color(0xffEAF6FF),
                                          offset: const Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                            "Name: " +
                                                snapshot.data!.documents[i]
                                                    ["name"],
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Color(0xff2A2A72),
                                                fontFamily: 'Bebas_Neue',
                                                letterSpacing: 1.7)),
                                        Text(
                                            "Applied for: " +
                                                snapshot.data!.documents[i]
                                                    ["type"],
                                            style: TextStyle(
                                              fontSize: 18,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ]),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Admins",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color(0xffFFA400),
                      fontFamily: 'Bebas_Neue',
                      letterSpacing: 2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: Database().getAdminApplications(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      return Container(
                        child: Column(children: [
                          for (var i = 0;
                              i < snapshot.data!.documents.length;
                              i++)
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                width: 600,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: Color(0xff009FFD),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xff232528),
                                        offset: const Offset(
                                          5.0,
                                          5.0,
                                        ),
                                        blurRadius: 10.0,
                                        spreadRadius: 2.0,
                                      ), //BoxShadow
                                      BoxShadow(
                                        color: Color(0xffEAF6FF),
                                        offset: const Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                          "Name: " +
                                              snapshot.data!.documents[i]
                                                  ["username"],
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Color(0xff2A2A72),
                                              fontFamily: 'Bebas_Neue',
                                              letterSpacing: 1.7)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                const Color(
                                                                    0xffFFA400)),
                                                    elevation:
                                                        MaterialStateProperty
                                                            .all<double>(4.0)),
                                                onPressed: () {
                                                  Firestore.instance
                                                      .collection("admins")
                                                      .document(snapshot.data!
                                                              .documents[i]
                                                          ["username"])
                                                      .setData({
                                                    "applicant": false,
                                                  }, merge: true);
                                                },
                                                child: Text("Approve")),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                const Color(
                                                                    0xff2A2A72)),
                                                    elevation:
                                                        MaterialStateProperty
                                                            .all<double>(4.0)),
                                                onPressed: () {
                                                  Firestore.instance
                                                      .collection("admins")
                                                      .document(snapshot.data!
                                                              .documents[i]
                                                          ["username"])
                                                      .delete();
                                                },
                                                child: Text("Decline")),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                        ]),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
