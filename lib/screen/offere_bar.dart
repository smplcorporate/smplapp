import 'package:flutter/material.dart';
import 'package:home/config/sizes.dart';

class OffereBar extends StatelessWidget {
  const OffereBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
     height: 180,
  width: double.infinity,

      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage('assets/banner.png'),
          // fit: BoxFit.cover, // Makes image fill the container proportionally
        ),
      ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     /// Text content
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         CText(
      //           text: "MEGA RECHARGE",
      //           size: 14,
      //           fWeight: FontWeight.w500,
      //           color: AppColors.textGreen,
      //         ),
      //         CText(
      //           text: "OFFER",
      //           size: 40,
      //           fWeight: FontWeight.w500,
      //           color: AppColors.textGreen,
      //         ),
      //         CText(
      //           text: "mobile Recharge or Bill Payment",
      //           size: 7,
      //           fWeight: FontWeight.w500,
      //           color: AppColors.textGreen,
      //         ),
      //         Container(
      //           margin: const EdgeInsets.only(top: 2),
      //           padding: const EdgeInsets.all(2),
      //           decoration: BoxDecoration(
      //             border: Border.all(color: AppColors.textGreen),
      //             borderRadius: BorderRadius.circular(5),
      //           ),
      //           child: Row(
      //             children: [
      //               CText(
      //                 text: "USE PROMOCODE: ",
      //                 size: 8,
      //                 fWeight: FontWeight.bold,
      //                 color: AppColors.textGreen,
      //               ),
      //               CText(
      //                 text: "GET10",
      //                 size: 8,
      //                 fWeight: FontWeight.bold,
      //                 color: Colors.blueAccent,
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
