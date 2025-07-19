import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/data/controller/billerParam.notier.dart';
import 'package:home/data/controller/orderDetails.provider.dart';
import 'package:home/data/model/billerParam.model.dart';
import 'package:home/data/model/orderDetails.res.dart';
import 'package:home/screen/home_page.dart';
import 'package:intl/intl.dart';

class PaymentDetailsScreen extends ConsumerStatefulWidget {
  final String trnxId;

  const PaymentDetailsScreen({super.key, required this.trnxId});

  @override
  ConsumerState<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends ConsumerState<PaymentDetailsScreen> {
  final Color buttonColor = const Color.fromRGBO(68, 128, 106, 1);
  final Color backgroundColor = const Color.fromARGB(255, 232, 243, 235);

  @override
  Widget build(BuildContext context) {
    final orderDetails = ref.watch(orderDetailsProvider(widget.trnxId));
    final params = ref.watch(paramsProvider);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Payment Details'),
        backgroundColor: buttonColor,
        foregroundColor: Colors.white,
      ),
      body: orderDetails.when(
        data: (snap) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTransactionSummaryCard(snap),
                const SizedBox(height: 20),
                _buildStatusCard(snap),
                const SizedBox(height: 20),
                _buildBillDetailsParamCard(params),
                
                if (snap.isbillDetails) _buildBillDetailsCard(snap),
                if (snap.isbillDetails) const SizedBox(height: 20),
                _buildChargesCommissionRow(snap),
                const SizedBox(height: 20),
                if (snap.iscoupon) _buildCouponCard(snap),
                if (snap.iscoupon) const SizedBox(height: 20),
                _buildBankIdsCard(snap),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (content) => HomePage()), (route) => false);
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (err, stack) => Center(child: Text("Something went wrong: $err, $stack")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildTransactionSummaryCard(OrderDetailsRes snap) {
    final order = snap.orderDetails;
    final formatCurrency = NumberFormat.currency(symbol: '₹', decimalDigits: 0);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: NetworkImage(order.transLogo),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.serviceProvider,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        order.serviceType,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Transaction ID:', style: TextStyle(color: Colors.grey)),
                Text(order.transId, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Date & Time:', style: TextStyle(color: Colors.grey)),
                Text(order.transDate, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Amount:', style: TextStyle(color: Colors.grey)),
                Text(
                  formatCurrency.format(order.transAmount),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(OrderDetailsRes snap) {
    final order = snap.orderDetails;
    Color statusColor = Colors.grey;
    
    if (order.transStatus.toLowerCase() == 'success') {
      statusColor = Colors.green;
    } else if (order.transStatus.toLowerCase() == 'failed') {
      statusColor = Colors.red;
    } else if (order.transStatus.toLowerCase() == 'pending') {
      statusColor = Colors.orange;
    }
    
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Status',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order.transStatus.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (order.refundDate.isNotEmpty) ...[
                  const SizedBox(width: 10),
                  const Icon(Icons.history, size: 16, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(
                    'Refunded on ${order.refundDate}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ],
            ),
            if (order.transRemark.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                'Remarks: ${order.transRemark}',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ],
        ),
      ),
    );
  }
  Widget _buildBillDetailsParamCard(ParamsState snap) {


    final params = ref.watch(paramsProvider);
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bill Information',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if(params.param1.isNotEmpty) 
              _buildDetailRow(params.param1, ""),
            if(params.param2.isNotEmpty)
              _buildDetailRow(params.param2, ""),
            if(params.param3.isNotEmpty)     
              _buildDetailRow(params.param3, ""),
            if(params.param4.isNotEmpty)  
              _buildDetailRow(params.param4, ""),
            if(params.param5.isNotEmpty)
              _buildDetailRow(params.param5, ""),
           
          ],
        ),
      ),
    );
  }

  Widget _buildBillDetailsCard(OrderDetailsRes snap) {
    final bill = snap.billDetails;
    
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bill Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildDetailRow('Customer Name', bill.customerName),
            if(bill.customerMobile.isNotEmpty)
            _buildDetailRow('Mobile', bill.customerMobile),
            if (bill.billNo != null && bill.billNo.isNotEmpty) _buildDetailRow('Bill No', bill.billNo.toString()),
            _buildDetailRow('Bill Date', bill.billDate),
            _buildDetailRow(
              'Due Date',
              bill.billDuedate,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChargesCommissionRow(OrderDetailsRes snap) {
    return Row(
      children: [
        if (snap.ischarges) Expanded(child: _buildChargesCard(snap)),
        if (snap.ischarges && snap.iscommission) const SizedBox(width: 10),
        if (snap.iscommission) Expanded(child: _buildCommissionCard(snap)),
      ],
    );
  }

  Widget _buildChargesCard(OrderDetailsRes snap) {
    final charges = snap.chargesDetails;
    final formatCurrency = NumberFormat.currency(symbol: '₹', decimalDigits: 0);
    
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Charges',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              formatCurrency.format(charges.chargesAmount),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              charges.chargesType,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommissionCard(OrderDetailsRes snap) {
    final commission = snap.commissionDetails;
    final formatCurrency = NumberFormat.currency(symbol: '₹', decimalDigits: 0);
    
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Commission',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              formatCurrency.format(commission.commissionAmount),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              commission.commissionType,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponCard(OrderDetailsRes snap) {
    final coupon = snap.couponDetails;
    final formatCurrency = NumberFormat.currency(symbol: '₹', decimalDigits: 0);
    
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.local_offer_outlined, color: Colors.orange),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Coupon Applied',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  coupon.couponCode,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              '-${formatCurrency.format(coupon.couponAmount)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankIdsCard(OrderDetailsRes snap) {
    final bankIds = snap.bankTransIds;
    
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Transaction References',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildDetailRow('Order ID', bankIds.orderId),
            _buildDetailRow('Operator ID', bankIds.operatorId),
            if(bankIds.referenceId.isNotEmpty)
            _buildDetailRow('Reference ID', bankIds.referenceId),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
