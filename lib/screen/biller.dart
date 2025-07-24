import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/data/controller/electirtyBiller.provider.dart';
import 'package:home/data/model/electritysityModel.dart';
import 'package:home/screen/eletercitybill.dart';
import 'package:home/screen/home_page.dart';
import 'package:home/screen/order.details.page.dart';

// Search query provider
final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

class BillerProvider {
  final String name;
  final String logo;

  BillerProvider({required this.name, required this.logo});
}

class Biller extends ConsumerStatefulWidget {
  const Biller({Key? key}) : super(key: key);

  @override
  _BillerState createState() => _BillerState();
}

class _BillerState extends ConsumerState<Biller> {
  final Color buttonColor = const Color.fromARGB(255, 68, 128, 106);
  String billerName = '';
  String billerCode = '';
  String circleCode = '';
  @override
  Widget build(BuildContext context) {
    final electricityProvider = ref.watch(electricityBillerProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final width = MediaQuery.of(context).size.width;
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: width * 0.04,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: Container(
                        height: width * 0.1,
                        width: width * 0.1,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: width * 0.05,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Electricity Bill',
                          style: GoogleFonts.inter(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.1),
                  ],
                ),
              ),

      
              electricityProvider.when(
                data: (snapshot) {
                  final filteredList =
                      snapshot.billersList
                          .where(
                            (biller) => biller.billerName
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()),
                          )
                          .toList();

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (snapshot.circleList != null) ...[
                        SizedBox(height: 30.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.03,
                          ),
                          child: BillerCircleDropDown(
                            billers: snapshot.circleList!,
                            callBack: (value) {
                              circleCode = value.circleId;
                            },
                          ),
                        ),
                      ],

