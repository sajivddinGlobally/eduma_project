import 'dart:developer';
import 'package:eduma_app/Screen/login.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/navigatorKey.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/registerBodyCustomeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

mixin RegisterApi<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();

  bool isCheck = false;
  bool isLoading = false;
  bool isShow = true;
  bool isObsecure = true;

  void toggleCheckbox() {
    setState(() {
      isCheck = !isCheck;
    });
  }

  String? selectedRole;
  final List<String> roles = ["Student", "Instructor"];

  Future<void> registerCall() async {
    if (formKey.currentState!.validate()) {
      if (passwordController.text.trim() != confirmPassController.text.trim()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Password do not match"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      if (!isCheck) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please accept the terms and conditions"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final body = RegisterBodyModel(
        username: userNameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmPassController.text,
      );

      setState(() {
        isLoading = true;
      });
      try {
        final service = APIStateNetwork(createDio());
        final response = await service.customeRegister(body);
        if (response.success == true) {
          Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => LoginPage()),
            (route) => false,
          );
          showSuccessMessage(context, response.message);

          setState(() {
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("data")));
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        //showErrorMessage(e.toString());
        log(e.toString());
      }
    }
  }
}


class ShimmerHomePage extends StatelessWidget {
  const ShimmerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Banner shimmer
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(height: 20),

              // Categories shimmer
              Row(
                children: List.generate(
                  3,
                  (index) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Courses shimmer
              Column(
                children: List.generate(
                  4,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
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