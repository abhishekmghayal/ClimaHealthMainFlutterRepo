import 'package:flutter/material.dart';
import 'DoctorDetailScreen.dart';

class NearDoctorScreen extends StatelessWidget {
  NearDoctorScreen({super.key});

  final List<Doctor> doctors = [
    Doctor(
      name: 'Dr. Joseph Blessitone',
      specialization: 'General Dentist',
      rating: 4.8,
      distance: '800m away',
      imagePath: 'assets/images/doctor1.jpg',
    ),
    Doctor(
      name: 'Dr. Eliza Williams',
      specialization: 'Cardiologist',
      rating: 4.9,
      distance: '1.2km away',
      imagePath: 'assets/images/doctor2.jpg',
    ),
    Doctor(
      name: 'Dr. Michael Smith',
      specialization: 'Orthopedic',
      rating: 4.7,
      distance: '500m away',
      imagePath: 'assets/images/doctor1.jpg',
    ),Doctor(
      name: 'Dr. Joseph Blessitone',
      specialization: 'General Dentist',
      rating: 4.8,
      distance: '800m away',
      imagePath: 'assets/images/doctor1.jpg',
    ),
    Doctor(
      name: 'Dr. Eliza Williams',
      specialization: 'Cardiologist',
      rating: 4.9,
      distance: '1.2km away',
      imagePath: 'assets/images/doctor2.jpg',
    ),
    Doctor(
      name: 'Dr. Michael Smith',
      specialization: 'Orthopedic',
      rating: 4.7,
      distance: '500m away',
      imagePath: 'assets/images/doctor1.jpg',
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: const Color(0xFF147B72).withOpacity(0.12),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Near Doctor',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFF147B72).withOpacity(0.12),
        child:ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            return DoctorCard(doctor: doctors[index]);
          },
        ),
      )
    );
  }
}

class Doctor {
  final String name;
  final String specialization;
  final double rating;
  final String distance;
  final String imagePath;

  Doctor({
    required this.name,
    required this.specialization,
    required this.rating,
    required this.distance,
    required this.imagePath,
  });
}

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorDetailScreen(doctor: doctor),
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          size: 16, color: Colors.blue),
                      const SizedBox(width: 4),
                      Text(doctor.rating.toString()),
                      const SizedBox(width: 12),
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        doctor.distance,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
