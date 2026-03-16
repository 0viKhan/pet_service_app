import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = const LatLng(23.8103, 90.4125);
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  bool _locationFetched = false;
  String _selectedFilter = 'All';
  Map<String, dynamic>? _selectedShop;

  final List<String> _filters = [
    'All',
    'Veterinarians',
    'Dog trainers',
    'Pet shops',
  ];

  final List<Map<String, dynamic>> _petShops = [
    {
      'id': '1',
      'name': 'Cosmo Dog Cares',
      'lat': 23.8150,
      'lng': 90.4150,
      'rating': 4.5,
      'price': '\$20.00',
      'image': 'https://img.freepik.com/free-vector/store-grocery-shop-building-isolated-white-background_1284-14054.jpg?semt=ais_hybrid&w=740&q=80',       'type': 'Pet shops',
    },
    {
      'id': '2',
      'name': 'Happy Paws Vet',
      'lat': 23.8160,
      'lng': 90.4160,
      'rating': 4.2,
      'price': '\$15.00',
      'image': 'assets/images/doctor_girl.jpg',
      'type': 'Veterinarians',
    },
    {
      'id': '3',
      'name': 'Pawfect Trainers',
      'lat': 23.8120,
      'lng': 90.4180,
      'rating': 4.0,
      'price': '\$18.00',
      'image': 'assets/images/doctor_girl.jpg',
      'type': 'Dog trainers',
    },
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    if (_locationFetched) return;
    _locationFetched = true;

    final status = await Permission.location.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      _addMarkers();
      _animateToPosition(_currentPosition);
      return;
    }

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _addMarkers();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });

      _addMarkers();
      _animateToPosition(_currentPosition);
    } catch (_) {
      _addMarkers();
      setState(() {});
    }
  }

  void _animateToPosition(LatLng position) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 16),
      ),
    );
  }

  String _getDistanceLabel(LatLng shopLatLng) {
    double distance = Geolocator.distanceBetween(
      _currentPosition.latitude,
      _currentPosition.longitude,
      shopLatLng.latitude,
      shopLatLng.longitude,
    );

    if (distance <= 500) return 'khub kachakachi';
    return '${(distance / 1000).toStringAsFixed(1)} km away';
  }

  void _addMarkers() {
    _markers.clear();
    _polylines.clear();

    // Current location marker
    _markers.add(
      Marker(
        markerId: const MarkerId('currentLocation'),
        position: _currentPosition,
        infoWindow: const InfoWindow(title: 'Your location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );

    // Filter shops
    List<Map<String, dynamic>> filteredShops = _selectedFilter == 'All'
        ? _petShops
        : _petShops.where((shop) => shop['type'] == _selectedFilter).toList();

    for (var shop in filteredShops) {
      LatLng shopLatLng = LatLng(shop['lat'], shop['lng']);
      String distanceLabel = _getDistanceLabel(shopLatLng);

      _markers.add(
        Marker(
          markerId: MarkerId(shop['id']),
          position: shopLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          infoWindow: InfoWindow(
            title: shop['name'],
            snippet: distanceLabel,
            onTap: () {
              setState(() => _selectedShop = shop);
              _drawRouteToShop(shopLatLng);
            },
          ),
          onTap: () {
            setState(() => _selectedShop = shop);
            _drawRouteToShop(shopLatLng);
          },
        ),
      );
    }

    setState(() {});
  }

  void _drawRouteToShop(LatLng destination) {
    _polylines.clear();
    _polylines.add(
      Polyline(
        polylineId: const PolylineId('route'),
        points: [_currentPosition, destination],
        color: Colors.red,
        width: 6,
      ),
    );
    _animateToPosition(destination);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(target: _currentPosition, zoom: 14),
            onMapCreated: (controller) => _mapController = controller,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: _markers,
            polylines: _polylines,
            onTap: (_) {
              setState(() {
                _selectedShop = null;
                _polylines.clear();
              });
            },
          ),

          // Top filters
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)],
                      ),
                      child: const Icon(Icons.arrow_back, size: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filters.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final filter = _filters[index];
                      final isSelected = _selectedFilter == filter;
                      return GestureDetector(
                        onTap: () {
                          setState(() => _selectedFilter = filter);
                          _addMarkers();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF2D6A4F) : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 4)],
                          ),
                          child: Text(
                            filter,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Bottom shop card
          if (_selectedShop != null)
            Positioned(
              bottom: 90,
              left: 16,
              right: 16,
              child: _buildShopCard(_selectedShop!),
            ),

          // Floating Add Button
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(

                onPressed: () {
                  // Animate the map camera to the user's current location
                  if (_mapController != null) {
                    _mapController!.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(target: _currentPosition, zoom: 16),
                      ),
                    );
                  }
                },
                child: const Icon(Icons.location_disabled, color: Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopCard(Map<String, dynamic> shop) {
    final img = shop['image'] as String?;
    Widget imageWidget;

    if (img != null && img.startsWith('assets/')) {
      imageWidget = Image.asset(img, width: 70, height: 70, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _placeholderImage());
    } else if (img != null && img.startsWith('http')) {
      imageWidget = Image.network(img, width: 70, height: 70, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _placeholderImage());
    } else {
      imageWidget = _placeholderImage();
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(10), child: imageWidget),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(shop['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(_getDistanceLabel(LatLng(shop['lat'], shop['lng'])),
                        style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    const SizedBox(width: 6),
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    Text('${shop['rating']}', style: const TextStyle(fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(shop['price'], style: const TextStyle(color: Color(0xFF2D6A4F), fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF2D6A4F)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            child: const Text('View Detail', style: TextStyle(color: Color(0xFF2D6A4F), fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      width: 70,
      height: 70,
      color: Colors.grey[200],
      child: const Icon(Icons.pets, color: Colors.grey),
    );
  }
}