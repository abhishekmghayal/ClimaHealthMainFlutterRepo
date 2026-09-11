import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:climahealth/icons/eva_icons.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

class Editscreen extends StatefulWidget{
  @override
  State<Editscreen> createState() => _EditscreenState();
}

class _EditscreenState extends State<Editscreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:Stack(
        clipBehavior: Clip.none,
        children: [
          //Decto Layer
          Container(height: 120),
          Positioned(
              top: 130,
              left: 160,
              child: Container(
                height: 200,
                width: 180,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Color(0xFF147B72),
                      Color(0xFF0C524C),
                    ])
                ),
              )),
          Positioned(
              top: 50,
              left: 300,
              child: Container(
                height: 90,
                width: 90,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Color(0xFF147B72),
                      Color(0xFF0C524C),
                    ])
                ),
              )),
          Positioned(
              top: 150,
              left: 370,
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Color(0xFF147B72),
                      Color(0xFF0C524C),
                    ])
                ),
              )),
          Positioned(
            top: -130,
            left: -140,
            child: Container(
              width: 400,
              height: 400,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF147B72),
                    Color(0xFF0C524C),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
              left: 40,
              child:Text("Edit Your Profile",style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Tinos",
                fontSize: 25,
                color: Colors.white,
              ),)
          ),






          //Scrollable Content
          SafeArea(
            bottom: false,
            child: Column(

              children: [
                const SizedBox(height: 270),
                Expanded(
                    child: SingleChildScrollView(


                        child: Container(
                          width: double.infinity,
                          height: 830,
                          child: Column(

                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 220,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Color(0xFF147B72), Color(0xFF0C524C)],
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(40),
                                        bottomRight: Radius.circular(40),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 20.0, top: 10),
                                      child: Text(
                                        "Personal Info...",
                                        style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Tinos",
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 35),
                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    // Banner 1


                                    const SizedBox(height: 20),

                                    // Name
                                    buildTextField(
                                      "Name",
                                      "Enter the Name of User",
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 10),
                                        child: HugeIcon(
                                          icon: HugeIconsStrokeRounded.strokeRoundedUserAi,
                                          color: const Color(0xFF147B72),
                                          size: 25,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    // Blood Group
                                    buildTextField(
                                      "Blood Group",
                                      "Change Your Blood Group",
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 10),
                                        child: HugeIcon(
                                          icon: HugeIconsStrokeRounded.blood,
                                          color: const Color(0xFF147B72),
                                          size: 25,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    // Height
                                    buildTextField(
                                      "Height (CM)",
                                      "Enter Your Height",
                                      keyboardType: TextInputType.number,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 10),
                                        child: HugeIcon(
                                          icon: HugeIconsStrokeRounded.hackerrank,
                                          color: const Color(0xFF147B72),
                                          size: 25,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    // Birth Date
                                    buildTextField(
                                      "Birth Date",
                                      "Enter Your Birth Date",
                                      keyboardType: TextInputType.number,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 10),
                                        child: HugeIcon(
                                          icon: HugeIconsStrokeRounded.hackerrank,
                                          color: const Color(0xFF147B72),
                                          size: 25,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 30),

                                    // Banner 2



                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 230,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF0C524C),
                                          Color(0xFF147B72), ],
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        bottomLeft: Radius.circular(40),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 20.0, top: 10),
                                      child: Text(
                                        "Accounts Center...",
                                        style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Tinos",
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.symmetric(horizontal: 35),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),

                                    // Mobile
                                    buildTextField(
                                      "Mobile No",
                                      "Enter the Mobile No.",
                                      keyboardType: TextInputType.phone,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 10),
                                        child: HugeIcon(
                                          icon: HugeIconsStrokeRounded.strokeRoundedSmartPhone02,
                                          color: const Color(0xFF147B72),
                                          size: 25,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    // Email
                                    buildTextField(
                                      "Email",
                                      "Enter the Email Address",
                                      keyboardType: TextInputType.emailAddress,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 10),
                                        child: HugeIcon(
                                          icon: HugeIconsStrokeRounded.addressBook,
                                          color: const Color(0xFF147B72),
                                          size: 25,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    // Password
                                    buildTextField(
                                      "Password",
                                      "Change Your Password",
                                      keyboardType: TextInputType.visiblePassword,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 10),
                                        child: HugeIcon(
                                          icon: HugeIconsStrokeRounded.circlePassword,
                                          color: const Color(0xFF147B72),
                                          size: 25,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    // Confirm Password
                                    buildTextField(
                                      "Confirm Password",
                                      "Re-enter Confirm Password",
                                      keyboardType: TextInputType.visiblePassword,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 10),
                                        child: HugeIcon(
                                          icon: HugeIconsStrokeRounded.passwordValidation,
                                          color: const Color(0xFF147B72),
                                          size: 25,
                                        ),
                                      ),
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(top: 10),

                                          height: 70,
                                          width: 220,

                                          decoration: const BoxDecoration(

                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40),
                                              bottomRight: Radius.circular(40),
                                            ),
                                          ),
                                          child: ElevatedButton(

                                            onPressed: () {
                                              // Add your action here
                                              print("Button Pressed!");
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(0xFF147B72),

                                              // custom color
                                              shape: RoundedRectangleBorder(


                                                borderRadius: BorderRadius.circular(30),
                                                // rounded corners
                                              ),

                                            ),
                                            child: const Text(
                                              "Submit",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),


                                  ],

                                ),
                              )
                            ],
                          ),
                        )
                    ),
                ),

              ],
            )
          )

        ],
      ),
    );
  }
  // Helper widget
  Widget buildTextField(
      String label,
      String hint, {
        Widget? prefixIcon,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return SizedBox(
      width: 370,
      child: TextField(
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 17,
          color: Color(0xFF147B72),
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Color(0xFF147B72),
            fontFamily: "Tinos",
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFF147B72),
            fontFamily: "Tinos",
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xFF147B72), width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xFF0C524C), width: 2),
          ),
        ),
      ),
    );
  }
}