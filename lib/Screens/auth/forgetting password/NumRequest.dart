import 'package:flutter/material.dart';
import 'otp code.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sonic_driver/models/jwt_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NumRequest extends StatefulWidget {
  const NumRequest({Key? key}) : super(key: key);

  @override
  State<NumRequest> createState() => _NumRequestState();
}

class _NumRequestState extends State<NumRequest> {
  var formkey = GlobalKey<FormState>();
  late TextEditingController phonecontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    phonecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.5),
            child: Image.asset(
              'assets/images/bar1.png',
              color: const Color(0xA8ABABAB),
            ),
          ),
          Image.asset(
            'assets/images/bar1.png',
            color: const Color(0xFF5FA8D3),
          ),
        ]),
        //Padding(
        Form(
          key: formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(children: [
                  // Welcome Text
                  const Text(
                    'Reset your Password',
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF1B4865),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8,),
                  const Text('We will send an OTP Verification for you' ,textAlign: TextAlign.center,
                    style: TextStyle(fontSize:20,fontWeight: FontWeight.w500) ,
                  ),
                  const SizedBox(height: 45,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Phone Number:",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 42,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: const Color(0xFF5FA8D3),),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OtpScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5FA8D3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Send Code",style:  TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
