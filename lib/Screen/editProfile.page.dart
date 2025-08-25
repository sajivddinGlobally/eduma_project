// import 'dart:developer';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:eduma_app/config/core/showFlushbar.dart';
// import 'package:eduma_app/config/network/api.state.dart';
// import 'package:eduma_app/config/utils/navigatorKey.dart';
// import 'package:eduma_app/config/utils/pretty.dio.dart';
// import 'package:eduma_app/data/Controller/updateProfileController.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// class EditProfilePage extends ConsumerStatefulWidget {
//   const EditProfilePage({super.key});

//   @override
//   ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends ConsumerState<EditProfilePage>
//     with UpdateProfile<EditProfilePage> {
//   File? pickedFile;

//   Future<void> pickAnyFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//     );

//     if (result != null) {
//       setState(() {
//         pickedFile = File(result.files.single.path!);
//       });
//     } else {
//       debugPrint("File picking cancelled");
//     }
//   }

//   // Future<void> pickAnyFile() async {
//   //   FilePickerResult? result = await FilePicker.platform.pickFiles(
//   //     type: FileType.image,
//   //   );
//   //   if (result != null) {
//   //     setState(() {
//   //       pickedFile = File(result.files.single.path!);
//   //     });
//   //   }
//   // }

//   // Future<void> uploadAvatarOnly() async {
//   //   if (pickedFile == null) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         backgroundColor: Colors.red,
//   //         content: Text("Please select an image first"),
//   //       ),
//   //     );
//   //     return;
//   //   }
//   //   try {
//   //     setState(() => isLoading = true);

//   //     // final avatarFile = await MultipartFile.fromFile(
//   //     //   pickedFile!.path,
//   //     //   filename: pickedFile!.path.split('/').last,
//   //     // );
//   //     final avatarFile = File(pickedFile!.path);

//   //     final service = APIStateNetwork(createDio());
//   //     final response = await service.updateAvater(avatarFile);

//   //     if (response.success == true) {
//   //       showSuccessMessage(context, response.message ?? "Avatar updated");
//   //     } else {
//   //       //showErrorMessage(context, "Avatar upload failed");
//   //     }
//   //   } catch (e) {
//   //     log("Upload Error: $e");
//   //     // showErrorMessage(context, "Something went wrong");
//   //   } finally {
//   //     setState(() => isLoading = false);
//   //   }
//   // }

//   // Future<void> saveFullProfile() async {
//   //   if (!formKey.currentState!.validate()) return;

//   //   try {
//   //     setState(() => isLoading = true);

//   //     MultipartFile? avatarFile;
//   //     if (pickedFile != null) {
//   //       avatarFile = await MultipartFile.fromFile(
//   //         pickedFile!.path,
//   //         filename: pickedFile!.path.split('/').last,
//   //       );
//   //     }

//   //     FormData formData = FormData.fromMap({
//   //       "first_name": nameController.text,
//   //       "last_name": "Ansari",
//   //       "display_name": nameController.text,
//   //       "email": emailController.text,
//   //       "phone": phoneController.text,
//   //       "bio": bioController.text,
//   //       "address": addressController.text,
//   //       "city": cityController.text,
//   //       "state": stateController.text,
//   //       "country": countryController.text,
//   //       "postal_code": "395006",
//   //       if (avatarFile != null) "avatar_url": avatarFile,
//   //     });

//   //     final service = APIStateNetwork(createDio());
//   //     final response = await service.updateProfileFormData(formData);

//   //     if (response.success == true) {
//   //       Navigator.pop(context);
//   //       showSuccessMessage(context, response.message);
//   //     } else {
//   //       //showErrorMessage(context, "Profile update failed");
//   //     }
//   //   } catch (e) {
//   //     log(e.toString());
//   //     //showErrorMessage(context, "Error: $e");
//   //   } finally {
//   //     setState(() => isLoading = false);
//   //   }
//   // }

