// import 'dart:developer';

// import 'package:eduma_app/Screen/orderList.page.dart';
// import 'package:eduma_app/config/core/showFlushbar.dart';
// import 'package:eduma_app/config/network/api.state.dart';
// import 'package:eduma_app/config/utils/pretty.dio.dart';
// import 'package:eduma_app/data/Model/createBodyModel.dart';
// import 'package:eduma_app/data/Model/editAddresBodyModel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class AddressFormPage extends StatefulWidget {
//   const AddressFormPage({super.key});

//   @override
//   State<AddressFormPage> createState() => _AddressFormPageState();
// }

// class _AddressFormPageState extends State<AddressFormPage> {
//   final _formKey = GlobalKey<FormState>();
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final countryController = TextEditingController();
//   final addressController = TextEditingController();
//   final townCityController = TextEditingController();
//   final stateController = TextEditingController();
//   final pinCodeController = TextEditingController();
//   final phoneNumberController = TextEditingController();
//   final emailController = TextEditingController();

//   @override
//   void dispose() {
//     firstNameController.dispose();
//     lastNameController.dispose();
//     countryController.dispose();
//     addressController.dispose();
//     townCityController.dispose();
//     stateController.dispose();
//     pinCodeController.dispose();
//     phoneNumberController.dispose();
//     emailController.dispose();
//     super.dispose();
//   }

//   bool isCheck = false;
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFFFFF),
//       appBar: AppBar(
//         title: Text('Order Review'),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 30.h),
//                 _buildTextField(
//                   label: "First Name",
//                   controller: firstNameController,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "First name is required";
//                     }

//                     return null;
//                   },
//                   icon: Icons.person_outline,
//                 ),
//                 SizedBox(height: 20.h),
//                 _buildTextField(
//                   label: "Last Name",
//                   controller: lastNameController,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Last name is required";
//                     }

//                     return null;
//                   },
//                   icon: Icons.person_outline,
//                 ),
//                 SizedBox(height: 20.h),
//                 _buildTextField(
//                   label: "Street Address",
//                   controller: addressController,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Street address is required";
//                     }
//                     return null;
//                   },
//                   maxLines: 2,
//                   icon: Icons.location_on_outlined,
//                 ),
//                 SizedBox(height: 20.h),
//                 _buildTextField(
//                   label: "Town / City",
//                   controller: townCityController,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Town/City is required";
//                     }

//                     return null;
//                   },
//                   icon: Icons.location_city,
//                 ),
//                 SizedBox(height: 20.h),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildTextField(
//                         label: "State",
//                         controller: stateController,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "State is required";
//                           }
//                           return null;
//                         },
//                         icon: Icons.map_outlined,
//                       ),
//                     ),
//                     SizedBox(width: 10.w),
//                     Expanded(
//                       child: _buildTextField(
//                         label: "Pin Code",
//                         controller: pinCodeController,
//                         maxlengh: 6,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Pin code is required";
//                           }
//                           if (!RegExp(r'^\d{6}$').hasMatch(value)) {
//                             return "Enter a valid 6-digit pin code";
//                           }
//                           return null;
//                         },
//                         keyboardType: TextInputType.number,
//                         icon: Icons.numbers,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20.h),
//                 _buildTextField(
//                   label: "Phone Number",
//                   controller: phoneNumberController,
//                   maxlengh: 10,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Phone number is required";
//                     }
//                     if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
//                       return "Enter a valid phone number";
//                     }
//                     return null;
//                   },
//                   keyboardType: TextInputType.phone,
//                   icon: Icons.phone_outlined,
//                 ),
//                 SizedBox(height: 20.h),
//                 _buildTextField(
//                   label: "Email",
//                   controller: emailController,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Email is required";
//                     }
//                     String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
//                     RegExp regex = RegExp(pattern);
//                     if (!regex.hasMatch(value.trim())) {
//                       return "Enter a valid email";
//                     }
//                     return null;
//                   },
//                   keyboardType: TextInputType.emailAddress,
//                   icon: Icons.mail,
//                 ),
//                 SizedBox(height: 40.h),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50.h,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       if (!_formKey.currentState!.validate()) {
//                         setState(() {
//                           isLoading = false;
//                         });
//                         return;
//                       }
//                       setState(() {
//                         isLoading = true;
//                       });

