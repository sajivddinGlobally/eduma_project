import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eduma_app/config/utils/navigatorKey.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetworkErrorPage extends StatefulWidget {
  const NetworkErrorPage({super.key});

  @override
  State<NetworkErrorPage> createState() => _NetworkErrorPageState();
}

class _NetworkErrorPageState extends State<NetworkErrorPage> {
  Future<void> _checkAgain(BuildContext context) async {
    final results = await Connectivity().checkConnectivity();
    final hasInternet =
        results.isNotEmpty && results.first != ConnectivityResult.none;

    if (hasInternet) {
      navigatorKey.currentState?.popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, color: Colors.redAccent, size: 80),
              const SizedBox(height: 20),
              Text(
                "No Internet Connection",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Please check your network and try again.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF001E6C),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => _checkAgain(context),
                child: const Text(
                  "Retry",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