//   bool isLoading = false;

//   Future<void> saveProfileAndAvatar() async {
//     if (!formKey.currentState!.validate()) return;

//     setState(() => isLoading = true);

//     try {
//       final service = APIStateNetwork(createDio());

//       // 1. Avatar upload agar image select kiya hai
//       bool avatarSuccess = true;
//       if (pickedFile != null) {
//         final avatarFile = File(pickedFile!.path);
//         final avatarResponse = await service.updateAvater(avatarFile);

//         avatarSuccess = avatarResponse.success == true;
//         if (!avatarSuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               backgroundColor: Colors.red,
//               content: Text("Avater Update Failed"),
//             ),
//           );
//         }
//       }

//       // 2. Profile save API
//       FormData formData = FormData.fromMap({
//         "first_name": nameController.text,
//         "last_name": "Ansari",
//         "display_name": nameController.text,
//         "email": emailController.text,
//         "phone": phoneController.text,
//         "bio": bioController.text,
//         "address": addressController.text,
//         "city": cityController.text,
//         "state": stateController.text,
//         "country": countryController.text,
//         "postal_code": "395006",
//         if (pickedFile != null)
//           "image": await MultipartFile.fromFile(
//             pickedFile!.path,
//             filename: pickedFile!.path.split('/').last,
//           ),
//       });

//       // final profileResponse = await service.updateProfileFormData(formData);
//       // bool profileSuccess = profileResponse.success == true;

//       // if (avatarSuccess && profileSuccess) {
//       //   if (mounted) {
//       //     showSuccessMessage(context, "Profile updated successfully ✅");
//       //     Navigator.pop(context, true); // <-- direct navigate back
//       //   }

//       final profileResponse = await service.updateProfileFormData(formData);
//       bool profileSuccess = profileResponse.success == true;

