import 'dart:developer';
import 'dart:io';

import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/navigatorKey.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Controller/updateProfileController.dart';
import 'package:eduma_app/data/Model/updateProfileBodyModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage>
    with UpdateProfile<EditProfilePage> {
  File? image;
  final picker = ImagePicker();

  Future pickImageFromGallery() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final PickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (PickedFile != null) {
        setState(() {
          image = File(PickedFile.path);
        });
      }
    } else {
      print("Gallery Permission isdenied");
    }
  }

  Future pickImageFromCamera() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final PickedFile = await picker.pickImage(source: ImageSource.camera);
      if (PickedFile != null) {
        setState(() {
          image = File(PickedFile.path);
        });
      }
    } else {
      print("Camera Permission isdenied");
    }
  }

  Future showImage() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              pickImageFromGallery();
            },
            child: Text("Gallery"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              pickImageFromCamera();
            },
            child: Text("Camera"),
          ),
        ],
      ),
    );
  }

  File? pickedFile;

  /// Pick any file (pdf, doc, image, zip, etc.)
  Future<void> pickAnyFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any, // Change to FileType.custom for specific extensions
    );

    if (result != null) {
      setState(() {
        pickedFile = File(result.files.single.path!);
      });
    } else {
      // User cancelled file picking
      debugPrint("File picking cancelled");
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF001E6C),
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
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 37.w,
                      height: 37.h,
                      decoration: BoxDecoration(
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
                height: MediaQuery.of(context).size.height * 2,
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
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Upload Profile",
                        style: GoogleFonts.roboto(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF4D4D4D),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.r),
                          border: Border.all(
                            color: Color.fromARGB(25, 0, 0, 0),
                          ),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                pickAnyFile();
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 16.w),
                                width: 91.w,
                                height: 35.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r),
                                  color: Color(0xFF001E6C),
                                ),
                                child: Center(
                                  child: Text(
                                    "Choose File",
                                    style: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            pickedFile == null
                                ? Container(
                                    margin: EdgeInsets.only(left: 16.w),
                                    width: 91.w,
                                    height: 35.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.r),
                                      // color: Color(0xFF001E6C),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Choose File",
                                        style: GoogleFonts.roboto(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF37474F),
                                        ),
                                      ),
                                    ),
                                  )
                                : Text(
                                    "Picked File: ${pickedFile!.path.split('/').last}",
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      ProfileBody(name: "Email", controller: emailController),
                      SizedBox(height: 20.h),
                      ProfileBody(name: "Phone", controller: phoneController),
                      SizedBox(height: 20.h),
                      ProfileBody(name: "City", controller: cityController),
                      SizedBox(height: 20.h),
                      ProfileBody(name: "State", controller: stateController),
                      SizedBox(height: 20.h),
                      ProfileBody(
                        name: "Country",
                        controller: countryController,
                      ),
                      SizedBox(height: 20.h),
                      ProfileBody(
                        name: "Address",
                        controller: addressController,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "About ",
                        style: GoogleFonts.roboto(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF4D4D4D),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
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
                            borderSide: BorderSide(
                              color: Color.fromARGB(25, 0, 0, 0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.r),
                            borderSide: BorderSide(
                              color: Color.fromARGB(25, 0, 0, 0),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.r),
                            borderSide: BorderSide(
                              color: Color.fromARGB(25, 0, 0, 0),
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.r),
                            borderSide: BorderSide(
                              color: Color.fromARGB(25, 0, 0, 0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(400.w, 52.h),
                          backgroundColor: Color(0xFF001E6C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.r),
                            side: BorderSide.none,
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final body = UpdateProfileBodyModel(
                              firstName: nameController.text,
                              lastName: "lastName",
                              displayName: "displayName",
                              email: emailController.text,
                              phone: phoneController.text,
                              bio: bioController.text,
                              address: addressController.text,
                              city: cityController.text,
                              state: stateController.text,
                              country: countryController.text,
                              postalCode: "395006",
                              avatarUrl: pickedFile!.path.toString(),
                            );
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              final service = APIStateNetwork(createDio());
                              final response = await service.updateProfile(
                                body,
                              );
                              if (response.success == true) {
                                Navigator.pop(context);
                                showSuccessMessage(context, response.message);
                              }
                              setState(() {
                                isLoading = false;
                              });
                            } catch (e) {
                              setState(() {
                                isLoading = false;
                              });
                              log(e.toString());
                            }
                          }
                        },
                        child: isLoading
                            ? Center(
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
  const ProfileBody({super.key, required this.name, required this.controller});

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
            color: Color(0xFF4D4D4D),
          ),
        ),
        SizedBox(height: 10.h),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: 20.w,
              right: 10.w,
              top: 15.h,
              bottom: 15.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.r),
              borderSide: BorderSide(color: Color.fromARGB(25, 0, 0, 0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.r),
              borderSide: BorderSide(color: Color.fromARGB(25, 0, 0, 0)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.r),
              borderSide: BorderSide(color: Color.fromARGB(25, 0, 0, 0)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.r),
              borderSide: BorderSide(color: Color.fromARGB(25, 0, 0, 0)),
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
