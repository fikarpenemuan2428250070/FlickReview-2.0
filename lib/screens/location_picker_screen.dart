import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final TextEditingController _searchController = TextEditingController();

  bool isLoading = false;

  Future<void> searchLocation() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() => isLoading = true);

    try {
      final locations = await locationFromAddress(query);
      if (locations.isEmpty) return;

      Navigator.pop(context, {
        'locationName': query,
        'latitude': locations.first.latitude,
        'longitude': locations.first.longitude,
        'isAutoLocation': false,
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Location not found')));
    }

    setState(() => isLoading = false);
  }

  Future<void> useCurrentLocation() async {
    setState(() => isLoading = true);

    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }

      final position = await Geolocator.getCurrentPosition();

      Navigator.pop(context, {
        'locationName':
            '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}',
        'latitude': position.latitude,
        'longitude': position.longitude,
        'isAutoLocation': true,
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to get location')));
    }

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Location')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search location',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: searchLocation,
                ),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => searchLocation(),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: isLoading ? null : useCurrentLocation,
                icon: const Icon(Icons.my_location),
                label: const Text('Use current location'),
              ),
            ),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
