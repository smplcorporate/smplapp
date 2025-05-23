import 'package:flutter/material.dart';

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
    OfferData('Nike', 'assets/nike.png', '6% cashback', 'welcome offers'),
    OfferData('Uber', 'assets/uber.png', '12% cashback', '+5% with PayPal Debit'),
    OfferData('Myntra', 'assets/myntra.png', '6% cashback', 'welcome offers'),
    OfferData('Amazon', 'assets/amazon.png', '12% cashback', '+5% with PayPal Debit'),
    OfferData('Flipkart', 'assets/flipkart.png', '6% cashback', 'welcome offers'),
    OfferData('Airtel', 'assets/airtel.png', '12% cashback', '+5% with PayPal Debit'),
  ];

  void _showBottomSheet(BuildContext context, OfferData offer) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => OfferDetailsSheet(offer: offer),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Cashback & offers', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildTab('Popular Brands'),
                _buildTab('Top Offers'),
                _buildTab('Exclusive'),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: offers.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final offer = offers[index];
                return GestureDetector(
                  onTap: () => _showBottomSheet(context, offer),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[100],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(offer.image),
                          radius: 20,
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(height: 12),
                        Text(offer.title, style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(offer.cashback, style: TextStyle(color: Colors.black87)),
                        Text(offer.description, style: TextStyle(color: Colors.grey)),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () => _showBottomSheet(context, offer),
                          child: Text('Apply Now'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 36),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.only(right: 8),
        child: Center(child: Text(label, style: TextStyle(fontWeight: FontWeight.w500))),
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
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: AssetImage(offer.image), radius: 20),
              SizedBox(width: 12),
              Text(offer.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Spacer(),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(offer.cashback, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          SizedBox(height: 20),
          _offerStep('shopping'),
          _offerStep('shopping'),
          _offerStep('shopping'),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            child: Center(child: Text('Shop Now')),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 48),
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          )
        ],
      ),
    );
  }

  Widget _offerStep(String action) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.shopping_cart_outlined, size: 20),
          SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: 'Find a cashback offer and start ',
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: '$action. Terms apply',
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