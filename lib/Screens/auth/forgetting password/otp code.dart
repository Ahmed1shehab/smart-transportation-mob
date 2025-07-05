import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sonic_driver/Screens/auth/forgetting%20password/set%20pass.dart';


void main() {
  runApp(MaterialApp(home: OtpScreen()));
}

class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Confirm your Number",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF1B4865),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 1.5),
                const Text("Enter the code we sent to your Number",textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w500),
                ),

                const SizedBox(height: 20),

                PinCodeTextField(
                  keyboardType: TextInputType.number,
                  appContext: context,
                  length: 4,
                  onChanged: (value) {
                    print("Current OTP: $value");
                  },
                  onCompleted: (value) {
                    print("OTP Entered: $value");
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 60,
                    fieldWidth: 60,
                    activeColor: Colors.blue,
                    selectedColor: Colors.yellow,
                    inactiveColor: Colors.grey,
                  ),
                ),

                  TextButton(
                        onPressed: () {
                        },
                        child: const Text(
                          "Resend Code",
                          style: TextStyle(color: Colors.black ,fontSize: 14),
                        ),
                      ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  PasswordScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5FA8D3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Verify",style:  TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
