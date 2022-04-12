import 'package:dctradesadmin/Pages/mainpage.dart';
import 'package:dctradesadmin/progressbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.windows) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDIKW5mGIjIcV7zeBYV3rVNNg1vN5MaFlo",
            authDomain: "dctrade-808d0.firebaseapp.com",
            databaseURL: "https://dctrade-808d0-default-rtdb.firebaseio.com",
            projectId: "dctrade-808d0",
            storageBucket: "dctrade-808d0.appspot.com",
            messagingSenderId: "926339567796",
            appId: "1:926339567796:web:eee2c7742b1fa2b50687e1",
            measurementId: "G-KTY9CJYDGB"));
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? 'login' : 'home',
      routes: {'login': (context) => Login(), 'home': (context) => Mainpage()},
    );
  }
}

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 37, 53),
      body: Dialog(
        child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.3,
          child: Form(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/dctechno.png',
                    color: Colors.black,
                    width: 60,
                    height: 60,
                  ),
                  Text(
                    "DC Groups",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      hintText: 'Email',
                      prefixIcon: Icon(
                        Icons.mail_outline,
                      ))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: password,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    hintText: 'Password',
                    prefixIcon: Icon(
                      Icons.key_sharp,
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.3,
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) => Progressbar(
                                message: "Logging you in, Please wait",
                              ));
                      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                      firebaseAuth.signInWithEmailAndPassword(
                          email: email.text, password: password.text)
                        ..catchError((onError) {
                          print(onError);
                        }).then((value) {
                          if (value != null) {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        Mainpage()));
                          } else {
                            Navigator.pop(context);
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Center(
                                          child: const Text('Login Failed')),
                                      content: Text(
                                          'Incorrect Email/Password. Please try again'),
                                    ));
                          }
                        });
                    },
                    child: Text("Login")),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
