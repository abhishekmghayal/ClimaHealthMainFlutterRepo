import 'package:climahealth/icons/eva_icons.dart';
import 'package:flutter/material.dart';

import 'Home/AccountScreen.dart';
import 'Home/ClimaScreen.dart';
import 'Home/HeathCheckerScreen.dart';
import 'Home/HomeScreen.dart';
import 'Home/SearchScreen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentIndex = 0;

  // Screens
  final List<Widget> screens = [
    HomeScreen(),
    ClimaScreen(),
    SearchScreen(),
    FavouriteScreen(),
    AccountScreen(),
  ];

  Widget buildNavItem({
    required int index,
    required IconData icon,
    required String title,
  }) {
    bool isSelected = currentIndex == index;

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        if (currentIndex != index) {
          setState(() {
            currentIndex = index;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
            : const EdgeInsets.all(8),
        decoration: isSelected
            ? BoxDecoration(
          color: const Color(0xFF147B72).withOpacity(0.3),
          borderRadius: BorderRadius.circular(30),
        )
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF147B72) : Colors.black,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF147B72),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [



          // Screens
          IndexedStack(
            index: currentIndex,
            children: screens,
          ),

          // Navigation Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildNavItem(index: 0, icon: EvaIcons.home, title: "Home"),
                    buildNavItem(index: 1, icon: FontAwesome.user_doctor_solid, title: "Clima"),
                    buildNavItem(index: 2, icon: EvaIcons.search, title: "Search"),
                    buildNavItem(index: 3, icon: EvaIcons.heart_outline, title: "Heath"),
                    buildNavItem(index: 4, icon: EvaIcons.person_outline, title: "Account"),
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