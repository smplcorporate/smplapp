import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/data/controller/dtdPrepaid.provider.dart';
import 'package:home/screen/dth2.dart';
import 'package:home/screen/home_page.dart';

class Bank {
  final String name;
  final String logo;

  Bank({required this.name, required this.logo});
}

// Riverpod state provider for search
final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

class Dth1 extends ConsumerStatefulWidget {
  const Dth1({Key? key}) : super(key: key);

  @override
  _Dth1State createState() => _Dth1State();
}

class _Dth1State extends ConsumerState<Dth1> {
  @override
  Widget build(BuildContext context) {
    final dthData = ref.watch(dthPrepaidProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return SafeArea(
      child: Scaffold(
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
              padding: const EdgeInsets.only(top: 22),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 23,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Select Provider',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 18,
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
                      hintText: 'Search by Biller',
                      prefixIcon: const Icon(Icons.search, size: 30),
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
                      ref.read(searchQueryProvider.notifier).state = value;
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        body: dthData.when(
          data: (snap) {
            final filteredList = snap.billersList.where((biller) {
              return biller.billerName
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase());
            }).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (filteredList.isEmpty)
                    const Center(child: Text("No result found")),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final bank = filteredList[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              bank.billerName,
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      Dth2(  billerName: '${bank.billerName}', billerCode: '${bank.billerCode}',),
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
              child: Text("$err"),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
