import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'map_viewmodel.dart';

class MapScreen extends StatefulWidget {
  final VoidCallback onBack;
  final String supervisorName;
  final String tripId;

  const MapScreen({
    super.key,
    required this.onBack,
    required this.supervisorName,
    required this.tripId,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  LatLng? _currentPosition;
  StreamSubscription<Position>? _positionStream;
  bool _hasMovedToInitial = false;

  final LatLng initialCenter = LatLng(31.0364, 31.3807);

  /// ✨ TEMP  — replace these with real student lat/lon from your API / model
  final List<LatLng> _studentLocations = [
    LatLng(31.0385, 31.3795), // student 1
    LatLng(31.0348, 31.3822), // student 2
  ];

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    Future.microtask(() {
      Provider.of<MapViewModel>(context, listen: false)
          .fetchTripStudents(widget.tripId);
    });
  }

  // ───────────────── Location helpers ─────────────────
  Future<void> _checkLocationPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) return;
    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied ||
        perm == LocationPermission.deniedForever) {
      perm = await Geolocator.requestPermission();
    }
    if (perm == LocationPermission.always ||
        perm == LocationPermission.whileInUse) {
      _startLiveTracking();
    }
  }

  void _startLiveTracking() {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    ).listen((pos) {
      final newPos = LatLng(pos.latitude, pos.longitude);
      setState(() {
        _currentPosition = newPos;
        if (!_hasMovedToInitial) {
          _mapController.move(newPos, 17);
          _hasMovedToInitial = true;
        }
      });
    });
  }

  LatLng _midpoint(LatLng a, LatLng b) =>
      LatLng((a.latitude + b.latitude) / 2, (a.longitude + b.longitude) / 2);

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  // ───────────────── Widget tree ─────────────────
  @override
  Widget build(BuildContext context) {
    final students = context.watch<MapViewModel>().students;

    return Scaffold(
      body: Stack(
        children: [
          // ───── MAP ─────
          Positioned.fill(
            child: // ───── MAP Fullscreen ─────
            Positioned.fill(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: initialCenter,
                  zoom: 16,
                  interactiveFlags: InteractiveFlag.all,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  if (_currentPosition != null)
                    MarkerLayer(markers: [
                      Marker(
                        width: 50,
                        height: 50,
                        point: _currentPosition!,
                        child: const Icon(Icons.directions_bus,
                            color: Colors.blue, size: 40),
                      ),
                    ]),
                  MarkerLayer(
                    markers: _studentLocations
                        .map(
                          (pos) => Marker(
                        point: pos,
                        width: 40,
                        height: 40,
                        child: const Icon(Icons.location_pin,
                            color: Colors.red, size: 40),
                      ),
                    )
                        .toList(),
                  ),
                  if (_currentPosition != null)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: [_currentPosition!, ..._studentLocations],
                          color: Colors.green,
                          strokeWidth: 4,
                        ),
                      ],
                    ),
                  if (_currentPosition != null)
                    MarkerLayer(markers: [
                      Marker(
                        point: _midpoint(
                            _currentPosition!, _studentLocations.last),
                        width: 50,
                        height: 50,
                        child: Image.asset('assets/images/bus.png'),
                      ),
                    ]),
                ],
              ),
            ),
          ),

          // ───── Greeting ─────
          Positioned(
            top: 80,
            left: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi ${widget.supervisorName},',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1B4965))),
                const SizedBox(height: 4),
                const Text('Welcome Back!',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87)),
              ],
            ),
          ),

          // ───── Back button ─────
          Positioned(
            top: 40,
            left: 8,
            child: IconButton(
              onPressed: widget.onBack,
              icon:
              const Icon(Icons.arrow_back, color: Color(0xff1B4965)),
            ),
          ),

          // ───── Student cards (unchanged except avatar top) ─────
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.2,
            maxChildSize: 0.75,
            builder: (context, scrollController) {
              if (students.isEmpty) {
                return _emptySheet();
              }

              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 16),
                  itemCount: students.length,
                  itemBuilder: (context, index) =>
                      _studentCard(students[index]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ───────────────── Helpers ─────────────────
  Widget _emptySheet() => Container(
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    child: const Center(child: Text('No students found.')),
  );

  Widget _studentCard(student) => Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // Card bg
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[100],
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 3)),
            ],
          ),
          padding: const EdgeInsets.only(
              top: 70, bottom: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(student.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.badge,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(student.ssn,
                        style: const TextStyle(fontSize: 14)),
                  ]),
              const SizedBox(height: 6),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.phone,
                    size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(student.phone,
                    style: const TextStyle(fontSize: 14)),
              ]),
              if (student.disabilities.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.accessibility_new,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        student.disabilities.join(', '),
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),

        // Coloured bar behind avatar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xff5fa8d3).withOpacity(0.8),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)),
            ),
          ),
        ),

        // Avatar on top
        Positioned(
          top: 2,
          left: 0,
          right: 0,
          child: Center(
            child: CircleAvatar(
              radius: 34,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(student.image),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
