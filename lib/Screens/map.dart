import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../models/dummyTracks.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final FlutterTts flutterTts = FlutterTts();
  LatLng? _currentPosition;
  StreamSubscription<Position>? _positionStream;
  bool isSpeaking = false;

  final LatLng initialCenter = const LatLng(31.043200, 31.356050,);

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      _startLiveTracking();
    }
  }

  void _startLiveTracking() {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    ).listen((Position position) {
      LatLng newPosition = LatLng(position.latitude, position.longitude);
      setState(() {
        _currentPosition = newPosition;
        _mapController.move(newPosition, 17.0);
      });
    });
  }

  Future<void> _speak() async {
    if (isSpeaking) {
      await flutterTts.stop();
      setState(() {
        isSpeaking = false;
      });
    } else {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.0);
      await flutterTts.speak("In 500 meters, Gomhoria Street");
      setState(() {
        isSpeaking = true;
      });
    }
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<LatLng> points = Tracks
        .map((track) => LatLng(track.latitude, track.longitude))
        .toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: const BackButton(color: Color(0xff1B4965)),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: initialCenter,
              zoom: 15.0,
              interactiveFlags: InteractiveFlag.all,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: Tracks.map((track) {
                  return Marker(
                    point: LatLng(track.latitude, track.longitude),
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.location_on, color: Color(0xffB40000), size: 30),
                  );
                }).toList(),
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: points,
                    strokeWidth: 3.5,
                    color: Color(0xff1B4965),
                  ),
                ],
              ),
            ],
          ),

          Positioned(
            top: 50,
            left: 120,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("in 500 m", style: TextStyle(fontSize: 18)),
                      Text("st.Gomhoria Street"),
                    ],
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: _speak,
                    icon: Icon(
                      isSpeaking ? Icons.volume_off : Icons.volume_up,
                      color: const Color(0xff5fa8d3),
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),

          // Bottom panel
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 132,
              color: Colors.white.withOpacity(0.9),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text("Arrives in"),
                        SizedBox(width: 15),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.3,
                            backgroundColor: Color(0xffDDF1FF),
                            color: Color(0xff5fa8d3),
                          ),
                        ),
                        SizedBox(width: 15),
                        Text("00:05:32"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            final startPoint = LatLng(
                                Tracks[0].latitude,
                                Tracks[0].longitude);
                            _mapController.move(startPoint, 17.0);
                          },
                          icon: const Icon(
                            Icons.navigation,
                            color: Color(0xff5fa8d3),
                            size: 40,
                          ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        SizedBox(width: 75),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5fa8d3),
                          ),
                          child: const Text(
                            "Urgent Stop",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