                      SizedBox(height: 5.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                        child: CustomSearchableDropdown(
                          billers: snapshot.billersList,
                          callBack: (value) {
                            billerCode = value.billerCode;
                            billerName = value.billerName;
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        color: Color.fromARGB(255, 232, 243, 235),
                        child: Padding(
                          padding: EdgeInsets.all(16.0 * scale),
                          child: ElevatedButton(
                            onPressed: () {
                              if (snapshot.isCircle == false) {
                                if (billerCode != "" && billerName != "") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => Eletercitybill(
                                            circleCode: circleCode,
                                            billerName: '${billerName}',
                                            billerCode: '${billerCode}',
                                          ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        "Select Provider",
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                if (billerCode != "" &&
                                    billerName != "" &&
                                    circleCode != "") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => Eletercitybill(
                                            circleCode: circleCode,
                                            billerName: '${billerName}',
                                            billerCode: '${billerCode}',
                                          ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        "Select Provider & Circle",
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25 * scale),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 14 * scale,
                              ),
                              minimumSize: Size(double.infinity, 45 * scale),
                            ),
                            child: Text(
                              'Continue',
                              style: GoogleFonts.inter(
                                fontSize: 18 * scale,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      if (snapshot.oldBills.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.05,
                            vertical: width * 0.025,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Recent Bills',
                              style: GoogleFonts.inter(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      if (snapshot.oldBills.isNotEmpty)
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                            bottom: width * 0.05,
                            right: width * 0.02,
                            left: width * 0.02,
                          ),
                          itemCount: snapshot.oldBills.length > 3 ? 2 : 1,
                          itemBuilder: (context, index) {
                            final transaction = snapshot.oldBills[index];
                            return TransactionCard(transaction: transaction);
                          },
                        ),
                    ],
                  );
                },
                error: (err, stack) {
                  return Center(child: Text("$err, $stack"));
                },
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCircleBottomSheet(
    BuildContext context,
    List<CircleList> circles,
    Function(CircleList) onSelect,
    String billername,
  ) {
    final Color buttonColor = const Color.fromRGBO(68, 128, 106, 1);
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375;
    final TextEditingController searchController = TextEditingController();
    String searchQuery = '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (_, controller) {
            return Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 243, 235),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Top drag handle
                        Container(
                          height: 5,
                          width: 50,
                          margin: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        // Title with animation
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 10,
                          ),
                          child: AnimatedOpacity(
                            opacity: 1.0,
                            duration: Duration(milliseconds: 500),
                            child: Text(
                              billername,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 16),

                        // Search Field with modern design
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },

                            decoration: InputDecoration(
                              hintText: "Search circle...",
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              suffixIcon:
                                  searchQuery.isNotEmpty
                                      ? IconButton(
                                        icon: Icon(
                                          Icons.clear,
                                          color: Colors.grey.shade600,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            searchController.clear();
                                            searchQuery = '';
                                          });
                                        },
                                      )
                                      : null,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                            ),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),

                        SizedBox(height: 16),

                        Container(
                          constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.59,
                          ),
                          child:
                              circles.isNotEmpty
                                  ? ListView.separated(
                                    controller: controller,
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    itemCount:
                                        circles
                                            .where(
                                              (circle) => circle.circleName
                                                  .toLowerCase()
                                                  .contains(
                                                    searchQuery.toLowerCase(),
                                                  ),
                                            )
                                            .length,
                                    separatorBuilder:
                                        (_, __) => Divider(
                                          color: Colors.grey.shade200,
                                          height: 1,
                                        ),
                                    itemBuilder: (context, index) {
                                      final filteredCircles =
                                          circles
                                              .where(
                                                (circle) => circle.circleName
                                                    .toLowerCase()
                                                    .contains(
                                                      searchQuery.toLowerCase(),
                                                    ),
                                              )
                                              .toList()
                                            ..sort(
                                              (a, b) => a.circleName
                                                  .toLowerCase()
                                                  .compareTo(
                                                    b.circleName.toLowerCase(),
                                                  ),
                                            );
                                      final circle = filteredCircles[index];

                                      return AnimatedOpacity(
                                        opacity: 1.0,
                                        duration: Duration(
                                          milliseconds: 300 + (index * 100),
                                        ),
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 8,
                                                ),
                                            leading: CircleAvatar(
                                              backgroundColor: Colors.black
                                                  .withOpacity(0.1),
                                              child: Icon(
                                                Icons.location_on_rounded,
                                                color: Colors.black,
                                              ),
                                            ),
                                            title: Text(
                                              circle.circleName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                              onSelect(circle);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                  : Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.search_off,
                                          size: 50,
                                          color: Colors.grey.shade400,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "No matching circles found.",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Close',
                              style: TextStyle(
                                fontSize: 18 * scale,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25 * scale),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 14 * scale,
                              ),
                              minimumSize: Size(double.infinity, 45 * scale),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {

      searchController.dispose();
    });
  }
}

class TransactionCard extends StatelessWidget {
  final OldBill transaction;

  const TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (_) => PaymentDetailsScreen(trnxId: '${transaction.transId}'),
          ),
        );
      },
      child: Card(
        elevation: 0,
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Transaction Logo
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  transaction.transLogo,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          Icon(Icons.error, size: 50, color: Colors.grey),
                ),
              ),
              SizedBox(width: 16),
              // Transaction Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.serviceProvider,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Last Paid: ${transaction.transDate}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),

                    SizedBox(height: 4),
                    Text(
                      '${transaction.serviceAccount}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${transaction.transAmount}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                transaction.transStatus == 'SUCCESS'
                                    ? Colors.green[100]
                                    : Colors.red[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            transaction.transStatus,
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  transaction.transStatus == 'SUCCESS'
                                      ? Colors.green[800]
                                      : Colors.red[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BillerCircleDropDown extends StatefulWidget {
  final Function callBack;
  final List<CircleList> billers;

  const BillerCircleDropDown({
    super.key,
    required this.billers,
    required this.callBack,
  });

  @override
  State<BillerCircleDropDown> createState() => _BillerCircleDropDownState();
}

class _BillerCircleDropDownState extends State<BillerCircleDropDown> {
  late TextEditingController _controller;
  bool isDropdownOpen = false;
  String searchText = '';
  late CircleList selectedCircle;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    selectedCircle = CircleList(circleName: "Select Circle", circleId: "null");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<CircleList> get filteredCircles {
    return widget.billers
        .where(
          (e) => e.circleName.toLowerCase().contains(searchText.toLowerCase()),
        )
        .toList();
  }

  String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength) + '...';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isDropdownOpen = !isDropdownOpen;
            });
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.circle_outlined, color: Colors.black),
                  Expanded(
                    child: Text(
                      truncate(selectedCircle.circleName, 35),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Icon(
                    isDropdownOpen
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isDropdownOpen) ...[
          SizedBox(height: 8),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Circle',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: width * 0.050,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView(
                children:
                    filteredCircles.map((circle) {
                      return ListTile(
                        title: Text(circle.circleName),
                        onTap: () {
                          setState(() {
                            selectedCircle = circle;
                            _controller.text = circle.circleName;
                            isDropdownOpen = false;
                            searchText = '';
                          });
                          widget.callBack(circle); // Send selected to parent
                        },
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class CustomSearchableDropdown extends StatefulWidget {
  final Function callBack;
  final List<BillersList> billers;

  const CustomSearchableDropdown({
    super.key,
    required this.callBack,
    required this.billers,
  });

  @override
  _CustomSearchableDropdownState createState() =>
      _CustomSearchableDropdownState();
}

class _CustomSearchableDropdownState extends State<CustomSearchableDropdown> {
  final List<String> employees = [
    "Patricia Wesley",
    "Edward Williams",
    "Andrea Mccarthy",
    "Ann Olivarria",
    "Bridget Hernandez",
  ];

  BillersList selectedEmployee = BillersList(
    billerName: "Service Provider",
    billerCode: "null",
  );
  String searchText = "";
  bool isDropdownOpen = false;

  List<BillersList> get filteredEmployees {
    return widget.billers
        .where(
          (e) => e.billerName.toLowerCase().contains(searchText.toLowerCase()),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isDropdownOpen = !isDropdownOpen;
            });
          },
          child: Card(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.electric_bolt, color: Colors.black),
                  Text(truncate(selectedEmployee.billerName, 35)),
                  Icon(
                    isDropdownOpen
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Dropdown Panel
        if (isDropdownOpen) ...[
          SizedBox(height: 8),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Service Provider',

                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: width * 0.050,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Card(
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView(
                children:
                    filteredEmployees.map((e) {
                      return ListTile(
                        title: Text(e.billerName),
                        onTap: () {
                          setState(() {
                            selectedEmployee = e;
                            isDropdownOpen = false;
                            searchText = "";
                            widget.callBack(e);
                          });
                        },
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

String truncate(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  }
  return text.substring(0, maxLength) + '...';
}
