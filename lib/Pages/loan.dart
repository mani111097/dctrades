import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dctradesadmin/loandetails.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Loan extends StatefulWidget {
  @override
  State<Loan> createState() => _LoanState();
}

class _LoanState extends State<Loan> {
  double loanContainer = 0;
  double acheight = 0;
  String iacno = "";
  String invplandropdonw = "Small Credit";
  String loanmonthdropdonw = "3 Months";
  TextStyle headerstyle = TextStyle(fontWeight: FontWeight.bold);
  TextEditingController amount = TextEditingController();
  TextEditingController uacno = TextEditingController();
  TextEditingController accno = TextEditingController();
  String months = "15 days Credit", intrest = "1% Intrest";
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  Loandetails loandetails = Loandetails();
  String iaccnum = "";
  bool month = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 235, 235),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Loans/Credits",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(MediaQuery.of(context).size.height * 0.01)),
                color: Colors.white,
              ),
              child: Row(children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: TextFormField(
                    controller: accno,
                    decoration: InputDecoration(
                      hintText: "Enter Loan Account number",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      print("Button clicked");
                      setState(() {
                        iaccnum = accno.text;
                      });

                      accountdetails();
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<CircleBorder>(
                            CircleBorder())),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          loanContainer =
                              MediaQuery.of(context).size.height * 0.7;

                          acheight = 0;
                        });
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.amber),
                                  borderRadius: BorderRadius.circular(10)))),
                      child: Text("New Loan/Credit")),
                ),
              ]),
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
              child: cart(),
            ),
            Container(
                height: loanContainer,
                width: MediaQuery.of(context).size.width * 0.8,
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.01),
                    color: Colors.white),
                child: createloan()),
          ],
        ),
      ),
    );
  }

  loantype() {
    return DropdownButton<String>(
      value: invplandropdonw,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.grey,
      ),
      onChanged: (String newValue) {
        if (newValue == "Small Credit") {
          setState(() {
            invplandropdonw = newValue;
            months = "15 days Credit";
            intrest = "1% Intrest";
            month = false;
          });
        } else if (newValue == "Personal Loan") {
          setState(() {
            invplandropdonw = newValue;
            //months = "3,6,9,12 Months";
            intrest = "6.39% Intrest";
            month = true;
          });
        }
      },
      items: <String>[
        'Small Credit',
        'Personal Loan',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              Text(value),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  loanmonths() {
    return DropdownButton<String>(
      value: loanmonthdropdonw,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.grey,
      ),
      onChanged: (String newValue) {
        setState(() {
          loanmonthdropdonw = newValue;
        });
      },
      items: <String>['3 Months', '6 Months', '9 Months', '12 Months']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              Text(value),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  createloan() {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
            child: Text(
          "New Loan Request",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.4,
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User Account Number:",
                      style: headerstyle,
                    ),
                    TextFormField(
                      controller: uacno,
                      decoration: InputDecoration(
                          hintText: "Enter user Account Number",
                          isDense: true,
                          contentPadding: EdgeInsets.all(10)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Account Number Cannot be Empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      "Loan Amount:",
                      style: headerstyle,
                    ),
                    TextFormField(
                        controller: amount,
                        decoration: InputDecoration(
                            hintText: "Enter the amount required",
                            isDense: true,
                            contentPadding: EdgeInsets.all(10)),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Amount Cannot be Empty";
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      "Select the plan for inversment",
                      style: headerstyle,
                    ),
                    loantype(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      child: month == true
                          ? loanmonths()
                          : SizedBox(
                              width: 0,
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_key.currentState.validate()) {
                                  print("validated");
                                }
                                if (amount.text.isNotEmpty &&
                                    uacno.text.isNotEmpty) {
                                  DatabaseReference ref = FirebaseDatabase
                                      .instance
                                      .ref("Local/Local");
                                  DatabaseEvent event = await ref.once();

                                  int no = int.parse(
                                      event.snapshot.child("Loan No").value);

                                  iacno = (no + 1).toString();

                                  Map<String, String> data = {
                                    "Loan No": "DCGL$iacno",
                                    "Created Date": dateTime.day.toString() +
                                        "/" +
                                        dateTime.month.toString() +
                                        "/" +
                                        dateTime.year.toString(),
                                    "Payment Date": returnspayer(
                                            amount.text, invplandropdonw)
                                        .last,
                                    "Acc No": uacno.text,
                                    "Amount": amount.text,
                                    "Plan": invplandropdonw,
                                    "Intrest Payed": (int.parse(returnspayer(
                                                    amount.text,
                                                    invplandropdonw)
                                                .first) -
                                            int.parse(amount.text))
                                        .toString(),
                                    "Months": month == true
                                        ? loanmonthdropdonw
                                        : months,
                                    "Monthly Payment": month == true
                                        ? monthlypayable(amount.text)
                                        : " ",
                                    "Total Payment": returnspayer(
                                            amount.text, invplandropdonw)
                                        .first,
                                    "Status": "Active"
                                  };

                                  FirebaseFirestore.instance
                                      .collection("Account")
                                      .doc(uacno.text)
                                      .update({
                                    "Loan No": {"DCGL$iacno"}
                                  });
                                  FirebaseFirestore.instance
                                      .collection("Loan")
                                      .doc("DCGL$iacno")
                                      .set(data);

                                  ref.child("Loan No").set(iacno).whenComplete(
                                      () => print("$iacno Completed"));

                                  showconfirmationdailog();
                                } else {}

                                // showconfirmationdailog();
                              },
                              child: Text(
                                "Create",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.38,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              "Plan:",
                              style: headerstyle,
                            ),
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.1,
                          // ),
                          Container(child: Text(invplandropdonw))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              "Loan Amount:",
                              style: headerstyle,
                            ),
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.1,
                          // ),
                          Container(child: Text(amount.text))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              "Intrest Payable:",
                              style: headerstyle,
                            ),
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.1,
                          // ),
                          Container(
                              child: Text((amount.text.isEmpty)
                                  ? ""
                                  : (int.parse(returnspayer(
                                                  amount.text, invplandropdonw)
                                              .first) -
                                          int.parse(amount.text))
                                      .toString()))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              "Total Payment:",
                              style: headerstyle,
                            ),
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.1,
                          // ),
                          Container(
                              child: Text((amount.text.isEmpty)
                                  ? ""
                                  : returnspayer(amount.text, invplandropdonw)
                                      .first))
                        ],
                      ),
                      SizedBox(
                        height: month
                            ? MediaQuery.of(context).size.height * 0.025
                            : 0,
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(
                                "Monthly Payment:",
                                style: headerstyle,
                              ),
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width * 0.1,
                            // ),
                            Container(
                                child: Text((amount.text.isEmpty)
                                    ? ""
                                    : (month == true)
                                        ? monthlypayable(amount.text)
                                        : " "))
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              "Intrest Rate:",
                              style: headerstyle,
                            ),
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.1,
                          // ),
                          Container(child: Text(intrest))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              "Months:",
                              style: headerstyle,
                            ),
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.1,
                          // ),
                          Container(
                              child: Text(
                                  month == true ? loanmonthdropdonw : months))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              "Payment Date:",
                              style: headerstyle,
                            ),
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.1,
                          // ),
                          Container(
                              child: Text((amount.text.isEmpty)
                                  ? ""
                                  : returnspayer(amount.text, invplandropdonw)
                                      .last))
                        ],
                      ),
                    ],
                  )),
            )
          ],
        )
      ]),
    );
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
                    "Your loan has been created successfully ",
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
                    "DCGL$iacno",
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

  DateTime dateTime = DateTime.now();

  accountdetails() {
    FirebaseFirestore.instance
        .collection("Loan")
        .where("Loan No", isEqualTo: iaccnum)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          loandetails.loanAccno = element.data()["Loan No"];
          loandetails.loanamount = element.data()["Amount"];
          loandetails.createddate = element.data()["Created Date"];
          loandetails.useraccno = element.data()["Acc No"];
          loandetails.months = element.data()["Months"];
          loandetails.plan = element.data()["Plan"];
          loandetails.totalpayable = element.data()["Total Payment"];
          loandetails.endDate = element.data()["Payment Date"];
          loandetails.monthlypayable = element.data()["Monthly Payment"];
          loandetails.status = element.data()["Status"];
          loandetails.intpayable = element.data()["Intrest Payed"];
          loandetails.endDate = element.data()["Payment Date"];

          loanContainer = 0;
          acheight = MediaQuery.of(context).size.height * 0.7;
        });
      });
    });
  }

  cart() {
    return Column(
      children: [
        Text(
          "Account Details:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Text(
                          "Account Number:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(loandetails.useraccno != null
                            ? loandetails.useraccno
                            : " "))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Text(
                          "Loan No:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(loandetails.loanAccno != null
                            ? loandetails.loanAccno
                            : " "))
                  ],
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Text(
                          "Created Date:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(loandetails.createddate != null
                            ? loandetails.createddate
                            : " "))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Text(
                          "Plan:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(
                            loandetails.plan != null ? loandetails.plan : " "))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Text(
                          "Amount:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(loandetails.loanamount != null
                            ? loandetails.loanamount
                            : " "))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),

                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Text(
                          "Months:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(loandetails.months != null
                            ? loandetails.months
                            : " "))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),

                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Text(
                          "Monthly Payment:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(loandetails.monthlypayable != null
                            ? loandetails.monthlypayable
                            : "-"))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Text(
                          "Total Returns:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(loandetails.totalpayable != null
                            ? loandetails.totalpayable
                            : " "))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),

                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Text(
                          "Returs Date:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(loandetails.endDate != null
                            ? loandetails.endDate
                            : " "))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),

                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Text(
                          "Status:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    statusdropdown()
                  ],
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.01,
                // ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("Loan")
                              .doc(loandetails.loanAccno)
                              .update({
                            "EMI Payed Date": {
                              "${dateTime.day}/${dateTime.month}/${dateTime.year}"
                            }
                          }).whenComplete(() {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Center(
                                          child: const Text('Payment Done')),
                                      content: Text(
                                          '${loandetails.monthlypayable} EMI payed on ${dateTime.day}/${dateTime.month}/${dateTime.year}'),
                                    ));
                          });
                        },
                        child: Text("EMI Payed")),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("Loan")
                              .doc(loandetails.loanAccno)
                              .update({
                            "Status": loandetails.status,
                            "End_Date":
                                "${dateTime.day}/${dateTime.month}/${dateTime.year}"
                          });
                        },
                        child: Text("Update"))
                  ],
                )
              ],
            ))
      ],
    );
  }

  statusdropdown() {
    return DropdownButton<String>(
      value: loandetails.status,
      icon: const Icon(Icons.arrow_drop_down),
      style: const TextStyle(color: Colors.black),
      underline: Container(
        color: Colors.grey,
      ),
      onChanged: (String newValue) {
        setState(() {
          loandetails.status = newValue;
        });
      },
      items: <String>["Active", "Payed"]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              Text(value),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  String monthlypayable(String amount) {
    int total = int.parse(amount);
    double intrest;
    double monthlypay;
    intrest = int.parse(amount) + (int.parse(amount) * 0.0639);
    if (loanmonthdropdonw == "3 Months") {
      monthlypay = (intrest / 3).ceilToDouble();
      return monthlypay.toString();
    } else if (loanmonthdropdonw == "6 Months") {
      monthlypay = (intrest / 6).ceilToDouble();
      return monthlypay.toString();
    } else if (loanmonthdropdonw == "9 Months") {
      monthlypay = (intrest / 9).ceilToDouble();
      return monthlypay.toString();
    } else if (loanmonthdropdonw == "12 Months") {
      monthlypay = (intrest / 12).ceilToDouble();
      return monthlypay.toString();
    }
  }

  Set<String> returnspayer(String amount, String plan) {
    double intrest;
    String date;
    if (plan == "Small Credit") {
      intrest = int.parse(amount) + (int.parse(amount) * 0.01);
      date =
          "${dateTime.add(Duration(days: 15)).day}/${dateTime.add(Duration(days: 15)).month}/${dateTime.add(Duration(days: 15)).year}";
      return {intrest.toString(), date};
    } else if (plan == "Personal Loan") {
      intrest = int.parse(amount) + (int.parse(amount) * 0.0639);
      if (loanmonthdropdonw == "3 Months") {
        date =
            "${dateTime.add(Duration(days: 90)).day}/${dateTime.add(Duration(days: 90)).month}/${dateTime.add(Duration(days: 90)).year}";
        return {intrest.toString(), date};
      } else if (loanmonthdropdonw == "6 Months") {
        date =
            "${dateTime.add(Duration(days: 180)).day}/${dateTime.add(Duration(days: 180)).month}/${dateTime.add(Duration(days: 180)).year}";
        return {intrest.toString(), date};
      } else if (loanmonthdropdonw == "9 Months") {
        date =
            "${dateTime.add(Duration(days: 270)).day}/${dateTime.add(Duration(days: 270)).month}/${dateTime.add(Duration(days: 270)).year}";
        return {intrest.toString(), date};
      } else if (loanmonthdropdonw == "12 Months") {
        date =
            "${dateTime.add(Duration(days: 365)).day}/${dateTime.add(Duration(days: 365)).month}/${dateTime.add(Duration(days: 365)).year}";
        return {intrest.toString(), date};
      }
    }
  }
}