//                       try {
//                         final body = EditAddressBodyModel(
//                           billing: Ing(
//                             firstName: firstNameController.text,
//                             lastName: lastNameController.text,
//                             address1: addressController.text,
//                             city: townCityController.text,
//                             state: stateController.text,
//                             postcode: pinCodeController.text,
//                             country: countryController.text,
//                             email: emailController.text,
//                             phone: phoneNumberController.text,
//                           ),
//                           shipping: Ing(
//                             firstName: firstNameController.text,
//                             lastName: lastNameController.text,
//                             address1: addressController.text,
//                             city: townCityController.text,
//                             state: stateController.text,
//                             postcode: pinCodeController.text,
//                             country: countryController.text,
//                           ),
//                         );
//                         final service = APIStateNetwork(createDio());
//                         final response = await service.editAddress(body);
//                         if (response != null) {
//                           Navigator.pop(context, true);
//                           showSuccessMessage(context, "Address Saved");
//                           setState(() {
//                             isLoading = false;
//                           });
//                         } else {
//                           setState(() {
//                             isLoading = false;
//                           });
//                           log("Error");
//                         }
//                       } catch (e, st) {
//                         log("${e.toString()} , ${st.toString()}");
//                         setState(() {
//                           isLoading = false;
//                         });
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xff007AFF),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15.r),
//                       ),
//                     ),
//                     child: isLoading
//                         ? SizedBox(
//                             width: 30.w,
//                             height: 30.h,
//                             child: CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 1.5,
//                             ),
//                           )
//                         : Text(
//                             "Save Address",
//                             style: GoogleFonts.roboto(
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                   ),
//                 ),
//                 SizedBox(height: 20.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required String label,
//     required TextEditingController controller,
//     required String? Function(String?)? validator,
//     int maxlengh = 0,
//     IconData? icon,
//     TextInputType? keyboardType,
//     int maxLines = 1,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.roboto(
//             fontSize: 15.sp,
//             fontWeight: FontWeight.w500,
//             color: const Color(0xff4D4D4D),
//           ),
//         ),
//         SizedBox(height: 12.h),
//         TextFormField(
//           maxLength: maxlengh > 0 ? maxlengh : null,
//           controller: controller,
//           maxLines: maxLines,
//           keyboardType: keyboardType,
//           decoration: InputDecoration(
//             counterText: "",
//             prefixIcon: icon != null
//                 ? Icon(icon, size: 20.w, color: const Color(0xff9CA3AF))
//                 : null,
//             contentPadding: EdgeInsets.symmetric(
//               horizontal: 19.w,
//               vertical: maxLines > 1 ? 12.h : 15.h,
//             ),
//             filled: true,
//             fillColor: const Color(0xffF9FAFB),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15.r),
//               borderSide: BorderSide.none,
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15.r),
//               borderSide: BorderSide(
//                 color: Color.fromARGB(25, 0, 0, 0),
//                 width: 1.w,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15.r),
//               borderSide: const BorderSide(color: Color(0xff007AFF), width: 1),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15.r),
//               borderSide: const BorderSide(color: Colors.red, width: 1),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15.r),
//               borderSide: const BorderSide(color: Colors.red, width: 1),
//             ),
//           ),
//           validator: validator,
//         ),
//       ],
//     );
//   }
// }

import 'dart:developer';

import 'package:eduma_app/Screen/orderList.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/createBodyModel.dart';
import 'package:eduma_app/data/Model/editAddresBodyModel.dart';
import 'package:eduma_app/data/Controller/userAddressController.dart'; // Add this import for Riverpod
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Add this import
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class AddressFormPage extends ConsumerStatefulWidget {
  // Change to ConsumerStatefulWidget
  const AddressFormPage({super.key});

  @override
  ConsumerState<AddressFormPage> createState() => _AddressFormPageState();
}

