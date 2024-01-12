// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:con/components/mybutton.dart';
import 'package:con/components/mytextfield.dart';
import 'package:con/pages/login.dart/optpage.dart';
import 'package:con/pages/navpage/navbar.dart';

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mobileController = TextEditingController();

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  Country selectedCountry = Country(
    phoneCode: "1",
    countryCode: "US",
    e164Sc: 0,
    geographic: true,
    level: 0,
    name: "United States",
    example: "United States",
    displayName: "United States",
    displayNameNoCountryCode: "US",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(130),
            Icon(
              Icons.map_rounded,
              size: 130,
              color: Colors.blueAccent,
            ),
            const Text(
              "I N F O",
              style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w600),
            ),
            const Gap(40),
            mytextfield(
              Controller: mobileController,
              hinttext: "Mobile no",
              obscureText: false,
              keyboardtype: TextInputType.number,
              // country code
              prefix: Container(
                padding: EdgeInsets.all(15),
                child: InkWell(
                  onTap: () {
                    showCountryPicker(
                      countryListTheme: CountryListThemeData(
                        bottomSheetHeight: 500,
                      ),
                      context: context,
                      onSelect: ((value) {
                        setState(() {
                          selectedCountry = value;
                        });
                      }),
                    );
                  },
                  child: Text(
                    "${selectedCountry.flagEmoji}",
                    style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const Gap(10),
            Mybutton(
              ontap: () {
                print("working");
                // Format the phone number with the country code
                String phoneNumber = "+${selectedCountry.phoneCode}${mobileController.text}";

                // Ensure that the phone number is in the correct format
                if (phoneNumber.isNotEmpty) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OptPage(
                        verificationID: phoneNumber,
                      ),
                    ),
                  );
                } else {
                  print("Invalid phone number format");
                }
              },
              buttontext: "send otp",
            ),
            const Gap(20),
            const Text(
              "Or",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            const Gap(20),
            GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const GmailLink()));
              },
              child: SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(
                  "assets/google.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Gap(200)
          ],
        ),
      ),
    );
  }
}
