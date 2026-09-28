import 'dart:io';
import 'dart:ui';
import 'package:climahealth/Home/EditScreen.dart';
import 'package:flutter/material.dart';
import 'package:climahealth/Home/HeathCheckerScreen.dart';
import 'package:climahealth/Home/HomeScreenPage/Services/AppointmentScreen.dart';
import 'package:climahealth/Home/HomeScreenPage/Services/FaqScreen.dart';
import 'package:climahealth/LoginScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:climahealth/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  File? profileImage;
  bool isDeleted = false;
  final ImagePicker picker = ImagePicker();
  String fullName = "";
  String email = "";
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadCachedProfileImage();
    _loadUserData();
  }

  Future<void> _loadCachedProfileImage() async {
    final cachedImage = await ApiService.getProfileImage();
    if (cachedImage != null && cachedImage.isNotEmpty && mounted) {
      String sanitizedPath = cachedImage;
      if (!sanitizedPath.startsWith('/')) {
        sanitizedPath = '/$sanitizedPath';
      }
      setState(() {
        profileImageUrl = "${ApiService.baseUrl}$sanitizedPath";
      });
    }
  }

  Widget _buildProfileImage({required double radius, String fallbackAsset = "assets/images/default_profile.png"}) {
    if (isDeleted) {
      return CircleAvatar(radius: radius, backgroundImage: AssetImage(fallbackAsset));
    } else if (profileImageUrl != null && profileImageUrl!.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          profileImageUrl!,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            print("Profile Image Error: $error");
            return CircleAvatar(radius: radius, backgroundImage: AssetImage(fallbackAsset));
          },
        ),
      );
    } else if (profileImage != null) { 
      return CircleAvatar(radius: radius, backgroundImage: FileImage(profileImage!));
    } else {
      return CircleAvatar(radius: radius, backgroundImage: AssetImage(fallbackAsset));
    }
  }

  Future<void> _loadUserData() async {
    final result = await ApiService.getProfile();

    if (!mounted) return;

    if (result["statusCode"] == 200 &&
        result["data"]["success"] == true) {
      final user = result["data"]["user"];

      setState(() {
        fullName = user["fullName"] ?? "";
        email = user["email"] ?? "";

        if (user["profileImage"] != null &&
            user["profileImage"].toString().isNotEmpty) {
          String sanitizedPath = user["profileImage"].toString();
          if (!sanitizedPath.startsWith('/')) {
            sanitizedPath = '/$sanitizedPath';
          }
          profileImageUrl = "${ApiService.baseUrl}$sanitizedPath";
          print("Profile image from API: ${user["profileImage"]}");
          print("Final profile image URL: $profileImageUrl");
        }
      });
      
      if (user["profileImage"] != null && user["profileImage"].toString().isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("profileImage", user["profileImage"].toString());
      }
    }
  }

  Future<void> pickImage() async {
    var status = await Permission.photos.request();

    if (status.isGranted) {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (image != null) {
        setState(() {
          profileImage = File(image.path);
          isDeleted = false;
        });

        // Get logged-in user's token
        final token = await ApiService.getToken();

        if (token == null || token.isEmpty) {
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please login again"),
            ),
          );

          return;
        }

        // Upload profile image to backend
        final result = await ApiService.uploadProfileImage(
          token: token,
          imagePath: image.path,
        );

        final data = result["data"];

        if (!mounted) return;

        if (result["statusCode"] == 200 && data["success"] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Profile image updated successfully"),
              backgroundColor: Color(0xFF0C524C),
            ),
          );
          
          final uploadedProfileImage = data["profileImage"];
          if (uploadedProfileImage != null) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString("profileImage", uploadedProfileImage.toString());
            
            String sanitizedPath = uploadedProfileImage.toString();
            if (!sanitizedPath.startsWith('/')) {
              sanitizedPath = '/$sanitizedPath';
            }
            
            setState(() {
               profileImage = null; // Don't rely on local path
               profileImageUrl = "${ApiService.baseUrl}$sanitizedPath";
            });
            print("Uploaded profile image from API: $uploadedProfileImage");
            print("Final uploaded profile image URL: $profileImageUrl");
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                data["message"] ?? "Failed to upload profile image",
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Permission denied to access photos"),
        ),
      );
    }
  }

  void _showEditOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Text(
            "Select Option",
            style: TextStyle(
              fontFamily: "Tinos",
              color: const Color(0xFF0C524C),
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF147B72).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.edit, color: const Color(0xFF147B72), size: 20.sp),
                ),
                title: Text("Edit Profile", style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  Editscreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 10.h),
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF147B72).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.photo_camera, color: const Color(0xFF147B72), size: 20.sp),
                ),
                title: Text("Change Profile Photo", style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(context);
                  pickImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Stack(
        children: [
          // Background Gradient that spans the whole top, going behind status bar
          SizedBox(
            height: 205.h,
            width: double.infinity,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    "My Profile ⌮ ",
                    style: TextStyle(
                      fontFamily: "Tinos",
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 23.sp,
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF147B72), Color(0xFF0C524C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
                ),
              ),
            ),
          ),

          // Scrollable Foreground Content inside SafeArea
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(

              child: Column(
                children: [
                  const SizedBox(height: 20),

                  Padding(
                    padding: EdgeInsets.only(
                        top: 100.h, left: 18.w, right: 18.w, bottom: 10.h),
                    child: GestureDetector(
                      onDoubleTap: () => _showProfilePreview(context),
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(18.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 15.r,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    Hero(
                                      tag: "profile",
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFF147B72),
                                            width: 2.w,
                                          ),
                                        ),
                                        child: _buildProfileImage(radius: 38.r),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(7.w),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF147B72),
                                          shape: BoxShape.circle,
                                        ),
                                        child: InkWell(
                                          onTap: () => _showEditOptionsDialog(context),
                                          child: Icon(
                                            Icons.edit_outlined,
                                            size: 15.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 25.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        fullName,
                                        style: TextStyle(
                                          fontSize: 21.sp,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF2C3E50),
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(

                                        email,

                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 18.w, vertical: 1.h),
                    child: Column(
                      children: [
                        _buildMenuCard(
                          child: _buildOptionTile(
                            icon: Icons.favorite_border_rounded,
                            title: "My Saved",
                            onTap: () {},
                          ),
                        ),
                        SizedBox(height: 9.h),
                        _buildMenuCard(
                          child: _buildOptionTile(
                            icon: Icons.assignment_outlined,
                            title: "Appointment",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AppointmentScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 9.h),
                        _buildMenuCard(
                          child: _buildOptionTile(
                            icon: Icons.account_balance_wallet_outlined,
                            title: "Payment Method",
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      "Payment Method screen is coming soon!"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 9.h),
                        _buildMenuCard(
                          child: _buildOptionTile(
                            icon: Icons.chat_bubble_outline_rounded,
                            title: "FAQs",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FaqScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 9.h),
                        _buildMenuCard(
                          child: _buildOptionTile(
                            icon: Icons.settings,
                            title: "Settings",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FaqScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 9.h),
                        _buildMenuCard(
                          child: _buildOptionTile(
                            icon: Icons.exit_to_app_rounded,
                            title: "Logout",
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Logout",
                                      style: TextStyle(
                                        fontFamily: "Tinos",
                                        color: const Color(0xFF0C524C),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    content: const Text(
                                        "Are you sure you want to logout?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("Cancel",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.sp)),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await ApiService.logout();
                                          if (!context.mounted) return;
                                          Navigator.pop(context);
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                              const LoginScreen(),
                                            ),
                                                (route) => false,
                                          );
                                        },
                                        child: Text("Logout",
                                            style: TextStyle(
                                                color: const Color(0xFF0C524C),
                                                fontSize: 14.sp)),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: const Border(
          top: BorderSide(color: Color(0xFF147B72), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20.r,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Row(
          children: [
            Container(
              width: 35.r,
              height: 35.r,
              decoration: BoxDecoration(
                color: const Color(0xFF147B72).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: const Color(0xFF147B72),
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C3E50),
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade600,
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniInfo(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF147B72),
          ),
        ),
      ],
    );
  }

  void _showProfilePreview(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Profile",
      barrierColor: Colors.black26,
      pageBuilder: (context, _, __) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => Navigator.pop(context), // dismiss when tapping outside
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: Container(color: Colors.black.withOpacity(.35)),
                  ),
                  SafeArea(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: PopupMenuButton<String>(
                            color: Colors.white,
                            icon: Icon(Icons.more_vert,
                                color: Colors.white, size: 24.sp),
                            onSelected: (value) async {
                              if (value == "change") {
                                await pickImage();
                                setStateDialog(() {});
                              }
                              if (value == "delete") {
                                setState(() {
                                  profileImage = null;
                                  isDeleted = true;
                                });
                                setStateDialog(() {});
                              }
                            },
                            itemBuilder: (_) => [
                              PopupMenuItem(
                                value: "change",
                                child: Row(
                                  children: [
                                    const Icon(Icons.photo),
                                    SizedBox(width: 7.w),
                                    Text("Change Photo",
                                        style: TextStyle(fontSize: 12.sp)),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: "delete",
                                child: Row(
                                  children: [
                                    const Icon(Icons.delete, color: Colors.red),
                                    SizedBox(width: 7.w),
                                    Text("Delete Photo",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12.sp
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Hero(
                          tag: "profile",
                          child: AnimatedScale(
                            scale: 1,
                            duration: const Duration(milliseconds: 200),
                            child: _buildProfileImage(
                              radius: 130.r,
                              fallbackAsset: "assets/images/profile.webp",
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

