import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/data/controller/electirtyBiller.provider.dart';
import 'package:home/data/model/electritysityModel.dart';
import 'package:home/screen/eletercitybill.dart';
import 'package:home/screen/home_page.dart';

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
  List<BillerProvider> allBillers = [
    BillerProvider(
      name: 'Jaipur Vidyut Vitran Nigam (JVVNL)',
      logo: 'assets/jv.png',
    ),
    BillerProvider(
      name: 'Ajmer Vidyut Vitran Nigam (AVVNL)',
      logo: 'assets/av.png',
    ),
    BillerProvider(
      name: 'Jodhpur Vidyut Vitran Nigam (JDVVNL)',
      logo: 'assets/jodhpur.png',
    ),
    BillerProvider(
      name: 'Bikaner Vidyut vitrain Nigam Limited',
      logo: 'assets/bkesl.png',
    ),
    BillerProvider(name: 'UIT Udaipur', logo: 'assets/jv.png'),
  ];

  @override
  Widget build(BuildContext context) {
    final electricityProvider = ref.watch(electricityBillerProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      body: SafeArea(
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
                        'Select Provider',
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

            // Search bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: SizedBox(
                height: width * 0.15,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by Biller',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: width * 0.03,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    ref.read(searchQueryProvider.notifier).state = value;
                  },
                ),
              ),
            ),

            // Section label
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: width * 0.025,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Billers in Rajasthan',
                  style: GoogleFonts.inter(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // List of billers
            Expanded(
              child: electricityProvider.when(
                data: (snapshot) {
                  final filteredList =
                      snapshot.billersList
                          .where(
                            (biller) => biller.billerName
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()),
                          )
                          .toList();

                  return ListView.builder(
                    padding: EdgeInsets.only(bottom: width * 0.05),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final biller = filteredList[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              biller.billerName,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.038,
                              ),
                            ),
                            onTap: () {
                              showCircleBottomSheet(
                                context,
                                snapshot.circleList,
                                (selectedCircle) {
                                  print(
                                    "Selected: ${selectedCircle.circleName}",
                                  );
                                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => Eletercitybill(
                                        circleCode: selectedCircle.circleId,
                                        billerName: '${biller.billerName}',
                                        billerCode: '${biller.billerCode}',
                                      ),
                                ),
                              );
                                  // handle selection
                                },
                              );
                              
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.05,
                            ),
                            child: const Divider(
                              color: Color.fromARGB(255, 221, 221, 221),
                              thickness: 1,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                error: (err, stack) {
                  return const Center(child: Text("Something went wrong"));
                },
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCircleBottomSheet(
    BuildContext context,
    List<CircleList> circles,
    Function(CircleList) onSelect,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 40,
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Text(
                'Select Circle',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: circles.length,
                  separatorBuilder: (_, __) => Divider(),
                  itemBuilder: (context, index) {
                    final circle = circles[index];
                    return ListTile(
                      title: Text(circle.circleName),
                      leading: Icon(
                        Icons.location_on_rounded,
                        color: Colors.blue,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        onSelect(circle);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
      },
    );
  }
}
