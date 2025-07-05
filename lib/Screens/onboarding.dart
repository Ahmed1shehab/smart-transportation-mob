import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/login.dart';

class Introscreen extends StatefulWidget {
  const Introscreen({super.key});

  @override
  State<Introscreen> createState() => _IntroscreenState();
}

class _IntroscreenState extends State<Introscreen> {
  Widget dotpageview() {
    return Builder(builder: ((context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < 2; i++)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 12,
              height:12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                color: i == pageNumber
                    ? const Color(0xff62B6CB)
                    : const Color(0xffd9d9d9), //Color(0xff653e3e)
              ),
            ),
        ],
      );
    }));
  }

  PageController nextpage = PageController();
  int pageNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: const Color(0xfff6efb4),
        body: PageView(
      onPageChanged: (value) {
        setState(() {
          pageNumber = value;
        });
      },
      controller: nextpage,
      children: [
        Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFA5D795),
                        Colors.white,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 110),
                  child: Center(
                    child: Image.asset(
                      'assets/images/on1.png',
                      width: 325,
                      height: 290,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 60),
              child: Text(
                "Our Best Man",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1b4865),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                  "Our bus driver and the most important man on this trip, we are counting on you for all the next",
                style: TextStyle(
                  color: Color(0xff000000),
                  fontFamily: 'Gilory Pro',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 53,
            ),
            dotpageview(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      nextpage.animateToPage(1,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn);
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
        Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFF8F0B1),
                        Colors.white,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: Image.asset(
                      'assets/images/on2.png',
                      width: 430,
                      height: 302,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 25),
              child: Text(
                "Welcome to your driver dashboard!",textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1b4865),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5 ,left:22,right: 22),
              child: Text(
                "Manage your routes with ease and stay connected with real-time updates.",
                style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 53,
            ),
            dotpageview(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
              child: Align(
                alignment: Alignment.centerRight,
                child:
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      "Finish",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ),
                  ),
              ),
            )
          ],
        )
      ],
    ));
  }

  void onDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('on bording', false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
