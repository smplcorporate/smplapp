import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/data/controller/mobilePrepaid.notifier.dart';
import 'package:home/data/controller/mobilePrepaid.provider.dart';

import 'package:home/screen/home_page.dart';
import 'package:home/screen/rechargebill2.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data/model/mobilePrepaid.res.dart';

class RechargeBillPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<RechargeBillPage> createState() => _RechargeBillPageState();
}

class _RechargeBillPageState extends ConsumerState<RechargeBillPage> {
  List<Contact> contacts = [];
  bool isLoading = false;

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
          withProperties: true, // Only this is needed to get phone numbers
          withPhoto: false,
        );

        setState(() {
          contacts = result;
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
                              child: TextField(
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Search by Biller',
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
                  const SizedBox(height: 20),

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
                          Row(
                            children: [
                              Image.asset("assets/airtel.png", height: 30),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Airtel",
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "9875867346",
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: Color(0xFFB3B3B3),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Contact List
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
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final contact = contacts[index];
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
                         
                                billerNotifier.setNumber(phone);
                                showBillerBottomSheet(
                                  context,
                                  snap.billersList,
                                  snap.circleList,
                                  ref,
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

            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with close button
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
                    const SizedBox(height: 24),
                    Text(
                      "Circle",
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

                  // Green Confirm Button
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          selectedBiller != null && selectedCircle != null
                              ? () {
                                      Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RechargePlansPage(),
                                  ),
                                );
                                // Add further action here
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(
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
