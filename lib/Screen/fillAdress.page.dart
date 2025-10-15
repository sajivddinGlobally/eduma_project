import 'dart:developer';
import 'package:eduma_app/Screen/home.page.dart';
import 'package:eduma_app/Screen/orderList.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/navigatorKey.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Controller/userAddressController.dart';
import 'package:eduma_app/data/Model/createBodyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class FillAddressPage extends ConsumerStatefulWidget {
  final String productId;
  final String quantity;
  const FillAddressPage({
    super.key,
    required this.productId,
    required this.quantity,
  });

  @override
  ConsumerState<FillAddressPage> createState() => _FillAddressPageState();
}

class _FillAddressPageState extends ConsumerState<FillAddressPage> {
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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final addres = ref.watch(userAddressController);
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text('Order Review'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addres.when(
            data: (data) {
              if (data.hasBilling == false || data.shipping == false) {
                return Form(
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
                            if (!RegExp(
                              r'^\+?[1-9]\d{1,14}$',
                            ).hasMatch(value)) {
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
                            String pattern =
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
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
                                  setState(() => isLoading = true);
                                  final service = APIStateNetwork(createDio());
                                  final response = await service.create(body);
                                  if (response != null) {
                                    final razorpay = Razorpay();
                                    final options = {
                                      "order_id": response.orderId,
                                      "amount": response.amount * 100,
                                      "currency": "INR",
                                      "receipt": response.receipt,
                                      // "key": "rzp_test_RIeIwZBZ2NZi6w",
                                      "key": "rzp_live_RQVbHR68ibVPuJ",
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
                                      log(
                                        "Payment Success : ${response.paymentId}",
                                      );

                                      // Navigator.pushAndRemoveUntil(
                                      //   context,
                                      //   CupertinoPageRoute(
                                      //     builder: (context) => HomePage(),
                                      //   ),
                                      //   (route) => false,
                                      // );
                                      Navigator.pushReplacement(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => OrderListPage(),
                                        ),
                                      );
                                      showSuccessMessage(
                                        context,
                                        "Payment Successful",
                                      );
                                      setState(() => isLoading = false);
                                    });
                                    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (
                                      PaymentFailureResponse response,
                                    ) {
                                      log(
                                        "Payment Failed : ${response.message}",
                                      );
                                      setState(() => isLoading = false);
                                      showErrorMessage(
                                        "Payment Failed : ${response.message}",
                                      );
                                    });
                                    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (
                                      ExternalWalletResponse response,
                                    ) {
                                      log(
                                        "External Wallet : ${response.walletName}",
                                      );
                                      setState(() => isLoading = false);
                                    });
                                  } else {
                                    setState(() => isLoading = false);
                                    log("Unknow Error");
                                  }
                                } catch (e, st) {
                                  setState(() => isLoading = false);
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
                            child: isLoading
                                ? SizedBox(
                                    width: 20.w,
                                    height: 20.h,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
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
                );
              } else {
                return Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Section
                      // Card(
                      //   elevation: 4,
                      //   child: Padding(
                      //     padding: EdgeInsets.all(16.0),
                      //     child: Row(
                      //       children: [
                      //         // Product Image
                      //         Container(
                      //           width: 80,
                      //           height: 80,
                      //           decoration: BoxDecoration(
                      //             image: DecorationImage(
                      //               image: NetworkImage(product['image']),
                      //               fit: BoxFit.cover,
                      //             ),
                      //             borderRadius: BorderRadius.circular(8),
                      //           ),
                      //         ),
                      //         SizedBox(width: 16),
                      //         Expanded(
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Text(
                      //                 product['name'],
                      //                 style: TextStyle(
                      //                   fontSize: 18,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //               ),
                      //               SizedBox(height: 4),
                      //               Text(
                      //                 'Quantity: ${product['quantity']}',
                      //                 style: TextStyle(color: Colors.grey[600]),
                      //               ),
                      //               SizedBox(height: 8),
                      //               Text(
                      //                 '₹${product['price'].toStringAsFixed(2)}',
                      //                 style: TextStyle(
                      //                   fontSize: 16,
                      //                   color: Colors.green,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 15.h),
                      Text(
                        "Billing Address",
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${data.billing.firstName} ${data.billing.lastName}",
                                    style: GoogleFonts.inter(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // IconButton(
                                  //   icon: Icon(Icons.edit, color: Colors.blue),
                                  //   onPressed: _editAddress,
                                  //   tooltip: 'Address Change Karo',
                                  // ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 10.w,
                                      right: 10.w,
                                      top: 5.h,
                                      bottom: 5.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Colors.lightBlueAccent,
                                    ),
                                    child: Text(
                                      "Change",
                                      style: GoogleFonts.inter(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "${data.billing.address1}, ${data.billing.city}",
                                style: GoogleFonts.inter(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                " ${data.billing.state},  ${data.billing.country}, ${data.billing.postcode}",
                                style: GoogleFonts.inter(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Phone: ${data.billing.phone}',
                                style: GoogleFonts.inter(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Checkbox(
                            value: isCheck,
                            onChanged: (value) {
                              setState(() {
                                isCheck = !isCheck;
                              });
                            },
                          ),
                          Text(
                            'Shipping Address',
                            style: GoogleFonts.inter(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      if (isCheck)
                        Card(
                          elevation: 4,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${data.shipping.firstName} ${data.shipping.lastName}",
                                      style: GoogleFonts.inter(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    // IconButton(
                                    //   icon: Icon(Icons.edit, color: Colors.blue),
                                    //   onPressed: _editAddress,
                                    //   tooltip: 'Address Change Karo',
                                    // ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 10.w,
                                        right: 10.w,
                                        top: 5.h,
                                        bottom: 5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                        color: Colors.lightBlueAccent,
                                      ),
                                      child: Text(
                                        "Change",
                                        style: GoogleFonts.inter(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "${data.shipping.address1}, ${data.shipping.city}",
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  "${data.shipping.state},  ${data.shipping.country}, ${data.shipping.postcode}",
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Phone: ',
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(height: 24.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Yahan order place karne ka logic add karo
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Order Place Ho Gaya!')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            'Place Order',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
        ],
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

// class AddressReview extends ConsumerStatefulWidget {
//   const AddressReview({super.key});
//   @override
//   ConsumerState<AddressReview> createState() => _AddressReviewState();
// }
// class _AddressReviewState extends ConsumerState<AddressReview> {
//   bool isCheck = false;
//   @override
//   Widget build(BuildContext context) {
//     final reviewAddress = ref.watch(userAddressController);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Review'),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: reviewAddress.when(
//         data: (address) {
//           return Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 20.h),
//                 Text(
//                   'Shipping Address',
//                   style: GoogleFonts.inter(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(height: 12.h),
//                 Card(
//                   elevation: 4,
//                   child: Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "${address.shipping.firstName} ${address.shipping.lastName}",
//                               style: GoogleFonts.inter(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             // IconButton(
//                             //   icon: Icon(Icons.edit, color: Colors.blue),
//                             //   onPressed: _editAddress,
//                             //   tooltip: 'Address Change Karo',
//                             // ),
//                             Container(
//                               padding: EdgeInsets.only(
//                                 left: 10.w,
//                                 right: 10.w,
//                                 top: 5.h,
//                                 bottom: 5.h,
//                               ),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10.r),
//                                 color: Colors.lightBlueAccent,
//                               ),
//                               child: Text(
//                                 "Change",
//                                 style: GoogleFonts.inter(
//                                   fontSize: 15.sp,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 8.h),
//                         Text(
//                           "${address.shipping.address1}, ${address.shipping.city}",
//                           style: GoogleFonts.inter(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.blue,
//                           ),
//                         ),
//                         Text(
//                           " ${address.shipping.state},  ${address.shipping.country}, ${address.shipping.postcode}",
//                           style: GoogleFonts.inter(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.blue,
//                           ),
//                         ),
//                         SizedBox(height: 4.h),
//                         Text(
//                           'Phone: ',
//                           style: GoogleFonts.inter(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15.h),
//                 Row(
//                   children: [
//                     Checkbox(
//                       value: isCheck,
//                       onChanged: (value) {
//                         setState(() {
//                           isCheck = !isCheck;
//                         });
//                       },
//                     ),
//                     Text(
//                       "Billing Address",
//                       style: GoogleFonts.inter(
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10.h),
//                 if (isCheck)
//                   Card(
//                     elevation: 4,
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "${address.billing.firstName} ${address.billing.lastName}",
//                                 style: GoogleFonts.inter(
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               // IconButton(
//                               //   icon: Icon(Icons.edit, color: Colors.blue),
//                               //   onPressed: _editAddress,
//                               //   tooltip: 'Address Change Karo',
//                               // ),
//                               Container(
//                                 padding: EdgeInsets.only(
//                                   left: 10.w,
//                                   right: 10.w,
//                                   top: 5.h,
//                                   bottom: 5.h,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10.r),
//                                   color: Colors.lightBlueAccent,
//                                 ),
//                                 child: Text(
//                                   "Change",
//                                   style: GoogleFonts.inter(
//                                     fontSize: 15.sp,
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 8.h),
//                           Text(
//                             "${address.billing.address1}, ${address.billing.city}",
//                             style: GoogleFonts.inter(
//                               fontSize: 15.sp,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.blue,
//                             ),
//                           ),
//                           Text(
//                             " ${address.billing.state},  ${address.billing.country}, ${address.billing.postcode}",
//                             style: GoogleFonts.inter(
//                               fontSize: 15.sp,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.blue,
//                             ),
//                           ),
//                           SizedBox(height: 4.h),
//                           Text(
//                             'Phone: ${address.billing.phone}',
//                             style: GoogleFonts.inter(
//                               fontSize: 15.sp,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.blue,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 SizedBox(height: 24.h),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Yahan order place karne ka logic add karo
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Order Place Ho Gaya!')),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                     ),
//                     child: Text(
//                       'Place Order',
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//         error: (error, stackTrace) {
//           log(stackTrace.toString());
//           return Center(child: Text(error.toString()));
//         },
//         loading: () => Center(child: CircularProgressIndicator()),
//       ),
//     );
//   }
// }
