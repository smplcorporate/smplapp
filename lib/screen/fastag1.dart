import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/data/controller/fastTag.provider.dart';
import 'package:home/screen/fastag2.dart';
import 'package:home/screen/home_page.dart';

class FastagScreen extends ConsumerStatefulWidget {
  const FastagScreen({Key? key}) : super(key: key);

  @override
  _FastagScreenState createState() => _FastagScreenState();
}

class _FastagScreenState extends ConsumerState<FastagScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final fastTagData = ref.watch(fastTagProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 232, 243, 235),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'FASTag Recharge',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: SizedBox(
                height: 70,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by FASTag Provider',
                    prefixIcon: const Icon(Icons.search, size: 28),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: fastTagData.when(
        data: (snap) {
          final filteredProviders = snap.billersList
              .where((provider) => provider.billerName
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
              .toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Text(
                    'All Provider',
                    style: GoogleFonts.inter(
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (filteredProviders.isEmpty)
                  Center(
                    child: Text(
                      'No FASTag providers found.',
                      style: GoogleFonts.inter(
                        fontSize: width * 0.03,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredProviders.length,
                  itemBuilder: (context, index) {
                    final provider = filteredProviders[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            provider.billerName,
                            style: GoogleFonts.inter(
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VehicleRegistrationScreen(billerName: provider.billerName, billerCode: provider.billerCode,),
                              ),
                            );
                          },
                        ),
                        const Divider(
                          color: Color.fromARGB(255, 221, 221, 221),
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
        error: (err, stack) {
          return Center(
            child: Text("Error: $err"),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
