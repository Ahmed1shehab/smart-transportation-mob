import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/dummyTracks.dart';
import 'map.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEE d MMMM').format(DateTime.now());
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xffF2F1F1),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Positioned(
                        top: -10,
                        right: -25,
                        bottom: -8.5,
                        child: Image.asset(
                          'assets/images/bus.png',
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hi Ali,',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff5FA8D3),
                            ),
                          ),
                          const Text(
                            'There is your next \nTRACK!',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.calendar_month, size: 16,
                                  color: Color(0xff5FA8D3)),
                              const SizedBox(width: 8),
                              Text(
                                formattedDate,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.only(bottom: 30),
                    physics: BouncingScrollPhysics(),
                    itemCount: Tracks.length,
                    itemBuilder: (context, index) {
                      final track = Tracks[index];
                      return buildPersonCard(
                          track.name, track.subtitle, track.imageAsset);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Center(child: Icon(Icons.keyboard_arrow_down_rounded)),

                const SizedBox(height: 25),

                Center(
                  child: SizedBox(
                    width: 323,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  MapScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff5FA8D3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Go to map',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPersonCard(String name, String address, String imageUrl) {
    return Container(
      width: 330,
      height: 82,
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imageUrl),
            radius: 30,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Icon(
                    Icons.home_outlined,
                    color: Color(0xff5FA8D3),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(limitWords(address,4), style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
String limitWords(String text, int maxWords) {
  List<String> words = text.split(' ');
  if (words.length <= maxWords) return text;
  return words.take(maxWords).join(' ') + '...';
}
