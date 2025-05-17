import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/colors.dart';
import 'package:home/config/c_text.dart';
import 'package:home/screen/contact.dart';
import 'package:home/screen/notification2.dart';
import 'package:home/screen/offere_bar.dart';
import 'package:home/screen/screen2.dart';
import 'package:home/screen/success.dart';
import 'package:home/screen/wallet.dart';

class TopColume extends StatelessWidget {
  const TopColume({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 234, 234, 87),
            Color.fromARGB(255, 230, 230, 103),
            Color.fromARGB(255, 146, 239, 172),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 45),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.white,
                  child: Icon(Icons.person, color: AppColors.primaryColor),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CText(
                      text: 'Ankit Sharma',
                      fWeight: FontWeight.bold,
                      size: 15,
                    ),
                    CText(
                      text: '+916743524538',
                      fWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 142, 138, 138),
                      size: 11,
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationScreen2()),
                    );
                  },
                  icon: const Icon(
                    Icons.notifications,
                    size: 30,
                    color: Color.fromARGB(255, 112, 241, 148),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            OffereBar(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTopButton(Icons.account_balance, "Balance", onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BankBalanceApp()),
                  );
                }),
                buildTopButton(Icons.history, "History", onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TransactionPage()),
                  );
                }),
                buildTopButton(Icons.account_balance_wallet, "Wallet", onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyWalletPage()),
                  );
                }),
                buildTopButton(Icons.person, "Mobile Number", onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => contact()),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTopButton(IconData icon, String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 30, color: const Color.fromARGB(255, 20, 139, 54)),
          ),
          const SizedBox(height: 8),
          CText(
            text: title,
            size: 13,
            ali: TextAlign.center,
            fWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
