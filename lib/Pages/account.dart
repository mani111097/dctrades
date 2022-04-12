import 'dart:io';
import 'dart:html' as html;
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dctradesadmin/progressbar.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as Path;

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  DateTime date = DateTime.now();
  String acno1;
  TextEditingController acno = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController bdate = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController aadar = TextEditingController();
  TextEditingController pan = TextEditingController();
  TextEditingController accno = TextEditingController();
  TextEditingController accname = TextEditingController();
  TextEditingController ifsc = TextEditingController();
  double acheight = 0;
  String afurl, aburl, purl;
  double createcontainer = 0;
  String acnumber = "",
      gender = "Male",
      plantype = "Bronze",
      accsearchselection = "Acc No";
  int gendervalue = 0, planvalue = 0, searchselection = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 235, 235),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Account",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.5),
                Row(
                  children: [
                    Text(FirebaseAuth.instance.currentUser.email),
                  ],
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(MediaQuery.of(context).size.height * 0.01)),
                color: Colors.white,
              ),

              //padding: EdgeInsets.all(10),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Phone Number/AC No.:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: TextField(
                              controller: acno,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                      value: 0,
                                      groupValue: searchselection,
                                      onChanged: (value) {
                                        if (mounted) {
                                          setState(() {
                                            accsearchselection = "Acc No";
                                            searchselection = value;
                                          });
                                        }
                                      }),
                                  Text("A/C No."),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: 1,
                                      groupValue: searchselection,
                                      onChanged: (value) {
                                        if (mounted) {
                                          setState(() {
                                            accsearchselection = "Phone No";
                                            searchselection = value;
                                          });
                                        }
                                      }),
                                  Text("Phone No"),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    if (mounted) {
                                      setState(() {
                                        acheight =
                                            MediaQuery.of(context).size.height *
                                                0.7;
                                        createcontainer = 0;

                                        acnumber = acno.text;
                                      });
                                    }
                                  },
                                  child: Text(
                                    "Search",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        if (mounted) {
                          setState(() {
                            createcontainer =
                                MediaQuery.of(context).size.height * 0.7;

                            acheight = 0;
                          });
                        }
                      },
                      child: Container(
                        //height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: Colors.amber,
                            )),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.add,
                              size: 50,
                              color: Colors.amber,
                            ),
                            Text(
                              "Create New Account",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              height: acheight,
              width: MediaQuery.of(context).size.width * 0.8,
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height * 0.01),
                color: Colors.white,
              ),
              child: accountdetails(),
            ),
            Container(
                height: createcontainer,
                width: MediaQuery.of(context).size.width * 0.8,
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.01),
                    color: Colors.white),
                child: createAccount()),
          ],
        ),
      ),
    );
  }

  accountdetails() {
    print(accsearchselection + acnumber);

    if (accsearchselection == "Acc No") {
      FirebaseFirestore.instance
          .collection("Loan")
          .where("Acc No", isEqualTo: acnumber)
          .get()
          .then((value) {
        print(value.docs);
      });
      print("object called");
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Account")
            .where("Acc No", isEqualTo: acnumber)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning_rounded,
                      size: 150,
                    ),
                    Text(
                      "No data found ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ]),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return cart(index, snapshot.data.docs[index]);
            },
          );
        },
      );
    } else {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Account")
            .where("Phone Number", isEqualTo: acnumber)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning_rounded,
                      size: 150,
                    ),
                    Text(
                      "No data found ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ]),
            );
          }
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return cart(index, snapshot.data.docs[index]);
            },
          );
        },
      );
    }
  }

  cart(int index, QueryDocumentSnapshot docs) {
    print("Acc number" + docs["Loan No"].toString());
    return Container(
        height: acheight,
        child: Column(
          children: [
            Text(
              "Account Details:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.39,
                    child: Column(children: [
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Text(
                                "Account Number:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(docs["Acc No"]))
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Text("Name:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(docs["Name"]))
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Text("Email Id:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Text(docs["Email Id"]))
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Text("Phone Number:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(docs["Phone Number"]))
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Text("Gender:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(docs["Gender"]))
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Text("DOB:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(docs["DOB"]))
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Text("Address:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(docs["Address"]["Street"]),
                                  Text(docs["Address"]["Area"]),
                                  Text(docs["Address"]["City"] +
                                      " - " +
                                      docs["Address"]["Pin code"]),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Text("Plan:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(docs["Plan Type"]))
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Text("Aadar:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(docs["Aadar"]["Aadar No"])),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                html.window.open(
                                    docs["Aadar"]["Aadar front"], "Aadar");
                                //showid(docs["Aadar"]["Aadar front"]);
                              },
                              child: Text("Veiw Aadar Front")),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01),
                          TextButton(
                              onPressed: () {
                                html.window.open(
                                    docs["Aadar"]["Aadar back"], "Aadar back");
                                //showid(docs["Aadar"]["Aadar front"]);
                              },
                              child: Text("Veiw Aadar Back"))
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Text("Pan:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(docs["Pan"]["Pan No"]))
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            html.window.open(docs["Pan"]["Pan"], "Pan");
                            //showid(docs["Aadar"]["Aadar front"]);
                          },
                          child: Text("Veiw Aadar Back")),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.06),
                          Container(
                              child: Text("Bank Account Details:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Text("Account Holder Name:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(docs["Account"]["Acc Name"]))
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Text("Account No:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(docs["Account"]["Acc No"]))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Text("IFSC code:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(docs["Account"]["IFSC"]))
                        ],
                      ),
                    ]),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.38,
                    child: Column(children: []),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  showid(String url) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              margin: EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Column(
                // mainAxisAlignment:
                //     MainAxisAlignment.center,
                children: [
                  // Container(
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       image: NetworkImage(url),
                  //       fit: BoxFit.fill,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          );
        });
  }

  createAccount() {
    return Container(
      //padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.005),
      child: Column(
        children: [
          Text(
            "Create a new Account:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name:"),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Enter user Full Name",
                              // border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.all(8)),
                          controller: name,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Text("Email:"),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Enter user Email Id",
                              // border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.all(8)),
                          controller: email,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Text("Phone Number:"),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Enter user Phone Number",
                              isDense: true,
                              contentPadding: EdgeInsets.all(8)),
                          controller: phone,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text("Gender:"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Radio(
                                    value: 0,
                                    groupValue: gendervalue,
                                    onChanged: (value) {
                                      if (mounted) {
                                        setState(() {
                                          gender = "Female";
                                          gendervalue = value;
                                        });
                                      }
                                    }),
                                Text("Male"),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: 1,
                                    groupValue: gendervalue,
                                    onChanged: (value) {
                                      if (mounted) {
                                        setState(() {
                                          gender = "Female";
                                          gendervalue = value;
                                        });
                                      }
                                    }),
                                Text("Female"),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: 2,
                                    groupValue: gendervalue,
                                    onChanged: (value) {
                                      if (mounted) {
                                        setState(() {
                                          gender = "Other";
                                          gendervalue = value;
                                        });
                                      }
                                    }),
                                Text("Other"),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text("Date of Birth:"),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Select the date",
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(8)),
                                controller: bdate,
                              ),
                            ),
                            GestureDetector(
                                onTap: () async {
                                  DateTime selecteddate = await showDatePicker(
                                      context: context,
                                      initialDate: date,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100));
                                  if (mounted) {
                                    setState(() {
                                      bdate.text = selecteddate.day.toString() +
                                          "/" +
                                          selecteddate.month.toString() +
                                          "/" +
                                          selecteddate.year.toString();
                                    });
                                  }
                                },
                                child: Icon(Icons.date_range_outlined))
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Text("Address:"),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "House No/Flat No and Street",
                              isDense: true,
                              contentPadding: EdgeInsets.all(8)),
                          controller: street,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Area/Colony",
                              isDense: true,
                              contentPadding: EdgeInsets.all(8)),
                          controller: area,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "City",
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(8)),
                                controller: city,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.2,
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Pin Code",
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(8)),
                                controller: pin,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.height * 0.1,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Aadar Number:"),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Enter user Aadar Number",
                                // border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)),
                            controller: aadar,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.15,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.amber),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.height *
                                          0.01),
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      imageupload("faadar");
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.file_download_outlined),
                                        Text("Upload Aadar front photo")
                                      ],
                                    )),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.15,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.amber),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.height *
                                          0.01),
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      imageupload("baadar");
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.file_download_outlined),
                                        Text("Upload Aadar back photo")
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005,
                          ),
                          Text("PAN Number:"),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Enter user PAN Number",
                                // border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)),
                            controller: pan,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.amber),
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * 0.01),
                            ),
                            child: TextButton(
                                onPressed: () {
                                  imageupload("pan");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.file_download_outlined),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.01,
                                    ),
                                    Text("Upload PAN front photo")
                                  ],
                                )),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.009,
                          ),
                          Text("Plan type:"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                      value: 0,
                                      groupValue: planvalue,
                                      onChanged: (value) {
                                        if (mounted) {
                                          setState(() {
                                            plantype = "Bronze";
                                            planvalue = value;
                                          });
                                        }
                                      }),
                                  Text("Bronze"),
                                ],
                              ),
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width * 0.03,
                              // ),
                              Row(
                                children: [
                                  Radio(
                                      value: 1,
                                      groupValue: planvalue,
                                      onChanged: (value) {
                                        if (mounted) {
                                          setState(() {
                                            plantype = "Silver";
                                            planvalue = value;
                                          });
                                        }
                                      }),
                                  Text("Silver"),
                                ],
                              ),
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width * 0.03,
                              // ),
                              Row(
                                children: [
                                  Radio(
                                      value: 2,
                                      groupValue: planvalue,
                                      onChanged: (value) {
                                        if (mounted) {
                                          setState(() {
                                            plantype = "Gold";
                                            planvalue = value;
                                          });
                                        }
                                      }),
                                  Text("Gold"),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: 3,
                                      groupValue: planvalue,
                                      onChanged: (value) {
                                        if (mounted) {
                                          setState(() {
                                            plantype = "Diamond";
                                            planvalue = value;
                                          });
                                        }
                                      }),
                                  Text("Diamond"),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: 4,
                                      groupValue: planvalue,
                                      onChanged: (value) {
                                        if (mounted) {
                                          setState(() {
                                            plantype = "Platinum";
                                            planvalue = value;
                                          });
                                        }
                                      }),
                                  Text("Platinum"),
                                ],
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.width * 0.01,
                          // ),
                          Text("Account Details"),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Account Holder Name",
                                // border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)),
                            controller: accname,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.005,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Account Number",
                                // border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)),
                            controller: accno,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.005,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "IFSC Code",
                                // border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)),
                            controller: ifsc,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      DatabaseReference ref = FirebaseDatabase
                                          .instance
                                          .ref("Local/Local");
                                      DatabaseEvent event = await ref.once();

                                      int no = int.parse(
                                          event.snapshot.child("Acc No").value);

                                      acno1 = (no + 1).toString();
                                      FirebaseFirestore.instance
                                          .collection("Account")
                                          .where("Phone Number",
                                              isEqualTo: phone.text)
                                          .get()
                                          .then((value) {
                                        if (value == null) {
                                          Map<String, dynamic> data = {
                                            "Name": name.text,
                                            "Email Id": email.text,
                                            "Phone Number": phone.text,
                                            "Gender": gender,
                                            "DOB": bdate.text,
                                            "Acc No": "DCG" + acno1,
                                            "Address": {
                                              "Street": street.text,
                                              "Area": area.text,
                                              "City": city.text,
                                              "Pin code": pin.text
                                            },
                                            "Aadar": {
                                              "Aadar No": aadar.text,
                                              "Aadar front": afurl,
                                              "Aadar back": aburl
                                            },
                                            "Pan": {
                                              "Pan No": aadar.text,
                                              "Pan": purl
                                              // "Pan back" :
                                            },
                                            "Plan Type": plantype,
                                            "Account": {
                                              "Acc No": accno.text,
                                              "Acc Name": accname.text,
                                              "IFSC": ifsc.text
                                            }
                                          };

                                          FirebaseFirestore.instance
                                              .collection("Account")
                                              .doc("DCG$acno1")
                                              .set(data);

                                          FirebaseFirestore.instance
                                              .collection("Local")
                                              .doc("Local")
                                              .update({"Acc No": acno1});
                                          showconfirmationdailog();
                                        } else {
                                          errorDailog(
                                              "Phone Number Already Exist",
                                              "Please use the same account");
                                        }
                                      });
                                    },
                                    child: Text(
                                      "Create",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  imageupload(String type) async {
    html.InputElement input = html.FileUploadInputElement()..accept = "image/";
    input.click();

    input.onChange.listen((event) {
      final file = input.files.first;
      final reader = html.FileReader();
      reader.readAsDataUrl(file);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => Progressbar(
                message: "Image is getting uploaded.Please wait",
              ));
      reader.onLoadEnd.listen((event) async {
        Reference ref = FirebaseStorage.instance.ref().child("$acno1/$type");
        UploadTask uploadTask = ref.putBlob(file);
        TaskSnapshot taskSnapshot = await uploadTask;
        String imageURL = await taskSnapshot.ref.getDownloadURL();
        print(imageURL);
        if (type == "faadar") {
          if (mounted) {
            setState(() {
              afurl = imageURL;
            });
          }
        } else if (type == "baadar") {
          if (mounted) {
            setState(() {
              aburl = imageURL;
            });
          }
        } else if (type == "pan") {
          if (mounted) {
            setState(() {
              purl = imageURL;
            });
          }
        }
        Navigator.of(context).pop();
      });
    });
  }

  errorDailog(String error1, String error2) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              margin: EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Error",
                      style: TextStyle(
                          color: Color.fromARGB(255, 226, 172, 7),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Image.asset("images/error.gif"),
                  Text(
                    error1,
                    style: TextStyle(
                        color: Color.fromARGB(255, 226, 172, 9), fontSize: 15),
                  ),
                  Text(
                    error2,
                    style: TextStyle(
                        color: Color.fromARGB(255, 226, 172, 9), fontSize: 15),
                  ),
                ],
              ),
            ),
          );
        });
  }

  showconfirmationdailog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              margin: EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Column(
                // mainAxisAlignment:
                //     MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Congratulation!",
                      style: TextStyle(
                          color: Color.fromARGB(255, 226, 172, 9),
                          fontSize: 30),
                    ),
                  ),
                  Image.asset("images/Ok.gif"),
                  Text(
                    "Your Account has been created successfully ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 226, 172, 9), fontSize: 15),
                  ),
                  Text(
                    "Account Number: ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 226, 172, 9), fontSize: 15),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Text(
                    "DCG$acno1",
                    style: TextStyle(
                        color: Color.fromARGB(255, 226, 172, 9),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        });
  }
}
