import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/controller/billerParam.notier.dart';
import 'package:home/data/controller/fetchBills.provider.dart';
import 'package:home/data/model/checkCopoun.model.dart';
import 'package:home/data/model/fetchBill.model.dart';
import 'package:home/data/model/paynow.model.dart';
import 'package:home/screen/elebillsummary.dart';
import 'package:home/screen/fastag1.dart';
import 'package:home/screen/order.details.page.dart';
import 'package:intl/intl.dart';

class FastagSummary extends ConsumerStatefulWidget {
  final FetchBodymodel body;

  FastagSummary({required this.body});

  @override
  ConsumerState<FastagSummary> createState() => _FastagSummaryState();
}

class _FastagSummaryState extends ConsumerState<FastagSummary> {
  final Color buttonColor = const Color.fromARGB(255, 68, 128, 106);
  late final FetchBodymodel fetchRequest;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _mpinControllr = TextEditingController();
  bool btnLoder = false;
  @override
  void initState() {
    super.initState();
    fetchRequest = widget.body;
  }

  bool applyBtnLoder = false;
  bool isInvalid = false;

  bool coupnApplyed = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375;
    final fetchBillerData = ref.watch(fetchBillDataProvider(fetchRequest));
    final params = ref.watch(paramsProvider);
    final String formattedDate = DateFormat(
      'dd-MM-yyyy',
    ).format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 232, 243, 235),
        title: Text(
          '${widget.body.data.billerName}',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: fetchBillerData.when(
        data: (snap) {
          return Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 232, 243, 235),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  

                  // Billing Card
                  Padding(
                    padding: EdgeInsets.all(16.0 * scale),
                    child: Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12 * scale),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0 * scale),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Image.asset(
                                //   'assets/icici.png',
                                //   height: 40 * scale,
                                // ),
                                SizedBox(width: 10 * scale),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.body.data.billerName}',
                                      style: GoogleFonts.inter(
                                        fontSize: 14 * scale,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.body.data.param1,
                                      style: GoogleFonts.inter(
                                        fontSize: 13 * scale,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (params.param2.isNotEmpty)
                                    _buildDetailRow(params.param2, ""),
                                  if (params.param3.isNotEmpty)
                                    _buildDetailRow(params.param3, ""),
                                  if (params.param4.isNotEmpty)
                                    _buildDetailRow(params.param4, ""),
                                  if (params.param5.isNotEmpty)
                                    _buildDetailRow(params.param5, ""),
                                ],
                              ),
                            ),
                            SizedBox(height: 20 * scale),
                            Text(
                              'Billing Details',
                              style: GoogleFonts.inter(
                                fontSize: 15 * scale,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10 * scale),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _infoColumn([
                                  if (snap.customerName != null ||
                                      snap.customerName!.isNotEmpty)
                                    "Customer Name",
                                  if (snap.billNo.isNotEmpty) "Bill Number",
                                  if (snap.billDate.isNotEmpty) "Bill Date",
                                  if (snap.billDate.isNotEmpty) "Bill Due Date",
                                ], scale),
                                _infoColumn(
                                  [
                                    if (snap.customerName != null ||
                                        snap.customerName!.isNotEmpty)
                                      snap.customerName ?? "No name",
                                    if (snap.billNo.isNotEmpty)
                                      snap.billNo.toString(),
                                    if (snap.billDate.isNotEmpty) snap.billDate,
                                    if (snap.billDate.isNotEmpty)
                                      DateFormat('yyyy-MM-dd ').format(
                                        DateTime.parse(snap.dueDate.toString()),
                                      ),
                                  ],
                                  scale,
                                  alignRight: true,
                                ),
                              ],
                            ),
                            SizedBox(height: 20 * scale),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                vertical: 12 * scale,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 232, 243, 235),
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10 * scale),
                              ),
                              child: Center(
                                child: TextField(
                                  controller: TextEditingController(
                                    text: '₹${snap.billAmount ?? "0"}',
                                  ),
                                  readOnly: true,
                                  showCursor: false,
                                  decoration: const InputDecoration.collapsed(
                                    hintText: '',
                                  ),
                                  style: TextStyle(
                                    fontSize: 22 * scale,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 18.w, right: 18.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            readOnly: coupnApplyed,
                            controller: _controller,
                            maxLength: 15, // Max length 15 characters
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                15,
                              ), // Enforce length limit
                              UpperCaseTextFormatter(), // Custom formatter for uppercase
                            ],
                            decoration: InputDecoration(
                              hintText: 'Gift card or discount code',
                              counterText: '', // Hide character counter
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                  color: isInvalid ? Colors.red : Colors.grey,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                  color: isInvalid ? Colors.red : Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                  color: isInvalid ? Colors.red : Colors.black,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () async {
                            if (coupnApplyed == false) {
                              setState(() {
                                applyBtnLoder = true;
                              });
                              final state = APIStateNetwork(await createDio());
                              final response = await state.checkCoupn(
                                CheckCouponModel(
                                  ipAddress: "152.59.109.59",
                                  macAddress: "not found",
                                  latitude: "26.917979",
                                  longitude: "75.814593",
                                  billerCode: fetchRequest.data.billerCode,
                                  billerName: fetchRequest.data.billerName,
                                  param1: fetchRequest.data.param1,
                                  transAmount:
                                      double.parse(
                                        snap.billAmount ?? "0.00",
                                      ).toInt().toString(),
                                  couponCode: _controller.text.trim(),
                                ),
                              );
                              if (response.response.data['status'] == true) {
                                setState(() {
                                  applyBtnLoder = false;
                                  coupnApplyed = true;
                                });

                                Fluttertoast.showToast(
                                  msg: response.response.data['status_desc'],
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                );
                              } else {
                                setState(() {
                                  applyBtnLoder = false;
                                });
                                Fluttertoast.showToast(
                                  msg: response.response.data['status_desc'],
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                );
                              }
                            } else {
                              setState(() {
                                coupnApplyed = false;
                                _controller.clear();
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child:
                              applyBtnLoder == true
                                  ? CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  )
                                  : Text(
                                    coupnApplyed == false ? 'Apply' : 'Remove',
                                    style: TextStyle(color: Colors.white),
                                  ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.only(left: 18.w, right: 18.w),
                    child: TextField(
                      controller: _mpinControllr,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                          6,
                        ), // Enforce length limit
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter your mpin',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: isInvalid ? Colors.red : Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: isInvalid ? Colors.red : Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: isInvalid ? Colors.red : Colors.black,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0 * scale),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_mpinControllr.text.isEmpty ||
                            _mpinControllr.text == "") {
                          Fluttertoast.showToast(
                            msg: "Mpin is required",
                            textColor: Colors.white,
                            backgroundColor: Colors.red,
                          );
                        } else {
                          setState(() {
                            btnLoder = true;
                          });
                          final box = Hive.box('userdata');
                          final mobile = box.get('@mobile');
                          final service = APIStateNetwork(await createDio());
                          final reponse = await service.payNow(
                            'b2c_bills_fastag',
                            PayNowModel(
                              ipAddress: "152.59.109.59",
                              macAddress: "not found",
                              latitude: "26.917979",
                              longitude: "75.814593",
                              billerCode: fetchRequest.data.billerCode,
                              billerName: fetchRequest.data.billerName,
                              circleCode: fetchRequest.data.circleCode,
                              param1: fetchRequest.data.param1,
                              param2: fetchRequest.data.param2,
                              param3: fetchRequest.data.param3,
                              param4: fetchRequest.data.param4,
                              param5: fetchRequest.data.param5,
                              customerName: snap.customerName ?? "",
                              billNo: snap.billNo,
                              dueDate: snap.dueDate,
                              billDate: snap.billDate,
                              billAmount: snap.billAmount.toString(),
                              returnTransid: snap.returnTransid.toString(),
                              returnFetchid: snap.returnFetchid,
                              returnBillid: snap.returnBillid,
                              couponCode: "${_controller.text.trim()}",
                              userMpin: "${_mpinControllr.text}",
                            ),
                          );
                          if (reponse.response.data["status"] == false) {
                            setState(() {
                              btnLoder = false;
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    '',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Text(
                                    '${reponse.response.data["status_desc"]}',
                                    style: GoogleFonts.inter(),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'OK',
                                        style: GoogleFonts.inter(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            setState(() {
                              btnLoder = false;
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    '${reponse.response.data['trans_status']}',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Text(
                                    '${reponse.response.data["status_desc"]}',
                                    style: GoogleFonts.inter(),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) => PaymentDetailsScreen(
                                                  trnxId:
                                                      '${reponse.response.data['trans_id']}',
                                                ),
                                          ),
                                          (route) => false,
                                        );
                                      },
                                      child: Text(
                                        'OK',
                                        style: GoogleFonts.inter(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25 * scale),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14 * scale),
                        minimumSize: Size(double.infinity, 45 * scale),
                      ),
                      child:
                          btnLoder == false
                              ? Text(
                                'Proceed to pay',
                                style: GoogleFonts.inter(
                                  fontSize: 18 * scale,
                                  color: Colors.white,
                                ),
                              )
                              : Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        error: (err, stack) {
          return Center(child: Text("$err"));
        },
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _infoColumn(
    List<String> items,
    double scale, {
    bool alignRight = false,
  }) {
    return Column(
      crossAxisAlignment:
          alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children:
          items
              .map(
                (item) => Padding(
                  padding: EdgeInsets.only(bottom: 6 * scale),
                  child: Text(
                    item,
                    style: GoogleFonts.inter(
                      fontSize: 11 * scale,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }
}

_buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(top: 1.5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(label, style: TextStyle(color: Colors.grey[900])),
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
