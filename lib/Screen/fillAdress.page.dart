import 'dart:developer';

import 'package:eduma_app/Screen/home.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/navigatorKey.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/createBodyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class FillAddressPage extends StatefulWidget {
  final String productId;
  final String quantity;
  const FillAddressPage({
    super.key,
    required this.productId,
    required this.quantity,
  });

  @override
  State<FillAddressPage> createState() => _FillAddressPageState();
}

class _FillAddressPageState extends State<FillAddressPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: Text(
          "Fill Details",
          style: GoogleFonts.roboto(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xff000000),
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xff000000)),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
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
              SizedBox(height: 40.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      //_showAddressReviewBottomSheet();

                      final body = CreateBodyModel(
                        cart: [
                          Cart(
                            productId: int.parse(widget.productId),
                            quantity: int.parse(widget.quantity),
                          ),
                        ],
                        billing: Billing(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          address1: addressController.text,
                          city: townCityController.text,
                          postcode: pinCodeController.text,
                          phone: phoneNumberController.text,
                          email: emailController.text,
                        ),
                      );
                      try {
                        setState(() => isCheck = true);
                        final service = APIStateNetwork(createDio());
                        final response = await service.create(body);
                        if (response != null) {
                          final razorpay = Razorpay();
                          final options = {
                            "order_id": response.orderId,
                            "amount": response.amount * 100,
                            "currency": "INR",
                            "receipt": response.receipt,
                            "key": "rzp_test_RIeIwZBZ2NZi6w",
                            "wc_order_id": response.wcOrderId,
                            "prefill": {
                              "name": response.user.name,
                              "email": response.user.email,
                              "contact": response.user.contact,
                            },
                          };

                          razorpay.open(options);
                          razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (
                            PaymentSuccessResponse response,
                          ) {
                            log("Payment Success : ${response.paymentId}");

                            Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => HomePage(),
                              ),
                              (route) => false,
                            );
                            showSuccessMessage(context, "Payment Successful");
                            setState(() => isCheck = false);
                          });
                          razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (
                            PaymentFailureResponse response,
                          ) {
                            log("Payment Failed : ${response.message}");
                            showErrorMessage(
                              "Payment Failed : ${response.message}",
                            );
                          });

                          razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (
                            ExternalWalletResponse response,
                          ) {
                            log("External Wallet : ${response.walletName}");
                          });
                        } else {
                          setState(() => isCheck = false);
                          log("Unknow Error");
                        }
                      } catch (e, st) {
                        setState(() => isCheck = false);
                        //showErrorMessage("Something went wrong: $e");
                        log("Error: $e");
                        log("StackTrace: $st");
                        log(e.toString());
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff007AFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  child: isCheck
                      ? const CircularProgressIndicator(color: Colors.white)
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
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?)? validator,
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
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
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

  void _showAddressReviewBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows custom height
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.25,
          maxChildSize: 0.65,
          builder: (context, scrollController) {
            return Container(
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Review Address",
                    style: GoogleFonts.roboto(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff000000),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAddressRow(
                            Icons.person_outline,
                            "${firstNameController.text} ${lastNameController.text}",
                            "Full Name",
                          ),
                          SizedBox(height: 15.h),
                          _buildAddressRow(
                            Icons.location_on_outlined,
                            addressController.text,
                            "Street Address",
                          ),
                          SizedBox(height: 15.h),
                          _buildAddressRow(
                            Icons.location_city,
                            townCityController.text,
                            "Town / City",
                          ),
                          SizedBox(height: 15.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: _buildAddressRow(
                                  Icons.map_outlined,
                                  stateController.text,
                                  "State",
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: _buildAddressRow(
                                  Icons.numbers,
                                  pinCodeController.text,
                                  "Pin Code",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          _buildAddressRow(
                            Icons.public,
                            countryController.text,
                            "Country",
                          ),
                          SizedBox(height: 15.h),
                          _buildAddressRow(
                            Icons.phone_outlined,
                            phoneNumberController.text,
                            "Phone Number",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () =>
                              Navigator.pop(context), // Close bottom sheet
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            "Edit",
                            style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle confirm: Save address and proceed (e.g., to Order Review)
                            Navigator.pop(context); // Close bottom sheet
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Address confirmed and saved!'),
                              ),
                            );
                            // Add navigation here, e.g., Navigator.push(...) to next page
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff007AFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            "Confirm",
                            style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Helper: Build a row for address display
  Widget _buildAddressRow(IconData icon, String value, String label) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20.w, color: const Color(0xff9CA3AF)),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.roboto(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff6B7280),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value.isEmpty ? "Not filled" : value, // Fallback if empty
                style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff000000),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
