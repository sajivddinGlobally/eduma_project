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
