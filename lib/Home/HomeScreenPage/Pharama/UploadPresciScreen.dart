import 'package:flutter/material.dart';

class UploadPresciScreen extends StatefulWidget {
  @override
  State<UploadPresciScreen> createState() => _UploadPresciScreenState();
}

class _UploadPresciScreenState extends State<UploadPresciScreen> {
  final Color primaryColor = Color(0xFF147B72);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0xffF4F4F4),
        elevation: 0,
        title: Text(
          "UPLOAD PRESCRIPTION",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Discount Banner
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                    color: Color(0xffD7CEF7),
                    borderRadius: BorderRadius.circular(14)),
                child: Center(
                  child: Text(
                    "Flat 15% off* on Medicine Order",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                ),
              ),

              SizedBox(height: 25),

              /// Title
              Text(
                "Have a Prescription?",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),

              SizedBox(height: 20),

              /// Upload Button
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(14)),
                child: Center(
                  child: Text(
                    "UPLOAD PRESCRIPTION",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),

              SizedBox(height: 25),

              /// Secure Info
              Row(
                children: [
                  Icon(Icons.security, color: primaryColor, size: 40),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Your Attached Prescription will be secure and Private.",
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),

              SizedBox(height: 25),

              /// Why Upload Title
              Text(
                "Why Upload a Prescription?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
              ),

              SizedBox(height: 15),

              /// Point 1
              Row(
                children: [
                  Icon(Icons.phone_android),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                        "Never Lose the Digital of your Prescription. It will be with you wherever you go."),
                  )
                ],
              ),

              SizedBox(height: 12),

              /// Point 2
              Row(
                children: [
                  Icon(Icons.medical_services_outlined),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text("Tata labs specialist will help you."),
                  )
                ],
              ),

              SizedBox(height: 12),

              /// Point 3
              Row(
                children: [
                  Icon(Icons.lock_outline),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                        "Details from your Prescription are not shared with any third Party."),
                  )
                ],
              ),

              SizedBox(height: 15),

              /// Link
              Text(
                "What is a Valid Prescription?",
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),

              SizedBox(height: 25),

              /// Offer Card
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffE6E2F8),
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      height: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://i.imgur.com/2yaf2wb.png"),
                              fit: BoxFit.cover)),
                    ),

                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Frequent Pains & Aches Slowing you Down?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Find Out the Cause.!",
                              style: TextStyle(color: primaryColor),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Frequent Pain Check Profile",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                "5 Test at \$15  FLASH SALE",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 30),

              /// Continue Button
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(14)),
                child: Center(
                  child: Text(
                    "CONTINUE  >",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),

              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}