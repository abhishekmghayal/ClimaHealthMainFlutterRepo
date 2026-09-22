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
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: const Text(
            "Change Password",
            style: TextStyle(
              color: Color(0xFF147B72),
              fontFamily: "Tinos",
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildTextField(
                  "Current Password",
                  "Enter current password",
                  controller: _currentPasswordController,
                  obscureText: true,
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
                buildTextField(
                  "New Password",
                  "Enter new password",
                  controller: _newPasswordController,
                  obscureText: true,
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
                buildTextField(
                  "Confirm Password",
                  "Re-enter new password",
                  controller: _confirmPasswordController,
                  obscureText: true,
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
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF147B72),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Stack(
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
                Container(
                  width: double.infinity,
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

                                    // Change Password Button
                                    SizedBox(
                                      width: 370,
                                      height: 60,
                                      child: ElevatedButton(
                                        onPressed: _showChangePasswordDialog,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          side: const BorderSide(color: Color(0xFF0C524C), width: 2),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          elevation: 0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            HugeIcon(
                                              icon: HugeIconsStrokeRounded.circlePassword,
                                              color: const Color(0xFF147B72),
                                              size: 25,
                                            ),
                                            const SizedBox(width: 10),
                                            const Text(
                                              "Change your password",
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Tinos",
                                                color: Color(0xFF147B72),
                                              ),
                                            ),
                                          ],
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

              ],
            )
          )

        ],
      ),
      ),
      ),
    );
  }
  // Helper widget
  Widget buildTextField(
      String label,
      String hint, {
        Widget? prefixIcon,
        TextInputType keyboardType = TextInputType.text,
        TextEditingController? controller,
        bool obscureText = false,
      }) {
    return SizedBox(
      width: 370,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
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