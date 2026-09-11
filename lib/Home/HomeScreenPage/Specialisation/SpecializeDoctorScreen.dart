import 'package:flutter/material.dart';

import 'DoctorListScreen.dart';


class Specialization {
  final String title;
  final IconData icon;
  final int doctorCount;

  Specialization({
    required this.title,
    required this.icon,
    required this.doctorCount,
  });
}

class SpecializedoctorScreen extends StatelessWidget {
  SpecializedoctorScreen({super.key});

  final List<Specialization> specializations = [
    Specialization(
        title: "Cardiologist",
        icon: Icons.favorite,
        doctorCount: 12),
    Specialization(
        title: "Dentist",
        icon: Icons.medical_services,
        doctorCount: 8),
    Specialization(
        title: "Neurologist",
        icon: Icons.psychology,
        doctorCount: 6),
    Specialization(
        title: "Pediatrician",
        icon: Icons.child_care,
        doctorCount: 10),
    Specialization(
        title: "Dermatologist",
        icon: Icons.spa,
        doctorCount: 5),
    Specialization(
        title: "Orthopedic",
        icon: Icons.accessibility_new,
        doctorCount: 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: const Color(0xFF147B72).withOpacity(0.12),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Specialized Doctors",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        color: Color(0xFF147B72).withOpacity(0.12),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: GridView.builder(
            padding: const EdgeInsets.only(top: 30),
            itemCount: specializations.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              final item = specializations[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DoctorListScreen(
                              specialization: item.title),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [

                      Icon(
                        item.icon,
                        size: 50,
                        color: const Color(0xFF147B72),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "${item.doctorCount} Doctors",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      )
    );
  }
}
