import 'package:flutter/material.dart';
import '../../models/jwt_helper.dart';
import '../NavBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgetting password/NumRequest.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  bool visibale = true;
  var formkey = GlobalKey<FormState>();
  late TextEditingController numbercontroller = TextEditingController();
  TextEditingController idcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    numbercontroller.dispose();
    idcontroller.dispose();
    passwordcontroller.dispose();
  }

  Future<void> login({
    required BuildContext context,
    required String phone,
    required String password,
    required String organizationId,
  })
  async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/auth/signin'),
        body: {
          'identifier': numbercontroller.text,
          'password': passwordcontroller.text,
          'organization': idcontroller.text,
        },
      );

      final data = jsonDecode(response.body);

      if (data['data'] != null && data['data']['access_token'] != null) {
        final token = data['data']['access_token'];
        final payload = parseJwt(token);
        print('Decoded Token: $payload');


        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('firstName', payload['firstName']);
        await prefs.setString('lastName', payload['lastName']);
        await prefs.setString('email', payload['email']);
        await prefs.setString('phone', payload['phone']);
        await prefs.setString('status', payload['status']);


        print("Login successful, token: $token");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavBar()),
        );
      }
      else {
        try {
          final error = jsonDecode(response.body);
          final message = error['message'] ?? 'Login failed.';
          print("Login failed: ${response.body}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login failed: $message")),
          );
        } catch (e) {
          print("Login failed, status: ${response.statusCode}");
          print("Raw body: ${response.body}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login failed. Please try again.")),
          );
        }
      }
    } catch (e) {
      print("Error during login: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred. Please try again.")),
      );
    }
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
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(children: [
                      // Welcome Text
                      const Text(
                        'Welcome Back!',
                        style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFF1B4865),
                            fontWeight: FontWeight.bold),
                      ),
                      const Text('Log in to your account' ,
                        style: TextStyle(fontSize:20,fontWeight: FontWeight.bold) ,
                      ),
                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                             const Align(
                                alignment: Alignment.centerLeft,
                                  child: Text(
                                    "ُPhone Number:",
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                  ),
                                ),
                            SizedBox(
                              height: 42,
                              child: TextField(
                                controller: numbercontroller,
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
                      const SizedBox(height: 20,),
                      // Password Field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                                child: Text(
                                  "Password:",
                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                ),
                              ),
                            SizedBox(
                              height: 42,
                              child: TextField(
                                controller: passwordcontroller,
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color(0xFF5FA8D3),),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Forget Password
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const NumRequest()));
                            },
                            child: const Text(
                              "Forget Password?",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      //Organization ID
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Organization ID:",
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 42,
                              child: TextField(
                                controller: idcontroller,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color(0xFF5FA8D3),),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:  const BorderSide(color: Colors.black, width: 2),
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


                      SizedBox(height: 20,),

                      // Login Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              final phone = numbercontroller.text.trim();
                              final pass = passwordcontroller.text.trim();
                              final orgId = idcontroller.text.trim();
                              login(
                                context: context,
                                phone: phone,
                                password: pass,
                                organizationId: orgId,
                              );
                            },
                            child: Text("Log in",style:  TextStyle(color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5FA8D3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
