import 'package:flutter/material.dart';
import 'colors.dart';
import 'planet.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController controller = PageController(viewportFraction: 0.75);
  int currentIndex = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void goToPage(int index) {
    if (index < 0 || index >= planets.length) return;
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final planet = planets[currentIndex];

    return Scaffold(
      backgroundColor: kBlack,
      body: Column(
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
                      height: 200,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      color: Colors.black.withOpacity(0.5),
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                ),

                // Gradient
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, kBlack],
                        stops: [0.5, 1.0],                      ),
                    ),
                  ),
                ),

                const Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text("Explore",
                        style: TextStyle(color: kWhite, fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),

                const Positioned(
                  bottom: 0,
                  left: 16,
                  child: Text(
                    "Which planet\nwould you like to explore?",
                    style: TextStyle(color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: planets.length,
              onPageChanged: (index) {
                setState(() => currentIndex = index);
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(6),
                  child: Image.asset(planets[index].image),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                arrowButton(Icons.arrow_back, () => goToPage(currentIndex - 1)),
                Text(
                  planet.name,
                  style: const TextStyle(
                    color: kWhite,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                arrowButton(
                    Icons.arrow_forward, () => goToPage(currentIndex + 1)),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsScreen(planet: planet),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kRed,
                  foregroundColor: kWhite,
                  elevation: 0,
                  padding: const EdgeInsets.all(16),
                  shape: const StadiumBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Explore ${planet.name}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Icon(Icons.arrow_right_alt),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget arrowButton(IconData icon, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: kRed,
        foregroundColor: kWhite,
        elevation: 0,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(8),
        minimumSize: Size.zero,
      ),
      child: Icon(icon, size: 22),
    );
  }
}