import 'package:con/components/mybutton.dart';
import 'package:con/components/mytextfield.dart';
import 'package:con/pages/login.dart/signup/signuppage.dart';
import 'package:con/pages/navpage/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }
}

class GmailLink extends StatefulWidget {
  const GmailLink({Key? key}) : super(key: key);

  @override
  State<GmailLink> createState() => _GmailLinkState();
}

class _GmailLinkState extends State<GmailLink> {
  final gmailController = TextEditingController();
  final passwordController = TextEditingController();

  void checkUser() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool? statuslog = pref.getBool("statuslog");

  if (statuslog == true) {
    // User is logged in, navigate to the home page
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomBar()));
  } else {
    // User is not logged in, stay on the sign-in page
  }
}

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  SignIn(String gmail, String password) async {
  if (gmailController.text.isEmpty || passwordController.text.isEmpty) {
    // Handle empty fields
    return;
  }

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: gmail, password: password);
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("statuslog", true); // Set the login status to true
    gmailController.clear();
    passwordController.clear();
    checkUser();
  } on FirebaseAuthException catch (ex) {
    print("Firebase Auth Exception: ${ex.message}");
    // Handle FirebaseAuthException (show a SnackBar, AlertDialog, or other appropriate UI)
  } catch (ex) {
    print("Unexpected Error: $ex");
    // Handle other unexpected errors
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(170),
            Icon(
              Icons.map_rounded,
              size: 130,
              color: Color.fromRGBO(133, 127, 247, 1),
            ),
            Gap(10),
            Text(
              "INFO",
              style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
            ),
            Gap(30),
            mytextfield(Controller: gmailController, hinttext: "Gmail", obscureText: false, keyboardtype: TextInputType.emailAddress),
            Gap(10),
            mytextfield(Controller: passwordController, hinttext: "Password", obscureText: true, keyboardtype: TextInputType.text),
            Gap(20),
            Mybutton(
              ontap: () {
                SignIn(gmailController.text.toString(), passwordController.text.toString());
              },
              buttontext: "SignIn",
            ),
            Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have account?",style: TextStyle(color: Colors.white),),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text("Create one"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
