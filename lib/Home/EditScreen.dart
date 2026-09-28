import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:climahealth/icons/eva_icons.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';
import 'package:climahealth/services/api_service.dart';

class Editscreen extends StatefulWidget{
  @override
  State<Editscreen> createState() => _EditscreenState();
}

class _EditscreenState extends State<Editscreen> {



  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();


  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  String? _convertDate(String date) {
    if (date.isEmpty) return null;

    final parts = date.split('/');

    if (parts.length != 3) return date;

    return "${parts[2]}-${parts[1]}-${parts[0]}";
  }
  @override
  void dispose() {

    _nameController.dispose();
    _bloodGroupController.dispose();
    _heightController.dispose();
    _birthDateController.dispose();
    _mobileController.dispose();
    _emailController.dispose();

    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    final result = await ApiService.getProfile();

    if (!mounted) return;

    final data = result["data"];

    if (result["statusCode"] == 200 && data["success"] == true) {
      final user = data["user"];

      setState(() {
        _nameController.text = user["fullName"] ?? "";
        _mobileController.text = user["mobile"] ?? "";
        _emailController.text = user["email"] ?? "";
        _bloodGroupController.text = user["bloodGroup"] ?? "";
        _heightController.text = user["height"]?.toString() ?? "";

        if (user["birthDate"] != null) {
          final date = DateTime.parse(user["birthDate"]);

          _birthDateController.text =
          "${date.day.toString().padLeft(2, '0')}/"
              "${date.month.toString().padLeft(2, '0')}/"
              "${date.year}";
        } else {
          _birthDateController.text = "";
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            data["message"] ?? "Failed to load profile",
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _updateProfile() async{
    final token = await ApiService.getToken();
    final result = await ApiService.updateProfile(
      token: token!,
      fullName: _nameController.text.trim(),
      mobile: _mobileController.text.trim(),
      email: _emailController.text.trim(),
      bloodGroup: _bloodGroupController.text.trim(),
      height: double.tryParse(_heightController.text.trim()),
      birthDate: _convertDate(_birthDateController.text.trim()),
    );
    final data=result["data"];
    if(!mounted) return;
    if(result["statusCode"]==200 && data["success"]==true){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Updated Successfully"),
        backgroundColor: Color(0xFF0C524C),
        )
      );
      Navigator.pop(context);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            data["message"] ?? "Failed to update profile",
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                                      controller: _nameController,
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
                                      controller: _bloodGroupController,
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
                                      controller: _heightController,
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
                                      controller: _birthDateController,
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
                                      controller: _mobileController,
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
                                      controller: _emailController,
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

                                            onPressed: _updateProfile,
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