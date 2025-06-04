import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(CashbackOffersApp());

class CashbackOffersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CashbackOffersPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CashbackOffersPage extends StatelessWidget {
  final List<OfferData> offers = [
    OfferData('Nike', 'assets/nike.png', '6% cashback', 'Welcome offers'),
    OfferData('Uber', 'assets/uber.png', '12% cashback', '+5% with PayPal Debit'),
    OfferData('Myntra', 'assets/myntra.png', '6% cashback', 'Welcome offers'),
    OfferData('Amazon', 'assets/amazon.png', '12% cashback', '+5% with PayPal Debit'),
    OfferData('Flipkart', 'assets/flipkart.png', '6% cashback', 'Welcome offers'),
    OfferData('Airtel', 'assets/airt.png', '12% cashback', '+5% with PayPal Debit'),
  ];

  void _showBottomSheet(BuildContext context, OfferData offer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => OfferDetailsSheet(offer: offer),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(width * 0.025),
          child: Container(
            decoration: BoxDecoration(
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
        backgroundColor: Color.fromARGB(255, 232, 243, 235),
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
      body: Container(
        color: Color.fromARGB(255, 232, 243, 235),
        child: Column(
          children: [
            SizedBox(height: width * 0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.015),
              child: Row(
                children: [
                  _buildTab(context, 'Popular Brands'),
                  _buildTab(context, 'Top Offers'),
                  _buildTab(context, 'Exclusive'),
                ],
              ),
            ),
            SizedBox(height: width * 0.04),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth < 600 ? 2 : 3;
                return GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  itemCount: offers.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: width * 0.05,
                    crossAxisSpacing: width * 0.04,
                    childAspectRatio: 0.78,
                  ),
                  itemBuilder: (context, index) {
                    final offer = offers[index];
                    return GestureDetector(
                      onTap: () => _showBottomSheet(context, offer),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: width * 0.01),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.025),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(width * 0.025),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(offer.image),
                                radius: width * 0.06,
                              ),
                              SizedBox(height: width * 0.03),
                              Text(
                                offer.title,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.035,
                                ),
                              ),
                              SizedBox(height: width * 0.02),
                              Text(
                                offer.cashback,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.03,
                                ),
                              ),
                              SizedBox(height: width * 0.02),
                              Text(
                                offer.description,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.03,
                                  color: Color.fromARGB(255, 141, 157, 255),
                                ),
                              ),
                              SizedBox(height: width * 0.02),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () => _showBottomSheet(context, offer),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    elevation: 0,
                                    side: BorderSide(
                                      color: Color.fromARGB(255, 68, 128, 106),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(width * 0.05),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.07,
                                      vertical: width * 0.03,
                                    ),
                                  ),
                                  child: Text(
                                    'Apply Now',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 68, 128, 106),
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
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, String label) {
    final width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        height: width * 0.1,
        margin: EdgeInsets.symmetric(horizontal: width * 0.01),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * 0.05),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: width * 0.03,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class OfferData {
  final String title;
  final String image;
  final String cashback;
  final String description;

  OfferData(this.title, this.image, this.cashback, this.description);
}

class OfferDetailsSheet extends StatelessWidget {
  final OfferData offer;

  const OfferDetailsSheet({required this.offer});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: width * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(offer.image),
                    radius: width * 0.06,
                  ),
                  SizedBox(width: width * 0.03),
                  Expanded(
                    child: Text(
                      offer.title,
                      style: GoogleFonts.inter(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(height: width * 0.03),
              Text(
                offer.cashback,
                style: GoogleFonts.inter(
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: width * 0.05),
              _offerStep(context),
              _offerStep(context),
              _offerStep(context),
              SizedBox(height: width * 0.06),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, width * 0.12),
                  backgroundColor: Color.fromARGB(255, 68, 128, 106),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * 0.04),
                  ),
                ),
                child: Text(
                  'Shop Now',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _offerStep(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.015),
      child: Row(
        children: [
          Icon(Icons.shopping_cart_outlined, size: width * 0.05),
          SizedBox(width: width * 0.02),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: 'Find a cashback offer and start \nshopping',
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.bold,
                ),
                children: const [
                  TextSpan(
                    text: ' Terms apply',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
