// lib/screens/report_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:sonic_driver/Screens/reports/reports.dart';
import '../../models/report_model.dart';
import 'new report.dart';

class ReportDetailScreen extends StatefulWidget {
  final Report report;
  ReportDetailScreen({super.key, required this.report});

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  late FlutterTts flutterTts = FlutterTts();


  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();

    // التأكد من أن المكتبة شغالة
    flutterTts.setStartHandler(() {
      print("Started reading");  // طباعة عند بدء القراءة
    });

    flutterTts.setCompletionHandler(() {
      print("Finished reading");  // طباعة عند إتمام القراءة
    });

    // لما يحصل خطأ
    flutterTts.setErrorHandler((msg) {
      print("TTS Error: $msg");
    });
  }
  Future<void> _speak() async {

    print("TTS: about to initialize");
    // 1. تعيين الصوت يدوياً
    await flutterTts.setVoice({ 'name': 'en_us', 'locale': 'en-US' });
    print("TTS: voice set to en-US");
    // عرض المحرّكات
    var engines = await flutterTts.getEngines;
    print("TTS engines installed: $engines");
    // الحصول على قائمة اللغات المدعومة
    var languages = await flutterTts.getLanguages;
    print("TTS: available languages: $languages");

    if (languages.contains("en-US")) {
      print("TTS: en-US is available, proceeding with setup...");
      await flutterTts.setLanguage("en-US");
    } else {
      print("TTS: en-US is not available on this device");
    }

    await flutterTts.setPitch(1.0);
    print("TTS: calling speak → ${widget.report.details}");

    var result = await flutterTts.speak(widget.report.details);
    print("TTS: speak() returned $result");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:BackButton(color: Color(0xff1B4965)),
        title: const Text('Report Details',
          style: TextStyle(
          color: Color(0xff5FA8D3),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),),
        actions: [

        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0,vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text('Report ID: #${widget.report.id}',
                    style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.black))),
            const SizedBox(height: 30),
            const Text('Title:', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration:BoxDecoration(
                color: Color(0xffEAEAEA),
                borderRadius: BorderRadius.circular(12),
              ),
              child:
              Text(widget.report.title,
                style:TextStyle(fontSize: 18,color: Colors.black) ,),
            ),
            const SizedBox(height: 20),
            const Text('Status:', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            Container(
              width: double.infinity,

              padding: EdgeInsets.all(15),
              decoration:BoxDecoration(
                color: Color(0xffEAEAEA),
                borderRadius: BorderRadius.circular(12),
              ),
              child:
              Text(widget.report.status,
                style:TextStyle(fontSize: 18,color: Colors.black) ,),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Details:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
               Spacer(),
                IconButton(
                    icon: const Icon(Icons.hearing, color: Color(0xff5FA8D3),size: 20,),
                    onPressed:
                    _speak
                )
              ],
            ),
            Container(
                  width: double.infinity,
                  height: 200,
                  padding: EdgeInsets.all(20),
                  decoration:BoxDecoration(
                    color: Color(0xffEAEAEA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    child:
                  Text(widget.report.details,
                    style:TextStyle(fontSize: 18,color: Colors.black) ,),
                ),
            ),
            const SizedBox(height: 28),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>   NewReportScreen()));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: const Color(0xff5FA8D3),
                  elevation: 8,
                  shadowColor: Colors.black,
                ),
                child: const Text(
                  'Response',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
