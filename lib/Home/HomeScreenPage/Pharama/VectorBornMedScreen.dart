import 'package:flutter/material.dart';

import 'DiseaseMedicineScreen.dart';


class VectorBornMedScreen extends StatefulWidget {
  @override
  State<VectorBornMedScreen> createState() => _VectorBornMedScreenState();
}

class Diseases {
  final String title;
  final IconData icon;

  Diseases({
    required this.title,
    required this.icon,
  });
}

class _VectorBornMedScreenState extends State<VectorBornMedScreen> {

  final List<Diseases> diseases = [
    Diseases(title: "Malaria", icon: Icons.bug_report),
    Diseases(title: "Dengue", icon: Icons.coronavirus),
    Diseases(title: "Zika Virus", icon: Icons.health_and_safety),
    Diseases(title: "Japanese Encephalitis", icon: Icons.biotech),
    Diseases(title: "Yellow Fever", icon: Icons.warning),
    Diseases(title: "Lyme", icon: Icons.medical_services),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF147B72).withOpacity(0.12),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Vector-Borne Diseases",
          style: TextStyle(
              color: Color(0xFF147B72),
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        color: const Color(0xFF147B72).withOpacity(0.12),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: GridView.builder(
            padding: const EdgeInsets.only(top: 30),
            itemCount: diseases.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              final item = diseases[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DiseaseMedicineScreen(
                              diseaseName: item.title),
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
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}