import 'package:eduma_app/data/Model/orderListModel.dart' hide Image;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackingPage extends StatefulWidget {
  final OrderListModel order; // अब OrderListModel पास कर (मॉडल क्लास)

  const TrackingPage({Key? key, required this.order}) : super(key: key);

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  // सपोर्ट कॉल के लिए हेल्पर फंक्शन (अगर URL लॉन्च न हो तो)
  Future<void> _launchPhoneCall(BuildContext context, String phone) async {
    final Uri url = Uri.parse('tel:$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // अगर न हो पाए तो स्नैकबार दिखा
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('फोन कॉल नहीं हो पा रहा। मैन्युअली डायल करें।')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final lineItems = widget.order.lineItems; // मॉडल से एक्सेस
    final billing = widget.order.billing; // मॉडल से
    final status = widget.order.status ?? 'Unknown';
    final dateCreated =
        widget.order.dateCreated?.toString().substring(0, 10) ?? '';
    final datePaid =
        widget.order.datePaid?.toString().substring(0, 10) ??
        ''; // date_paid -> datePaid (अगर मॉडल में है, वरना order.dateCreated यूज कर)
    final total = widget.order.total ?? '0';
    final paymentMethod =
        widget.order.paymentMethodTitle ??
        widget.order.paymentMethod ??
        'Unknown'; // payment_method_title
    final transactionId = widget.order.transactionId ?? ''; // transaction_id
    final phone = billing.phone ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Track Order",
          style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color(0xFF001E6C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ऑर्डर समरी
            Card(
              margin: EdgeInsets.only(bottom: 16.h),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order ID: #${widget.order.id}",
                          style: GoogleFonts.roboto(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: status == 'processing'
                                ? Colors.orange
                                : (status == 'completed'
                                      ? Colors.green
                                      : Colors.grey),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            status.toUpperCase(),
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Order Date: $dateCreated",
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      "Payment Date: $datePaid",
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total: ₹$total",
                          style: GoogleFonts.roboto(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF001E6C),
                          ),
                        ),
                        Text(
                          "Payment: $paymentMethod",
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // प्रोडक्ट्स लिस्ट
            Text(
              "Items:",
              style: GoogleFonts.roboto(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            ...lineItems.map((item) {
              final itemTotal = item.total ?? '0'; // मॉडल से
              final quantity = item.quantity ?? 1;
              final imageUrl = item.image?.src ?? ''; // image.src
              return Card(
                margin: EdgeInsets.only(bottom: 12.h),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          imageUrl,
                          width: 60.w,
                          height: 60.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: 60.w,
                                height: 60.h,
                                color: Colors.grey[300],
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 30,
                                ),
                              ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                            ), // item.name
                            Text(
                              "Quantity: $quantity",
                              style: GoogleFonts.roboto(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "₹$itemTotal",
                              style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF001E6C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(), // .toList() ऐड किया map के लिए

            SizedBox(height: 16.h),

            // पेमेंट डिटेल्स
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Details",
                      style: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Transaction ID: $transactionId",
                      style: GoogleFonts.roboto(fontSize: 14.sp),
                    ),
                    Text(
                      "Method: $paymentMethod",
                      style: GoogleFonts.roboto(fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // एड्रेस
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Address",
                      style: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "${billing.firstName} ${billing.lastName}",
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ), // billing.firstName
                    Text(
                      "${billing.address1}, ${billing.city}, ${billing.postcode}",
                      style: GoogleFonts.roboto(fontSize: 14.sp),
                    ), // address_1 -> address1
                    Text(
                      "Phone: $phone",
                      style: GoogleFonts.roboto(fontSize: 14.sp),
                    ),
                    Text(
                      "Email: ${billing.email}",
                      style: GoogleFonts.roboto(fontSize: 14.sp),
                    ), // email
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // ट्रैकिंग स्टेटस
            Card(
              color: status == 'processing'
                  ? Colors.orange[50]
                  : (status == 'completed'
                        ? Colors.green[50]
                        : Colors.grey[50]),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    Icon(
                      status == 'processing'
                          ? Icons.hourglass_empty
                          : (status == 'completed'
                                ? Icons.check_circle
                                : Icons.help_outline),
                      color: status == 'processing'
                          ? Colors.orange
                          : (status == 'completed'
                                ? Colors.green
                                : Colors.grey),
                      size: 24,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      status == 'processing'
                          ? "Your order is being processed. We'll update you soon."
                          : (status == 'completed'
                                ? "Order has been delivered!"
                                : "Status: $status"),
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        color: status == 'processing'
                            ? Colors.orange[800]
                            : (status == 'completed'
                                  ? Colors.green[800]
                                  : Colors.grey[800]),
                      ),
                    ),
                    Text(
                      "Tracking Number: Not available (Shipping pending)",
                      style: GoogleFonts.roboto(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // एक्शन बटन्स
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () =>
                      _launchPhoneCall(context, phone), // context पास किया
                  icon: Icon(Icons.support_agent),
                  label: Text("Support"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // PDF डाउनलोड – तेरे पिछले कोड से, अगर फंक्शन है तो कॉल कर
                    // generateInvoice(order);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Invoice downloading...')),
                    );
                  },
                  icon: Icon(Icons.download),
                  label: Text("Download Invoice"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
