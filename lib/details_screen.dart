import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'colors.dart';
import 'planet.dart';

class DetailsScreen extends StatelessWidget {
  final Planet planet;

  const DetailsScreen({super.key, required this.planet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Transform.flip(
                      flipY: true,
                      child: Image.asset(
                        "assets/images/appbar_bg.jpg",
                        width: double.maxFinite,
                        height: 150,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        color: Colors.black.withOpacity(0.5),
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: kRed,
                        child: Icon(Icons.arrow_back, color: kWhite, size: 20),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 54,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        planet.name,
                        style: const TextStyle(
                          color: kWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Text(
                      planet.title,
                      style: const TextStyle(
                        color: kWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 300,
              width: double.infinity,
              child: Flutter3DViewer(
                src: planet.model,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "About",
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    planet.about,
                    style: const TextStyle(color: kWhite, fontSize: 16),
                  ),
                  const SizedBox(height: 16),

                  infoRow("Distance from Sun (km)", planet.distance),
                  infoRow("Length of Day (hours)", planet.dayLength),
                  infoRow("Orbital Period (Earth years)", planet.orbitalPeriod),
                  infoRow("Radius (km)", planet.radius),
                  infoRow("Mass (kg)", planet.mass),
                  infoRow("Gravity (m/s²)", planet.gravity),
                  infoRow("Surface Area (km²)", planet.surfaceArea),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        "$label : $value",
        style: const TextStyle(
          color: kWhite,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}