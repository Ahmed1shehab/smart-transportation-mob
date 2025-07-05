import 'package:flutter/material.dart';

import '../login.dart';

void main() {
  runApp(MaterialApp(home: PasswordScreen()));
}

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  String currentPassword = '';
  double passwordStrength = 0.0;
  String strengthText = '';

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  double _calculatePasswordStrength(String password) {
    double strength = 0;
    if (password.length >= 8) strength += 0.25;
    if (RegExp(r'[0-9]').hasMatch(password)) strength += 0.25;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.25;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) strength += 0.5;
    return strength.clamp(0.0, 1.0);
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 50),
                    Text(
                      'Your password has been reset\nsuccessfully',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  LoginScreen()));
                         // Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF6AA9CF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //  (X)
                Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close, color: Color(0xff61B6CB)),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }


  String _getStrengthText(double strength) {
    if (strength == 0) return '';
    if (strength <= 0.25) return 'Very weak';
    if (strength <= 0.5) return 'Weak';
    if (strength <= 0.75) return 'Slightly strong';
    return 'Strong';
  }

  Widget _buildPasswordStrengthBar(double strength) {
    return Row(
      children: List.generate(4, (index) {
        double filled = (index + 1) * 0.25 <= strength ? 1 : 0;
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 1),
            height: 7,
            decoration: BoxDecoration(
              color: filled == 1 ? Colors.blue.shade700 : Colors.blue.shade100,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildConditionText(String text, bool condition, {Key? key}) {
    return Row(
      key: key,
      children: [
        Icon(
          condition ? Icons.check_circle : Icons.radio_button_unchecked,
          color: condition ? Colors.green : Colors.grey,
          size: 18,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: Colors.blueGrey,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              const Text(
                "Set new password",
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF1B4865),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              const Text(
                "Write your new one !",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize:20,fontWeight: FontWeight.w500) ,
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Password:",
                        style: TextStyle(fontSize:14,fontWeight: FontWeight.w500) ,
                      ),
                    ),
                    const SizedBox(height: 3),
                    SizedBox(
                      height: 42,
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF5FA8D3),),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        controller: passwordController,
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            currentPassword = value;
                            passwordStrength = _calculatePasswordStrength(value);
                            strengthText = _getStrengthText(passwordStrength);
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPasswordStrengthBar(passwordStrength),
                        SizedBox(height: 6),
                        Text(
                          strengthText,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildConditionText(
                            'Must contain a number',
                            RegExp(r'\d').hasMatch(currentPassword),
                            key: ValueKey('number'),
                          ),
                          _buildConditionText(
                            'At least 8 letters',
                            currentPassword.length >= 8,
                            key: ValueKey('length'),
                          ),
                        ],
                      ),
                    const SizedBox(height: 10),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Confirm Password:",
                        style: TextStyle(fontSize:14,fontWeight: FontWeight.w500) ,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 42,
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF5FA8D3),),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: 8),

                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            showSuccessDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5FA8D3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Reset password",style:  TextStyle(color: Colors.white),),
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
