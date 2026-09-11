import 'package:flutter/material.dart';
import 'NearDoctorScreen.dart';
import 'SuccessAppointment.dart';

class DoctorDetailScreen extends StatefulWidget {
  final Doctor doctor;

  const DoctorDetailScreen({super.key, required this.doctor});

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  int selectedDateIndex = 2;
  int selectedTimeIndex = 4;

  final List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  final List<String> dates = ["21", "22", "23", "24", "25", "26"];

  final List<String> times = [
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "01:00 PM",
    "02:00 PM",
    "03:00 PM",
    "04:00 PM",
    "07:00 PM",
    "08:00 PM",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: const Color(0xFF147B72).withOpacity(0.12),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Doctor Detail",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFF147B72).withOpacity(0.12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Doctor Info
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      widget.doctor.imagePath,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.doctor.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.doctor.specialization,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                size: 16, color: Color(0xFF147B72)),
                            const SizedBox(width: 4),
                            Text(widget.doctor.rating.toString()),
                            const SizedBox(width: 12),
                            const Icon(Icons.location_on,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(widget.doctor.distance),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text("About",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                style: TextStyle(color: Color(0xFF147B72),
                    fontSize: 16),
              ),

              const SizedBox(height: 25),

              /// Date Selector
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedDateIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDateIndex = index;
                        });
                      },
                      child: Container(
                        width: 70,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF147B72)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: Colors.grey.shade300),
                        ),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Text(
                              days[index],
                              style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            Text(
                              dates[index],
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1.5,
                ),
              ),

              /// Time Selector
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 13,
                    children: List.generate(times.length, (index) {
                      bool isSelected = selectedTimeIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTimeIndex = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF147B72)
                                : Colors.white,
                            borderRadius:
                            BorderRadius.circular(30),
                            border: Border.all(
                                color: Colors.grey.shade300),
                          ),
                          child: Text(
                            times[index],
                            style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),



              /// Button
              /// Button
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF147B72),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {

                      String selectedFullDate =
                          "${days[selectedDateIndex]} ${dates[selectedDateIndex]}";

                      String selectedTime =
                      times[selectedTimeIndex];

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SuccessAppointment(
                            doctorName: widget.doctor.name,
                            date: selectedFullDate,
                            time: selectedTime,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Book Appointment",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      )
    );
  }
}
