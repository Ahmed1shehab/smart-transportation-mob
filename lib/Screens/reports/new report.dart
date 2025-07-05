import 'package:flutter/material.dart';
import 'package:sonic_driver/Screens/reports/reports.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class NewReportScreen extends StatefulWidget {
  @override
  _NewReportScreenState createState() => _NewReportScreenState();
}

class _NewReportScreenState extends State<NewReportScreen> {
  late stt.SpeechToText _speech;
  bool _isListeningTitle = false;
  bool _isListeningDetails = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future<void> _listenTitle() async {
    if (!_isListeningTitle) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          if (status == 'notListening' || status == 'done') {
            setState(() => _isListeningTitle = false);
          }
        },
        onError: (err) => print('Error: $err'),
      );
      if (available) {
        setState(() => _isListeningTitle = true);
        _speech.listen(
          localeId: 'en_US', // أو 'ar_EG' للعربية
          onResult: (val) => setState(() {
            _titleController.text = val.recognizedWords;
          }),
          listenMode: stt.ListenMode.dictation,
          partialResults: true,
          listenFor: Duration(seconds: 10),
        );
      }
    } else {
      setState(() => _isListeningTitle = false);
      _speech.stop();
    }
  }
  Future<void> _listenDetails() async {
    if (!_isListeningDetails) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          if (status == 'notListening' || status == 'done') {
            setState(() => _isListeningDetails = false);
          }
        },
        onError: (err) => print('Error: $err'),
      );
      if (available) {
        setState(() => _isListeningDetails = true);
        _speech.listen(
          localeId: 'en_US', // أو 'ar_EG' للعربية
          onResult: (val) => setState(() {
            _detailsController.text = val.recognizedWords;
          }),
          listenMode: stt.ListenMode.dictation,
          partialResults: true,
          listenFor: Duration(seconds: 10),
        );
      }
    } else {
      setState(() => _isListeningDetails = false);
      _speech.stop();
    }
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
                    SizedBox(height: 20),
                    const Text('Report Sent!',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF6AA9CF)
                      ),
                    ),
                    SizedBox(height: 30),
                    const Text('Your Report ID is: #125',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ), ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>   ReportsScreen()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Color(0xff5FA8D3)),
        title: const Text(
          'New Report',
          style: TextStyle(
            color: Color(0xff5FA8D3),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0x57cae9ff),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isListeningTitle ? Icons.mic : Icons.mic_none,
                      color: Color(0xff5FA8D3),
                    ),
                    onPressed: _listenTitle,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text('Details:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color(0x57cae9ff),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _detailsController,
                        maxLines: null,
                        expands: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isListeningDetails ? Icons.mic : Icons.mic_none,
                      color: Color(0xff5FA8D3),
                    ),
                    onPressed: _listenDetails,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:(){showSuccessDialog(context);}
                  ,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff5FA8D3),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                  ),
                  child: Text('Send', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
