import 'package:admin_app_my_market/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ApplicantDetails extends StatefulWidget {
  final String uid;

  const ApplicantDetails({Key? key, required this.uid}) : super(key: key);

  @override
  _ApplicantDetailsState createState() => _ApplicantDetailsState();
}

class _ApplicantDetailsState extends State<ApplicantDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Applicant Details"),
        backgroundColor: Color(0xff009FFD),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: Database().getApplicantDetails(widget.uid),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(47.0),
                  child: Container(
                    width: 500,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        color: Color(0xff232528),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffEAF6FF),
                            offset: const Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Color(0xffFFA400),
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(37.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Name: " + snapshot.data!.documents[0]["name"],
                              style: TextStyle(color: Color(0xffEAF6FF)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Phone Number: " +
                                  snapshot.data!.documents[0]["phoneNumber"],
                              style: TextStyle(color: Color(0xffEAF6FF)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Shop Name: " +
                                  snapshot.data!.documents[0]["shopName"],
                              style: TextStyle(color: Color(0xffEAF6FF)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Shop Address: \n" +
                                  snapshot.data!.documents[0]["shopAddress"],
                              style: TextStyle(color: Color(0xffEAF6FF)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Applied for: " +
                                  snapshot.data!.documents[0]["type"],
                              style: TextStyle(color: Color(0xffEAF6FF)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Shop Coordinates: {" +
                                  snapshot.data!.documents[0]["shopLat"]
                                      .toString() +
                                  ", " +
                                  snapshot.data!.documents[0]["shopLong"]
                                      .toString() +
                                  "}",
                              style: TextStyle(color: Color(0xffEAF6FF)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color(0xffFFA400)),
                                        elevation:
                                            MaterialStateProperty.all<double>(
                                                4.0)),
                                    child: Text("Approve"),
                                    onPressed: () {
                                      Firestore.instance
                                          .collection("users")
                                          .document(widget.uid)
                                          .setData({"applicant": false},
                                              merge: true);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color(0xff009FFD)),
                                        elevation:
                                            MaterialStateProperty.all<double>(
                                                4.0)),
                                    child: Text("Decline"),
                                    onPressed: () {
                                      Firestore.instance
                                          .collection("users")
                                          .document(widget.uid)
                                          .delete();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