//       if (mounted && avatarSuccess && profileSuccess) {
//         showSuccessMessage(context, "Profile updated successfully ✅");
//         // Check if the route can be popped before attempting navigation
//         if (Navigator.of(context).canPop()) {
//           Future.microtask(() {
//             if (mounted) {
//               Navigator.of(context).maybePop(true);
//             }
//           });
//         } else {
//           log("Cannot pop: No route available to pop");
//           if (mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 backgroundColor: Colors.yellow,
//                 content: Text(
//                   "Navigation not possible, route already dismissed",
//                 ),
//               ),
//             );
//           }
//         }
//       } else if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             backgroundColor: Colors.red,
//             content: Text("Something went wrong"),
//           ),
//         );
//       }
//     } catch (e) {
//       log("Save Profile Error: $e");
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF001E6C),
//       body: Form(
//         key: formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: 31.h),
//               Row(
//                 children: [
//                   SizedBox(width: 20.w),
//                   InkWell(
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Container(
//                       width: 37.w,
//                       height: 37.h,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Color.fromARGB(255, 23, 47, 111),
//                       ),
//                       child: Icon(
//                         Icons.arrow_back,
//                         color: Colors.white,
//                         size: 20.sp,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 50.w),
//                   Text(
//                     "Complete your Profile",
//                     style: GoogleFonts.roboto(
//                       fontSize: 26.sp,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                       letterSpacing: -1,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 30.h),
//               Container(
//                 height: MediaQuery.of(context).size.height * 2 / 1.3,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(40.r),
//                     topRight: Radius.circular(40.r),
//                   ),
//                   color: Colors.white,
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ProfileBody(
//                         name: "You are a",
//                         controller: nameController,
//                         type: TextInputType.name,
//                       ),

//                       SizedBox(height: 20.h),
//                       ProfileBody(
//                         name: "Email",
//                         controller: emailController,
//                         type: TextInputType.emailAddress,
//                       ),
//                       SizedBox(height: 20.h),
//                       ProfileBody(
//                         name: "Phone",
//                         controller: phoneController,
//                         type: TextInputType.phone,
//                         maxLength: 10,
//                       ),
//                       SizedBox(height: 20.h),
//                       ProfileBody(
//                         name: "City",
//                         controller: cityController,
//                         type: TextInputType.text,
//                       ),
//                       SizedBox(height: 20.h),
//                       ProfileBody(
//                         name: "State",
//                         controller: stateController,
//                         type: TextInputType.text,
//                       ),
//                       SizedBox(height: 20.h),
//                       ProfileBody(
//                         name: "Country",
//                         controller: countryController,
//                         type: TextInputType.text,
//                       ),
//                       SizedBox(height: 20.h),
//                       ProfileBody(
//                         name: "Address",
//                         controller: addressController,
//                         type: TextInputType.streetAddress,
//                       ),
//                       SizedBox(height: 20.h),
//                       Text(
//                         "Upload Profile",
//                         style: GoogleFonts.roboto(
//                           fontSize: 13.sp,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xFF4D4D4D),
//                         ),
//                       ),
//                       SizedBox(height: 10.h),
//                       InkWell(
//                         onTap: () async {
//                           // if (pickedFile == null) {
//                           //   ScaffoldMessenger.of(context).showSnackBar(
//                           //     SnackBar(
//                           //       backgroundColor: Colors.red,
//                           //       content: Text("Please select an image first"),
//                           //     ),
//                           //   );
//                           //   return;
//                           // }

//                           // try {
//                           //   // File ko MultipartFile me convert karein
//                           //   final avatarFile = await MultipartFile.fromFile(
//                           //     pickedFile!.path,
//                           //     filename: pickedFile!.path.split('/').last,
//                           //   );

//                           //   // Service initialize karo
//                           //   final service = APIStateNetwork(createDio());

//                           //   // API call
//                           //   final response = await service.updateAvater(
//                           //     avatarile!,
//                           //   );

//                           //   if (response.success == true) {
//                           //     log(response.message ?? "Upload success");
//                           //     showSuccessMessage(
//                           //       context,
//                           //       response.message ?? "Profile updated",
//                           //     );
//                           //   } else {
//                           //     ScaffoldMessenger.of(context).showSnackBar(
//                           //       SnackBar(
//                           //         backgroundColor: Colors.red,
//                           //         content: Text("Update failed"),
//                           //       ),
//                           //     );
//                           //   }
//                           // } catch (e) {
//                           //   log("Upload Error: $e");
//                           //   ScaffoldMessenger.of(context).showSnackBar(
//                           //     SnackBar(
//                           //       backgroundColor: Colors.red,
//                           //       content: Text("Something went wrong"),
//                           //     ),
//                           //   );
//                           // }
//                         },
//                         child: InkWell(
//                           onTap: pickAnyFile,
//                           child: Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: 60.h,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(40.r),
//                               border: Border.all(
//                                 color: Color.fromARGB(25, 0, 0, 0),
//                               ),
//                             ),
//                             child: Row(
//                               children: [
//                                 pickedFile == null
//                                     ? Container(
//                                         margin: EdgeInsets.only(left: 16.w),
//                                         width: 91.w,
//                                         height: 35.h,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(
//                                             30.r,
//                                           ),
//                                           color: Color(0xFF001E6C),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             "Choose File",
//                                             style: GoogleFonts.roboto(
//                                               fontSize: 12.sp,
//                                               fontWeight: FontWeight.w400,
//                                               color: Color(0xFFFFFFFF),
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     : Padding(
//                                         padding: EdgeInsets.only(left: 10.w),
//                                         child: Text(
//                                           "Picked File: ${pickedFile!.path.split('/').last}",
//                                         ),
//                                       ),
//                                 // const Spacer(),
//                                 // ElevatedButton(
//                                 //   onPressed: uploadAvatarOnly,
//                                 //   child: const Text("Upload Avatar"),
//                                 // ),
//                                 // : Padding(
//                                 //     padding: EdgeInsets.only(left: 16.w),
//                                 //     child: Text(
//                                 //       "Picked File: ${pickedFile!.path.split('/').last}",
//                                 //       style: GoogleFonts.roboto(
//                                 //         fontSize: 12.sp,
//                                 //         fontWeight: FontWeight.w500,
//                                 //       ),
//                                 //     ),
//                                 //   ),
//                                 // : Padding(
//                                 //     padding: EdgeInsetsGeometry.only(
//                                 //       left: 10.w,
//                                 //     ),
//                                 //     child: Image.file(pickedFile!),
//                                 //   ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20.h),
//                       Text(
//                         "About ",
//                         style: GoogleFonts.roboto(
//                           fontSize: 13.sp,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xFF4D4D4D),
//                         ),
//                       ),
//                       SizedBox(height: 10.h),
//                       TextFormField(
//                         keyboardType: TextInputType.text,
//                         controller: bioController,
//                         maxLines: 3,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.only(
//                             left: 20.w,
//                             right: 10.w,
//                             top: 15.h,
//                             bottom: 15.h,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(40.r),
//                             borderSide: BorderSide(
//                               color: Color.fromARGB(25, 0, 0, 0),
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(40.r),
//                             borderSide: BorderSide(
//                               color: Color.fromARGB(25, 0, 0, 0),
//                             ),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(40.r),
//                             borderSide: BorderSide(
//                               color: Color.fromARGB(25, 0, 0, 0),
//                             ),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(40.r),
//                             borderSide: BorderSide(
//                               color: Color.fromARGB(25, 0, 0, 0),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 30.h),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: Size(400.w, 52.h),
//                           backgroundColor: Color(0xFF001E6C),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(40.r),
//                             side: BorderSide.none,
//                           ),
//                         ),
//                         onPressed: () async {
//                           // saveFullProfile();
//                           // uploadAvatarOnly();
//                           saveProfileAndAvatar();

//                           // if (!formKey.currentState!.validate()) return;

//                           // setState(() => isLoading = true);

//                           // try {
//                           //   // MultipartFile बनाएँ अगर image select हुई हो
//                           //   MultipartFile? avatarFile;
//                           //   if (pickedFile != null) {
//                           //     avatarFile = await MultipartFile.fromFile(
//                           //       pickedFile!.path,
//                           //       filename: pickedFile!.path.split('/').last,
//                           //     );
//                           //   }

//                           //   // FormData तैयार करें
//                           //   FormData formData = FormData.fromMap({
//                           //     "first_name": nameController.text,
//                           //     "last_name": "Ansari",
//                           //     "display_name": nameController.text,
//                           //     "email": emailController.text,
//                           //     "phone": phoneController.text,
//                           //     "bio": bioController.text,
//                           //     "address": addressController.text,
//                           //     "city": cityController.text,
//                           //     "state": stateController.text,
//                           //     "country": countryController.text,
//                           //     "postal_code": "395006",
//                           //     "avatur_url": avatarFile,
//                           //   });

//                           //   // API call using PrettyDio
//                           //   final service = APIStateNetwork(createDio());
//                           //   final response = await service
//                           //       .updateProfileFormData(formData);

//                           //   if (response.success == true) {
//                           //     Navigator.pop(context);
//                           //     showSuccessMessage(context, response.message);
//                           //   }
//                           // } catch (e) {
//                           //   log(e.toString());
//                           //   ScaffoldMessenger.of(context).showSnackBar(
//                           //     SnackBar(content: Text("Error: $e")),
//                           //   );
//                           // } finally {
//                           //   setState(() => isLoading = false);
//                           // }
//                         },
//                         child: isLoading
//                             ? Center(
//                                 child: CircularProgressIndicator(
//                                   color: Colors.white,
//                                 ),
//                               )
//                             : Text(
//                                 "Save Profile",
//                                 style: GoogleFonts.roboto(
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ProfileBody extends StatelessWidget {
//   final String name;
//   final TextEditingController controller;
//   final TextInputType type;
//   final int? maxLength;
//   const ProfileBody({
//     super.key,
//     required this.name,
//     required this.controller,
//     required this.type,
//     this.maxLength,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           name,
//           style: GoogleFonts.roboto(
//             fontSize: 13.sp,
//             fontWeight: FontWeight.w400,
//             color: Color(0xFF4D4D4D),
//           ),
//         ),
//         SizedBox(height: 10.h),
//         TextFormField(
//           maxLength: maxLength,
//           keyboardType: type,
//           controller: controller,
//           decoration: InputDecoration(
//             counterText: "",
//             contentPadding: EdgeInsets.only(
//               left: 20.w,
//               right: 10.w,
//               top: 15.h,
//               bottom: 15.h,
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(40.r),
//               borderSide: BorderSide(color: Color.fromARGB(25, 0, 0, 0)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(40.r),
//               borderSide: BorderSide(color: Color.fromARGB(25, 0, 0, 0)),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(40.r),
//               borderSide: BorderSide(color: Color.fromARGB(25, 0, 0, 0)),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(40.r),
//               borderSide: BorderSide(color: Color.fromARGB(25, 0, 0, 0)),
//             ),
//           ),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return "$name is required";
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }
// }

import 'dart:developer';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/navigatorKey.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Controller/updateProfileController.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Custom showSuccessMessage implementation
Future<void> showSuccessMessage(BuildContext context, String message) async {
  if (!context.mounted) return;

  await Flushbar(
    message: message,
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.green,
    flushbarPosition: FlushbarPosition.TOP,
    margin: EdgeInsets.all(8.w),
    borderRadius: BorderRadius.circular(8.r),
  ).show(context);
}

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage>
    with UpdateProfile<EditProfilePage> {
  File? pickedFile;
  bool isLoading = false;

  Future<void> pickAnyFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        pickedFile = File(result.files.single.path!);
      });
    } else {
      debugPrint("File picking cancelled");
    }
  }

  Future<void> saveProfileAndAvatar() async {
    if (!formKey.currentState!.validate() || isLoading) return;

    setState(() => isLoading = true);

    try {
      final service = APIStateNetwork(createDio());

      // 1. Avatar upload if an image is selected
      bool avatarSuccess = true;
      if (pickedFile != null) {
        final avatarFile = File(pickedFile!.path);
        final avatarResponse = await service.updateAvater(avatarFile);

        avatarSuccess = avatarResponse.success == true;
        if (!avatarSuccess && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Avatar Update Failed"),
            ),
          );
        }
      }

      // 2. Profile save API
      FormData formData = FormData.fromMap({
        "first_name": nameController.text,
        "last_name": "Ansari",
        "display_name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "bio": bioController.text,
        "address": addressController.text,
        "city": cityController.text,
        "state": stateController.text,
        "country": countryController.text,
        "postal_code": "395006",
        if (pickedFile != null)
          "image": await MultipartFile.fromFile(
            pickedFile!.path,
            filename: pickedFile!.path.split('/').last,
          ),
      });

      final profileResponse = await service.updateProfileFormData(formData);
      bool profileSuccess = profileResponse.success == true;

      if (mounted && avatarSuccess && profileSuccess) {
        // Show success message and wait for it to dismiss
        await showSuccessMessage(context, "Profile updated successfully ✅");

        // Check if the route can be popped after Flushbar dismisses
        if (mounted && Navigator.of(context).canPop()) {
          Navigator.of(context).pop(true);
        } else if (mounted) {
          log("Cannot pop: No route available to pop");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.yellow,
              content: Text("Navigation not possible, route already dismissed"),
            ),
          );
        }
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Something went wrong"),
          ),
        );
      }
    } catch (e) {
      log("Save Profile Error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text("Error: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001E6C),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 31.h),
              Row(
                children: [
                  SizedBox(width: 20.w),
                  InkWell(
                    onTap: isLoading
                        ? null
                        : () {
                            if (mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                    child: Container(
                      width: 37.w,
                      height: 37.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 23, 47, 111),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 50.w),
                  Text(
                    "Complete your Profile",
                    style: GoogleFonts.roboto(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Container(
                height: MediaQuery.of(context).size.height * 2 / 1.3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileBody(
                        name: "You are a",
                        controller: nameController,
                        type: TextInputType.name,
                      ),
                      SizedBox(height: 20.h),
                      ProfileBody(
                        name: "Email",
                        controller: emailController,
                        type: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20.h),
                      ProfileBody(
                        name: "Phone",
                        controller: phoneController,
                        type: TextInputType.phone,
                        maxLength: 10,
                      ),
                      SizedBox(height: 20.h),
                      ProfileBody(
                        name: "City",
                        controller: cityController,
                        type: TextInputType.text,
                      ),
                      SizedBox(height: 20.h),
                      ProfileBody(
                        name: "State",
                        controller: stateController,
                        type: TextInputType.text,
                      ),
                      SizedBox(height: 20.h),
                      ProfileBody(
                        name: "Country",
                        controller: countryController,
                        type: TextInputType.text,
                      ),
                      SizedBox(height: 20.h),
                      ProfileBody(
                        name: "Address",
                        controller: addressController,
                        type: TextInputType.streetAddress,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Upload Profile",
                        style: GoogleFonts.roboto(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF4D4D4D),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      InkWell(
                        onTap: pickAnyFile,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.r),
                            border: Border.all(
                              color: const Color.fromARGB(25, 0, 0, 0),
                            ),
                          ),
                          child: Row(
                            children: [
                              pickedFile == null
                                  ? Container(
                                      margin: EdgeInsets.only(left: 16.w),
                                      width: 91.w,
                                      height: 35.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          30.r,
                                        ),
                                        color: const Color(0xFF001E6C),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Choose File",
                                          style: GoogleFonts.roboto(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFFFFFFFF),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(left: 10.w),
                                      child: Text(
                                        "Picked File: ${pickedFile!.path.split('/').last}",
                                        style: GoogleFonts.roboto(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "About",
                        style: GoogleFonts.roboto(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF4D4D4D),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: bioController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 20.w,
                            right: 10.w,
                            top: 15.h,
                            bottom: 15.h,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.r),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(25, 0, 0, 0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.r),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(25, 0, 0, 0),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.r),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(25, 0, 0, 0),
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.r),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(25, 0, 0, 0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(400.w, 52.h),
                          backgroundColor: const Color(0xFF001E6C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.r),
                            side: BorderSide.none,
                          ),
                        ),
                        onPressed: isLoading ? null : saveProfileAndAvatar,
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                "Save Profile",
                                style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final TextInputType type;
  final int? maxLength;

  const ProfileBody({
    super.key,
    required this.name,
    required this.controller,
    required this.type,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: GoogleFonts.roboto(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF4D4D4D),
          ),
        ),
        SizedBox(height: 10.h),
        TextFormField(
          maxLength: maxLength,
          keyboardType: type,
          controller: controller,
          decoration: InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.only(
              left: 20.w,
              right: 10.w,
              top: 15.h,
              bottom: 15.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.r),
              borderSide: const BorderSide(color: Color.fromARGB(25, 0, 0, 0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.r),
              borderSide: const BorderSide(color: Color.fromARGB(25, 0, 0, 0)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.r),
              borderSide: const BorderSide(color: Color.fromARGB(25, 0, 0, 0)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.r),
              borderSide: const BorderSide(color: Color.fromARGB(25, 0, 0, 0)),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "$name is required";
            }
            return null;
          },
        ),
      ],
    );
  }
}
