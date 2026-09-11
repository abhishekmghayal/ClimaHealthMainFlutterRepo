import 'package:flutter/material.dart';
import '../Doctor/DoctorDetailScreen.dart';
import '../Doctor/NearDoctorScreen.dart';


class DoctorListScreen extends StatelessWidget {
  final String specialization;

  DoctorListScreen({
    super.key,
    required this.specialization,
  });

  final List<Doctor> allDoctors = [
    Doctor(
      name: "Dr. John Smith",
      specialization: "Cardiologist",
      imagePath: "assets/images/doctor1.jpg",
      rating: 4.8,
      distance: "1.2 km",
    ),
    Doctor(
      name: "Dr. Alex Wilson",
      specialization: "Cardiologist",
      imagePath: "assets/images/doctor2.jpg",
      rating: 4.9,
      distance: "2.1 km",
    ),
    Doctor(
      name: "Dr. Emily Brown",
      specialization: "Dentist",
      imagePath: "assets/images/doctor1.jpg",
      rating: 4.6,
      distance: "3.4 km",
    ),
    Doctor(
      name: "Dr. John Smith",
      specialization: "Cardiologist",
      imagePath: "assets/images/doctor1.jpg",
      rating: 4.8,
      distance: "1.2 km",
    ),
    Doctor(
      name: "Dr. Alex Wilson",
      specialization: "Cardiologist",
      imagePath: "assets/images/doctor2.jpg",
      rating: 4.9,
      distance: "2.1 km",
    ),
    Doctor(
      name: "Dr. Emily Brown",
      specialization: "Dentist",
      imagePath: "assets/images/doctor1.jpg",
      rating: 4.6,
      distance: "3.4 km",
    ),
    Doctor(
      name: "Dr. John Smith",
      specialization: "Cardiologist",
      imagePath: "assets/images/doctor1.jpg",
      rating: 4.8,
      distance: "1.2 km",
    ),
    Doctor(
      name: "Dr. Alex Wilson",
      specialization: "Cardiologist",
      imagePath: "assets/images/doctor2.jpg",
      rating: 4.9,
      distance: "2.1 km",
    ),
    Doctor(
      name: "Dr. Emily Brown",
      specialization: "Dentist",
      imagePath: "assets/images/doctor1.jpg",
      rating: 4.6,
      distance: "3.4 km",
    ),
    Doctor(
      name: "Dr. John Smith",
      specialization: "Cardiologist",
      imagePath: "assets/images/doctor1.jpg",
      rating: 4.8,
      distance: "1.2 km",
    ),
    Doctor(
      name: "Dr. Alex Wilson",
      specialization: "Cardiologist",
      imagePath: "assets/images/doctor2.jpg",
      rating: 4.9,
      distance: "2.1 km",
    ),
    Doctor(
      name: "Dr. Emily Brown",
      specialization: "Dentist",
      imagePath: "assets/images/doctor1.jpg",
      rating: 4.6,
      distance: "3.4 km",
    ),
    Doctor(
      name: "Dr. John Smith",
      specialization: "Cardiologist",
      imagePath: "assets/images/doctor1.jpg",
      rating: 4.8,
      distance: "1.2 km",
    ),
    Doctor(
      name: "Dr. Alex Wilson",
      specialization: "Cardiologist",
      imagePath: "assets/images/doctor2.jpg",
      rating: 4.9,
      distance: "2.1 km",
    ),
    Doctor(
      name: "Dr. Emily Brown",
      specialization: "Dentist",
      imagePath: "assets/images/doctor1.jpg",
      rating: 4.6,
      distance: "3.4 km",
    ),
    Doctor(
      name: "Dr. John Smith",
      specialization: "Cardiologist",
      imagePath: "assets/images/doctor1.jpg",
      rating: 4.8,
      distance: "1.2 km",
    ),
    Doctor(
      name: "Dr. Alex Wilson",
      specialization: "Cardiologist",
      imagePath: "assets/images/doctor2.jpg",
      rating: 4.9,
      distance: "2.1 km",
    ),
    Doctor(
      name: "Dr. Emily Brown",
      specialization: "Dentist",
      imagePath: "assets/images/doctor1.jpg",
      rating: 4.6,
      distance: "3.4 km",
    ),
  ];

  @override
  Widget build(BuildContext context) {

    final filteredDoctors = allDoctors
        .where((doc) => doc.specialization == specialization)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF147B72).withOpacity(0.12),
        centerTitle: true,
        title: Text(
          specialization,
          style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
        ),
      ),

      body: filteredDoctors.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.medical_services_outlined,
              size: 90,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              "No Doctors Available",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      )
          : Container(
        color: Color(0xFF147B72).withOpacity(0.12),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filteredDoctors.length,
          itemBuilder: (context, index) {

            final doctor = filteredDoctors[index];

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DoctorDetailScreen(doctor: doctor),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [

                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        doctor.imagePath,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            doctor.specialization,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  size: 16,
                                  color: Colors.blue),
                              const SizedBox(width: 4),
                              Text(doctor.rating.toString()),
                              const SizedBox(width: 12),
                              const Icon(Icons.location_on,
                                  size: 16,
                                  color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(doctor.distance),
                            ],
                          )
                        ],
                      ),
                    ),

                    const Icon(Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey),
                  ],
                ),
              ),
            );
          },
        ),
      )
    );
  }
}
