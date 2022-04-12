import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dctradesadmin/constant.dart';
import 'package:dctradesadmin/invdetails.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Investment extends StatefulWidget {
  @override
  State<Investment> createState() => _InvestmentState();
}

class _InvestmentState extends State<Investment> {
  double createContainer = 0;
  double acheight = 0;
  String iacno = "";
  String iaccnum = "";
  bool end = false;
  bool end1 = false;

  TextEditingController amount = TextEditingController();
  TextEditingController iaccno = TextEditingController();
  TextEditingController uacno = TextEditingController();

  String invplandropdonw = "Quartely 4 (Q4)";
  TextStyle headerstyle = TextStyle(fontWeight: FontWeight.bold);
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
              "Investment",
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
                    controller: iaccno,
                    decoration: InputDecoration(
                      hintText: "Enter Investment Account number",
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
                      setState(() {
                        iaccnum = iaccno.text;
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
                        print("button clicked");
                        setState(() {
                          createContainer =
                              MediaQuery.of(context).size.height * 0.7;

                          acheight = 0;
                        });
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.amber),
                                  borderRadius: BorderRadius.circular(10)))),
                      child: Text("New Investment")),
                )
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
                height: createContainer,
                width: MediaQuery.of(context).size.width * 0.8,
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.01),
                    color: Colors.white),
                child: createInvestment()),
          ],
        ),
      ),
    );
  }

  Invdetails invdetails = Invdetails();
  accountdetails() {
    FirebaseFirestore.instance
        .collection("Investment")
        .where("Investment Acc No", isEqualTo: iaccnum)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          invdetails.invAccno = element.data()["Investment Acc No"];
          invdetails.amountInv = element.data()["Amount Invested"];
          invdetails.createddate = element.data()["Created Date"];
          invdetails.useraccno = element.data()["Acc No"];
          invdetails.months = element.data()["Months"];
          invdetails.plan = element.data()["Plan"];
          invdetails.plannedReturns = element.data()["Planned Returns"];
          invdetails.returnsDate = element.data()["Returs Date"];
          invdetails.status = element.data()["Status"];
          invdetails.totalReturns = element.data()["Total Returns"];
          invdetails.endDate = element.data()["End_Date"];
          createContainer = 0;
          acheight = MediaQuery.of(context).size.height * 0.7;
        });
      });
    });
  }

  cart() {
    print(invdetails.endDate);

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
                        child: Text(invdetails.useraccno != null
                            ? invdetails.useraccno
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
                          "Investment No:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(invdetails.invAccno != null
                            ? invdetails.invAccno
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
                          "Amount Invested:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(invdetails.amountInv != null
                            ? invdetails.amountInv
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
                            invdetails.plan != null ? invdetails.plan : " "))
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
                        child: Text(invdetails.months != null
                            ? invdetails.months
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
                          "Total Returns:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(invdetails.plannedReturns != null
                            ? invdetails.plannedReturns
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
                        child: Text(invdetails.createddate != null
                            ? invdetails.createddate
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
                        child: Text(invdetails.returnsDate != null
                            ? invdetails.returnsDate
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
                          end == true ? "Last Returns payed" : "End Date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(invdetails.endDate != null
                            ? invdetails.endDate
                            : " "))
                  ],
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (invdetails.status == "Active") {
                            end = false;
                            end1 = true;
                            FirebaseFirestore.instance
                                .collection("Investment")
                                .doc(invdetails.invAccno)
                                .update({
                              "Status": invdetails.status,
                              "End_Date":
                                  "${dateTime.day}/${dateTime.month}/${dateTime.year}"
                            });
                          } else {
                            end1 = false;
                            FirebaseFirestore.instance
                                .collection("Investment")
                                .doc(invdetails.invAccno)
                                .update({
                              "Status": invdetails.status,
                            });
                          }
                          if (invdetails.status == "Returns payed") {
                            end = true;
                            end1 = true;
                            FirebaseFirestore.instance
                                .collection("Investment")
                                .doc(invdetails.invAccno)
                                .update({
                              "Status": invdetails.status,
                              "End_Date":
                                  "${dateTime.day}/${dateTime.month}/${dateTime.year}"
                            });
                          }
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
      value: invdetails.status,
      icon: const Icon(Icons.arrow_drop_down),
      style: const TextStyle(color: Colors.black),
      underline: Container(
        color: Colors.grey,
      ),
      onChanged: (String newValue) {
        setState(() {
          invdetails.status = newValue;
        });
      },
      items: <String>["Active", "Ended", "Returns payed"]
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

  norecordcart() {
    print("No data found");
    return Column(
      children: [
        Text(
          "Account Details:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Icon(
          Icons.warning_rounded,
          size: 150,
        ),
        Text(
          "No record Found",
          style: TextStyle(
            fontSize: 20,
          ),
        )
      ],
    );
  }

  investmentplandropdown() {
    return DropdownButton<String>(
      value: invplandropdonw,
      icon: const Icon(Icons.arrow_drop_down),
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.grey,
      ),
      onChanged: (String newValue) {
        if (newValue == "Quartely 4 (Q4)") {
          setState(() {
            invplandropdonw = newValue;
            months = "1 year, 3 months once profit";
          });
        } else if (newValue == "Half yearly (H2)") {
          setState(() {
            invplandropdonw = newValue;
            months = "1 year, 6 months once profit";
          });
        } else if (newValue == "One Time Investment") {
          setState(() {
            invplandropdonw = newValue;
            months = "1 year, Profit after 370 days";
          });
        } else if (newValue == "Systematic Investment Plan") {
          setState(() {
            invplandropdonw = newValue;
            months = "13th Month";
          });
        } else if (newValue == "Systematic Investment Plan (Old)") {
          setState(() {
            invplandropdonw = newValue;
            months = "13th Month";
          });
        } else if (newValue == "One Time Investment (Old)") {
          setState(() {
            invplandropdonw = newValue;
            months = "1 year, Profit after 370 days";
          });
        } else if (newValue == "Lockdown Insurance Plan") {
          setState(() {
            invplandropdonw = newValue;
            months =
                "Monthly 10% profit for 5 months if lockdown exist. \nIf no lockdown exist u get 50% profit at the\nend of 12th month.";
          });
        } else if (newValue == "Self Provident Fund(SPF)") {
          setState(() {
            invplandropdonw = newValue;
            months = "Profit on 6th,7th and 8th year. (Monthly)";
          });
        } else if (newValue == "Monthly Income (Mincome)") {
          setState(() {
            invplandropdonw = newValue;
            months = "1 year, Profit will be given every month";
          });
        } else if (newValue == "Children Education Plan") {
          setState(() {
            invplandropdonw = newValue;
            months = "Withdrawal any month between 3 to 12 month's";
          });
        }
      },
      items: <String>[
        'Quartely 4 (Q4)',
        'Half yearly (H2)',
        'One Time Investment',
        'One Time Investment (Old)',
        'Systematic Investment Plan',
        'Systematic Investment Plan (Old)',
        'Lockdown Insurance Plan',
        'Self Provident Fund(SPF)',
        'Monthly Income (Mincome)',
        'Children Education Plan'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              Text(value),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.21,
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  createInvestment() {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Text(
            "Create a new Investment:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.4,
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
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    "Amount to be invested:",
                    style: headerstyle,
                  ),
                  TextFormField(
                    controller: amount,
                    decoration: InputDecoration(
                        hintText: "Enter the amount to be invested",
                        isDense: true,
                        contentPadding: EdgeInsets.all(10)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    "Select the plan for inversment",
                    style: headerstyle,
                  ),
                  investmentplandropdown(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: ElevatedButton(
                            onPressed: () async {
                              DatabaseReference ref =
                                  FirebaseDatabase.instance.ref("Local/Local");
                              DatabaseEvent event = await ref.once();

                              int no = int.parse(
                                  event.snapshot.child("Investment No").value);

                              iacno = (no + 1).toString();

                              Map<String, String> data = {
                                "Investement Acc No": "DCGI$iacno",
                                "Created Date": dateTime.day.toString() +
                                    "/" +
                                    dateTime.month.toString() +
                                    "/" +
                                    dateTime.year.toString(),
                                "Returs Date":
                                    returnsdate(invplandropdonw).toString(),
                                "Acc No": uacno.text,
                                "Amount Invested": amount.text,
                                "Plan": invplandropdonw,
                                "Total Returns":
                                    returnscalculator(amount.text).last,
                                "Months": months,
                                "Planned Returns":
                                    returnscalculator(amount.text).first,
                                "Status": "Active"
                              };

                              FirebaseFirestore.instance
                                  .collection("Account")
                                  .doc(uacno.text)
                                  .update({
                                "Investment no": {"DCGI$iacno"}
                              });
                              FirebaseFirestore.instance
                                  .collection("Investment")
                                  .doc("DCGI$iacno")
                                  .set(data);

                              ref
                                  .child("Investment No")
                                  .set(iacno)
                                  .whenComplete(
                                      () => print("$iacno Completed"));

                              showconfirmationdailog();
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
            Container(
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
                            "Amount Invested:",
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
                            "Total Returns:",
                            style: headerstyle,
                          ),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * 0.1,
                        // ),
                        Container(
                            child: Text((amount.text.isEmpty)
                                ? ""
                                : returnscalculator(amount.text).last))
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
                        Container(child: Text(months))
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Text(
                            "Planned Returns:",
                            style: headerstyle,
                          ),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * 0.1,
                        // ),
                        Container(
                            child: Text((amount.text.isEmpty)
                                ? ""
                                : returnscalculator(amount.text).first))
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Text(
                            "Returns Date:",
                            style: headerstyle,
                          ),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * 0.1,
                        // ),
                        Container(
                            child:
                                Text(returnsdate(invplandropdonw).toString()))
                      ],
                    ),
                  ],
                ))
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
                    "Your Investmented has been created successfully ",
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
                    "DCGI$iacno",
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

  String profitestring;
  Set<String> dates = {};
  DateTime dateTime = DateTime.now();

  Set<String> returnsdate(String invplandropdown) {
    if (invplandropdonw == "Quartely 4 (Q4)") {
      dates = {
        "${dateTime.day}/${dateTime.add(Duration(days: 90)).month}/${dateTime.add(Duration(days: 90)).year}",
        "${dateTime.day}/${dateTime.add(Duration(days: 180)).month}/${dateTime.add(Duration(days: 180)).year}",
        "${dateTime.day}/${dateTime.add(Duration(days: 270)).month}/${dateTime.add(Duration(days: 270)).year}",
        "${dateTime.day}/${dateTime.add(Duration(days: 360)).month}/${dateTime.add(Duration(days: 360)).year}"
      };
      return dates;
    } else if (invplandropdonw == "Half yearly (H2)") {
      dates = {
        "${dateTime.day}/${dateTime.add(Duration(days: 180)).month}/${dateTime.add(Duration(days: 180)).year}",
        "${dateTime.day}/${dateTime.add(Duration(days: 360)).month}/${dateTime.add(Duration(days: 360)).year}"
      };
      return dates;
    } else if (invplandropdonw == "One Time Investment") {
      dates = {
        "${dateTime.add(Duration(days: 370)).day}/${dateTime.add(Duration(days: 370)).month}/${dateTime.add(Duration(days: 370)).year}"
      };
      return dates;
    } else if (invplandropdonw == "Systematic Investment Plan") {
      dates = {
        "${dateTime.day}/${dateTime.add(Duration(days: 390)).month}/${dateTime.add(Duration(days: 390)).year}"
      };
      return dates;
    } else if (invplandropdonw == "Systematic Investment Plan (Old)") {
      dates = {
        "${dateTime.day}/${dateTime.add(Duration(days: 390)).month}/${dateTime.add(Duration(days: 390)).year}"
      };
      return dates;
    } else if (invplandropdonw == "One Time Investment (Old)") {
      dates = {
        "${dateTime.add(Duration(days: 370)).day}/${dateTime.add(Duration(days: 370)).month}/${dateTime.add(Duration(days: 370)).year}"
      };
      return dates;
    } else if (invplandropdonw == "Lockdown Insurance Plan") {
      dates = {
        "${dateTime.day}/${dateTime.add(Duration(days: 365)).month}/${dateTime.add(Duration(days: 365)).year}"
      };
      return dates;
    } else if (invplandropdonw == "Self Provident Fund(SPF)") {
      dates = {
        "${dateTime.day}/${dateTime.add(Duration(days: 365)).month}/${dateTime.add(Duration(days: 365)).year}"
      };
      return dates;
    } else if (invplandropdonw == "Monthly Income (Mincome)") {
      dates = {
        "${dateTime.day}/${dateTime.add(Duration(days: 2190)).month}/${dateTime.add(Duration(days: 2190)).year}",
        "${dateTime.day}/${dateTime.add(Duration(days: 2555)).month}/${dateTime.add(Duration(days: 2555)).year}",
        "${dateTime.day}/${dateTime.add(Duration(days: 2920)).month}/${dateTime.add(Duration(days: 2920)).year}"
      };
      return dates;
    } else if (invplandropdonw == "Children Education Plan") {
      dates = {
        "${dateTime.day}/${dateTime.add(Duration(days: 365)).month}/${dateTime.add(Duration(days: 365)).year}"
      };
      return dates;
    } else {
      return {" "};
    }
  }

  // ignore: missing_return
  Set<String> returnscalculator(String amount) {
    double profite;

    if (invplandropdonw == "Quartely 4 (Q4)") {
      profite = int.parse(amount) * 0.1;
      profitestring = "${profite.toString()}, every 3 months";

      print(dates);
      return {profitestring, ((profite * 4) + int.parse(amount)).toString()};
    } else if (invplandropdonw == "Half yearly (H2)") {
      profite = int.parse(amount) * 0.3;
      profitestring = "${profite.toString()}, every 6 months";
      return {profitestring, ((profite * 2) + int.parse(amount)).toString()};
    } else if (invplandropdonw == "One Time Investment") {
      profite = int.parse(amount) * 0.8;
      profitestring = "${profite.toString()}, after 370 days";
      return {profitestring, (profite + int.parse(amount)).toString()};
    } else if (invplandropdonw == "Systematic Investment Plan") {
      profite = int.parse(amount) * 0.6;
      double monthly = int.parse(amount) * 0.1;
      profitestring =
          "${profite + int.parse(amount)} on 13th month end, \nMonthly $monthly needs to be payed";

      return {profitestring, (profite + int.parse(amount)).toString()};
    } else if (invplandropdonw == "Systematic Investment Plan (Old)") {
      profite = int.parse(amount) * 0.8;
      double monthly = int.parse(amount) * 0.1;
      profitestring =
          "${profite + int.parse(amount)} on 13th month end, \nMonthly $monthly needs to be payed";

      return {profitestring, (profite + int.parse(amount)).toString()};
    } else if (invplandropdonw == "One Time Investment (Old)") {
      profite = double.parse(amount);
      profitestring = "${profite.toString()}, after 370 days";
      return {profitestring, (profite + int.parse(amount)).toString()};
    } else if (invplandropdonw == "Lockdown Insurance Plan") {
      profite = int.parse(amount) * 0.85;
      profitestring = "${profite.toString()}, at the end of 12th Month";
      return {profitestring, (profite + int.parse(amount)).toString()};
    } else if (invplandropdonw == "Self Provident Fund(SPF)") {
      profite = int.parse(amount) * 10.0;
      profitestring = "${profite.toString()}, Every month 6th,7th & 8th year ";
      return {profitestring, ((profite * 36).toString())};
    } else if (invplandropdonw == "Monthly Income (Mincome)") {
      profite = int.parse(amount) * 0.03;

      profitestring =
          "${profite.toString()}, Every Month \nAfter one year total amount can be withdrawn";
      return {profitestring, (profite * 12 + int.parse(amount)).toString()};
    } else if (invplandropdonw == "Children Education Plan") {
      profite = int.parse(amount) * 0.5;
      profitestring = "${profite + int.parse(amount)}, End of 12th month";
      return {profitestring, (profite + int.parse(amount)).toString()};
    } else {
      return {" "};
    }
  }
}
