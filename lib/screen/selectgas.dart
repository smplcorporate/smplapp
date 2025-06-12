import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/data/controller/gasBiller.provider.dart';
import 'package:home/screen/gasno.dart'; // Ensure this file exists

class GasProviderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SelectGasProviderScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SelectGasProviderScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SelectGasProviderScreen> createState() =>
      _SelectGasProviderScreenState();
}

class _SelectGasProviderScreenState
    extends ConsumerState<SelectGasProviderScreen> {
  final List<Map<String, String>> gasProviders = [
    {'name': 'Bharat Gas', 'icon': 'assets/bhgas.png'},
    {'name': 'Bharat Gas-Commercial', 'icon': 'assets/bhgas.png'},
    {'name': 'Indane Gas(Indian oil)', 'icon': 'assets/indgas.png'},
    {'name': 'HP Gas', 'icon': 'assets/hpgas.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final gasDataProvider = ref.watch(getGasBillerProvider);
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 232, 243, 235),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top section with back button and centered title
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, size: 26),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Select Your Gas Provider',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              // Banner Image
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                child: Image.asset(
                  'assets/bann.png',
                  width: screenWidth * 0.95,
                  height: screenHeight * 0.29,
                  // fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 15),
              // Gas Provider List
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0),
                  child: Container(
                    width: screenWidth,
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: gasDataProvider.when(data: (snap){
                      return ListView.builder(
                      itemCount: gasProviders.length,
                      itemBuilder: (context, index) {
                        final provider = snap.billersList[index];
                        return ListTile(
                          // leading: Image.asset(
                          //   provider['icon']!,
                          //   width: screenWidth * 0.1,
                          //   height: screenWidth * 0.1,
                          // ),
                          title: Text(
                            provider.billerName!,
                            style: GoogleFonts.inter(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => GasNumberScreen(
                                      providerName: provider.billerName!,
                                    ),
                              ),
                            );
                          },
                        );
                      },
                    );
                    }, error: (err, stack){
                      return Center(
                        child: Text("$err"),
                      );
                    }, loading: () => Center(
                      child: CircularProgressIndicator(),
                    )),
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
