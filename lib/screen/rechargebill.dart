import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/data/controller/fetchBills.provider.dart';
import 'package:home/data/controller/mobilePrepaid.notifier.dart';
import 'package:home/data/controller/mobilePrepaid.provider.dart';
import 'package:home/data/model/electritysityModel.dart' hide BillersList, CircleList;
import 'package:home/data/model/fetchBill.model.dart';
import 'package:home/screen/home_page.dart';
import 'package:home/screen/mobilepreapid/mobilepreapid3.page.dart';
import 'package:home/screen/rechargebill2.dart';
import 'package:home/screen/summerysPages/fastagBiller.page.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data/model/mobilePrepaid.res.dart';

class RechargeBillPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<RechargeBillPage> createState() => _RechargeBillPageState();
}

class _RechargeBillPageState extends ConsumerState<RechargeBillPage> {
  List<Contact> contacts = [];
  List<Contact> filteredContacts = []; // NEW
  bool isLoading = false;
  TextEditingController searchController = TextEditingController(); // NEW

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    final status = await Permission.contacts.status;
    if (status.isGranted) {
      setState(() => isLoading = true);
      try {
        final result = await FlutterContacts.getContacts(
          withProperties: true,
          withPhoto: false,
        );

        setState(() {
          contacts = result;
          filteredContacts = result; // init filtered list
          isLoading = false;
        });
      } catch (e) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to load contacts: $e')));
      }
    } else if (status.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text('Permission Required'),
              content: Text('Please enable contacts permission from settings.'),
              actions: [
                TextButton(
                  onPressed: () => openAppSettings(),
                  child: Text('Open Settings'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
              ],
            ),
      );
    } else {
      final result = await Permission.contacts.request();
      if (result.isGranted) {
        fetchContacts();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Contacts permission denied')));
      }
    }
  }

  // NEW: Search filter
  void filterContacts(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredContacts = contacts;
      });
      return;
    }
    final lowerQuery = query.toLowerCase();
    setState(() {
      filteredContacts =
          contacts.where((contact) {
            final name = contact.displayName.toLowerCase();
            final phoneMatches = contact.phones.any(
              (p) => p.number.toLowerCase().contains(lowerQuery),
            );
            return name.contains(lowerQuery) || phoneMatches;
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(mobilePrepaidProvider);
    final billerNotifier = ref.read(billerProvider.notifier);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 232, 243, 235),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Recharge Bill',
          style: GoogleFonts.inter(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () {
              if (Navigator.of(context).canPop()) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()),
                );
              }
            },
            child: Container(
              height: 55,
              width: 55,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ),
      body: data.when(
        data: (snap) {
          return isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Box
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      margin: const EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: SizedBox(
                              height: 45,
                              child: TextFormField(
                                controller: searchController,
                                onChanged: filterContacts,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Search by name or number',
                                  hintStyle: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: Color(0xFF9E9E9E),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  // Recent Bill Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Recent Bill",
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            itemCount:
                                snap.oldRecharges.length > 3
                                    ? 3
                                    : snap.oldRecharges.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final transaction = snap.oldRecharges[index];
                              return TransactionCard(
                                transaction: OldBill(
                                  transId: transaction.transId,
                                  transLogo: transaction.transLogo,
                                  transDate: transaction.transDate,
                                  transAmount: transaction.transAmount,
                                  serviceProvider: transaction.serviceProvider,
                                  serviceAccount: transaction.serviceAccount,
                                  transStatus: transaction.transStatus,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Contact List (filtered)
                  if (filteredContacts.isEmpty) ...[
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            margin: const EdgeInsets.only(top: 12),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.dialer_sip,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: SizedBox(
                                      height: 45,
                                      child: TextFormField(
                                        maxLength: 10,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          hintText:
                                              'Enter Mobile Number manually',
                                          hintStyle: GoogleFonts.inter(
                                            fontSize: 16,
                                            color: const Color(0xFF9E9E9E),
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                        ),

                                        // ✅ Auto validate enable
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,

                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please enter mobile number";
                                          } else if (!RegExp(
                                            r'^[6-9]\d{9}$',
                                          ).hasMatch(value)) {
                                            return "Enter valid 10-digit Indian mobile number";
                                          }
                                          return null;
                                        },

                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (value) {
                                          if (RegExp(
                                            r'^[6-9]\d{9}$',
                                          ).hasMatch(value)) {
                                            billerNotifier.setNumber(value);
                                            showBillerBottomSheet(
                                              context,
                                              snap.billersList,
                                              snap.circleList ?? [],
                                              ref,
                                              snap.isPlanfetch,
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Please enter valid 10-digit Indian mobile number",
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12,
                        ),
                        itemCount: filteredContacts.length,
                        itemBuilder: (context, index) {
                          final contact = filteredContacts[index];
                          log(contact.phones.toString());
                          final phone =
                              contact.phones.isNotEmpty
                                  ? contact.phones.first.number
                                  : 'No number';
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 3,
                            ),
                            leading: const CircleAvatar(
                              radius: 30,
                              backgroundColor: Color.fromARGB(
                                255,
                                68,
                                128,
                                106,
                              ),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            title: Text(
                              contact.displayName,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              phone,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Color(0xFFB3B3B3),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              if (phone != 'No number') {
                                billerNotifier.setNumber(
                                  stripCountryCode(phone),
                                );
                                showBillerBottomSheet(
                                  context,
                                  snap.billersList,
                                  snap.circleList ?? [],
                                  ref,
                                  snap.isPlanfetch,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
        },
        error: (err, stack) {
          return Center(child: Text("$err"));
        },
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void showBillerBottomSheet(
    BuildContext context,
    List<BillersList> billers,
    List<CircleList> circles,
    WidgetRef ref,
    bool planFetch,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            final selectedBiller = ref.watch(
              billerProvider.select((state) => state.selectedBiller),
            );
            final selectedCircle = ref.watch(
              billerProvider.select((state) => state.selectedCircle),
            );
            final biller = ref.watch(billerProvider);

            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Biller & Circle",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Biller Dropdown
                  Text(
                    "Service Provider",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<BillersList>(
                        value: selectedBiller,
                        hint: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "-- Select Service Provider --",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down, size: 30),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        items:
                            billers.isEmpty
                                ? [
                                  const DropdownMenuItem<BillersList>(
                                    enabled: false,
                                    child: Text("No billers available"),
                                  ),
                                ]
                                : billers.map((biller) {
                                  return DropdownMenuItem<BillersList>(
                                    value: biller,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      child: Text(
                                        biller.billerName,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyLarge,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  );
                                }).toList(),
                        onChanged: (biller) {
                          if (biller != null) {
                            ref.read(billerProvider.notifier).setBiller(biller);
                          }
                        },
                      ),
                    ),
                  ),

                  // Circle Dropdown
                  if (selectedBiller != null) ...[
                    if (circles.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Text(
                        "Circle",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<CircleList>(
                            value: selectedCircle,
                            hint: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "-- Select Circle --",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down, size: 30),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            items:
                                circles.isEmpty
                                    ? [
                                      const DropdownMenuItem<CircleList>(
                                        enabled: false,
                                        child: Text("No circles available"),
                                      ),
                                    ]
                                    : circles.map((circle) {
                                      return DropdownMenuItem<CircleList>(
                                        value: circle,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          child: Text(
                                            circle.circleName,
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.bodyLarge,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                            onChanged: (circle) {
                              if (circle != null) {
                                ref
                                    .read(billerProvider.notifier)
                                    .setCircle(circle);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ],

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (circles.isNotEmpty) {
                          if (selectedCircle == null) {
                            Fluttertoast.showToast(
                              msg: "Please select Circl first",
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              gravity: ToastGravity.TOP,
                            );
                          } else {
                            if (selectedBiller == null) {
                              Fluttertoast.showToast(
                                msg: "Please select Biller!",
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                gravity: ToastGravity.TOP,
                              );
                            } else {
                              if (planFetch == true) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => RechargePlansPage(
                                          billerName: selectedBiller.billerName,
                                          billerCode: selectedBiller.billerCode,
                                          circleCode:
                                              selectedCircle?.circleId ?? "",
                                        ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder:
                                        (context) => MobilePrepaid3(
                                          body: FetchBodymodel(
                                            path: "",
                                            data: FetchBillModel(
                                              ipAddress: "127.0.0.1",
                                              macAddress: "not found",
                                              latitude: "26.917979",
                                              longitude: "75.814593",
                                              billerCode:
                                                  selectedBiller.billerCode,
                                              billerName:
                                                  selectedBiller.billerName,
                                              circleCode:
                                                  selectedCircle?.circleId ??
                                                  "",
                                              param1: biller.number ?? "",
                                              param2: "",
                                              param3: "",
                                              param4: "",
                                              param5: "",
                                            ),
                                          ),
                                        ),
                                  ),
                                );
                              }
                            }
                          }
                        } else {
                          if (selectedBiller == null) {
                            Fluttertoast.showToast(
                              msg: "Please select Biller!",
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              gravity: ToastGravity.TOP,
                            );
                          } else {
                            if (planFetch == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => RechargePlansPage(
                                        billerName: selectedBiller.billerName,
                                        billerCode: selectedBiller.billerCode,
                                        circleCode:
                                            selectedCircle?.circleId ?? "",
                                      ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder:
                                      (context) => MobilePrepaid3(
                                        body: FetchBodymodel(
                                          path: "",
                                          data: FetchBillModel(
                                            ipAddress: "127.0.0.1",
                                            macAddress: "not found",
                                            latitude: "26.917979",
                                            longitude: "75.814593",
                                            billerCode:
                                                selectedBiller.billerCode,
                                            billerName:
                                                selectedBiller.billerName,
                                            circleCode:
                                                selectedCircle?.circleId ?? "",
                                            param1: biller.number ?? "",
                                            param2: "",
                                            param3: "",
                                            param4: "",
                                            param5: "",
                                          ),
                                        ),
                                      ),
                                ),
                              );
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          68,
                          128,
                          106,
                        ),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

String removeDotZero(String value) {
  if (value.endsWith('.0')) {
    return value.replaceAll('.0', '');
  }
  return value;
}

String stripCountryCode(String number) {
  // remove all non-digits
  String digits = number.replaceAll(RegExp(r'\D'), '');

  // agar 10 ya usse zyada digits hai to last 10 return karo (local number)
  if (digits.length >= 10) {
    return digits.substring(digits.length - 10);
  }
  return digits;
}