class _AddressFormPageState extends ConsumerState<AddressFormPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final countryController = TextEditingController();
  final addressController = TextEditingController();
  final townCityController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCurrentAddress();
  }

  void _loadCurrentAddress() {
    final addres = ref.read(userAddressController);
    addres.whenData((data) {
      if (data.hasBilling) {
        final billing = data.billing!;
        firstNameController.text = billing.firstName ?? '';
        lastNameController.text = billing.lastName ?? '';
        addressController.text = billing.address1 ?? '';
        townCityController.text = billing.city ?? '';
        stateController.text = billing.state ?? '';
        pinCodeController.text = billing.postcode ?? '';
        countryController.text = billing.country ?? 'India'; // Default if empty
        phoneNumberController.text = billing.phone?.toString() ?? '';
        emailController.text = billing.email ?? '';
      }
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    countryController.dispose();
    addressController.dispose();
    townCityController.dispose();
    stateController.dispose();
    pinCodeController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  bool isCheck = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text('Edit Address'), // Changed title for clarity
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                _buildTextField(
                  label: "First Name",
                  controller: firstNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "First name is required";
                    }
                    return null;
                  },
                  icon: Icons.person_outline,
                ),
                SizedBox(height: 20.h),
                _buildTextField(
                  label: "Last Name",
                  controller: lastNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Last name is required";
                    }
                    return null;
                  },
                  icon: Icons.person_outline,
                ),
                SizedBox(height: 20.h),
                _buildTextField(
                  label: "Street Address",
                  controller: addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Street address is required";
                    }
                    return null;
                  },
                  maxLines: 2,
                  icon: Icons.location_on_outlined,
                ),
                SizedBox(height: 20.h),
                _buildTextField(
                  label: "Town / City",
                  controller: townCityController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Town/City is required";
                    }
                    return null;
                  },
                  icon: Icons.location_city,
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: "State",
                        controller: stateController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "State is required";
                          }
                          return null;
                        },
                        icon: Icons.map_outlined,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: _buildTextField(
                        label: "Pin Code",
                        controller: pinCodeController,
                        maxlengh: 6,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Pin code is required";
                          }
                          if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                            return "Enter a valid 6-digit pin code";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        icon: Icons.numbers,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                _buildTextField(
                  label: "Phone Number",
                  controller: phoneNumberController,
                  maxlengh: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phone number is required";
                    }
                    if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
                      return "Enter a valid phone number";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  icon: Icons.phone_outlined,
                ),
                SizedBox(height: 20.h),
                _buildTextField(
                  label: "Email",
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value.trim())) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.mail,
                ),
                SizedBox(height: 20.h),
                _buildTextField(
                  label: "Country",
                  controller: countryController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Country is required";
                    }
                    return null;
                  },
                  icon: Icons.public,
                ),
                SizedBox(height: 40.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = false;
                        });
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        final body = EditAddressBodyModel(
                          billing: Ing(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            address1: addressController.text,
                            city: townCityController.text,
                            state: stateController.text,
                            postcode: pinCodeController.text,
                            country: countryController.text,
                            email: emailController.text,
                            phone: phoneNumberController.text,
                          ),
                          shipping: Ing(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            address1: addressController.text,
                            city: townCityController.text,
                            state: stateController.text,
                            postcode: pinCodeController.text,
                            country: countryController.text,
                          ),
                        );
                        final service = APIStateNetwork(createDio());
                        final response = await service.editAddress(body);
                        if (response != null) {
                          Navigator.pop(context, true);
                          showSuccessMessage(context, "Address Saved");
                          setState(() {
                            isLoading = false;
                          });
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          log("Error");
                        }
                      } catch (e, st) {
                        log("${e.toString()} , ${st.toString()}");
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff007AFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                    child: isLoading
                        ? SizedBox(
                            width: 30.w,
                            height: 30.h,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1.5,
                            ),
                          )
                        : Text(
                            "Save Address",
                            style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    int maxlengh = 0,
    IconData? icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xff4D4D4D),
          ),
        ),
        SizedBox(height: 12.h),
        TextFormField(
          maxLength: maxlengh > 0 ? maxlengh : null,
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            counterText: "",
            prefixIcon: icon != null
                ? Icon(icon, size: 20.w, color: const Color(0xff9CA3AF))
                : null,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 19.w,
              vertical: maxLines > 1 ? 12.h : 15.h,
            ),
            filled: true,
            fillColor: const Color(0xffF9FAFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(
                color: Color.fromARGB(25, 0, 0, 0),
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: const BorderSide(color: Color(0xff007AFF), width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
