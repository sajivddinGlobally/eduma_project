import 'dart:developer';
import 'package:eduma_app/Screen/home.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/data/Controller/orderCreateController.dart';
import 'package:eduma_app/data/Model/orderCreateModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPage extends ConsumerStatefulWidget {
  const RazorpayPage({super.key});

  @override
  ConsumerState<RazorpayPage> createState() => _RazorpayPageState();
}

class _RazorpayPageState extends ConsumerState<RazorpayPage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _openCheckout(OrderCreateModel order) {
    final options = {
      "order_id": order.orderId,
      "amount": order.amount * 100,
      "currency": "INR",
      "receipt": order.receipt,
      "key": "rzp_test_RIeIwZBZ2NZi6w",
      "wc_order_id": order.wcOrderId,
      "user": {
        "name": order.user.name,
        "email": order.user.email,
        "contact": order.user.contact,
      },
    };
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    log("Payment Success : ${response.paymentId}");
    showSuccessMessage(context, "Payment Successful");
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => HomePage()),
      (route) => false,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log("Payment Failed : ${response.message}");
    showSuccessMessage(context, "Payment Failed : ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log("External Wallet : ${response.walletName}");
  }

  @override
  Widget build(BuildContext context) {
    final createOrderProvider = ref.watch(orderCreateController);

    ref.listen<AsyncValue<OrderCreateModel>>(orderCreateController, (
      previous,
      next,
    ) {
      next.whenOrNull(
        data: (order) {
          _openCheckout(order);
        },
        error: (err, stack) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(err.toString())));
        },
      );
    });

    return Scaffold(
      body: createOrderProvider.when(
        data: (_) => const Center(child: Text("Opening Razorpay...")),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
