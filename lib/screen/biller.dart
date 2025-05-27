import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/data/controller/electirtyBiller.provider.dart';
import 'package:home/data/model/electritysityModel.dart';
import 'package:home/screen/eletercitybill.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class BillerProvider {
  final String name;
  final String logo;

  BillerProvider({required this.name, required this.logo});
}

class Biller extends ConsumerStatefulWidget {
  const Biller({Key? key}) : super(key: key);

  @override
  ConsumerState<Biller> createState() => _BillerState();
}

class _BillerState extends ConsumerState<Biller> {
  String? _publicIp;
  String? _macAddress;
  Future<void> _getMacAddress() async {
    try {
      // Request permissions (for Android location permission)
      if (await Permission.locationWhenInUse.request().isGranted) {
        final info = NetworkInfo();
        final wifiBSSID =
            await info
                .getWifiBSSID(); // MAC address of the connected Wi-Fi access point

        setState(() {
          _macAddress = wifiBSSID ?? 'MAC Address not available';
        });
      } else {
        setState(() {
          _macAddress = 'Location permission denied';
        });
      }
    } catch (e) {
      setState(() {
        _macAddress = 'not found';
      });
    }
  }

  Future<void> _getPublicIpAddress() async {
    try {
      final response = await http.get(Uri.parse('https://api.ipify.org'));
      if (response.statusCode == 200) {
        setState(() {
          _publicIp =
              response.body; // The response body contains the IP address
        });
      } else {
        setState(() {
          _publicIp = 'Failed to fetch IP';
        });
      }
    } catch (e) {
      setState(() {
        _publicIp = 'notfound';
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getPublicIpAddress();
  }

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final billerProvider = ref.watch(electricityBillerProvider);

    return billerProvider.when(
      data: (snapshot) {
        List<BillersList> filteredBillers =
            snapshot.billersList
                .where(
                  (biller) => biller.billerName.toLowerCase().contains(
                    searchQuery.toLowerCase(),
                  ),
                )
                .toList();
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(200),
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
                padding: const EdgeInsets.only(top: 18),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                            size: 21,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Select Provider',
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 20,
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
                        prefixIcon: const Icon(Icons.search),
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
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    'Billers in Rajasthan',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredBillers.length,
                  itemBuilder: (context, index) {
                    final biller = filteredBillers[index];
                    if(biller.billerName != "--Service Provider--"){
                      
                    }
                    return Column(
                      children: [
                        ListTile(
                          leading: Image.asset(
                            'assets/jv.png',
                            height: 50,
                            width: 40,
                          ),
                          title: Text(
                            biller.billerName,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Eletercitybill(),
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
          ),
        );
      },
      error: (err, stack) {
        return Scaffold(body: Center(child: Text("Some thing went wrong")));
      },
      loading: () => Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
