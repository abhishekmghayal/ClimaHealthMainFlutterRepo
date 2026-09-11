import 'package:flutter/material.dart';

class Appointment {
  final String doctorName;
  final String specialization;
  final String date;
  final String time;
  final String status;

  Appointment({
    required this.doctorName,
    required this.specialization,
    required this.date,
    required this.time,
    required this.status,
  });
}

class AppointmentScreen extends StatelessWidget {
  AppointmentScreen({super.key});

  final List<Appointment> appointments = [
    Appointment(
      doctorName: "Dr. John Smith",
      specialization: "Cardiologist",
      date: "Mon 21 Feb",
      time: "10:00 AM",
      status: "Approved",
    ),
    Appointment(
      doctorName: "Dr. Emily Brown",
      specialization: "Dentist",
      date: "Tue 22 Feb",
      time: "02:00 PM",
      status: "Pending",
    ),
    Appointment(
      doctorName: "Dr. Alex Wilson",
      specialization: "Neurologist",
      date: "Wed 23 Feb",
      time: "04:00 PM",
      status: "Rejected",
    ),
    Appointment(
      doctorName: "Dr. John Smith",
      specialization: "Cardiologist",
      date: "Mon 21 Feb",
      time: "10:00 AM",
      status: "Approved",
    ),
    Appointment(
      doctorName: "Dr. Emily Brown",
      specialization: "Dentist",
      date: "Tue 22 Feb",
      time: "02:00 PM",
      status: "Pending",
    ),
    Appointment(
      doctorName: "Dr. Alex Wilson",
      specialization: "Neurologist",
      date: "Wed 23 Feb",
      time: "04:00 PM",
      status: "Rejected",
    ),
    Appointment(
      doctorName: "Dr. John Smith",
      specialization: "Cardiologist",
      date: "Mon 21 Feb",
      time: "10:00 AM",
      status: "Approved",
    ),
    Appointment(
      doctorName: "Dr. Emily Brown",
      specialization: "Dentist",
      date: "Tue 22 Feb",
      time: "02:00 PM",
      status: "Pending",
    ),
    Appointment(
      doctorName: "Dr. Alex Wilson",
      specialization: "Neurologist",
      date: "Wed 23 Feb",
      time: "04:00 PM",
      status: "Rejected",
    ),
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      case "Rejected":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "Approved":
        return Icons.check_circle;
      case "Pending":
        return Icons.access_time;
      case "Rejected":
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF147B72).withOpacity(0.12),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Appointments",
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
        ),
      ),
      body: appointments.isEmpty
          ? const Center(
        child: Text(
          "No Appointments Booked",
          style: TextStyle(fontSize: 16),
        ),
      )
          : Container(
        color: Color(0xFF147B72).withOpacity(0.12),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            final appointment = appointments[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Doctor Name
                  Text(
                    appointment.doctorName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    appointment.specialization,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(appointment.date),
                      const SizedBox(width: 20),
                      const Icon(Icons.access_time,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(appointment.time),
                    ],
                  ),

                  const SizedBox(height: 15),

                  /// Status Row
                  Row(
                    children: [
                      Icon(
                        getStatusIcon(appointment.status),
                        color: getStatusColor(appointment.status),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        appointment.status,
                        style: TextStyle(
                          color: getStatusColor(appointment.status),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      )
    );
  }
}
