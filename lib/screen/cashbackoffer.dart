import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/data/controller/offers.provider.dart';
import 'package:home/screen/biller.dart';

class CashbackOffersPage extends ConsumerStatefulWidget {
  const CashbackOffersPage({super.key});

  @override
  ConsumerState<CashbackOffersPage> createState() =>
      _CashbackOffersPageState();
}

class _CashbackOffersPageState extends ConsumerState<CashbackOffersPage> {
 

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final offersData = ref.watch(offersListProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(width * 0.025),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new,
                  color: Colors.black, size: width * 0.045),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 232, 243, 235),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Cashback & offers',
          style: GoogleFonts.inter(
            fontSize: width * 0.045,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: offersData.when(
        data: (snap) {
          return Container(
            color: const Color.fromARGB(255, 232, 243, 235),
            child: Column(
              children: [
                SizedBox(height: width * 0.04),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount =
                          constraints.maxWidth < 600 ? 2 : 3;
                      return GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        itemCount: snap.offersList.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: width * 0.05,
                          crossAxisSpacing: width * 0.04,
                          childAspectRatio: 0.78,
                        ),
                        itemBuilder: (context, index) {
                          final offer = snap.offersList[index];
                          return GestureDetector(
                            onTap: () => null,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: width * 0.01),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.025),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(width * 0.025),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.grey[200],
                                      radius: width * 0.06,
                                      child: ClipOval(
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                              'assets/placeholder.png',
                                          image: offer.offerImage,
                                          fit: BoxFit.cover,
                                          width: width * 0.12,
                                          height: width * 0.12,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: width * 0.03),
                                    Text(
                                      truncate(offer.offerTitle, 15),
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.035,
                                      ),
                                    ),
                                    SizedBox(height: width * 0.02),
                                    Text(
                                      offer.serviceName,
                                      style: GoogleFonts.inter(
                                        fontSize: width * 0.03,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    SizedBox(height: width * 0.02),
                                    Text(
                                      offer.validTo,
                                      style: GoogleFonts.inter(
                                        fontSize: width * 0.03,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(
                                            255, 141, 157, 255),
                                      ),
                                    ),
                                    const Spacer(),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () =>
                                           null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.black,
                                          elevation: 0,
                                          side: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 68, 128, 106),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    width * 0.05),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.07,
                                            vertical: width * 0.03,
                                          ),
                                        ),
                                        child: Text(
                                          'Apply Now',
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 68, 128, 106),
                                            fontSize: width * 0.032,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
        error: (err, stack) => const Center(child: Text("Something went wrong")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

// class OfferDetailsSheet extends StatelessWidget {
//   final OfferListItem offer;

//   const OfferDetailsSheet({super.key, required this.offer});

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;

//     return ClipRRect(
//       borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
//       child: Container(
//         color: Colors.white,
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(
//               horizontal: width * 0.06, vertical: width * 0.08),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.grey[200],
//                     radius: width * 0.06,
//                     child: ClipOval(
//                       child: FadeInImage.assetNetwork(
//                         placeholder: 'assets/placeholder.png',
//                         image: offer.offerImage,
//                         fit: BoxFit.cover,
//                         width: width * 0.12,
//                         height: width * 0.12,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: width * 0.03),
//                   Expanded(
//                     child: Text(
//                       offer.offerTitle,
//                       style: GoogleFonts.inter(
//                         fontSize: width * 0.045,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.close),
//                     onPressed: () => Navigator.of(context).pop(),
//                   ),
//                 ],
//               ),
//               SizedBox(height: width * 0.03),
//               Text(
//                 offer.serviceName,
//                 style: GoogleFonts.inter(
//                   fontSize: width * 0.04,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: width * 0.05),
//               ..._buildSteps(context, offer.steps ?? []),
//               SizedBox(height: width * 0.06),
//               ElevatedButton(
//                 onPressed: () {
//                   // Link to offer action
//                 },
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(double.infinity, width * 0.12),
//                   backgroundColor: const Color.fromARGB(255, 68, 128, 106),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(width * 0.04),
//                   ),
//                 ),
//                 child: Text(
//                   'Shop Now',
//                   style: GoogleFonts.inter(
//                     color: Colors.white,
//                     fontSize: width * 0.035,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildSteps(BuildContext context, List<String> steps) {
//     final width = MediaQuery.of(context).size.width;
//     if (steps.isEmpty) {
//       steps = [
//         'Find a cashback offer and start shopping. Terms apply.',
//         'Use the promo code while checking out.',
//         'Get cashback credited to your account.',
//       ];
//     }
//     return steps
//         .map((step) => Padding(
//               padding: EdgeInsets.symmetric(vertical: width * 0.015),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(Icons.shopping_cart_outlined, size: width * 0.05),
//                   SizedBox(width: width * 0.02),
//                   Expanded(
//                     child: Text(
//                       step,
//                       style: GoogleFonts.inter(
//                         color: Colors.black,
//                         fontSize: width * 0.035,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ))
//         .toList();
//   }
// }
